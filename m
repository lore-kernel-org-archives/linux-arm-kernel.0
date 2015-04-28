From: wcohen@redhat.com (William Cohen)
Date: Mon, 27 Apr 2015 22:58:21 -0400
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <553AB222.50609@redhat.com>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
 <55363791.4070706@hitachi.com> <553AB222.50609@redhat.com>
Message-ID: <553EF74D.8020706@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi All,

I have been experimenting with the patches for arm64 kprobes support.
On occasion the kernel gets stuck in a loop printing output:

 Unexpected kernel single-step exception at EL1

This message by itself is not that enlighten.  I added the attached
patch to get some additional information about register state when the
warning is printed out.  Below is an example output:


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


The really odd thing is the address of the PC it is in el1_da the code
to handle data aborts.  it looks like it is getting the unexpected
single_step exception right after the enable_debug in el1_da.  I think
what might be happening is:

-an instruction is instrumented with kprobe
-the instruction is copied to a buffer
-a breakpoint replaces the instruction
-the kprobe fires when the breakpoint is encountered
-the instruction in the buffer is set to single step
-a single step of the instruction is attempted
-a data abort exception is raised
-el1_da is called
-el1_da does an enable_dbg to unmask the debug exceptions
-single_step_handler is called
-single_step_handler doesn't find anything to handle that pc
-single_step_handler prints the warning about unexpected el1 single step
-single_step_handler re-enable ss step
-the single step of the instruction is attempted endlessly

It looks like commit 1059c6bf8534acda249e7e65c81e7696fb074dc1 from Mon
Sep 22   "arm64: debug: don't re-enable debug exceptions on return from el1_dbg"
was trying to address a similar problem for the el1_dbg
function.  Should el1_da and other el1_* functions have the enable_dbg
removed?

If single_step_handler doesn't find a handler, is re-enabling the
single step with set_regs_spsr_ss in single_step_handler the right thing to do?

-Will

-------------- next part --------------
A non-text attachment was scrubbed...
Name: debug_diag.patch
Type: text/x-patch
Size: 915 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150427/2a3d266f/attachment.bin>
