From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:17 +0200
Subject: [PATCH 04/40] dmaengine i.MX SDMA: do not depend on grouped clocks
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the current i.MX clock support groups together unrelated clocks
to a single clock which is then used by the driver. This can't
be accomplished with the generic clock framework so we instead
request the individual clocks in the driver. For i.MX there are
generally three different clocks:

ipg: bus clock (needed to access registers)
ahb: dma relevant clock, sometimes referred to as hclk in the datasheet
per: bit clock, pixel clock

This patch changes the driver to request the individual clocks.
Currently all clk_get will get the same clock until the SoCs
are converted to the generic clock framework

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |   40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d3e38e2..fddccae 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -322,7 +322,8 @@ struct sdma_engine {
 	struct sdma_context_data	*context;
 	dma_addr_t			context_phys;
 	struct dma_device		dma_device;
-	struct clk			*clk;
+	struct clk			*clk_ipg;
+	struct clk			*clk_ahb;
 	struct mutex			channel_0_lock;
 	struct sdma_script_start_addrs	*script_addrs;
 };
@@ -859,7 +860,8 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	sdmac->peripheral_type = data->peripheral_type;
 	sdmac->event_id0 = data->dma_request;
 
-	clk_enable(sdmac->sdma->clk);
+	clk_enable(sdmac->sdma->clk_ipg);
+	clk_enable(sdmac->sdma->clk_ahb);
 
 	ret = sdma_request_channel(sdmac);
 	if (ret)
@@ -896,7 +898,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	dma_free_coherent(NULL, PAGE_SIZE, sdmac->bd, sdmac->bd_phys);
 
-	clk_disable(sdma->clk);
+	clk_disable(sdma->clk_ipg);
+	clk_disable(sdma->clk_ahb);
 }
 
 static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
@@ -1169,12 +1172,14 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 	addr = (void *)header + header->script_addrs_start;
 	ram_code = (void *)header + header->ram_code_start;
 
-	clk_enable(sdma->clk);
+	clk_enable(sdma->clk_ipg);
+	clk_enable(sdma->clk_ahb);
 	/* download the RAM image for SDMA */
 	sdma_load_script(sdma, ram_code,
 			header->ram_code_size,
 			addr->ram_code_start_addr);
-	clk_disable(sdma->clk);
+	clk_disable(sdma->clk_ipg);
+	clk_disable(sdma->clk_ahb);
 
 	sdma_add_scripts(sdma, addr);
 
@@ -1216,7 +1221,8 @@ static int __init sdma_init(struct sdma_engine *sdma)
 		return -ENODEV;
 	}
 
-	clk_enable(sdma->clk);
+	clk_enable(sdma->clk_ipg);
+	clk_enable(sdma->clk_ahb);
 
 	/* Be sure SDMA has not started yet */
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
@@ -1269,12 +1275,14 @@ static int __init sdma_init(struct sdma_engine *sdma)
 	/* Initializes channel's priorities */
 	sdma_set_channel_priority(&sdma->channel[0], 7);
 
-	clk_disable(sdma->clk);
+	clk_disable(sdma->clk_ipg);
+	clk_disable(sdma->clk_ahb);
 
 	return 0;
 
 err_dma_alloc:
-	clk_disable(sdma->clk);
+	clk_disable(sdma->clk_ipg);
+	clk_disable(sdma->clk_ahb);
 	dev_err(sdma->dev, "initialisation failed with %d\n", ret);
 	return ret;
 }
@@ -1313,12 +1321,21 @@ static int __init sdma_probe(struct platform_device *pdev)
 		goto err_request_region;
 	}
 
-	sdma->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(sdma->clk)) {
-		ret = PTR_ERR(sdma->clk);
+	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(sdma->clk_ipg)) {
+		ret = PTR_ERR(sdma->clk_ipg);
 		goto err_clk;
 	}
 
+	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(sdma->clk_ahb)) {
+		ret = PTR_ERR(sdma->clk_ahb);
+		goto err_clk;
+	}
+
+	clk_prepare(sdma->clk_ipg);
+	clk_prepare(sdma->clk_ahb);
+
 	sdma->regs = ioremap(iores->start, resource_size(iores));
 	if (!sdma->regs) {
 		ret = -ENOMEM;
@@ -1426,7 +1443,6 @@ err_alloc:
 err_request_irq:
 	iounmap(sdma->regs);
 err_ioremap:
-	clk_put(sdma->clk);
 err_clk:
 	release_mem_region(iores->start, resource_size(iores));
 err_request_region:
-- 
1.7.9.5
