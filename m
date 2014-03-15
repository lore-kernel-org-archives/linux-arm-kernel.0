From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 15 Mar 2014 13:44:19 +0100
Subject: [PATCH v2 11/16] ASoC: fsl-ssi: Fix register values when disabling
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1394887464-969-12-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bits we have to clear when disabling are different when the other
stream is still active.

This patch fixes the calculation of new register values after disabling
one stream. It also adds a more detailed description of the new register
value calculation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c8002d3..0d10b7e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -329,6 +329,26 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
 }
 
 /*
+ * Calculate the bits that have to be disabled for the current stream that is
+ * getting disabled. This keeps the bits enabled that are necessary for the
+ * second stream to work if 'stream_active' is true.
+ *
+ * Detailed calculation:
+ * These are the values that need to be active after disabling. For non-active
+ * second stream, this is 0:
+ *	vals_stream * !!stream_active
+ *
+ * The following computes the overall differences between the setup for the
+ * to-disable stream and the active stream, a simple XOR:
+ *	vals_disable ^ (vals_stream * !!(stream_active))
+ *
+ * The full expression adds a mask on all values we care about
+ */
+#define fsl_ssi_disable_val(vals_disable, vals_stream, stream_active) \
+	((vals_disable) & \
+	 ((vals_disable) ^ ((vals_stream) * (u32)!!(stream_active))))
+
+/*
  * Enable/Disable a ssi configuration. You have to pass either
  * ssi_private->rxtx_reg_val.rx or tx as vals parameter.
  */
@@ -340,6 +360,12 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	u32 scr_val = read_ssi(&ssi->scr);
 	int nr_active_streams = !!(scr_val & CCSR_SSI_SCR_TE) +
 				!!(scr_val & CCSR_SSI_SCR_RE);
+	int keep_active;
+
+	if (nr_active_streams - 1 > 0)
+		keep_active = 1;
+	else
+		keep_active = 0;
 
 	/* Find the other direction values rx or tx which we do not want to
 	 * modify */
@@ -350,7 +376,8 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 
 	/* If vals should be disabled, start with disabling the unit */
 	if (!enable) {
-		u32 scr = vals->scr & (vals->scr ^ avals->scr);
+		u32 scr = fsl_ssi_disable_val(vals->scr, avals->scr,
+				keep_active);
 		write_ssi_mask(&ssi->scr, scr, 0);
 	}
 
@@ -361,7 +388,7 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 */
 	if (fsl_ssi_offline_config(ssi_private)) {
 		if ((enable && !nr_active_streams) ||
-				(!enable && nr_active_streams == 1))
+				(!enable && !keep_active))
 			fsl_ssi_rxtx_config(ssi_private, enable);
 
 		goto config_done;
@@ -390,9 +417,12 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 		 */
 
 		/* These assignments are simply vals without bits set in avals*/
-		sier = vals->sier & (vals->sier ^ avals->sier);
-		srcr = vals->srcr & (vals->srcr ^ avals->srcr);
-		stcr = vals->stcr & (vals->stcr ^ avals->stcr);
+		sier = fsl_ssi_disable_val(vals->sier, avals->sier,
+				keep_active);
+		srcr = fsl_ssi_disable_val(vals->srcr, avals->srcr,
+				keep_active);
+		stcr = fsl_ssi_disable_val(vals->stcr, avals->stcr,
+				keep_active);
 
 		write_ssi_mask(&ssi->srcr, srcr, 0);
 		write_ssi_mask(&ssi->stcr, stcr, 0);
-- 
1.9.0
