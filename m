From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Mon, 4 Sep 2017 10:58:40 +0800
Subject: [RFC PATCH v1 1/3] arm64/ras: support sea error recovery
In-Reply-To: <7deab964-40a7-cb7d-5742-7dd837e22878@arm.com>
References: <1504261921-39308-1-git-send-email-xiexiuqi@huawei.com>
 <1504261921-39308-2-git-send-email-xiexiuqi@huawei.com>
 <7deab964-40a7-cb7d-5742-7dd837e22878@arm.com>
Message-ID: <471744b2-843c-949c-9888-e02544a3088c@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 2017/9/1 23:51, Julien Thierry wrote:
> Hi Xie,
> 
> On 01/09/17 11:31, Xie XiuQi wrote:
>> With ARM v8.2 RAS Extension, SEA are usually triggered when memory errors
>> are consumed. In some cases, if the error address is in a clean page or a
>> read-only page, there is a chance to recover. Such as error occurs in a
>> instruction page, we can reread this page from disk instead of killing process.
>>
>> Because memory_failure() may sleep, we can not call it directly in SEA exception
>> context. So we saved faulting physical address associated with a process in the
>> ghes handler and set __TIF_SEA_NOTIFY. When we return from SEA exception context
>> and get into do_notify_resume() before the process running, we could check it
>> and call memory_failure() to do recovery. It's safe, because we are in process
>> context.
>>
>> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
>> Signed-off-by: Wang Xiongfeng <wangxiongfeng2@huawei.com>

...

>> +
>> +void arm_proc_error_check(struct ghes *ghes, struct cper_sec_proc_arm *err)
>> +{
>> +    int i, ret = -1;
>> +    struct cper_arm_err_info *err_info;
>> +
>> +    if ((ghes->generic->notify.type != ACPI_HEST_NOTIFY_SEA) ||
>> +        (ghes->estatus->error_severity != CPER_SEV_RECOVERABLE))
>> +        return;
>> +
>> +    err_info = (struct cper_arm_err_info *)(err + 1);
>> +    for (i = 0; i < err->err_info_num; i++, err_info++) {
>> +        if (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR) {
>> +            ret |= sea_save_info(err_info->physical_fault_addr);
>> +        }
>> +    }
>> +
>> +    if (!ret)
> 
> If ret is initialized to -1, this is never true since you only OR bits in ret.
> 
> Should the body of the loop be:
>     ret &= sea_save_info(err_info->physical_fault_addr);
> 
> so as long as you as you manage to store 1 sea_info you set the thread flag?
> 
> But if that's the case a boolean might make more sense:
> 
> bool info_saved = false;
> [...]
>     info_saved |= !sea_save_info(err_info->physical_fault_addr);
> [...]
> if (info_saved)
>         [...]
> 

You are right, I'll fix this issue, thanks.

> 
>> +        set_thread_flag(TIF_SEA_NOTIFY);
>> +}
>> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
>> index 089c3747..71e314e 100644
>> --- a/arch/arm64/kernel/signal.c
>> +++ b/arch/arm64/kernel/signal.c
>> @@ -38,6 +38,7 @@
>>   #include <asm/fpsimd.h>
>>   #include <asm/signal32.h>
>>   #include <asm/vdso.h>
>> +#include <asm/ras.h>
>>     /*
>>    * Do a signal return; undo the signal stack. These are aligned to 128-bit.
>> @@ -749,6 +750,13 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
>>        * Update the trace code with the current status.
>>        */
>>       trace_hardirqs_off();
>> +
>> +#ifdef CONFIG_ARM64_ERR_RECOV
>> +        /* notify userspace of pending SEAs */
>> +        if (thread_flags & _TIF_SEA_NOTIFY)
>> +            sea_notify_process();
>> +#endif /* CONFIG_ARM64_ERR_RECOV */
>> +
>>       do {
>>           if (thread_flags & _TIF_NEED_RESCHED) {
>>               schedule();
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 1f22a41..b38476d 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -594,14 +594,25 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>               nmi_exit();
>>       }
>>   -    info.si_signo = SIGBUS;
>> -    info.si_errno = 0;
>> -    info.si_code  = 0;
>> -    if (esr & ESR_ELx_FnV)
>> -        info.si_addr = NULL;
>> -    else
>> -        info.si_addr  = (void __user *)addr;
>> -    arm64_notify_die("", regs, &info, esr);
>> +    if (user_mode(regs)) {
>> +        if (test_thread_flag(TIF_SEA_NOTIFY))
>> +            return ret;
>> +
>> +        info.si_signo = SIGBUS;
>> +        info.si_errno = 0;
>> +        info.si_code  = 0;
>> +        if (esr & ESR_ELx_FnV)
>> +            info.si_addr = NULL;
>> +        else
>> +            info.si_addr  = (void __user *)addr;
>> +
>> +        current->thread.fault_address = 0;
>> +        current->thread.fault_code = esr;
>> +        force_sig_info(info.si_signo, &info, current);
>> +    } else {
>> +        die("Uncorrected hardware memory error in kernel-access\n",
>> +            regs, esr);
>> +    }
>>         return ret;
>>   }
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index d661d45..fa9400d 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -52,6 +52,7 @@
>>   #include <acpi/ghes.h>
>>   #include <acpi/apei.h>
>>   #include <asm/tlbflush.h>
>> +#include <asm/ras.h>
>>   #include <ras/ras_event.h>
>>     #include "apei-internal.h"
>> @@ -520,6 +521,7 @@ static void ghes_do_proc(struct ghes *ghes,
>>           else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>>               struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>>   +            arm_proc_error_check(ghes, err);
> 
> If I understand the Makefile change correctly, arm_proc_error_check is compiled only when CONFIG_ARM64_ERR_RECOV, don't you get a linker error here if this config is not selected?
> 

Yes, it's a problem if CONFIG_ARM64_ERR_RECOV is not selected.
I'll fix it in next version.

> Otherwise patch looks fine.
> 

Thanks for your comments.

> Cheers,
> 

-- 
Thanks,
Xie XiuQi
