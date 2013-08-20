From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Aug 2013 10:04:31 +0200
Subject: [PATCH 1/3] dma: imx-sdma: Use struct for driver data
In-Reply-To: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
References: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1376985873-25776-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a struct type instead of an enum type for distinguishing between
different versions. This makes it simpler to handle multiple differences
withtou cluttering the code with comparisons for certain devtypes.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 63 ++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 1e44b8c..e3e7e3f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -307,9 +307,9 @@ struct sdma_firmware_header {
 	u32	ram_code_size;
 };
 
-enum sdma_devtype {
-	IMX31_SDMA,	/* runs on i.mx31 */
-	IMX35_SDMA,	/* runs on i.mx35 and later */
+struct sdma_driver_data {
+	int chnenbl0;
+	int num_events;
 };
 
 struct sdma_engine {
@@ -318,8 +318,6 @@ struct sdma_engine {
 	struct sdma_channel		channel[MAX_DMA_CHANNELS];
 	struct sdma_channel_control	*channel_control;
 	void __iomem			*regs;
-	enum sdma_devtype		devtype;
-	unsigned int			num_events;
 	struct sdma_context_data	*context;
 	dma_addr_t			context_phys;
 	struct dma_device		dma_device;
@@ -327,15 +325,26 @@ struct sdma_engine {
 	struct clk			*clk_ahb;
 	spinlock_t			channel_0_lock;
 	struct sdma_script_start_addrs	*script_addrs;
+	const struct sdma_driver_data	*drvdata;
+};
+
+struct sdma_driver_data sdma_imx31 = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX31,
+	.num_events = 32,
+};
+
+struct sdma_driver_data sdma_imx35 = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
 };
 
 static struct platform_device_id sdma_devtypes[] = {
 	{
 		.name = "imx31-sdma",
-		.driver_data = IMX31_SDMA,
+		.driver_data = (unsigned long)&sdma_imx31,
 	}, {
 		.name = "imx35-sdma",
-		.driver_data = IMX35_SDMA,
+		.driver_data = (unsigned long)&sdma_imx35,
 	}, {
 		/* sentinel */
 	}
@@ -343,8 +352,8 @@ static struct platform_device_id sdma_devtypes[] = {
 MODULE_DEVICE_TABLE(platform, sdma_devtypes);
 
 static const struct of_device_id sdma_dt_ids[] = {
-	{ .compatible = "fsl,imx31-sdma", .data = &sdma_devtypes[IMX31_SDMA], },
-	{ .compatible = "fsl,imx35-sdma", .data = &sdma_devtypes[IMX35_SDMA], },
+	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
+	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
@@ -356,8 +365,7 @@ MODULE_DEVICE_TABLE(of, sdma_dt_ids);
 
 static inline u32 chnenbl_ofs(struct sdma_engine *sdma, unsigned int event)
 {
-	u32 chnenbl0 = (sdma->devtype == IMX31_SDMA ? SDMA_CHNENBL0_IMX31 :
-						      SDMA_CHNENBL0_IMX35);
+	u32 chnenbl0 = sdma->drvdata->chnenbl0;
 	return chnenbl0 + event * 4;
 }
 
@@ -733,7 +741,7 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
 	sdmac->per_addr = 0;
 
 	if (sdmac->event_id0) {
-		if (sdmac->event_id0 >= sdmac->sdma->num_events)
+		if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
 			return -EINVAL;
 		sdma_event_enable(sdmac, sdmac->event_id0);
 	}
@@ -1218,19 +1226,6 @@ static int __init sdma_init(struct sdma_engine *sdma)
 	int i, ret;
 	dma_addr_t ccb_phys;
 
-	switch (sdma->devtype) {
-	case IMX31_SDMA:
-		sdma->num_events = 32;
-		break;
-	case IMX35_SDMA:
-		sdma->num_events = 48;
-		break;
-	default:
-		dev_err(sdma->dev, "Unknown sdma type %d. aborting\n",
-			sdma->devtype);
-		return -ENODEV;
-	}
-
 	clk_enable(sdma->clk_ipg);
 	clk_enable(sdma->clk_ahb);
 
@@ -1257,7 +1252,7 @@ static int __init sdma_init(struct sdma_engine *sdma)
 			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control));
 
 	/* disable all channels */
-	for (i = 0; i < sdma->num_events; i++)
+	for (i = 0; i < sdma->drvdata->num_events; i++)
 		writel_relaxed(0, sdma->regs + chnenbl_ofs(sdma, i));
 
 	/* All channels have priority 0 */
@@ -1339,6 +1334,17 @@ static int __init sdma_probe(struct platform_device *pdev)
 	int i;
 	struct sdma_engine *sdma;
 	s32 *saddr_arr;
+	const struct sdma_driver_data *drvdata = NULL;
+
+	if (of_id)
+		drvdata = of_id->data;
+	else if (pdev->id_entry)
+		drvdata = (void *)pdev->id_entry->driver_data;
+
+	if (!drvdata) {
+		dev_err(&pdev->dev, "unable to find driver data\n");
+		return -EINVAL;
+	}
 
 	sdma = kzalloc(sizeof(*sdma), GFP_KERNEL);
 	if (!sdma)
@@ -1347,6 +1353,7 @@ static int __init sdma_probe(struct platform_device *pdev)
 	spin_lock_init(&sdma->channel_0_lock);
 
 	sdma->dev = &pdev->dev;
+	sdma->drvdata = drvdata;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
@@ -1396,10 +1403,6 @@ static int __init sdma_probe(struct platform_device *pdev)
 	for (i = 0; i < SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1; i++)
 		saddr_arr[i] = -EINVAL;
 
-	if (of_id)
-		pdev->id_entry = of_id->data;
-	sdma->devtype = pdev->id_entry->driver_data;
-
 	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
 
-- 
1.8.4.rc3
