From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 10:57:19 +0200
Subject: [PATCH 2/4] staging: drm/imx: ipu-dmfc: fix bandwidth allocation
In-Reply-To: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
References: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1371805041-9299-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IPU can request up to four pixels per access, which gives four
times the bandwidth compared to what the driver currently assumes.
After correcting this, we have to increase safety margins for
bandwidth requirement calculations.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
index 91821bc..1dc9817 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
@@ -292,7 +292,7 @@ int ipu_dmfc_alloc_bandwidth(struct dmfc_channel *dmfc,
 {
 	struct ipu_dmfc_priv *priv = dmfc->priv;
 	int slots = dmfc_bandwidth_to_slots(priv, bandwidth_pixel_per_second);
-	int segment = 0, ret = 0;
+	int segment = -1, ret = 0;
 
 	dev_dbg(priv->dev, "dmfc: trying to allocate %ldMpixel/s for IPU channel %d\n",
 			bandwidth_pixel_per_second / 1000000,
@@ -307,7 +307,17 @@ int ipu_dmfc_alloc_bandwidth(struct dmfc_channel *dmfc,
 		goto out;
 	}
 
-	segment = dmfc_find_slots(priv, slots);
+	/* Always allocate at least 128*4 bytes (2 slots) */
+	if (slots < 2)
+		slots = 2;
+
+	/* For the MEM_BG channel, first try to allocate twice the slots */
+	if (dmfc->data->ipu_channel == IPUV3_CHANNEL_MEM_BG_SYNC)
+		segment = dmfc_find_slots(priv, slots * 2);
+	if (segment >= 0)
+		slots *= 2;
+	else
+		segment = dmfc_find_slots(priv, slots);
 	if (segment < 0) {
 		ret = -EBUSY;
 		goto out;
@@ -391,7 +401,7 @@ int ipu_dmfc_init(struct ipu_soc *ipu, struct device *dev, unsigned long base,
 	 * We have a total bandwidth of clkrate * 4pixel divided
 	 * into 8 slots.
 	 */
-	priv->bandwidth_per_slot = clk_get_rate(ipu_clk) / 8;
+	priv->bandwidth_per_slot = clk_get_rate(ipu_clk) * 4 / 8;
 
 	dev_dbg(dev, "dmfc: 8 slots with %ldMpixel/s bandwidth each\n",
 			priv->bandwidth_per_slot / 1000000);
-- 
1.8.3.1
