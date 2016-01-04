From: cmetcalf@ezchip.com (Chris Metcalf)
Date: Mon, 4 Jan 2016 16:01:05 -0500
Subject: [PATCH v9 08/13] arch/arm64: adopt prepare_exit_to_usermode()
 model from x86
In-Reply-To: <20160104203316.GE17127@leverpostej>
References: <1451936091-29247-1-git-send-email-cmetcalf@ezchip.com>
 <1451936091-29247-9-git-send-email-cmetcalf@ezchip.com>
 <20160104203316.GE17127@leverpostej>
Message-ID: <568ADD91.1050100@ezchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2016 03:33 PM, Mark Rutland wrote:
> Hi,
>
> On Mon, Jan 04, 2016 at 02:34:46PM -0500, Chris Metcalf wrote:
>> This change is a prerequisite change for TASK_ISOLATION but also
>> stands on its own for readability and maintainability.
> I have also been looking into converting the userspace return path from
> assembly to C [1], for the latter two reasons. Based on that, I have a
> couple of comments.

Thanks!

> It seems unfortunate to leave behind portions of the entry.S
> _TIF_WORK_MASK state machine (i.e. a small portion of ret_fast_syscall,
> and the majority of work_pending and ret_to_user).
>
> I think it would be nicer if we could handle all of that in one place
> (or at least all in C).

Yes, in principle I agree with this, and I think your deasm tree looks
like an excellent idea.

For this patch series I wanted to focus more on what was necessary
for the various platforms to implement task isolation, and less on
additional cleanups of the platforms in question.  I think my changes
don't make the TIF state machine any less clear, nor do they make
it harder for an eventual further migration to C code along the lines
of what you've done, so it seems plausible to me to commit them
upstream independently of your work.

>> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
>> index e18c48cb6db1..fde59c1139a9 100644
>> --- a/arch/arm64/kernel/signal.c
>> +++ b/arch/arm64/kernel/signal.c
>> @@ -399,18 +399,30 @@ static void do_signal(struct pt_regs *regs)
>>   	restore_saved_sigmask();
>>   }
>>   
>> -asmlinkage void do_notify_resume(struct pt_regs *regs,
>> -				 unsigned int thread_flags)
>> +asmlinkage void prepare_exit_to_usermode(struct pt_regs *regs,
>> +					 unsigned int thread_flags)
>>   {
>> -	if (thread_flags & _TIF_SIGPENDING)
>> -		do_signal(regs);
>> +	do {
>> +		local_irq_enable();
>>   
>> -	if (thread_flags & _TIF_NOTIFY_RESUME) {
>> -		clear_thread_flag(TIF_NOTIFY_RESUME);
>> -		tracehook_notify_resume(regs);
>> -	}
>> +		if (thread_flags & _TIF_NEED_RESCHED)
>> +			schedule();
> Previously, had we called schedule(), we'd reload the thread info flags
> and start that state machine again, whereas now we'll handle all the
> cached flags before reloading.
>
> Are we sure nothing is relying on the prior behaviour?

Good eye, and I probably should have called that out in the commit
message.  My best guess is that there should be nothing that depends
on the old semantics.  Other platforms (certainly x86 and tile, anyway)
already have the semantics that you run out the old state machine on
return from schedule(), so regardless, it's probably appropriate for
arm to follow that same convention.

>> +
>> +		if (thread_flags & _TIF_SIGPENDING)
>> +			do_signal(regs);
>> +
>> +		if (thread_flags & _TIF_NOTIFY_RESUME) {
>> +			clear_thread_flag(TIF_NOTIFY_RESUME);
>> +			tracehook_notify_resume(regs);
>> +		}
>> +
>> +		if (thread_flags & _TIF_FOREIGN_FPSTATE)
>> +			fpsimd_restore_current_state();
>> +
>> +		local_irq_disable();
>>   
>> -	if (thread_flags & _TIF_FOREIGN_FPSTATE)
>> -		fpsimd_restore_current_state();
>> +		thread_flags = READ_ONCE(current_thread_info()->flags) &
>> +			_TIF_WORK_MASK;
>>   
>> +	} while (thread_flags);
>>   }
> Other than that, this looks good to me.
>
> Thanks,
> Mark.
>
> [1] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=arm64/entry-deasm

Thanks again for the review - shall I add your Reviewed-by (or Acked-by?)
to this patch?

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
