From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Feb 2013 16:48:58 +0000
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <20130208161811.GW17833@n2100.arm.linux.org.uk>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
 <20130207125801.GA19091@S2101-09.ap.freescale.net>
 <CAOMZO5D5ipAF0JOUOFezGz4Zr66M4bRm819ZurAfwPOrduBo5w@mail.gmail.com>
 <20130208161811.GW17833@n2100.arm.linux.org.uk>
Message-ID: <20130208164858.GA32318@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 04:18:11PM +0000, Russell King - ARM Linux wrote:
> Ok, so this is an ARMv5 kernel.

[...]

> And this is failing at:
> 
>    0:	1affffd9 	bne	0xffffff6c
>    4:	ee074f9a 	mcr	15, 0, r4, cr7, cr10, {4}
>    8:	ee084f16 	mcr	15, 0, r4, cr8, cr6, {0}
>    c:	ee084f15 	mcr	15, 0, r4, cr8, cr5, {0}
>   10:	ee074fd5 	mcr	15, 0, r4, cr7, cr5, {6}
> 
> which is local_flush_tlb_all().  The last instruction is the faulting
> instruction - because ARM926 doesn't have it... and... that was introduced
> by:
> 
> commit 5d9e3f9d7fcd7d09feb5d23974768a60bcea4094
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Thu Jan 31 19:15:49 2013 +0100
> 
>     ARM: 7636/1: tlb: perform branch predictor maintenance for whole invalidation

[...]

> And this patch looking at it now, is obviously wrong.  Will, can you
> take a look please?

Ah yes, this should be predicated on v6+. Sorry about that -- please see the
patch below.

> Also note - we used to do BTB maintanence, but I dropped it in this
> commit after discussing it with folk in ARM:
> 
> commit 4348810a241a330d3d143d62d7c988ec8b2e6629
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Tue Jul 5 09:01:13 2011 +0100
> 
>     ARM: btc: avoid invalidating the branch target cache on kernel TLB maintanence
>     
>     Kernel space needs very little in the way of BTC maintanence as most
>     mappings which are created and destroyed are non-executable, and so
>     could never enter the instruction stream.
>     
>     The case which does warrant BTC maintanence is when a module is loaded.
>     This creates a new executable mapping, but at that point the pages have
>     not been initialized with code and data, so at that point they contain
>     unpredictable information.  Invalidating the BTC at this stage serves
>     little useful purpose.
>     
>     Before we execute module code, we call flush_icache_range(), which deals
>     with the BTC maintanence requirements.  This ensures that we have a BTC
>     maintanence operation before we execute code via the newly created
>     mapping.
>     
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> So, I think we can do away entirely with your patch.

Unfortunately, we do need to add the maintenance for things like changing to
the idmap and ASID rollover, which is what prompted me to write the patch in
the first place (after discussion with Richard).

It's worth noting that this is one area where the micro-architecture
typically makes life easy for software, and the invalidation may well
execute as a nop.

Will

--->8

>From dc381a5dff9663901a61fe0dd86c986add382281 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Fri, 8 Feb 2013 16:41:19 +0000
Subject: [PATCH] ARM: tlb: fix branch predictor maintenance for ARMv6

The BPIALL operation is not available on all CPUs, so ensure that we
only execute it on processors implementing the instruction.

Reported-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/tlbflush.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 713ff32..e6bd71f 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -34,11 +34,13 @@
 #define TLB_V6_D_ASID	(1 << 17)
 #define TLB_V6_I_ASID	(1 << 18)
 
+#define TLB_V6_BP	(1 << 19)
+
 /* Unified Inner Shareable TLB operations (ARMv7 MP extensions) */
-#define TLB_V7_UIS_PAGE	(1 << 19)
-#define TLB_V7_UIS_FULL (1 << 20)
-#define TLB_V7_UIS_ASID (1 << 21)
-#define TLB_V7_UIS_BP	(1 << 22)
+#define TLB_V7_UIS_PAGE	(1 << 20)
+#define TLB_V7_UIS_FULL (1 << 21)
+#define TLB_V7_UIS_ASID (1 << 22)
+#define TLB_V7_UIS_BP	(1 << 23)
 
 #define TLB_BARRIER	(1 << 28)
 #define TLB_L2CLEAN_FR	(1 << 29)		/* Feroceon */
@@ -151,7 +153,8 @@
 #define v6wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
 			 TLB_V6_I_FULL | TLB_V6_D_FULL | \
 			 TLB_V6_I_PAGE | TLB_V6_D_PAGE | \
-			 TLB_V6_I_ASID | TLB_V6_D_ASID)
+			 TLB_V6_I_ASID | TLB_V6_D_ASID | \
+			 TLB_V6_BP)
 
 #ifdef CONFIG_CPU_TLB_V6
 # define v6wbi_possible_flags	v6wbi_tlb_flags
@@ -171,7 +174,7 @@
 				 TLB_V7_UIS_ASID | TLB_V7_UIS_BP)
 #define v7wbi_tlb_flags_up	(TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
 				 TLB_V6_U_FULL | TLB_V6_U_PAGE | \
-				 TLB_V6_U_ASID)
+				 TLB_V6_U_ASID | TLB_V6_BP)
 
 #ifdef CONFIG_CPU_TLB_V7
 
@@ -335,7 +338,7 @@ static inline void local_flush_tlb_all(void)
 
 	if (tlb_flag(TLB_V7_UIS_BP))
 		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
-	else
+	else if (tlb_flag(TLB_V6_BP))
 		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero));
 
 	if (tlb_flag(TLB_BARRIER)) {
-- 
1.8.0
