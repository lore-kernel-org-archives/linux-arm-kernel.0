From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 10:49:23 -0400 (EDT)
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <20140624141056.GD4489@arm.com>
References: <7416978.W29blLsymn@wuerfel> <20140624134249.GB4489@arm.com>
 <alpine.LFD.2.11.1406240956540.16842@knanqh.ubzr>
 <20140624141056.GD4489@arm.com>
Message-ID: <alpine.LFD.2.11.1406241016340.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jun 2014, Catalin Marinas wrote:

> On Tue, Jun 24, 2014 at 03:04:14PM +0100, Nicolas Pitre wrote:
> > On Tue, 24 Jun 2014, Catalin Marinas wrote:
> > 
> > > On Tue, Jun 24, 2014 at 02:17:06PM +0100, Arnd Bergmann wrote:
> > > > Since 3.16, we have the ability to build a multiplatform kernel
> > > > that includes both kirkwood (feroceon) and some other ARMv5 CPU.
> > > > 
> > > > I accidentally stumbled over a bug in the VFP code that looks
> > > > like it will break at least ARM9 VFP support if CPU_FEROCEON
> > > > is also enabled, introduced by this (old) commit:
> > > 
> > > I would argue that the bug is in the CPU (feroceon). See the end of this
> > > email:
> > > 
> > > http://www.spinics.net/lists/arm-kernel/msg41460.html
> > > 
> > > and my follow-up. Basically you can't avoid the conditional compilation
> > > as Feroceon doesn't follow the VFP sub-architecture spec and doesn't
> > > present itself as a different CPU from an _ARM_ 9. Unless things have
> > > changed with Marvell's hardware implementation and they got a new id, I
> > > suggest you don't enable this for multi-platform.
> > 
> > Only the early revision did hijack the ARM9 ID but still. We certainly 
> > can determine at run time if the platform being booted is equiped with a 
> > Feroceon before user space is started.  In that case I'd suggest some 
> > runtime code patching to branch to some out-of-line assembly code for 
> > Feroceon.
> 
> You don't even need to branch to out of line assembly, just branch over
> the imprecise VFP abort handling in arch/arm/vfp/vfphw.S.

Even better.  I looked too quickly at the patch seeing a #ifdef while it 
is in fact #ifndef.

What about something like this?

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index be807625ed..d46eb84884 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -115,7 +115,7 @@ ENTRY(vfp_support_entry)
 	beq	vfp_reload_hw		@ then the hw state needs reloading
 	VFPFSTMIA r4, r5		@ save the working registers
 	VFPFMRX	r5, FPSCR		@ current status
-#ifndef CONFIG_CPU_FEROCEON
+vfp_extra:
 	tst	r1, #FPEXC_EX		@ is there additional state to save?
 	beq	1f
 	VFPFMRX	r6, FPINST		@ FPINST (only if FPEXC.EX is set)
@@ -123,7 +123,6 @@ ENTRY(vfp_support_entry)
 	beq	1f
 	VFPFMRX	r8, FPINST2		@ FPINST2 if needed (and present)
 1:
-#endif
 	stmia	r4, {r1, r5, r6, r8}	@ save FPEXC, FPSCR, FPINST, FPINST2
 vfp_reload_hw:
 
@@ -219,6 +218,19 @@ process_exception:
 					@ retry the faulted instruction
 ENDPROC(vfp_support_entry)
 
+#ifdef CONFIG_CPU_FEROCEON
+ENTRY(vfp_feroceon_quirk)
+	/* force a skip over the imprecise VFP abort handling */
+	adr	r0, vfp_extra
+	ldr	r1, .L_eq_insn
+	str	r1, [r0]
+	add	r1, r0, #4
+	b	feroceon_coherent_kern_range
+.L_eq_insn:
+	teq	r0, r0
+ENDPROC(vfp_feroceon_quirk)
+#endif
+
 ENTRY(vfp_save_state)
 	@ Save the current VFP state
 	@ r0 - save location

Then suffice to call vfp_feroceon_quirk() during boot when appropriate.


Nicolas
