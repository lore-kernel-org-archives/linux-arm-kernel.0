From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Thu, 7 Sep 2017 12:22:15 +0800
Subject: [PATCH v2 1/3] arm64/ras: support sea error recovery
In-Reply-To: <20170906101251.5gy53sbbkikpfg3y@pd.tnic>
References: <1504609566-66318-1-git-send-email-xiexiuqi@huawei.com>
 <1504609566-66318-2-git-send-email-xiexiuqi@huawei.com>
 <20170906101251.5gy53sbbkikpfg3y@pd.tnic>
Message-ID: <281c6244-2203-e06c-1850-f07c6fba4954@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On 2017/9/6 18:12, Borislav Petkov wrote:
> On Tue, Sep 05, 2017 at 07:06:04PM +0800, Xie XiuQi wrote:
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
>> ---
>>  arch/arm64/Kconfig                   |  11 +++
>>  arch/arm64/include/asm/ras.h         |  36 +++++++++
>>  arch/arm64/include/asm/thread_info.h |   4 +-
>>  arch/arm64/kernel/Makefile           |   1 +
>>  arch/arm64/kernel/ras.c              | 143 +++++++++++++++++++++++++++++++++++
>>  arch/arm64/kernel/signal.c           |   8 ++
>>  arch/arm64/mm/fault.c                |  27 +++++--
>>  drivers/acpi/apei/ghes.c             |   4 +-
>>  8 files changed, 223 insertions(+), 11 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/ras.h
>>  create mode 100644 arch/arm64/kernel/ras.c
> 
> Please integrate scripts/checkpatch.pl into your patch creation workflow
> and run all patches through it before submitting:

Sorry for my mistake. I'll fix it, thanks.

