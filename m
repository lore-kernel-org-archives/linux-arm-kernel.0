From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 24 Aug 2011 13:58:18 -0700 (PDT)
Subject: [PATCH 2/2] process: change from __backtrace to
	dump_stack_regs in show_regs
In-Reply-To: <alpine.LFD.2.00.1108241434140.20358@xanadu.home>
References: <1314206507-6487-1-git-send-email-lauraa@codeaurora.org>
	<1314206507-6487-3-git-send-email-lauraa@codeaurora.org>
	<alpine.LFD.2.00.1108241434140.20358@xanadu.home>
Message-ID: <a82026b2eff29e255a843f51d7c72ca7.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, August 24, 2011 11:57 am, Nicolas Pitre wrote:
> On Wed, 24 Aug 2011, Laura Abbott wrote:
>
>> Currently, show_regs calls __backtrace which does
>> nothing if CONIFG_FRAME_POINTER is not set. Switch to
>
> s/CONIFG/CONFIG/
>
>> dump_stack_regs to show the backtrace from a given
>> set of registers.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>  arch/arm/kernel/process.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>> index 1a347f4..6f11213 100644
>> --- a/arch/arm/kernel/process.c
>> +++ b/arch/arm/kernel/process.c
>> @@ -319,7 +319,7 @@ void show_regs(struct pt_regs * regs)
>>  	printk("\n");
>>  	printk("Pid: %d, comm: %20s\n", task_pid_nr(current), current->comm);
>>  	__show_regs(regs);
>> -	__backtrace();
>> +	dump_stack_regs(regs);
>
> This is not equivalent.  A call to __backtrace() will display a call
> trace leading to this show_regs().  Given that you defined
> dump_stack_regs(regs) as dump_backtrace(regs, NULL), the trace will
> instead contain calls leading up to the point where those regs were
> saved.
>

Do other architectures show the call stack to show_regs? From my reading
of other code (x86, ppc) it seems like if show_regs generates a call stack
it generates a call stack based off of the saved registers unless I'm
drastically misunderstanding the code. Generating a call stack based off
of not saved registers seems inconsistent with the rest of show_regs which
shows saved state.

> A better way to achieve what you want would be:
>
> - remove the __backtrace entry point from lib/backtrace.S
>
> - define __backtrace() in kernel/traps.c as a call to
>   dump_backtrace(NULL, NULL) which will have the same effect as the
>   assembly code for __backtrace().
>
> - realize that dump_stack() is already doing exactly that, therefore...
>
> - use dump_stack() in show_regs() which is the only caller of
>   __backtrace and get rid of __backtrace entirely.
>
> Obviously the above can be collapsed in one patch.
>
>
> Nicolas
>

Laura

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
