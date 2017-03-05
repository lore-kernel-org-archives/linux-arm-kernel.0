From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun,  5 Mar 2017 21:37:03 +0800
Subject: [PATCH v2 06/12] dmaengine: sun6i: make gate bit in sun8i's DMA
 engines a common quirk
In-Reply-To: <20170305133709.6288-1-icenowy@aosc.xyz>
References: <20170305133709.6288-1-icenowy@aosc.xyz>
Message-ID: <20170305133709.6288-7-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originally we enable a special gate bit when the compatible indicates
A23/33.

But according to BSP sources and user manuals, more SoCs will need this
gate bit.

So make it a common quirk configured in the config struct.

The BSP source also indicates that A83T will need this gate bit (there's
"SUN8IW6" in the #ifdef's), so also enable this gate bit for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/dma/sun6i-dma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a2358780ab2c..889fb24023cd 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -101,6 +101,7 @@ struct sun6i_dma_config {
 	u32 nr_max_channels;
 	u32 nr_max_requests;
 	u32 nr_max_vchans;
+	bool gate_needed;
 };
 
 /*
@@ -1009,12 +1010,14 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 24,
 	.nr_max_vchans   = 37,
+	.gate_needed	 = true,
 };
 
 static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 28,
 	.nr_max_vchans   = 39,
+	.gate_needed	 = true,
 };
 
 /*
@@ -1177,10 +1180,10 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	/*
 	 * sun8i variant requires us to toggle a dma gating register,
 	 * as seen in Allwinner's SDK. This register is not documented
-	 * in the A23 user manual.
+	 * in the A23 user manual, but documented at least in V3s user
+	 * manual.
 	 */
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "allwinner,sun8i-a23-dma"))
+	if (sdc->cfg->gate_needed)
 		writel(SUN8I_DMA_GATE_ENABLE, sdc->base + SUN8I_DMA_GATE);
 
 	return 0;
-- 
2.11.1
