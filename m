From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 06 Sep 2015 19:25:01 +0200
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <20150905203818.GO21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Sat, 5 Sep 2015 21:38:18 +0100")
References: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
 <20150902103955.GF6281@e103592.cambridge.arm.com>
 <878u8lx9hl.fsf@belgarion.home>
 <20150905142519.GN21084@n2100.arm.linux.org.uk>
 <87y4gkx04m.fsf@belgarion.home>
 <20150905203818.GO21084@n2100.arm.linux.org.uk>
Message-ID: <87lhcjwjde.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sat, Sep 05, 2015 at 07:10:49PM +0200, Robert Jarzmik wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> So the issue is around this SW_DOMAIN_PAN, at least on PXA.
>
> If so, you may need to add:
>
> 	mrc p15, 0, \rd, c2, c0, 0
> 	mov \rd, \rd
> 	sub pc, pc, #4
>
> to the places we update the domain access register to ensure that the
> Xscale pipeline stalls to allow the CP15 DACR update to hit.
Nope, that didn't work.
I have tried 2 different patches :
 - in [1], your proposed solution
 - in [2], a PrefetchFlush as adviced by ARM Architecture Reference Manual

None of them worked. I confirmed by disassembling __dabt_svc my changes hit the
abort routine, and they did. I'll continue next week by trying to have a closer
look at the SW_DOMAIN_PAN commit (a5e090acbf545), and take time to walk through
the whole Oops for information I have missed.

Cheers.

-- 
Robert

[1] Approach 1 : translation table sync
=======================================
diff --cc arch/arm/include/asm/assembler.h
index 7bbf325a4f31,7bbf325a4f31..6bb46198fd08
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@@ -449,6 -449,6 +449,12 @@@ THUMB(    orr     \reg , \reg , #PSR_T_BIT        
  #endif
        .endm
  
++      .macro  dacr_sync, rd
++      mrc     p15, 0, \rd, c2, c0, 0
++      mov     \rd, \rd
++      sub     pc, pc, #4
++      .endm
++
        .macro  uaccess_disable, tmp, isb=1
  #ifdef CONFIG_CPU_SW_DOMAIN_PAN
        /*
@@@ -457,6 -457,6 +463,7 @@@
         */
        mov     \tmp, #DACR_UACCESS_DISABLE
        mcr     p15, 0, \tmp, c3, c0, 0         @ Set domain register
++      dacr_sync \tmp
        .if     \isb
        instr_sync
        .endif
@@@ -471,6 -471,6 +478,7 @@@
         */
        mov     \tmp, #DACR_UACCESS_ENABLE
        mcr     p15, 0, \tmp, c3, c0, 0
++      dacr_sync \tmp
        .if     \isb
        instr_sync
        .endif
@@@ -488,6 -488,6 +496,7 @@@
  #ifdef CONFIG_CPU_SW_DOMAIN_PAN
        ldr     r0, [sp, #S_FRAME_SIZE]
        mcr     p15, 0, r0, c3, c0, 0
++      dacr_sync r0
  #endif
        .endm

[2] Approach 2 : PrefetchFlush
==============================
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 7bbf325a4f31..2152d43d7ede 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -449,6 +449,10 @@ THUMB(     orr     \reg , \reg , #PSR_T_BIT        )
 #endif
        .endm
 
+       .macro  dacr_sync, rd
+       mcr     p15, 0, \rd, c7, c5, 4
+       .endm
+
        .macro  uaccess_disable, tmp, isb=1
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
        /*
@@ -457,6 +461,7 @@ THUMB(      orr     \reg , \reg , #PSR_T_BIT        )
         */
        mov     \tmp, #DACR_UACCESS_DISABLE
        mcr     p15, 0, \tmp, c3, c0, 0         @ Set domain register
+       dacr_sync \tmp
        .if     \isb
        instr_sync
        .endif
@@ -471,6 +476,7 @@ THUMB(      orr     \reg , \reg , #PSR_T_BIT        )
         */
        mov     \tmp, #DACR_UACCESS_ENABLE
        mcr     p15, 0, \tmp, c3, c0, 0
+       dacr_sync \tmp
        .if     \isb
        instr_sync
        .endif
@@ -488,6 +494,7 @@ THUMB(      orr     \reg , \reg , #PSR_T_BIT        )
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
        ldr     r0, [sp, #S_FRAME_SIZE]
        mcr     p15, 0, r0, c3, c0, 0
+       dacr_sync r0
 #endif
        .endm
