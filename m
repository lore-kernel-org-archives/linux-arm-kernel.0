From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jul 2018 10:49:40 +0100
Subject: [PATCH 2/6] ASoC: qdsp6: q6afe-dai: add support to slim tx dais
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180704094944.16440-3-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to SLIMbus TX dais in AFE module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 175 +++++++++++++++++++++++++++++++++++----
 1 file changed, 161 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 1d2e5013c121..8dd3683eb367 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -382,23 +382,31 @@ static int q6slim_set_channel_map(struct snd_soc_dai *dai,
 	struct q6afe_port_config *pcfg = &dai_data->port_config[dai->id];
 	int i;
 
-	if (!rx_slot) {
-		pr_err("%s: rx slot not found\n", __func__);
-		return -EINVAL;
-	}
+	if (dai->id & 0x1) {
+		/* TX */
+		if (!tx_slot) {
+			pr_err("%s: tx slot not found\n", __func__);
+			return -EINVAL;
+		}
 
-	for (i = 0; i < rx_num; i++) {
-		pcfg->slim.ch_mapping[i] =   rx_slot[i];
-		pr_debug("%s: find number of channels[%d] ch[%d]\n",
-		       __func__, i, rx_slot[i]);
-	}
+		for (i = 0; i < tx_num; i++)
+			pcfg->slim.ch_mapping[i] = tx_slot[i];
+
+		pcfg->slim.num_channels = tx_num;
+
+
+	} else {
+		if (!rx_slot) {
+			pr_err("%s: rx slot not found\n", __func__);
+			return -EINVAL;
+		}
 
-	pcfg->slim.num_channels = rx_num;
+		for (i = 0; i < rx_num; i++)
+			pcfg->slim.ch_mapping[i] =   rx_slot[i];
 
-	pr_debug("%s: SLIMBUS_%d_RX cnt[%d] ch[%d %d]\n", __func__,
-		(dai->id - SLIMBUS_0_RX) / 2, rx_num,
-		pcfg->slim.ch_mapping[0],
-		pcfg->slim.ch_mapping[1]);
+		pcfg->slim.num_channels = rx_num;
+
+	}
 
 	return 0;
 }
@@ -443,6 +451,14 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"Slimbus5 Playback", NULL, "SLIMBUS_5_RX"},
 	{"Slimbus6 Playback", NULL, "SLIMBUS_6_RX"},
 
+	{"SLIMBUS_0_TX", NULL, "Slimbus Capture"},
+	{"SLIMBUS_1_TX", NULL, "Slimbus1 Capture"},
+	{"SLIMBUS_2_TX", NULL, "Slimbus2 Capture"},
+	{"SLIMBUS_3_TX", NULL, "Slimbus3 Capture"},
+	{"SLIMBUS_4_TX", NULL, "Slimbus4 Capture"},
+	{"SLIMBUS_5_TX", NULL, "Slimbus5 Capture"},
+	{"SLIMBUS_6_TX", NULL, "Slimbus6 Capture"},
+
 	{"Primary MI2S Playback", NULL, "PRI_MI2S_RX"},
 	{"Secondary MI2S Playback", NULL, "SEC_MI2S_RX"},
 	{"Tertiary MI2S Playback", NULL, "TERT_MI2S_RX"},
@@ -636,6 +652,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 			.rate_min = 8000,
 			.rate_max = 192000,
 		},
+	}, {
+		.name = "SLIMBUS_0_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_0_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus1 Playback",
@@ -654,6 +688,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_1_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.name = "SLIMBUS_1_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_1_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus1 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus2 Playback",
@@ -672,6 +724,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_2_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+
+	}, {
+		.name = "SLIMBUS_2_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_2_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus2 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus3 Playback",
@@ -690,6 +761,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_3_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+
+	}, {
+		.name = "SLIMBUS_3_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_3_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus3 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus4 Playback",
@@ -708,6 +798,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_4_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+
+	}, {
+		.name = "SLIMBUS_4_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_4_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus4 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus5 Playback",
@@ -726,6 +835,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_5_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+
+	}, {
+		.name = "SLIMBUS_5_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_5_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus5 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus6 Playback",
@@ -744,6 +872,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_6_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+
+	}, {
+		.name = "SLIMBUS_6_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_6_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus6 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Primary MI2S Playback",
-- 
2.16.2
