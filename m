From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Mon, 4 Apr 2011 15:47:09 +0100 (BST)
Subject: [RFC PATCH] Current status, suspend-to-disk support on ARM
Message-ID: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

some status on making hibernation (suspend-to-disk) work on ARM.

I've simplified an updated patch set again, to make the pieces obvious. 
The attached patch set also cleanly compiles when adding TuxOnIce to it.


Pls. don't take this as a formal patch submission; this is discussion 
material and hence not currently based on any specific kernel revision.


The code essentially splits into two - a generic bit supplying the glue 
code that the framework needs, and SoC-specific code to do the core state 
suspend/resume.

The generic bits do two things:

 	* implement some glue the suspend-to-disk framework requires:

 		- pfn_is_nosave
 		- save/restore_processor_state
 		- swsusp_arch_suspend/resume entrypoints

 	* ARM assembly for the "guts" of swsusp_arch_suspend/resume

 		- save/restore current regset, CPSR and svc stack/lr
 		- page restore loop to copy the pageset back
 		- redirect to SoC-specific code for core suspend/resume

Hopefully what's in there is actually agnostic enough to qualify as "ARM 
generic". This stuff is quite clean by now.

There's one ugly thing in this set - I've changed a generic kernel header, 
<linux/suspend.h> to #define save/restore_processor_state() on ARM so that 
it only does preempt_disable/enable(). It's surprising that this isn't the 
default behaviour; all platforms need swsusp_arch_suspend/resume anyway so 
why force the existance of _two_ arch-specific hooks ?



In addition to this glue, one needs:

 	* a SoC-dependent __save/__restore_processor_state.
           There's two examples attached for that, OMAP3 and Samsung 6450.

This bit is the "hacky" part of the patch; on ARM, the platform code is 
blissfully unaware of suspend-to-disk while suspend-to-ram is partially 
very complex code.

The shown diffs hook into the "inner guts" of existing suspend-to-ram on 
ARM, and while that looks like it does a large part of the job, there's 
surely a better way.

I've supplied those as merely illustrative... to show that the inline 
assembly orgies from previous patches are just unnecessarily duplicating 
already-existing functionality. The way this is reused here might not be 
the perfect way - intent only was to show how much code re-use is 
actually possible in the area.

Whoever wishes can instead substitute the __save/__restore_processor_state 
inline assembly orgies from previously posted patches here - it all hooks 
in very cleanly.



To test / extend this code on an ARM architecture other than the two 
shown, one can start with the generic bits and simply make NOP-impls for 
the SoC-specific bits; that should at the very least allow a snapshot to 
be created, and so validate that device tree quiesce/freeze resume/thaw 
work correctly. Resume from such an image wouldn't work, though. At least 
the MMU state is absolutely critical.




Re, how (if at all) to get this towards mainline:

It looks like the various ARM boards have _very_ different views towards 
what suspend_ops.enter() will have to do; some are quite simple there, 
others are exceedingly complex.

One would ultimately hope for as much code sharing between hibernation and 
suspend-to-mem as possible, for sure, but the current code isn't aware of 
this; in many cases, saving/restoring state is done all over the place in 
the "arch framework" bits of suspend_ops.enter(), before the actual CPU 
core state is saved/resumed. ARM is heavily biased towards optimizing the 
hell out of suspend-to-mem, and a "grand central store" for system state 
isn't really there, all boards have their own strategy for this, and their 
own assumptions on what the CPU state is when resumed from RAM. This is 
even harder to do for "secure" SoCs, where part of the functionality is 
handled by (non-kernel) internal ROM code.


Russell King has recently done a change to the CPU suspend core code to 
make that use a "more generic" interface (have them all dump state into a 
caller-supplied buffer, at the least). The attached patches aren't yet 
fully aware of that because of the need _not_ to suspend (but return after 
state save) when called through the hibernation code. My brain hasn't yet 
grown big enough to solve this well ...



Re, success with this patch: On OMAP3, I've got issues; the console 
doesn't properly suspend/resume and using no_console_suspend keeps the 
messages but looses console input after resume. Also, graphics doesn't 
come back, and successive hibernation attempts cause crashes in the USB 
stack. It works much better on the Samsung 64xx boards, for me at least. 
But then, quite a few people reported success with the older patches on 
OMAP, hence I wonder, who's got it "fully working" ?



Any comments ? What can be improved ?


Have fun,
FrankH.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hibernate-core-04Apr2011.patch
Type: text/x-diff
Size: 9586 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110404/10ee57ea/attachment-0001.bin>
-------------- next part --------------
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index df5ce56..b4713ba 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -23,6 +23,7 @@ config ARCH_OMAP3
 	select CPU_V7
 	select COMMON_CLKDEV
 	select OMAP_IOMMU
