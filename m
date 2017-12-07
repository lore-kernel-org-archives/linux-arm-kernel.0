From: gengdongjiu@huawei.com (gengdongjiu)
Date: Thu, 7 Dec 2017 13:55:36 +0800
Subject: [PATCH RESEND] arm64: fault: avoid send SIGBUS two times
In-Reply-To: <20171206161540.GB25408@arm.com>
References: <20171205150235.46325-1-gengdongjiu@huawei.com>
 <20171206161540.GB25408@arm.com>
Message-ID: <7d5791bf-39d4-b790-2f01-6abff800c6d0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/12/7 0:15, Will Deacon wrote:
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -570,7 +570,6 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>  {
>>  	struct siginfo info;
>>  	const struct fault_info *inf;
>> -	int ret = 0;
>>  
>>  	inf = esr_to_fault_info(esr);
>>  	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
>> @@ -585,7 +584,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>  		if (interrupts_enabled(regs))
>>  			nmi_enter();
>>  
>> -		ret = ghes_notify_sea();
>> +		ghes_notify_sea();
>>  
>>  		if (interrupts_enabled(regs))
>>  			nmi_exit();
>> @@ -600,7 +599,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>  		info.si_addr  = (void __user *)addr;
>>  	arm64_notify_die("", regs, &info, esr);
>>  
>> -	return ret;
>> +	return 0;
> Hmm, so this code is a bit of mess.
> 
> Wouldn't it be better to have the signal dispatching code in do_mem_abort
> check ESR.ESR_ELx_FnV, so then do_sea wouldn't have to, and we could just
> return an error instead?

Thanks the mail and comments!

Regardless ghes_notify_sea()'s return value, it always needs to deliver signal,
because ghes_notify_sea()'s return value does not reflect whether the memory error
handler(memory_failure()) handle the error successfully or failed. If let do_mem_abort()
delivers the signal, we should always let do_sea() return error, then  the do_mem_abort() can
always deliver signal. Then we will see the strange log as shown below when happen Synchronous External Abort.

[  676.700652] Synchronous External Abort: synchronous external abort (0x96000410) at 0x0000000033ff7008
[  676.723301] Unhandled fault: synchronous external abort (0x96000410) at 0x0000000033ff7008

so I think it is better send the signal in the do_sea(), not send it in the do_mem_abort().
do_mem_abort() only send the signal when the exception does not defined in fault_info[]. Another benefit
is that do_sea() can send different signal according to the Synchronous External Abort type, such as SIGBUS or SIGKILL.
the do_mem_abort() can only send one kind signal.
