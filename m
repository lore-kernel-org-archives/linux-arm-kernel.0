From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 20 Oct 2015 22:19:19 +0900
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <5624921E.7090003@linaro.org>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
 <5617CE26.10604@arm.com> <561E009B.3070001@linaro.org>
 <EB44D363-ACBA-48DB-B4EA-EDE1B87B99C8@gmail.com>
 <C0BCEB8B-2939-45AF-ACB4-BBE369B67699@gmail.com>
 <561F2965.3050204@linaro.org>
 <AC94227C-28D4-4745-9EC8-14EC59766DAD@gmail.com>
 <5624921E.7090003@linaro.org>
Message-ID: <DF640E12-7504-4EFD-A458-00DE86207551@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 19, 2015, at 3:47 PM, AKASHI Takahiro wrote:
> Jungseok,
> 
> On 10/15/2015 10:39 PM, Jungseok Lee wrote:
>> On Oct 15, 2015, at 1:19 PM, AKASHI Takahiro wrote:
>>> Jungseok,
>> 
>>>>> ----8<----
>>>>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>>>>> index f93aae5..e18be43 100644
>>>>> --- a/arch/arm64/kernel/traps.c
>>>>> +++ b/arch/arm64/kernel/traps.c
>>>>> @@ -103,12 +103,15 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
>>>>>        set_fs(fs);
>>>>> }
>>>>> 
>>>>> -static void dump_backtrace_entry(unsigned long where, unsigned long stack)
>>>>> +static void dump_backtrace_entry(unsigned long where)
>>>>> {
>>>>> +       /*
>>>>> +        * PC has a physical address when MMU is disabled.
>>>>> +        */
>>>>> +       if (!kernel_text_address(where))
>>>>> +               where = (unsigned long)phys_to_virt(where);
>>>>> +
>>>>>        print_ip_sym(where);
>>>>> -       if (in_exception_text(where))
>>>>> -               dump_mem("", "Exception stack", stack,
>>>>> -                        stack + sizeof(struct pt_regs), false);
>>>>> }
>>>>> 
>>>>> static void dump_instr(const char *lvl, struct pt_regs *regs)
>>>>> @@ -172,12 +175,17 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>>>>>        pr_emerg("Call trace:\n");
>>>>>        while (1) {
>>>>>                unsigned long where = frame.pc;
>>>>> +               unsigned long stack;
>>>>>                int ret;
>>>>> 
>>>>> +               dump_backtrace_entry(where);
>>>>>                ret = unwind_frame(&frame);
>>>>>                if (ret < 0)
>>>>>                        break;
>>>>> -               dump_backtrace_entry(where, frame.sp);
>>>>> +               stack = frame.sp;
>>>>> +               if (in_exception_text(where))
>>>>> +                       dump_mem("", "Exception stack", stack,
>>>>> +                                stack + sizeof(struct pt_regs), false);
>>>>>        }
>>>>> }
>>>>> ----8<----
>>>>> 
>>>>>> Thanks,
>>>>>> -Takahiro AKASHI
>>>>>> ----8<----
>>>>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>>>>> index 650cc05..5fbd1ea 100644
>>>>>> --- a/arch/arm64/kernel/entry.S
>>>>>> +++ b/arch/arm64/kernel/entry.S
>>>>>> @@ -185,14 +185,12 @@ alternative_endif
>>>>>> 	mov	x23, sp
>>>>>> 	and	x23, x23, #~(THREAD_SIZE - 1)
>>>>>> 	cmp	x20, x23			// check irq re-enterance
>>>>>> +	mov	x19, sp
>>>>>> 	beq	1f
>>>>>> -	str	x29, [x19, #IRQ_FRAME_FP]
>>>>>> -	str	x21, [x19, #IRQ_FRAME_SP]
>>>>>> -	str	x22, [x19, #IRQ_FRAME_PC]
>>>>>> -	mov	x29, x24
>>>>>> -1:	mov	x19, sp
>>>>>> -	csel	x23, x19, x24, eq		// x24 = top of irq stack
>>>>>> -	mov	sp, x23
>>>>>> +	mov	sp, x24				// x24 = top of irq stack
>>>>>> +	stp	x29, x22, [sp, #-32]!
>>>>>> +	mov	x29, sp
>>>>>> +1:
>>>>>> 	.endm
>>>>>> 
>>>>>> 	/*
>>>>> 
>>>>> Is it possible to decide which stack is used without aborted SP information?
>>>> 
>>>> We could know which stack is used via current SP, but how could we decide
>>>> a variable 'low' in unwind_frame() when walking a process stack?
>>> 
>>> The following patch, replacing your [PATCH 2/2], seems to work nicely,
>>> traversing from interrupt stack to process stack. I tried James' method as well
>>> as "echo c > /proc/sysrq-trigger."
>> 
>> Great thanks!
>> 
>> Since I'm favor of your approach, I've played with this patch instead of my one.
>> A kernel panic is observed when using 'perf record with -g option' and sysrq.
>> I guess some other changes are on your tree..
>> 
>> Please refer to my analysis.
>> 
>>> The only issue that I have now is that dump_backtrace() does not show
>>> correct "pt_regs" data on process stack (actually it dumps interrupt stack):
>>> 
>>> CPU1: stopping
>>> CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.3.0-rc5+ #24
>>> Hardware name: ARM Arm Versatile Express/Arm Versatile Express, BIOS 11:37:19 Jul 16 2015
>>> Call trace:
>>> [<ffffffc00008a7b0>] dump_backtrace+0x0/0x19c
>>> [<ffffffc00008a968>] show_stack+0x1c/0x28
>>> [<ffffffc0003936d0>] dump_stack+0x88/0xc8
>>> [<ffffffc00008fdf8>] handle_IPI+0x258/0x268
>>> [<ffffffc000082530>] gic_handle_irq+0x88/0xa4
>>> Exception stack(0xffffffc87b1bffa0 to 0xffffffc87b1c00c0) <== HERE
>>> ffa0: ffffffc87b18fe30 ffffffc87b1bc000 ffffffc87b18ff50 ffffffc000086ac8
>>> ffc0: ffffffc87b18c000 afafafafafafafaf ffffffc87b18ff50 ffffffc000086ac8
>>> ffe0: ffffffc87b18ff50 ffffffc87b18ff50 afafafafafafafaf afafafafafafafaf
>>> 0000: 0000000000000000 ffffffffffffffff ffffffc87b195c00 0000000200000002
>>> 0020: 0000000057ac6e9d afafafafafafafaf afafafafafafafaf afafafafafafafaf
>>> 0040: afafafafafafafaf afafafafafafafaf afafafafafafafaf afafafafafafafaf
>>> 0060: afafafafafafafaf afafafafafafafaf afafafafafafafaf afafafafafafafaf
>>> 0080: afafafafafafafaf afafafafafafafaf afafafafafafafaf afafafafafafafaf
>>> 00a0: afafafafafafafaf afafafafafafafaf afafafafafafafaf afafafafafafafaf
>>> [<ffffffc0000855e0>] el1_irq+0xa0/0x114
>>> [<ffffffc000086ac4>] arch_cpu_idle+0x14/0x20
>>> [<ffffffc0000fc110>] default_idle_call+0x1c/0x34
>>> [<ffffffc0000fc464>] cpu_startup_entry+0x2cc/0x30c
>>> [<ffffffc00008f7c4>] secondary_start_kernel+0x120/0x148
>>> [<ffffffc0000827a8>] secondary_startup+0x8/0x20
>> 
>> My 'dump_backtrace() rework' patch is in your working tree. Right?
> 
> Yeah. I applied your irq stack v5 and "Synchronise dump_backtrace()..." v3,
> and tried to reproduce your problem, but didn't.

I've have not seen this problem yet with my patches and your v2.

>>> 
>>> Thanks,
>>> -Takahiro AKASHI
>>> 
>>> ----8<----
>>> From 1aa8d4e533d44099f69ff761acfa3c1045a00796 Mon Sep 17 00:00:00 2001
>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> Date: Thu, 15 Oct 2015 09:04:10 +0900
>>> Subject: [PATCH] arm64: revamp unwind_frame for interrupt stack
>>> 
>>> This patch allows unwind_frame() to traverse from interrupt stack
>>> to process stack correctly by having a dummy stack frame for irq_handler
>>> created at its prologue.
>>> 
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>> arch/arm64/kernel/entry.S      |   22 ++++++++++++++++++++--
>>> arch/arm64/kernel/stacktrace.c |   14 +++++++++++++-
>>> 2 files changed, 33 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>> index 6d4e8c5..25cabd9 100644
>>> --- a/arch/arm64/kernel/entry.S
>>> +++ b/arch/arm64/kernel/entry.S
>>> @@ -185,8 +185,26 @@ alternative_endif
>>> 	and	x23, x23, #~(THREAD_SIZE - 1)
>>> 	cmp	x20, x23			// check irq re-enterance
>>> 	mov	x19, sp
>>> -	csel	x23, x19, x24, eq		// x24 = top of irq stack
>>> -	mov	sp, x23
>>> +	beq	1f
>>> +	mov	sp, x24				// x24 = top of irq stack
>>> +	stp	x29, x21, [sp, #-16]!		// for sanity check
>>> +	stp	x29, x22, [sp, #-16]!		// dummy stack frame
>>> +	mov	x29, sp
>>> +1:
>>> +	/*
>>> +	 * Layout of interrupt stack after this macro is invoked:
>>> +	 *
>>> +	 *     |                |
>>> +	 *-0x20+----------------+ <= dummy stack frame
>>> +	 *     |      fp        |    : fp on process stack
>>> +	 *-0x18+----------------+
>>> +	 *     |      lr        |    : return address
>>> +	 *-0x10+----------------+
>>> +	 *     |    fp (copy)   |    : for sanity check
>>> +	 * -0x8+----------------+
>>> +	 *     |      sp        |    : sp on process stack
>>> +	 *  0x0+----------------+
>>> +	 */
>>> 	.endm
>>> 
>>> 	/*
>>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>>> index 407991b..03611a1 100644
>>> --- a/arch/arm64/kernel/stacktrace.c
>>> +++ b/arch/arm64/kernel/stacktrace.c
>>> @@ -43,12 +43,24 @@ int notrace unwind_frame(struct stackframe *frame)
>>> 	low  = frame->sp;
>>> 	high = ALIGN(low, THREAD_SIZE);
>>> 
>>> -	if (fp < low || fp > high - 0x18 || fp & 0xf)
>>> +	if (fp < low || fp > high - 0x20 || fp & 0xf)
>>> 		return -EINVAL;
>> 
>> IMO, this condition should be changes as follows.
>> 
>> 	if (fp < low || fp > high - 0x20 || fp & 0xf || !fp)
> 
> If fp is NULL, (fp < low) should also be true.

I will report with the value of low, high, and fp if detected.

Best Regards
Jungseok Lee
