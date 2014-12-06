From: moon.linux@yahoo.com (Anand Moon)
Date: Sat, 06 Dec 2014 15:43:44 +0530
Subject: [PATCH] do_work_pending: Enable interrupts in do_work_pending()
In-Reply-To: <20141205151355.GU11285@n2100.arm.linux.org.uk>
References: <1417791066-5458-1-git-send-email-moon.linux@yahoo.com>
 <20141205151355.GU11285@n2100.arm.linux.org.uk>
Message-ID: <5482D6D8.5090804@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Russell King,

I was experiencing the same problem. You mention.
I realized later after few application failure an system slowdown.

-Anand Moon

On 12/5/2014 8:43 PM, Russell King - ARM Linux wrote:
> On Fri, Dec 05, 2014 at 08:21:06PM +0530, Anand Moon wrote:
>> @@ -574,12 +574,14 @@ asmlinkage int
>>   do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
>>   {
>>   	do {
>> +		if (unlikely(!user_mode(regs)))
>> +			return 0;
>> +		/* Enable interrupts; they are disabled again on return to
>> +		 * caller. */
>> +		local_irq_enable();
>>   		if (likely(thread_flags & _TIF_NEED_RESCHED)) {
>>   			schedule();
>>   		} else {
>> -			if (unlikely(!user_mode(regs)))
>> -				return 0;
>> -			local_irq_enable();
>>   			if (thread_flags & _TIF_SIGPENDING) {
>>   				int restart = do_signal(regs, syscall);
>>   				if (unlikely(restart)) {
> I'm happy with the hunk above, but:
>
>> @@ -588,6 +590,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
>>   					 * Deal with it without leaving
>>   					 * the kernel space.
>>   					 */
>> +					local_irq_disable();
>>   					return restart;
> not this one.  The code expects in the non-zero return case, that
> interrupts will be enabled, otherwise we will be restarting the syscall
> with IRQs disabled, and calling into the syscall function with IRQs
> disabled.
>
