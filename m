From: gengdongjiu@huawei.com (gengdongjiu)
Date: Fri, 8 Dec 2017 12:43:09 +0800
Subject: [PATCH RESEND] arm64: fault: avoid send SIGBUS two times
In-Reply-To: <5A295114.7020409@arm.com>
References: <20171205150235.46325-1-gengdongjiu@huawei.com>
 <20171206161540.GB25408@arm.com>
 <7d5791bf-39d4-b790-2f01-6abff800c6d0@huawei.com> <5A295114.7020409@arm.com>
Message-ID: <d2b0d31b-1831-3c76-1c57-96101abf4b6e@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James, Will

On 2017/12/7 22:32, James Morse wrote:
> Hi gengdongjiu, Will,
> 
> On 07/12/17 05:55, gengdongjiu wrote:
>> On 2017/12/7 0:15, Will Deacon wrote:
>>>> --- a/arch/arm64/mm/fault.c
>>>> +++ b/arch/arm64/mm/fault.c
>>>> @@ -570,7 +570,6 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>>>  {
>>>>  	struct siginfo info;
>>>>  	const struct fault_info *inf;
>>>> -	int ret = 0;
>>>>  
>>>>  	inf = esr_to_fault_info(esr);
>>>>  	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
>>>> @@ -585,7 +584,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>>>  		if (interrupts_enabled(regs))
>>>>  			nmi_enter();
>>>>  
>>>> -		ret = ghes_notify_sea();
>>>> +		ghes_notify_sea();
>>>>  
>>>>  		if (interrupts_enabled(regs))
>>>>  			nmi_exit();
>>>> @@ -600,7 +599,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>>>  		info.si_addr  = (void __user *)addr;
>>>>  	arm64_notify_die("", regs, &info, esr);
>>>>  
>>>> -	return ret;
>>>> +	return 0;
> 
>>> Hmm, so this code is a bit of mess.
>>>
>>> Wouldn't it be better to have the signal dispatching code in do_mem_abort
>>> check ESR.ESR_ELx_FnV, so then do_sea wouldn't have to, and we could just
>>> return an error instead?
> 
> FnV only applies to one of the Synchronous External Abort ESRs, hence it ended
> up in her>
>> Regardless ghes_notify_sea()'s return value, it always needs to deliver signal,
>> because ghes_notify_sea()'s return value does not reflect whether the memory error
>> handler(memory_failure()) handle the error successfully or failed. If let do_mem_abort()
>> delivers the signal, we should always let do_sea() return error, then  the do_mem_abort() can
>> always deliver signal. Then we will see the strange log as shown below when happen Synchronous External Abort.
>>
>> [  676.700652] Synchronous External Abort: synchronous external abort (0x96000410) at 0x0000000033ff7008
>> [  676.723301] Unhandled fault: synchronous external abort (0x96000410) at 0x0000000033ff7008
>>
>> so I think it is better send the signal in the do_sea(), not send it in the do_mem_abort().
> 
> I agree: I think improving the commit message would help here, something like:
> ---------
> do_sea() calls arm64_notify_die() which will always signal user-space.
> It also returns whether APEI claimed the external abort as a RAS notification.
> If it returns failure do_mem_abort() will signal user-space too.
> 
> do_mem_abort() wants to know if we handled the error, we always call
> arm64_notify_die() so can always return success.
> ---------

Thanks for the agreement and good example. surely I will update the commit message to clearly describe it.
by the way, I think also change the info.si_code to "BUS_MCEERR_AR" is better, as shown [1].
BUS_MCEERR_AR can tell user space  "Hardware memory error consumed on a error; action required".
so it is better than "0". In the X86 platform, it also use the "BUS_MCEERR_AR" for si_code[2] in "arch/x86/mm/fault.c".
what do you think about it?

[1]:
static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
{
    .........
    info.si_signo = SIGBUS;
    info.si_errno = 0;
-   info.si_code  = 0;
+   info.si_code  = BUS_MCEERR_AR;
}

[2]:
arch/x86/mm/fault.c:

static void
do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
      u32 *pkey, unsigned int fault)
{
  ......
#ifdef CONFIG_MEMORY_FAILURE
    if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
        printk(KERN_ERR
    "MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
            tsk->comm, tsk->pid, address);
        code = BUS_MCEERR_AR;
    }
#endif
    force_sig_info_fault(SIGBUS, code, address, tsk, pkey, fault);
}


> 
> APEI's return value matters for KVM, and it will matter here too if we support
> kernel-first.
yes.

> 
> 
>> do_mem_abort() only send the signal when the exception does not defined in fault_info[]. Another benefit
>> is that do_sea() can send different signal according to the Synchronous External Abort type, such as SIGBUS or SIGKILL.
>> the do_mem_abort() can only send one kind signal.
> 
> (I'm not convinced we want to do this other than via the firwmare/kernel RAS
> code, but that is a separate issue)
yes, that is a separate issue.

> 
> 
> Thanks,
> 
> James
> 
> 
> .
> 
