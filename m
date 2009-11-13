From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Nov 2009 16:07:50 -0800
Subject: [PATCH 03/14] omap: iommu: avoid remapping if it's been mapped in MPU
	side
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Message-ID: <20091113000749.9034.95911.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

MPU side (v)-(p) mapping is necessary only if IOVMF_MMIO is set in
"flags".

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iovmm.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 0ce36bb..577d8c0 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -617,7 +617,7 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
 		 u32 flags)
 {
 	size_t bytes;
-	void *va;
+	void *va = NULL;
 
 	if (!obj || !obj->dev || !sgt)
 		return -EINVAL;
@@ -627,9 +627,11 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
 		return -EINVAL;
 	bytes = PAGE_ALIGN(bytes);
 
-	va = vmap_sg(sgt);
-	if (IS_ERR(va))
-		return PTR_ERR(va);
+	if (flags & IOVMF_MMIO) {
+		va = vmap_sg(sgt);
+		if (IS_ERR(va))
+			return PTR_ERR(va);
+	}
 
 	flags &= IOVMF_HW_MASK;
 	flags |= IOVMF_DISCONT;