+	select ARCH_HIBERNATION_POSSIBLE
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index ea4e498..fd48417 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -328,6 +328,17 @@ restore:
 	.word	0xE1600071		@ call SMI monitor (smi #1)
 #endif
 	b	logic_l1_restore
+#ifdef CONFIG_HIBERNATION
+ENTRY(__restore_processor_state)
+	stmfd	sp!, { r0 - r12, lr }
+	str	sp, [r0]		@ fixup saved stack pointer
+	str	lr, [r0, #8]		@ fixup saved link register
+	mov	r3, r0
+	mov	r1, #1
+	b	.Llogic_l1_restore_internal
+ENDPROC(__restore_processor_state)
+#endif
+
 l2_inv_api_params:
 	.word   0x1, 0x00
 l2_inv_gp:
@@ -358,6 +369,7 @@ logic_l1_restore:
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
 	adds	r3, r3, #16
+.Llogic_l1_restore_internal:
 	ldmia	r3!, {r4-r6}
 	mov	sp, r4
 	msr	spsr_cxsf, r5
@@ -433,6 +445,10 @@ ttbr_error:
 	*/
 	b	ttbr_error
 usettbr0:
+#ifdef CONFIG_HIBERNATION
+	cmp	r1, #1
+	ldmeqfd	sp!, { r0 - r12, pc }	@ early return from __restore_processor_state
+#endif
 	mrc	p15, 0, r2, c2, c0, 0
 	ldr	r5, ttbrbit_mask
 	and	r2, r5
@@ -471,6 +487,16 @@ usettbr0:
 	mcr	p15, 0, r4, c1, c0, 0
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
+
+#ifdef CONFIG_HIBERNATION
+ENTRY(__save_processor_state)
+	stmfd	sp!, {r0-r12, lr}
+	mov	r1, #0x4
+	mov	r8, r0
+	b	l1_logic_lost
+ENDPROC(__save_processor_state)
+#endif
+
 save_context_wfi:
 	/*b	save_context_wfi*/	@ enable to debug save code
 	mov	r8, r0 /* Store SDRAM address in r8 */
@@ -545,6 +571,10 @@ l1_logic_lost:
 	mrc	p15, 0, r4, c1, c0, 0
 	/* save control register */
 	stmia	r8!, {r4}
+#ifdef CONFIG_HIBERNATION
+	cmp	r1, #4
+	ldmeqfd	sp!, {r0-r12, pc}	@ early return from __save_processor_state
+#endif
 clean_caches:
 	/* Clean Data or unified cache to POU*/
 	/* How to invalidate only L1 cache???? - #FIX_ME# */
-------------- next part --------------
diff --git a/arch/arm/plat-s5p/sleep.S b/arch/arm/plat-s5p/sleep.S
index 2cdae4a..fd2b0a1 100644
--- a/arch/arm/plat-s5p/sleep.S
+++ b/arch/arm/plat-s5p/sleep.S
@@ -48,10 +48,17 @@
 	 *
 	 * entry:
 	 *	r0 = save address (virtual addr of s3c_sleep_save_phys)
-	*/
+	 *	r1 (_internal_ only) = CPU sleep trampoline (if any)
+	 */
 
-ENTRY(s3c_cpu_save)
+ENTRY(__save_processor_state)
+	mov	r1, #0
+	b	.Ls3c_cpu_save_internal
+ENDPROC(__save_processor_state)
 
+ENTRY(s3c_cpu_save)
+	ldr	r1, =pm_cpu_sleep	@ set trampoline
+.Ls3c_cpu_save_internal:
 	stmfd	sp!, { r3 - r12, lr }
 
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
@@ -67,11 +74,13 @@ ENTRY(s3c_cpu_save)
 
 	stmia	r0, { r3 - r13 }
 
+	mov	r4, r1
 	@@ write our state back to RAM
 	bl	s3c_pm_cb_flushcache
 
+	mov	r0, r4
+	ldmeqfd	sp!, { r3 - r12, pc }	@ if there was no trampoline, return
 	@@ jump to final code to send system to sleep
-	ldr	r0, =pm_cpu_sleep
 	@@ldr	pc, [ r0 ]
 	ldr	r0, [ r0 ]
 	mov	pc, r0
@@ -86,9 +95,19 @@ resume_with_mmu:
 	str	r12, [r4]
 
 	ldmfd	sp!, { r3 - r12, pc }
+ENDPROC(s3c_cpu_save)
+
+ENTRY(__restore_processor_state)
+	stmfd	sp!, { r3 - r12, lr }
+	ldr	r2, =.Ls3c_cpu_resume_internal
+	mov	r1, #1
+	str	sp, [r0, #40]		@ fixup sp in restore context
+	mov	pc, r2
+ENDPROC(__restore_processor_state)
 
 	.ltorg
 
+
 	@@ the next bits sit in the .data segment, even though they
 	@@ happen to be code... the s5pv210_sleep_save_phys needs to be
 	@@ accessed by the resume code before it can restore the MMU.
@@ -131,6 +150,7 @@ ENTRY(s3c_cpu_resume)
 	mcr	p15, 0, r1, c7, c5, 0		@@ invalidate I Cache
 
 	ldr	r0, s3c_sleep_save_phys	@ address of restore block
+.Ls3c_cpu_resume_internal:
 	ldmia	r0, { r3 - r13 }
 
 	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
@@ -152,6 +172,9 @@ ENTRY(s3c_cpu_resume)
 	mcr	p15, 0, r12, c10, c2, 0	@ write PRRR
 	mcr	p15, 0, r3, c10, c2, 1	@ write NMRR
 
+	cmp	r1, #0
+	bne	0f			@ only do MMU phys init
+					@ not called by __restore_processor_state
 	/* calculate first section address into r8 */
 	mov	r4, r6
 	ldr	r5, =0x3fff
@@ -175,6 +198,7 @@ ENTRY(s3c_cpu_resume)
 	str	r10, [r4]
 
 	ldr	r2, =resume_with_mmu
+0:
 	mcr	p15, 0, r9, c1, c0, 0		@ turn on MMU, etc
 
         nop
@@ -183,6 +207,7 @@ ENTRY(s3c_cpu_resume)
         nop
         nop					@ second-to-last before mmu
 
+	ldmnefd	sp!, { r3 - r12, pc }
 	mov	pc, r2				@ go back to virtual address
 
 	.ltorg
