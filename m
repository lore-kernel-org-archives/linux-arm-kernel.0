From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Fri, 27 May 2011 16:01:13 +0100 (BST)
Subject: [RFC PATCH v3] ARM hibernation/suspend-to-disk support
In-Reply-To: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
Message-ID: <alpine.DEB.2.00.1105271549220.6109@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 May 2011, Frank Hofmann wrote:

> Hi,
>
> I've cleaned this up by the suggestions in the previous thread; this is the 
> result.
>
> - now baselined against rmk/devel-stable
> - didn't create the <asm/suspend.h> because Rafael is just removing
>  that everywhere anyway
> - Fixes re prev suggestion:
> 	local_fiq_enable/disable bracketing
> 	save only absolutely essential regs and let cpu_init do the rest
> 	thumb2 clean assembly
> 	allows mach hooks (but they're not defined by this code)
>
> - Also: uses the "generic suspend/resume support" code
>  (commit f6b0fa02e8b0708d17d631afce456524eadf87ff, rmk/devel-stable)
>
> Via the latter, the previously-used hooks into machine-dependent code, 
> __save/__restore_processor_state, have become unnecessary.
>
> This now simply calls the cpu_do_suspend/resume utilities provided by the 
> generic code.
>
>
> I'm still figuring out how to best test a recent devel-stable kernel ...


Ok, I have figured out a way to test (on ARM1176, not yet Cortex-A8), by 
bringing my kernel up to a recent-enough baseline.


I've found that the cpu_resume_mmu call done at the end of cpu_do_resume 
is reliant on having the MMU off at that point.

If it's on (as is the case when coming through the hibernation resume 
point) the TTBR table modification in cpu_resume_mmu crashes ... well, 
it's a PA after all.


I could make hibernation resume to work through the generic paths if I add 
a "fast exit" case:


diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 6398ead..d83123a 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -71,10 +71,13 @@ ENDPROC(cpu_suspend)
  /*
   * r0 = control register value
   * r1 = v:p offset (preserved by cpu_do_resume)
+ *      if this is zero, do not reenable MMU (it's on)
   * r2 = phys page table base
   * r3 = L1 section flags
   */
  ENTRY(cpu_resume_mmu)
+       teq     r1, #0
+       moveq   pc, lr                  @ return if MMU already on
         adr     r4, cpu_resume_turn_mmu_on
         mov     r4, r4, lsr #20
         orr     r3, r3, r4, lsl #20


and "mov r1,#0" before calling cpu_do_suspend, from swsusp_arch_resume.


It leaves an unsatisfying feeling about this not being "quite right" 
though.

I wonder; is there a proper/suggested way to switch MMU off (and not end 
in binary nirvana), to have the reentry / reenable work ?


FrankH.
