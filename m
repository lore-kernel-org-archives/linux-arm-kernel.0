From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Feb 2011 10:44:39 +0000
Subject: [RFC] Generic CPU save/restore PM support
In-Reply-To: <000101cbc689$cceb8f40$66c2adc0$%kim@samsung.com>
References: <20110206191117.GA17808@n2100.arm.linux.org.uk>
	<000101cbc689$cceb8f40$66c2adc0$%kim@samsung.com>
Message-ID: <20110207104439.GB31929@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 02:42:15PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > The following patch series implements infrastructure to save/restore
> > CPU state on suspend/resume PM events, and updates SA11x0, PXA and
> > Samsung platforms to use this.
> > 
> > Not all CPU support files are updated with the necessary changes -
> > currently only ARM920, ARM926, SA11x0, XScale, XScale3, V6 and V7
> > CPUs are supported.
> > 
> > I've build-tested this for Assabet, PXA, and S3C2410, but not boot
> > tested it yet.
> > 
> Hi Russell,
> 
> Occurs following build error with s5pv210_defconfig.
> (I applied your patches into my some branch which is based on 38-rc3 for
> test)
> 
> arch/arm/mm/proc-v7.S:207: error: unterminated #ifdef
> 
> Let you know the test result on my board after fixing it.

There is an issue here which I missed when pulling the code out of
s5pv210, so you'll also need this.  This also fixes Xscale3 to operate
in the same manner.

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index abffa81..45d1024 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -203,7 +203,7 @@ cpu_v7_name:
 .equ	NMRR,	0x40e040e0
 
 .globl	cpu_v7_suspend_size
-.equ	cpu_v7_suspend_size, 4 * 7
+.equ	cpu_v7_suspend_size, 4 * 8
 #ifdef CONFIG_PM
 ENTRY(cpu_v7_do_suspend)
 	stmfd	sp!, {r4 - r10, lr}
@@ -214,7 +214,7 @@ ENTRY(cpu_v7_do_suspend)
 	mrc	p15, 0, r8, c1, c0, 0	@ Control register
 	mrc	p15, 0, r9, c1, c0, 1	@ Auxiliary control register
 	mrc	p15, 0, r10, c1, c0, 2	@ Co-processor access control
-	stmia	r0, {r4 - r10}
+	stmia	r0, {r1, r4 - r10}
 	ldmfd	sp!, {r4 - r10, pc}
 ENDPROC(cpu_v7_do_suspend)
 
@@ -222,7 +222,7 @@ ENTRY(cpu_v7_do_resume)
 	mov	ip, #0
 	mcr	p15, 0, ip, c8, c7, 0	@ invalidate TLBs
 	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
-	ldmia	r0, {r4 - r10}
+	ldmia	r0, {r1, r4 - r10}
 	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
 	mcr	p15, 0, r6, c2, c0, 0	@ TTB 0
@@ -245,6 +245,7 @@ ENTRY(cpu_v7_do_resume)
 	orr	r3, r2, r4, lsl #20	@ phys addr
 	ldr	r5, [r6, r4, lsl #2]	@ save old translation
 	str	r3, [r6, r4, lsl #2]	@ virt index
+	sub	r6, r6, r1		@ convert to virt translation base
 
 	ldr	r2, =cpu_v7_resume_after_mmu
 	b	cpu_v7_turn_mmu_on
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 054c1e8..9b3a0bf 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -416,7 +416,7 @@ ENTRY(cpu_xsc3_set_pte_ext)
 	.align
 
 .globl	cpu_xsc3_suspend_size
-.equ	cpu_xsc3_suspend_size, 4 * 7
+.equ	cpu_xsc3_suspend_size, 4 * 8
 #ifdef CONFIG_PM
 ENTRY(cpu_xsc3_do_suspend)
 	stmfd	sp!, {r4 - r10, lr}
@@ -428,17 +428,17 @@ ENTRY(cpu_xsc3_do_suspend)
 	mrc	p15, 0, r9, c1, c0, 1	@ auxiliary control reg
 	mrc 	p15, 0, r10, c1, c0, 0	@ control reg
 	bic	r4, r4, #2		@ clear frequency change bit
-	stmia	r0, {r4 - r10}		@ store cp regs
+	stmia	r0, {r1, r4 - r10}	@ store v:p offset + cp regs
 	ldmia	sp!, {r4 - r10, pc}
 ENDPROC(cpu_xsc3_do_suspend)
 
 ENTRY(cpu_xsc3_do_resume)
-	ldmia	r0, {r4 - r10}		@ load cp regs
-	mov	r1, #0
-	mcr	p15, 0, r1, c7, c7, 0	@ invalidate I & D caches, BTB
-	mcr	p15, 0, r1, c7, c10, 4	@ drain write (&fill) buffer
-	mcr	p15, 0, r1, c7, c5, 4	@ flush prefetch buffer
-	mcr	p15, 0, r1, c8, c7, 0	@ invalidate I & D TLBs
+	ldmia	r0, {r1, r4 - r10}	@ load v:p offset + cp regs
+	mov	ip, #0
+	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I & D caches, BTB
+	mcr	p15, 0, ip, c7, c10, 4	@ drain write (&fill) buffer
+	mcr	p15, 0, ip, c7, c5, 4	@ flush prefetch buffer
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I & D TLBs
 	mcr	p14, 0, r4, c6, c0, 0	@ clock configuration, turbo mode.
 	mcr	p15, 0, r5, c15, c1, 0	@ CP access reg
 	mcr	p15, 0, r6, c13, c0, 0	@ PID
@@ -457,12 +457,7 @@ ENTRY(cpu_xsc3_do_resume)
 	orr	r3, r2, r4, lsl #20
 	ldr	r5, [r8, r4, lsl #2]
 	str     r3, [r8, r4, lsl #2]
-
-	@ Mapping page table address in the page table
-	mov	r6, r8, lsr #20
-	orr	r3, r2, r6, lsl #20
-	ldr	r7, [r8, r6, lsl #2]
-	str	r3, [r8, r6, lsl #2]
+	sub	r8, r8, r1		@ convert to virt table base
 
 	ldr	r2, =cpu_xsc3_resume_after_mmu	@ absolute virtual address
 	b	cpu_xsc3_turn_on_mmu	@ cache align execution
@@ -481,7 +476,6 @@ ENDPROC(cpu_xsc3_mmu_on)
 cpu_xsc3_resume_after_mmu:
 	/* restore the temporary mapping */
 	str	r5, [r8, r4, lsl #2]
-	str	r7, [r8, r6, lsl #2]
 	mov	pc, lr
 ENDPROC(cpu_xsc3_resume_after_mmu)
 #else
