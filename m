From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 12:57:42 +0100
Subject: [PATCH v3 6/9] ASoC: fsl-ssi: Add configuration helper functions
In-Reply-To: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387367865-26391-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a struct 'fsl_ssi_rxtx_reg_val' which holds register
values necessary to enable rx/tx. Based on those preset register values,
the added configuration functions will cleanly enable/disable different
parts of the SSI IP while supporting online/offline configuration.
Different operating modes can be setup directly as different register
values in fsl_ssi_reg_val.

These functions and structs will help to cleanup and simplify the
trigger function to support many different IP versions (online/offline
configuration) and different operating modes.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7a87d06..eabf568 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -129,6 +129,18 @@ enum fsl_ssi_type {
 	FSL_SSI_MX51,
 };
 
+struct fsl_ssi_reg_val {
+	u32 sier;
+	u32 srcr;
+	u32 stcr;
+	u32 scr;
+};
+
+struct fsl_ssi_rxtx_reg_val {
+	struct fsl_ssi_reg_val rx;
+	struct fsl_ssi_reg_val tx;
+};
+
 /**
  * fsl_ssi_private: per-SSI private data
  *
@@ -163,6 +175,8 @@ struct fsl_ssi_private {
 	struct imx_dma_data filter_data_tx;
 	struct imx_dma_data filter_data_rx;
 	struct imx_pcm_fiq_params fiq_params;
+	/* Register values for rx/tx configuration */
+	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
 
 	struct {
 		unsigned int rfrc;
@@ -443,6 +457,114 @@ static void fsl_ssi_debugfs_remove(struct fsl_ssi_private *ssi_private)
 
 #endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
 
+/*
+ * Enable/Disable all rx/tx config flags at once.
+ */
+static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
+		bool enable)
+{
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct fsl_ssi_rxtx_reg_val *vals = &ssi_private->rxtx_reg_val;
+
+	if (enable) {
+		write_ssi_mask(&ssi->sier, 0, vals->rx.sier | vals->tx.sier);
+		write_ssi_mask(&ssi->srcr, 0, vals->rx.srcr | vals->tx.srcr);
+		write_ssi_mask(&ssi->stcr, 0, vals->rx.stcr | vals->tx.stcr);
+	} else {
+		write_ssi_mask(&ssi->srcr, vals->rx.srcr | vals->tx.srcr, 0);
+		write_ssi_mask(&ssi->stcr, vals->rx.stcr | vals->tx.stcr, 0);
+		write_ssi_mask(&ssi->sier, vals->rx.sier | vals->tx.sier, 0);
+	}
+}
+
+/*
+ * Enable/Disable a ssi configuration. You have to pass either
+ * ssi_private->rxtx_reg_val.rx or tx as vals parameter.
+ */
+static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
+		struct fsl_ssi_reg_val *vals)
+{
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	struct fsl_ssi_reg_val *avals;
+	u32 scr_val = read_ssi(&ssi->scr);
+	int nr_active_streams = !!(scr_val & CCSR_SSI_SCR_TE) +
+				!!(scr_val & CCSR_SSI_SCR_RE);
+
+	/* Find the other direction values rx or tx which we do not want to
+	 * modify */
+	if (&ssi_private->rxtx_reg_val.rx == vals)
+		avals = &ssi_private->rxtx_reg_val.tx;
+	else
+		avals = &ssi_private->rxtx_reg_val.rx;
+
+	/* If vals should be disabled, start with disabling the unit */
+	if (!enable) {
+		u32 scr = vals->scr & (vals->scr ^ avals->scr);
+		write_ssi_mask(&ssi->scr, scr, 0);
+	}
+
+	/*
+	 * We are running on a SoC which does not support online SSI
+	 * reconfiguration, so we have to enable all necessary flags at once
+	 * even if we do not use them later (capture and playback configuration)
+	 */
+	if (ssi_private->offline_config) {
+		if ((enable && !nr_active_streams) ||
+				(!enable && nr_active_streams == 1))
+			fsl_ssi_rxtx_config(ssi_private, enable);
+
+		goto config_done;
+	}
+
+	/*
+	 * Configure single direction units while the SSI unit is running
+	 * (online configuration)
+	 */
+	if (enable) {
+		write_ssi_mask(&ssi->sier, 0, vals->sier);
+		write_ssi_mask(&ssi->srcr, 0, vals->srcr);
+		write_ssi_mask(&ssi->stcr, 0, vals->stcr);
+	} else {
+		u32 sier;
+		u32 srcr;
+		u32 stcr;
+
+		/*
+		 * Disabling the necessary flags for one of rx/tx while the
+		 * other stream is active is a little bit more difficult. We
+		 * have to disable only those flags that differ between both
+		 * streams (rx XOR tx) and that are set in the stream that is
+		 * disabled now. Otherwise we could alter flags of the other
+		 * stream
+		 */
+
+		/* These assignments are simply vals without bits set in avals*/
+		sier = vals->sier & (vals->sier ^ avals->sier);
+		srcr = vals->srcr & (vals->srcr ^ avals->srcr);
+		stcr = vals->stcr & (vals->stcr ^ avals->stcr);
+
+		write_ssi_mask(&ssi->srcr, srcr, 0);
+		write_ssi_mask(&ssi->stcr, stcr, 0);
+		write_ssi_mask(&ssi->sier, sier, 0);
+	}
+
+config_done:
+	/* Enabling of subunits is done after configuration */
+	if (enable)
+		write_ssi_mask(&ssi->scr, 0, vals->scr);
+}
+
+
+static void fsl_ssi_rx_config(struct fsl_ssi_private *ssi_private, bool enable)
+{
+	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.rx);
+}
+
+static void fsl_ssi_tx_config(struct fsl_ssi_private *ssi_private, bool enable)
+{
+	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.tx);
+}
+
 static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 {
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-- 
1.8.5.1
