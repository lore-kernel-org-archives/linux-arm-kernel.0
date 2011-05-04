From: s-anna@ti.com (Suman Anna)
Date: Wed, 4 May 2011 17:45:37 -0500
Subject: [PATCH] omap: iommu: fix pte attributes for super section
Message-ID: <mailman.223.1305048323.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PTE programming causes a 16MB entry to be interpreted
as a 4K entry because of the bitwise check, and therefore does
not set the attributes properly in the first-level descriptor
table. The bitwise check has been replaced appropriately.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/iommu2.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index adb083e..c21fbe6 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -225,7 +225,8 @@ static u32 omap2_get_pte_attr(struct iotlb_entry *e)
        attr = e->mixed << 5;
        attr |= e->endian;
        attr |= e->elsz >> 3;
-       attr <<= ((e->pgsz & MMU_CAM_PGSZ_4K) ? 0 : 6);
+       attr <<= (((e->pgsz == MMU_CAM_PGSZ_4K) ||
+                       (e->pgsz == MMU_CAM_PGSZ_64K)) ? 0 : 6);

        return attr;
 }
--
1.7.0.4
