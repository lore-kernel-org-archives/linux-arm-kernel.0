From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 15:17:06 +0200
Subject: VFP handling in multiplatform feroceon kernels
Message-ID: <7416978.W29blLsymn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 3.16, we have the ability to build a multiplatform kernel
that includes both kirkwood (feroceon) and some other ARMv5 CPU.

I accidentally stumbled over a bug in the VFP code that looks
like it will break at least ARM9 VFP support if CPU_FEROCEON
is also enabled, introduced by this (old) commit:

commit 85d6943af50537d3aec58b967ffbd3fec88453e9
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Sat May 30 14:00:18 2009 +0100

    Fix the VFP handling on the Feroceon CPU
    
    This CPU generates synchronous VFP exceptions in a non-standard way -
    the FPEXC.EX bit set but without the FPSCR.IXE bit being set like in the
    VFP subarchitecture 1 or just the FPEXC.DEX bit like in VFP
    subarchitecture 2. The main problem is that the faulty instruction
    (which needs to be emulated in software) will be restarted several times
    (normally until a context switch disables the VFP). This patch ensures
    that the VFP exception is treated as synchronous.
    
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    Cc: Nicolas Pitre <nico@cam.org>

 diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
 index 83c4e38..1aeae38 100644 
 --- a/arch/arm/vfp/vfphw.S
 +++ b/arch/arm/vfp/vfphw.S
 @@ -100,6 +100,7 @@ ENTRY(vfp_support_entry)
        beq     no_old_VFP_process
        VFPFSTMIA r4, r5                @ save the working registers
        VFPFMRX r5, FPSCR               @ current status
 +#ifndef CONFIG_CPU_FEROCEON
        tst     r1, #FPEXC_EX           @ is there additional state to save?
        beq     1f
        VFPFMRX r6, FPINST              @ FPINST (only if FPEXC.EX is set)
 @@ -107,6 +108,7 @@ ENTRY(vfp_support_entry)
        beq     1f
        VFPFMRX r8, FPINST2             @ FPINST2 if needed (and present)
  1:
 +#endif
        stmia   r4, {r1, r5, r6, r8}    @ save FPEXC, FPSCR, FPINST, FPINST2
                                        @ and point r4 at the word at the
                                        @ start of the register dump
   ...


Any ideas for how this should be done better? I suppose we need a run-time
check for feroceon of some sort.

	Arnd
