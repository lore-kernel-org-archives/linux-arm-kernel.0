From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Jul 2010 16:53:57 +0100
Subject: [PATCH 1/2] ARM: errata: TLBIASIDIS and TLBIMVAIS operations can
	broadcast a faulty ASID
In-Reply-To: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
Message-ID: <1279209238-16234-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On versions of the Cortex-A9 prior to r2p0, performing TLB invalidations by
ASID match can result in the incorrect ASID being broadcast to other CPUs.
As a consequence of this, the targetted TLB entries are not invalidated
across the system.

This workaround changes the TLB flushing routines to invalidate entries
regardless of the ASID.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig                |   12 ++++++++++++
 arch/arm/include/asm/tlbflush.h |    8 ++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 98922f7..4824fb4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1027,6 +1027,18 @@ config PL310_ERRATA_588369
 	   is not correctly implemented in PL310 as clean lines are not
 	   invalidated as a result of these operations. Note that this errata
 	   uses Texas Instrument's secure monitor api.
+
+config ARM_ERRATA_720789
+	bool "ARM errata: TLBIASIDIS and TLBIMVAIS operations can broadcast a faulty ASID"
+	depends on CPU_V7 && SMP
+	help
+	  This option enables the workaround for the 720789 Cortex-A9 (prior to
+	  r2p0) erratum. A faulty ASID can be sent to the other CPUs for the
+	  broadcasted CP15 TLB maintenance operations TLBIASIDIS and TLBIMVAIS.
+	  As a consequence of this erratum, some TLB entries which should be
+	  invalidated are not, resulting in an incoherency in the system page
+	  tables. The workaround changes the TLB flushing routines to invalidate
+	  entries regardless of the ASID.
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index bd863d8..33b546a 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -378,7 +378,11 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	if (tlb_flag(TLB_V6_I_ASID))
 		asm("mcr p15, 0, %0, c8, c5, 2" : : "r" (asid) : "cc");
 	if (tlb_flag(TLB_V7_UIS_ASID))
+#ifdef CONFIG_ARM_ERRATA_720789
+		asm("mcr p15, 0, %0, c8, c3, 0" : : "r" (zero) : "cc");
+#else
 		asm("mcr p15, 0, %0, c8, c3, 2" : : "r" (asid) : "cc");
+#endif
 
 	if (tlb_flag(TLB_BTB)) {
 		/* flush the branch target cache */
@@ -424,7 +428,11 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	if (tlb_flag(TLB_V6_I_PAGE))
 		asm("mcr p15, 0, %0, c8, c5, 1" : : "r" (uaddr) : "cc");
 	if (tlb_flag(TLB_V7_UIS_PAGE))
+#ifdef CONFIG_ARM_ERRATA_720789
+		asm("mcr p15, 0, %0, c8, c3, 3" : : "r" (uaddr & PAGE_MASK) : "cc");
+#else
 		asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (uaddr) : "cc");
+#endif
 
 	if (tlb_flag(TLB_BTB)) {
 		/* flush the branch target cache */
-- 
1.6.3.3
