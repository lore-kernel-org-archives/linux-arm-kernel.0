From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Tue,  1 Jun 2010 08:30:46 +0300
Subject: [PATCH 7/8] omap iommu: move iommu_disable at fault to the above layer
In-Reply-To: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Message-ID: <1275370247-15888-7-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function prefix "omap2_iommu_" indicates that the prefixed
function belongs to "omap2_iommu_ops" to provide iommu basic
functionalities for the above layers. It's better to avoid the
prefixed function called in the same prefixed ones internally, like
nested here. Now "iommu_disable" is called just after fault_isr() in
the above layer. This is a little bit more sensible to keep the
consistency of module layers.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |    2 +-
 arch/arm/plat-omap/iommu.c   |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index edf7cd4..14ee686 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -172,7 +172,7 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 	printk("\n");
 
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
-	omap2_iommu_disable(obj);
+
 	return stat;
 }
 
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 688ae66..a202a2c 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -800,6 +800,8 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	if (!stat)
 		return IRQ_HANDLED;
 
+	iommu_disable(obj);
+
 	iopgd = iopgd_offset(obj, da);
 
 	if (!iopgd_is_table(*iopgd)) {
-- 
1.7.1.rc1
