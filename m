From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 21 Nov 2012 23:07:59 +0000 (UTC)
Subject: [PATCH v2 2/2] ARM: OMAP: omap_device: Correct resource handling
 for DT boot
In-Reply-To: <1351596296-13825-3-git-send-email-peter.ujfalusi@ti.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com>
 <1351596296-13825-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.00.1211212307200.32242@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Oct 2012, Peter Ujfalusi wrote:

> When booting with DT the OF core can fill up the resources provided within
> the DT blob.
> The current way of handling the DT boot prevents us from removing hwmod data
> for platforms only suppose to boot with DT (OMAP5 for example) since we need
> to keep the whole hwmod database intact in order to have more resources in
> hwmod than in DT (to be able to append the DMA resource from hwmod).
> 
> To fix this issue we just examine the OF provided resources:
> If we do not have resources we use hwmod to fill them.
> If we have resources we check if we already able to recive DMA resource, if
> no we only append the DMA resurce from hwmod to the OF provided ones.
> 
> In this way we can start removing hwmod data for devices which have their
> resources correctly configured in DT without regressions.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Here's this one, updated to apply after the v3.8 cleanups.


- Paul

>From 65e57fff87781b60e9406888e0ae803cb0df41cc Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 21 Nov 2012 11:50:46 -0700
Subject: [PATCH 2/2] ARM: OMAP2+: omap_device: Correct resource handling for
 DT boot
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When booting with DT the OF core can fill up the resources provided within
the DT blob.
The current way of handling the DT boot prevents us from removing hwmod data
for platforms only suppose to boot with DT (OMAP5 for example) since we need
to keep the whole hwmod database intact in order to have more resources in
hwmod than in DT (to be able to append the DMA resource from hwmod).

To fix this issue we just examine the OF provided resources:
If we do not have resources we use hwmod to fill them.
If we have resources we check if we already able to recive DMA resource, if
no we only append the DMA resurce from hwmod to the OF provided ones.

In this way we can start removing hwmod data for devices which have their
resources correctly configured in DT without regressions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Beno?t Cousson <b-cousson@ti.com>
[paul at pwsan.com: fixed checkpatch problem; updated to apply]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_device.c |   84 ++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 8917a08..e065daa 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -559,55 +559,73 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
 	od->hwmods = hwmods;
 	od->pdev = pdev;
 
-	/* Count all resources for the device */
-	res_count = omap_device_count_resources(od, IORESOURCE_IRQ |
-						    IORESOURCE_DMA |
-						    IORESOURCE_MEM);
 	/*
+	 * Non-DT Boot:
+	 *   Here, pdev->num_resources = 0, and we should get all the
+	 *   resources from hwmod.
+	 *
 	 * DT Boot:
 	 *   OF framework will construct the resource structure (currently
 	 *   does for MEM & IRQ resource) and we should respect/use these
 	 *   resources, killing hwmod dependency.
 	 *   If pdev->num_resources > 0, we assume that MEM & IRQ resources
 	 *   have been allocated by OF layer already (through DTB).
-	 *
-	 * Non-DT Boot:
-	 *   Here, pdev->num_resources = 0, and we should get all the
-	 *   resources from hwmod.
+	 *   As preparation for the future we examine the OF provided resources
+	 *   to see if we have DMA resources provided already. In this case
+	 *   there is no need to update the resources for the device, we use the
+	 *   OF provided ones.
 	 *
 	 * TODO: Once DMA resource is available from OF layer, we should
 	 *   kill filling any resources from hwmod.
 	 */
-	if (res_count > pdev->num_resources) {
-		/* Allocate resources memory to account for new resources */
-		res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
-		if (!res)
-			goto oda_exit3;
-
-		/*
-		 * If pdev->num_resources > 0, then assume that,
-		 * MEM and IRQ resources will only come from DT and only
-		 * fill DMA resource from hwmod layer.
-		 */
-		if (pdev->num_resources && pdev->resource) {
-			dev_dbg(&pdev->dev, "%s(): resources already allocated %d\n",
-				__func__, res_count);
-			memcpy(res, pdev->resource,
-			       sizeof(struct resource) * pdev->num_resources);
-			_od_fill_dma_resources(od, &res[pdev->num_resources]);
-		} else {
-			dev_dbg(&pdev->dev, "%s(): using resources from hwmod %d\n",
-				__func__, res_count);
-			omap_device_fill_resources(od, res);
+	if (!pdev->num_resources) {
+		/* Count all resources for the device */
+		res_count = omap_device_count_resources(od, IORESOURCE_IRQ |
+							    IORESOURCE_DMA |
+							    IORESOURCE_MEM);
+	} else {
+		/* Take a look if we already have DMA resource via DT */
+		for (i = 0; i < pdev->num_resources; i++) {
+			struct resource *r = &pdev->resource[i];
+
+			/* We have it, no need to touch the resources */
+			if (r->flags == IORESOURCE_DMA)
+				goto have_everything;
 		}
+		/* Count only DMA resources for the device */
+		res_count = omap_device_count_resources(od, IORESOURCE_DMA);
+		/* The device has no DMA resource, no need for update */
+		if (!res_count)
+			goto have_everything;
 
-		ret = platform_device_add_resources(pdev, res, res_count);
-		kfree(res);
+		res_count += pdev->num_resources;
+	}
 
-		if (ret)
-			goto oda_exit3;
+	/* Allocate resources memory to account for new resources */
+	res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
+	if (!res)
+		goto oda_exit3;
+
+	if (!pdev->num_resources) {
+		dev_dbg(&pdev->dev, "%s: using %d resources from hwmod\n",
+			__func__, res_count);
+		omap_device_fill_resources(od, res);
+	} else {
+		dev_dbg(&pdev->dev,
+			"%s: appending %d DMA resources from hwmod\n",
+			__func__, res_count - pdev->num_resources);
+		memcpy(res, pdev->resource,
+		       sizeof(struct resource) * pdev->num_resources);
+		_od_fill_dma_resources(od, &res[pdev->num_resources]);
 	}
 
+	ret = platform_device_add_resources(pdev, res, res_count);
+	kfree(res);
+
+	if (ret)
+		goto oda_exit3;
+
+have_everything:
 	if (!pm_lats) {
 		pm_lats = omap_default_latency;
 		pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
-- 
1.7.10.4
