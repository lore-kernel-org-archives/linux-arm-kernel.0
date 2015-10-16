From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri, 16 Oct 2015 21:52:21 +0900
Subject: [PATCH] arm64: Synchonise dump_backtrace() with perf callchain
In-Reply-To: <20151015172600.GD19202@arm.com>
References: <1444915314-13649-1-git-send-email-jungseoklee85@gmail.com>
 <20151015172600.GD19202@arm.com>
Message-ID: <C6DDC1F5-52AB-4834-A4D7-EAF7EA262153@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 16, 2015, at 2:26 AM, Will Deacon wrote:

Hi Will,

> On Thu, Oct 15, 2015 at 01:21:54PM +0000, Jungseok Lee wrote:
>> dump_backtrace() has its own backtrace logic unlike perf callchain which
>> relies on walk_stackframe(). They behave differently when a symbol is
>> recorded. Perf writes it down *before* calling unwind_frame(), but
>> dump_backtrace() prints it out *after* unwind_frame(). As a result, the
>> last valid symbol is not added to a list in case of dump_backtrace().
>> 
>> This patch catches up the last symbol as synchronising dump_backtrace()
>> with perf callchain. However, the patch does not cover a case where MMU
>> is disabled. That is, a physical address can be stored in stack frame,
>> but it's not handled. For example, a swapper process falls into this case.
>> Unlike a swapper from a secondary core, a swapper on a boot cpu, which
>> starting from __mmap_switched(), can't be tracked down with a simple
>> conversion, phys_to_virt(), because PC is retrieved from LR - 4, not LR.
> 
> It would be good to have an example backtrace before and after this patch
> is applied, to show what it fixes.

Agreed. I will add a call trace data to the commit message.

>> It is a big tradeoff to change both head.S and unwind_frame() structure
>> for a few of symbols in *.S, so this hunk does not take care of the case.
>> 
>> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
>> ---
>> arch/arm64/kernel/traps.c | 16 +++++++++++-----
>> 1 file changed, 11 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index f93aae5..4ddb928 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -103,12 +103,13 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
>> 	set_fs(fs);
>> }
>> 
>> -static void dump_backtrace_entry(unsigned long where, unsigned long stack)
>> +static void dump_backtrace_entry(unsigned long where)
>> {
>> +	/*
>> +	 * The highest stack frame of a swapper process stores PC in a form
>> +	 * of physical address, but this case is not handled.
>> +	 */
>> 	print_ip_sym(where);
>> -	if (in_exception_text(where))
>> -		dump_mem("", "Exception stack", stack,
>> -			 stack + sizeof(struct pt_regs), false);
>> }
>> 
>> static void dump_instr(const char *lvl, struct pt_regs *regs)
>> @@ -172,12 +173,17 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>> 	pr_emerg("Call trace:\n");
>> 	while (1) {
>> 		unsigned long where = frame.pc;
>> +		unsigned long stack;
>> 		int ret;
>> 
>> +		dump_backtrace_entry(where);
>> 		ret = unwind_frame(&frame);
>> 		if (ret < 0)
>> 			break;
>> -		dump_backtrace_entry(where, frame.sp);
>> +		stack = frame.sp;
>> +		if (in_exception_text(where))
>> +			dump_mem("", "Exception stack", stack,
>> +				 stack + sizeof(struct pt_regs), false);
> 
> AFAICT, the original code is all based on unwind_backtrace in
> arch/arm/kernel/unwind.c. Does that need updating too (as a separate patch)?

I think so, but I don't have any evidence from a real hardware..

Best Regards
Jungseok Lee
