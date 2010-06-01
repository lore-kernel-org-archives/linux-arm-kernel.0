From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Tue,  1 Jun 2010 08:30:44 +0300
Subject: [PATCH 5/8] omap iommu: update irq mask to be specific about twl and
	tlb
In-Reply-To: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Message-ID: <1275370247-15888-5-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kanigeri, Hari <h-kanigeri2@ti.com>

Revise the IRQ mask definitions to handle the  MMU faults related
to TWL fault as well as TLB miss fault.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index e82da68..ebbdae2 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -44,9 +44,13 @@
 #define MMU_IRQ_EMUMISS		(1 << 2)
 #define MMU_IRQ_TRANSLATIONFAULT	(1 << 1)
 #define MMU_IRQ_TLBMISS		(1 << 0)
-#define MMU_IRQ_MASK	\
-	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_EMUMISS | \
-	 MMU_IRQ_TRANSLATIONFAULT)
+
+#define __MMU_IRQ_FAULT		\
+	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_EMUMISS | MMU_IRQ_TRANSLATIONFAULT)
+#define MMU_IRQ_MASK		\
+	(__MMU_IRQ_FAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_TLBMISS)
+#define MMU_IRQ_TWL_MASK	(__MMU_IRQ_FAULT | MMU_IRQ_TABLEWALKFAULT)
+#define MMU_IRQ_TLB_MISS_MASK	(__MMU_IRQ_FAULT | MMU_IRQ_TLBMISS)
 
 /* MMU_CNTL */
 #define MMU_CNTL_SHIFT		1
@@ -96,7 +100,7 @@ static int omap2_iommu_enable(struct iommu *obj)
 	l |= (MMU_SYS_IDLE_SMART | MMU_SYS_AUTOIDLE);
 	iommu_write_reg(obj, l, MMU_SYSCONFIG);
 
-	iommu_write_reg(obj, MMU_IRQ_MASK, MMU_IRQENABLE);
+	iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
 	iommu_write_reg(obj, pa, MMU_TTB);
 
 	l = iommu_read_reg(obj, MMU_CNTL);
-- 
1.7.1.rc1
