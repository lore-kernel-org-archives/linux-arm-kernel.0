From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 11 Oct 2013 12:11:03 +0200
Subject: [PATCH 2/3] ASoC: mxs-saif: Store saif state
In-Reply-To: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
References: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1381486264-1672-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trigger commands may be passed multiple times. To avoid errors with
clk_enable/disable, store the saif state and return if saif is already
running/stopped.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/mxs/mxs-saif.c | 8 ++++++++
 sound/soc/mxs/mxs-saif.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index b56b8a0..c8ead01 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -503,6 +503,9 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (saif->state == MXS_SAIF_STATE_RUNNING)
+			return 0;
+
 		dev_dbg(cpu_dai->dev, "start\n");
 
 		clk_enable(master_saif->clk);
@@ -543,6 +546,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 		}
 
 		master_saif->ongoing = 1;
+		saif->state = MXS_SAIF_STATE_RUNNING;
 
 		dev_dbg(saif->dev, "CTRL 0x%x STAT 0x%x\n",
 			__raw_readl(saif->base + SAIF_CTRL),
@@ -555,6 +559,9 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (saif->state == MXS_SAIF_STATE_STOPPED)
+			return 0;
+
 		dev_dbg(cpu_dai->dev, "stop\n");
 
 		/* wait a while for the current sample to complete */
@@ -575,6 +582,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 		}
 
 		master_saif->ongoing = 0;
+		saif->state = MXS_SAIF_STATE_STOPPED;
 
 		break;
 	default:
diff --git a/sound/soc/mxs/mxs-saif.h b/sound/soc/mxs/mxs-saif.h
index 53eaa4b..fbaf7ba 100644
--- a/sound/soc/mxs/mxs-saif.h
+++ b/sound/soc/mxs/mxs-saif.h
@@ -124,6 +124,11 @@ struct mxs_saif {
 
 	u32 fifo_underrun;
 	u32 fifo_overrun;
+
+	enum {
+		MXS_SAIF_STATE_STOPPED,
+		MXS_SAIF_STATE_RUNNING,
+	} state;
 };
 
 extern int mxs_saif_put_mclk(unsigned int saif_id);
-- 
1.8.4.rc3
