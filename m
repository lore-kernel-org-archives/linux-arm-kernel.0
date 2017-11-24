From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Nov 2017 15:56:50 +0000
Subject: do page fault in atomic bug on arm
In-Reply-To: <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
 <20171121132001.GH31757@n2100.armlinux.org.uk>
 <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
Message-ID: <20171124155649.GT31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 11:09:30PM +0800, Alex Shi wrote:
> 
> >> [   53.302718] softirqs last  enabled at (11474): [<c034c5d0>] __do_softirq+0x280/0x5ac
> >> [   53.310494] softirqs last disabled at (11433): [<c034cc98>] irq_exit+0xf4/0x158
> >> [   53.317837] CPU: 0 PID: 1691 Comm: ftracetest Not tainted 4.9.55-dirty #1
> >> [   53.324652] Hardware name: Generic DRA74X (Flattened Device Tree)
> >> [   53.330857] [<c03114d8>] (unwind_backtrace) from [<c030cb18>] (show_stack+0x10/0x14)
> >> [   53.338644] [<c030cb18>] (show_stack) from [<c067e604>] (dump_stack+0xa4/0xd0)
> >> [   53.345908] [<c067e604>] (dump_stack) from [<c0373808>] (___might_sleep+0x1ac/0x2a0)
> >> [   53.353694] [<c0373808>] (___might_sleep) from [<c0d60ec8>] (do_page_fault+0x25c/0x428)
> >> [   53.361739] [<c0d60ec8>] (do_page_fault) from [<c03013e8>] (do_PrefetchAbort+0x38/0x9c)
> >> [   53.369780] [<c03013e8>] (do_PrefetchAbort) from [<c0d605a8>] (__pabt_svc+0x68/0xa0)
> >> [   53.377557] Exception stack(0xec6fbfa8 to 0xec6fbff0)
> >> [   53.382629] bfa0:                   00000001 00000001 ffffffff 00000000 0010ac68 00000007
> >> [   53.390845] bfc0: 00000001 0000003f 00000009 0000000c fffffffa be9d27a4 000e31fc ec6fbff8
> >> [   53.399055] bfe0: b6e6d49c b6e6d49c 40070093 ffffffff
> >> [   53.404137] [<c0d605a8>] (__pabt_svc) from [<b6e6d49c>] (0xb6e6d49c)
> > 
> > It also doesn't help that the backtrace stops at this point, and it looks
> > very strange:
> > 
> > 1. the value of PC looks like it's outside of the module space.
> > 2. the CPSR indicates that the CPU was in SVC mode in the parent context
> >    with IRQs disabled.
> > 3. We're right at the top of the kernel stack, which suggests no further
> >    stack frames above this.
> > 
> > We should never be in SVC mode without further stack frames on the kernel
> > stack.
> > 
> > We don't seem to have overflowed the kernel stack, as the thread info
> > seems correct - and it would also be unlikely that the saved SP value
> > would end in ff8 in the exception stack frame.
> 
> Hi Russell,
> 
> Sorry for response late!
> Is this SP was stained by sth? As my understand, SP should be times of
> 32bits. But why stack print out correct with a incorrect SP?

There's nothing wrong with SP.

Looking deeper at this, I think that the kernel stack somehow got
corrupted earlier:

irq event stamp: 12924
hardirqs last  enabled at (12923): [<c0307f10>] no_work_pending+0x4/0x30
hardirqs last disabled at (12924): [<c0d605a0>] __pabt_svc+0x60/0xa0

The hard IRQ disable is as a result of taking a prefetch abort in
SVC mode.  The saved context agrees with that:

                        R0       R1       R2       R3       R4       R5
bfa0:                   00000001 00000001 ffffffff 00000000 0010ac68 00000007
      R6       R7       R8       R9       R10      FP       IP       SP
bfc0: 00000001 0000003f 00000009 0000000c fffffffa be9d27a4 000e31fc ec6fbff8
      LR       PC       PSR
bfe0: b6e6d49c b6e6d49c 40070093 ffffffff

The PSR lower 5 bits are 0x13, which is SVC mode.  Bit 7 set means IRQs
disabled.  The PC address was 0xb6e6d49c.

The last record we have of interrupts being enabled was in
no_work_pending, which is the exit path to usermode - but if we were
returning to usermode:

(a) how did we get into SVC mode instead
(b) why are interrupts disabled
(c) why was mm->mmap_sem still held

Can you try the following patch to try and catch the problem earlier?
I haven't tested it myself, and adding code may move things around in
the kernel and make this bug disappear.

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index d523cd8439a3..ff577177b286 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -299,6 +299,8 @@
 	@ ARM mode restore
 	mov	r2, sp
 	ldr	r1, [r2, #\offset + S_PSR]	@ get calling cpsr
+	tst	r1, #0xcf
+	bne	oops
 	ldr	lr, [r2, #\offset + S_PC]!	@ get pc
 	msr	spsr_cxsf, r1			@ save in spsr_svc
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_32v6K)
@@ -314,6 +316,15 @@
 						@ after ldm {}^
 	add	sp, sp, #\offset + PT_REGS_SIZE
 	movs	pc, lr				@ return & move spsr_svc into cpsr
+oops:	.word	0xe7f001f2
+	.pushsection .rodata.str, "aMS", %progbits, 1
+2:	.asciz	"Returning to usermode but unexpected PSR bits set?"
+	.popsection
+	.pushsection __bug_table, "aw"
+	.align	2
+	.word	oops, 2b
+	.hword	\@
+	.popsection
 #elif defined(CONFIG_CPU_V7M)
 	@ V7M restore.
 	@ Note that we don't need to do clrex here as clearing the local


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
