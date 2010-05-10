From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 10 May 2010 12:16:12 +0300
Subject: [PATCH] omap iommu: Reject unaligned addresses at setting page table
	entry
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Message-ID: <1273482972-5586-9-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This rejects unaligned device virtual address('da') and physical
address('pa') and informs error to caller when a page table entry is
set. Otherwise, a wrong address can be used by IO device.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/iommu.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 9598d40..bc094db 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -516,6 +516,12 @@ static int iopgd_alloc_section(struct iommu *obj, u32 da, u32 pa, u32 prot)
 {
 	u32 *iopgd = iopgd_offset(obj, da);
 
+	if ((da | pa) & ~IOSECTION_MASK) {
+		dev_err(obj->dev, "%s: %08x:%08x should aligned on %08lx\n",
+			__func__, da, pa, IOSECTION_SIZE);
+		return -EINVAL;
+	}
+
 	*iopgd = (pa & IOSECTION_MASK) | prot | IOPGD_SECTION;
 	flush_iopgd_range(iopgd, iopgd);
 	return 0;
@@ -526,6 +532,12 @@ static int iopgd_alloc_super(struct iommu *obj, u32 da, u32 pa, u32 prot)
 	u32 *iopgd = iopgd_offset(obj, da);
 	int i;
 
+	if ((da | pa) & ~IOSUPER_MASK) {
+		dev_err(obj->dev, "%s: %08x:%08x should aligned on %08lx\n",
+			__func__, da, pa, IOSUPER_SIZE);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < 16; i++)
 		*(iopgd + i) = (pa & IOSUPER_MASK) | prot | IOPGD_SUPER;
 	flush_iopgd_range(iopgd, iopgd + 15);
@@ -555,6 +567,12 @@ static int iopte_alloc_large(struct iommu *obj, u32 da, u32 pa, u32 prot)
 	u32 *iopte = iopte_alloc(obj, iopgd, da);
 	int i;
 
+	if ((da | pa) & ~IOLARGE_MASK) {
+		dev_err(obj->dev, "%s: %08x:%08x should aligned on %08lx\n",
+			__func__, da, pa, IOLARGE_SIZE);
+		return -EINVAL;
+	}
+
 	if (IS_ERR(iopte))
 		return PTR_ERR(iopte);
 
-- 
1.7.1.rc1
