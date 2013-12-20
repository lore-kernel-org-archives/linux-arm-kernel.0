From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 20 Dec 2013 14:11:32 +0100
Subject: [PATCH v4 5/9] ASoC: fsl-ssi: Add offline_config flag
In-Reply-To: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387545096-2334-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx50-ssi and later versions of this IP support online reconfiguration
of all registers. The reference manual does not list any registers that
can only be configured while the SSI unit is disabled. This patch
introduces the flag for later use.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f37bcbe..2f25525 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -159,6 +159,7 @@ struct fsl_ssi_private {
 	bool use_dma;
 	bool baudclk_locked;
 	bool irq_stats;
+	bool offline_config;
 	u8 i2s_mode;
 	spinlock_t baudclk_lock;
 	struct clk *baudclk;
@@ -1251,6 +1252,32 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ssi_private->baudclk_locked = false;
 	spin_lock_init(&ssi_private->baudclk_lock);
 
+	/*
+	 * imx51 and later SoCs have a slightly different IP that allows the
+	 * SSI configuration while the SSI unit is running.
+	 *
+	 * More important, it is necessary on those SoCs to configure the
+	 * sperate TX/RX DMA bits just before starting the stream
+	 * (fsl_ssi_trigger). The SDMA unit has to be configured before fsl_ssi
+	 * sends any DMA requests to the SDMA unit, otherwise it is not defined
+	 * how the SDMA unit handles the DMA request.
+	 *
+	 * SDMA units are present on devices starting at imx35 but the imx35
+	 * reference manual states that the DMA bits should not be changed
+	 * while the SSI unit is running (SSIEN). So we support the necessary
+	 * online configuration of fsl-ssi starting at imx51.
+	 */
+	switch (hw_type) {
+	case FSL_SSI_MCP8610:
+	case FSL_SSI_MX21:
+	case FSL_SSI_MX35:
+		ssi_private->offline_config = true;
+		break;
+	case FSL_SSI_MX51:
+		ssi_private->offline_config = false;
+		break;
+	}
+
 	if (hw_type == FSL_SSI_MX21 || hw_type == FSL_SSI_MX51 ||
 			hw_type == FSL_SSI_MX35) {
 		u32 dma_events[2];
-- 
1.8.5.1
