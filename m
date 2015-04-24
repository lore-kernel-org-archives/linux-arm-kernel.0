From: wcohen@redhat.com (William Cohen)
Date: Fri, 24 Apr 2015 17:14:10 -0400
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <55363791.4070706@hitachi.com>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <55363791.4070706@hitachi.com>
Message-ID: <553AB222.50609@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 07:42 AM, Masami Hiramatsu wrote:
> (2015/04/21 5:19), David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
>> first seen in October 2013. This version attempts to address concerns raised by
>> reviewers and also fixes problems discovered during testing.
>>
>> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
>> and return probes(kretprobes) support for ARM64.
>>
>> The kprobes mechanism makes use of software breakpoint and single stepping
>> support available in the ARM v8 kernel.
>>
> [...]
>> Changes since v5 include:
>>
>> 1) Replaced installation of breakpoint hook with direct call from the
>> handlers in debug-monitors.c, as requested.
>> 2) Reject probing of instructions that read the interrupt mask, in
>> addition to instructions that set it.
>> 3) Cleaned up comments describing usage of Debug Mask.
>> 4) Added KPROBE_REENTER case in reenter_kprobe.
>> 5) Corrected the ifdef'd definitions for notify_page_fault() to be
>> consistent when KPROBES is not configed.
>> 6) Changed "cpsr" to "pstate" for HAVE_REGS_AND_STACK_ACCESS_API feature.
>> 7) Added back in missing new files in previous patch.
>> 8) Changed two instances of pr_warning() to pr_warn().
> 
> Looks OK to me:)
> BTW, have you tried to build and test this with CONFIG_KPROBE_EVENT?
> If so, you can also test it by tools/testing/selftests/ftrace/ftracetest.
> 
>> Note that there seems to be at least a potential issue with kprobes
>> on multiple (possibly all) platforms having to do with use of kfree
>> inside of the kretprobes trampoline handler.  This has manifested
>> occasionally in systemtap testing on arm64.  There does not appear to
>> be an simple solution to the problem.
> 
> No, trampoline handler must call recycle_rp_inst() instead of kfree
> to return kretprobe instance to the pool. Hmm, I should look into it.
> 
> Thank you,
> 

Hi All,

At time the kernel with arm64 kprobe patches gets stuck printing out:

Unexpected kernel single-step exception at EL1

I put some instrumentation in debug-monitor.c to print out the kcb and register state when this happens.  Below is an example output:

[14613.263536] Unexpected kernel single-step exception at EL1
[14613.269001] kcb->ss_ctx.ss_status = 1
[14613.272643] kcb->ss_ctx.match_addr = fffffdfffc001250 0xfffffdfffc001250
[14613.279324] instruction_pointer(regs) = fffffe0000093358 el1_da+0x8/0x70
[14613.286003] 
[14613.287487] CPU: 3 PID: 621 Comm: irqbalance Tainted: G           OE   4.0.0u4+ #6
[14613.295019] Hardware name: AppliedMicro Mustang/Mustang, BIOS 1.1.0-rh-0.15 Mar 13 2015
[14613.302982] task: fffffe01d6806780 ti: fffffe01d68ac000 task.ti: fffffe01d68ac000
[14613.310430] PC is at el1_da+0x8/0x70
[14613.313990] LR is at trampoline_probe_handler+0x188/0x1ec
[14613.319363] pc : [<fffffe0000093358>] lr : [<fffffe0000687590>] pstate: 600001c5
[14613.326724] sp : fffffe01d68af640
[14613.330021] x29: fffffe01d68afbf0 x28: fffffe01d68ac000 
[14613.335328] x27: fffffe00000939cc x26: fffffe0000bb09d0 
[14613.340634] x25: fffffe01d68afdb0 x24: 0000000000000025 
[14613.345939] x23: 00000000800003c5 x22: fffffdfffc001284 
[14613.351245] x21: fffffe01d68af760 x20: fffffe01d7c79a00 
[14613.356552] x19: 0000000000000000 x18: 000003ffa4b8e600 
[14613.361858] x17: 000003ffa5480698 x16: fffffe00001f2afc 
[14613.367164] x15: 0000000000000007 x14: 000003ffeffa8690 
[14613.372471] x13: 0000000000000001 x12: 000003ffa4baf200 
[14613.377778] x11: fffffe00006bb328 x10: fffffe00006bb32c 
[14613.383084] x9 : fffffe01d68afd10 x8 : fffffe01d6806d10 
[14613.388390] x7 : fffffe01ffd01298 x6 : fffffe000009192c 
[14613.393696] x5 : fffffe0000c1b398 x4 : 0000000000000000 
[14613.399001] x3 : 0000000000200200 x2 : 0000000000100100 
[14613.404306] x1 : 0000000096000006 x0 : 0000000000000015 
[14613.409610] 
[14613.411094] BUG: failure at arch/arm64/kernel/debug-monitors.c:276/single_step_handler()!

One thing to note is the pstate value 0x600001c5; it has the SS bit set.  I think that sometime during handling the kprobe the SS is being set incorrectly or not cleared in the saved state.  When the register state gets reload a single step is attempted and the debug-monitors code flags it because it doesn't match up to the currently running kprobe.

Is single_step_handler functions setting the flag again with set_regs_spsr_ss(regs) the correct way to handle this if it wasn't previously handled?  If the single step isn't handled the first time, why are the following instructions going to be handled? It is going to spew many warning messages.

-Will Cohen