> 
> ERROR: code indent should use tabs where possible
> #200: FILE: arch/arm64/kernel/ras.c:42:
> +        atomic_t                inuse;$
> 
> WARNING: please, no spaces at the start of a line
> #200: FILE: arch/arm64/kernel/ras.c:42:
> +        atomic_t                inuse;$
> 
> ERROR: code indent should use tabs where possible
> #201: FILE: arch/arm64/kernel/ras.c:43:
> +        struct task_struct      *t;$
> 
> WARNING: please, no spaces at the start of a line
> #201: FILE: arch/arm64/kernel/ras.c:43:
> +        struct task_struct      *t;$
> 
> ERROR: code indent should use tabs where possible
> #202: FILE: arch/arm64/kernel/ras.c:44:
> +        __u64                   paddr;$
> 
> WARNING: please, no spaces at the start of a line
> #202: FILE: arch/arm64/kernel/ras.c:44:
> +        __u64                   paddr;$
> 
> ERROR: code indent should use tabs where possible
> #207: FILE: arch/arm64/kernel/ras.c:49:
> +        struct sea_info *si;$
> 
> WARNING: please, no spaces at the start of a line
> #207: FILE: arch/arm64/kernel/ras.c:49:
> +        struct sea_info *si;$
> 
> ERROR: code indent should use tabs where possible
> #209: FILE: arch/arm64/kernel/ras.c:51:
> +        for (si = sea_info; si < &sea_info[SEA_INFO_MAX]; si++) {$
> 
> WARNING: please, no spaces at the start of a line
> #209: FILE: arch/arm64/kernel/ras.c:51:
> +        for (si = sea_info; si < &sea_info[SEA_INFO_MAX]; si++) {$
> 
> ERROR: code indent should use tabs where possible
> #210: FILE: arch/arm64/kernel/ras.c:52:
> +                if (atomic_cmpxchg(&si->inuse, 0, 1) == 0) {$
> 
> WARNING: please, no spaces at the start of a line
> #210: FILE: arch/arm64/kernel/ras.c:52:
> +                if (atomic_cmpxchg(&si->inuse, 0, 1) == 0) {$
> 
> ERROR: code indent should use tabs where possible
> #211: FILE: arch/arm64/kernel/ras.c:53:
> +                        si->t = current;$
> 
> WARNING: please, no spaces at the start of a line
> #211: FILE: arch/arm64/kernel/ras.c:53:
> +                        si->t = current;$
> 
> ERROR: code indent should use tabs where possible
> #212: FILE: arch/arm64/kernel/ras.c:54:
> +                        si->paddr = addr;$
> 
> WARNING: please, no spaces at the start of a line
> #212: FILE: arch/arm64/kernel/ras.c:54:
> +                        si->paddr = addr;$
> 
> ERROR: code indent should use tabs where possible
> #213: FILE: arch/arm64/kernel/ras.c:55:
> +                        return true;$
> 
> WARNING: please, no spaces at the start of a line
> #213: FILE: arch/arm64/kernel/ras.c:55:
> +                        return true;$
> 
> ERROR: code indent should use tabs where possible
> #214: FILE: arch/arm64/kernel/ras.c:56:
> +                }$
> 
> WARNING: please, no spaces at the start of a line
> #214: FILE: arch/arm64/kernel/ras.c:56:
> +                }$
> 
> ERROR: code indent should use tabs where possible
> #215: FILE: arch/arm64/kernel/ras.c:57:
> +        }$
> 
> WARNING: please, no spaces at the start of a line
> #215: FILE: arch/arm64/kernel/ras.c:57:
> +        }$
> 
> ERROR: code indent should use tabs where possible
> #223: FILE: arch/arm64/kernel/ras.c:65:
> +        struct sea_info *si;$
> 
> WARNING: please, no spaces at the start of a line
> #223: FILE: arch/arm64/kernel/ras.c:65:
> +        struct sea_info *si;$
> 
> ERROR: code indent should use tabs where possible
> #225: FILE: arch/arm64/kernel/ras.c:67:
> +        for (si = sea_info; si < &sea_info[SEA_INFO_MAX]; si++)$
> 
> WARNING: please, no spaces at the start of a line
> #225: FILE: arch/arm64/kernel/ras.c:67:
> +        for (si = sea_info; si < &sea_info[SEA_INFO_MAX]; si++)$
> 
> ERROR: code indent should use tabs where possible
> #226: FILE: arch/arm64/kernel/ras.c:68:
> +                if (atomic_read(&si->inuse) && si->t == current)$
> 
> WARNING: please, no spaces at the start of a line
> #226: FILE: arch/arm64/kernel/ras.c:68:
> +                if (atomic_read(&si->inuse) && si->t == current)$
> 
> ERROR: code indent should use tabs where possible
> #227: FILE: arch/arm64/kernel/ras.c:69:
> +                        return si;$
> 
> WARNING: please, no spaces at the start of a line
> #227: FILE: arch/arm64/kernel/ras.c:69:
> +                        return si;$
> 
> ERROR: code indent should use tabs where possible
> #228: FILE: arch/arm64/kernel/ras.c:70:
> +        return NULL;$
> 
> WARNING: please, no spaces at the start of a line
> #228: FILE: arch/arm64/kernel/ras.c:70:
> +        return NULL;$
> 
> ERROR: code indent should use tabs where possible
> #233: FILE: arch/arm64/kernel/ras.c:75:
> +        atomic_set(&si->inuse, 0);$
> 
> WARNING: please, no spaces at the start of a line
> #233: FILE: arch/arm64/kernel/ras.c:75:
> +        atomic_set(&si->inuse, 0);$
> 
> WARNING: braces {} are not necessary for single statement blocks
> #265: FILE: arch/arm64/kernel/ras.c:107:
> +		if (memory_failure(pfn, 0, flags) < 0) {
> +			fail++;
> +		}
> 
> WARNING: braces {} are not necessary for single statement blocks
> #293: FILE: arch/arm64/kernel/ras.c:135:
> +		if (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR) {
> +			info_saved |= sea_save_info(err_info->physical_fault_addr);
> +		}
> 
> total: 17 errors, 21 warnings, 299 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> NOTE: Whitespace errors detected.
>       You may wish to use scripts/cleanpatch or scripts/cleanfile
> 
> Your patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 

-- 
Thanks,
Xie XiuQi
