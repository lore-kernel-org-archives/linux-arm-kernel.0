From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 21 Nov 2012 23:07:17 +0000 (UTC)
Subject: [PATCH v2 1/2] ARM: OMAP: hwmod: Add possibility to count hwmod
 resources based on type
In-Reply-To: <1351596296-13825-2-git-send-email-peter.ujfalusi@ti.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com>
 <1351596296-13825-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.00.1211212306340.32242@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Oct 2012, Peter Ujfalusi wrote:

> Add flags parameter for omap_hwmod_count_resources() so users can tell which
> type of resources they are interested when counting them in hwmod database.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Here's this one, updated to apply after the various cleanups.


- Paul

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 21 Nov 2012 11:50:12 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod: Add possibility to count hwmod
 resources based on type
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add flags parameter for omap_hwmod_count_resources() so users can tell which
type of resources they are interested when counting them in hwmod database.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Beno?t Cousson <b-cousson@ti.com>
[paul at pwsan.com: updated to apply]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_device.c |   11 ++++++++---
 arch/arm/mach-omap2/omap_hwmod.c  |   27 ++++++++++++++++-----------
 arch/arm/mach-omap2/omap_hwmod.h  |    2 +-
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 0ef934f..8917a08 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -441,19 +441,21 @@ int omap_device_get_context_loss_count(struct platform_device *pdev)
 /**
  * omap_device_count_resources - count number of struct resource entries needed
  * @od: struct omap_device *
+ * @flags: Type of resources to include when counting (IRQ/DMA/MEM)
  *
  * Count the number of struct resource entries needed for this
  * omap_device @od.  Used by omap_device_build_ss() to determine how
  * much memory to allocate before calling
  * omap_device_fill_resources().  Returns the count.
  */
-static int omap_device_count_resources(struct omap_device *od)
+static int omap_device_count_resources(struct omap_device *od,
+				       unsigned long flags)
 {
 	int c = 0;
 	int i;
 
 	for (i = 0; i < od->hwmods_cnt; i++)
-		c += omap_hwmod_count_resources(od->hwmods[i]);
+		c += omap_hwmod_count_resources(od->hwmods[i], flags);
 
 	pr_debug("omap_device: %s: counted %d total resources across %d hwmods\n",
 		 od->pdev->name, c, od->hwmods_cnt);
@@ -557,7 +559,10 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
 	od->hwmods = hwmods;
 	od->pdev = pdev;
 
-	res_count = omap_device_count_resources(od);
+	/* Count all resources for the device */
+	res_count = omap_device_count_resources(od, IORESOURCE_IRQ |
+						    IORESOURCE_DMA |
+						    IORESOURCE_MEM);
 	/*
 	 * DT Boot:
 	 *   OF framework will construct the resource structure (currently
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 083adbe..a809090 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3427,7 +3427,7 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
 /**
  * omap_hwmod_count_resources - count number of struct resources needed by hwmod
  * @oh: struct omap_hwmod *
- * @res: pointer to the first element of an array of struct resource to fill
+ * @flags: Type of resources to include when counting (IRQ/DMA/MEM)
  *
  * Count the number of struct resource array elements necessary to
  * contain omap_hwmod @oh resources.  Intended to be called by code
@@ -3440,20 +3440,25 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
  * resource IDs.
  *
  */
-int omap_hwmod_count_resources(struct omap_hwmod *oh)
+int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags)
 {
-	struct omap_hwmod_ocp_if *os;
-	struct list_head *p;
-	int ret;
-	int i = 0;
+	int ret = 0;
 
-	ret = _count_mpu_irqs(oh) + _count_sdma_reqs(oh);
+	if (flags & IORESOURCE_IRQ)
+		ret += _count_mpu_irqs(oh);
 
-	p = oh->slave_ports.next;
+	if (flags & IORESOURCE_DMA)
+		ret += _count_sdma_reqs(oh);
 
-	while (i < oh->slaves_cnt) {
-		os = _fetch_next_ocp_if(&p, &i);
-		ret += _count_ocp_if_addr_spaces(os);
+	if (flags & IORESOURCE_MEM) {
+		int i = 0;
+		struct omap_hwmod_ocp_if *os;
+		struct list_head *p = oh->slave_ports.next;
+
+		while (i < oh->slaves_cnt) {
+			os = _fetch_next_ocp_if(&p, &i);
+			ret += _count_ocp_if_addr_spaces(os);
+		}
 	}
 
 	return ret;
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 421ff65..86b7414 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -631,7 +631,7 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs);
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs);
 int omap_hwmod_softreset(struct omap_hwmod *oh);
 
-int omap_hwmod_count_resources(struct omap_hwmod *oh);
+int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags);
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
 int omap_hwmod_fill_dma_resources(struct omap_hwmod *oh, struct resource *res);
 int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
-- 
1.7.10.4
