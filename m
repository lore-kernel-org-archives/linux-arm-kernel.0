From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 03 Dec 2009 06:49:48 -0700
Subject: [PATCH 03/10] OMAP hwmod: add names to module MPU IRQ lines
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Message-ID: <20091203134943.17146.88603.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the existing u8 array of module MPU IRQ lines with a struct
that includes a name - similar to the existing struct
omap_hwmod_dma_info.  Device drivers can then use
platform_get_resource_byname() to retrieve specific IRQs without nasty
dependencies on array ordering.

Thanks to Beno?t Cousson <b-cousson@ti.com> and Kevin Hilman
<khilman@deeprootsystems.com> for feedback on this approach.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    5 +++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 709ec5d..234567b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1389,8 +1389,9 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 	/* For each IRQ, DMA, memory area, fill in array.*/
 
 	for (i = 0; i < oh->mpu_irqs_cnt; i++) {
-		(res + r)->start = *(oh->mpu_irqs + i);
-		(res + r)->end = *(oh->mpu_irqs + i);
+		(res + r)->name = (oh->mpu_irqs + i)->name;
+		(res + r)->start = (oh->mpu_irqs + i)->irq;
+		(res + r)->end = (oh->mpu_irqs + i)->irq;
 		(res + r)->flags = IORESOURCE_IRQ;
 		r++;
 	}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 643a972..007935a 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -64,7 +64,21 @@ struct omap_device;
 
 
 /**
- * struct omap_hwmod_dma_info - MPU address space handled by the hwmod
+ * struct omap_hwmod_irq_info - MPU IRQs used by the hwmod
+ * @name: name of the IRQ channel (module local name)
+ * @irq_ch: IRQ channel ID
+ *
+ * @name should be something short, e.g., "tx" or "rx".  It is for use
+ * by platform_get_resource_byname().  It is defined locally to the
+ * hwmod.
+ */
+struct omap_hwmod_irq_info {
+	const char	*name;
+	u16		irq;
+};
+
+/**
+ * struct omap_hwmod_dma_info - DMA channels used by the hwmod
  * @name: name of the DMA channel (module local name)
  * @dma_ch: DMA channel ID
  *
@@ -379,7 +393,7 @@ struct omap_hwmod_omap4_prcm {
 struct omap_hwmod {
 	const char			*name;
 	struct omap_device		*od;
-	u8				*mpu_irqs;
+	struct omap_hwmod_irq_info	*mpu_irqs;
 	struct omap_hwmod_dma_info	*sdma_chs;
 	union {
 		struct omap_hwmod_omap2_prcm omap2;
