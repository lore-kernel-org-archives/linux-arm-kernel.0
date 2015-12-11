From: koro.chen@mediatek.com (Koro Chen)
Date: Fri, 11 Dec 2015 11:33:51 +0800
Subject: [RFC PATCH] ASoC: dpcm: Apply symmetry for DPCM
Message-ID: <1449804831-58929-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: PC Liao <pc.liao@mediatek.com>

DPCM does not fully support symmetry attributes. soc_pcm_apply_symmetry()
is skipped in soc_pcm_open() for DPCM, without being applied elsewhere.
So HW parameters cannot be correctly limited, and user space can do
playback/capture at different rates while HW actually does not support it.
soc_pcm_params_symmetry() will return error and the second stream stops.

This patch adds soc_pcm_apply_symmetry() for FE, BE, and codec DAIs
in DPCM path that was skipped in soc_pcm_open().

Signed-off-by: PC Liao <pc.liao@mediatek.com>
Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/soc-pcm.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 67ef1a0..2a2ca22 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1614,6 +1614,56 @@ static void dpcm_set_fe_update_state(struct snd_soc_pcm_runtime *fe,
 	snd_pcm_stream_unlock_irq(substream);
 }
 
+static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
+			       int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+	struct snd_soc_pcm_runtime *fe = fe_substream->private_data;
+	struct snd_soc_dai *fe_cpu_dai = fe->cpu_dai;
+	int err;
+
+	/* apply symmetry for FE */
+	if (soc_pcm_has_symmetry(fe_substream))
+		fe_substream->runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
+
+	/* Symmetry only applies if we've got an active stream. */
+	if (fe_cpu_dai->active) {
+		err = soc_pcm_apply_symmetry(fe_substream, fe_cpu_dai);
+		if (err < 0)
+			return err;
+	}
+
+	/* apply symmetry for BE */
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+		struct snd_soc_pcm_runtime *rtd = be_substream->private_data;
+		int i;
+
+		if (soc_pcm_has_symmetry(be_substream))
+			be_substream->runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
+
+		/* Symmetry only applies if we've got an active stream. */
+		if (rtd->cpu_dai->active) {
+			err = soc_pcm_apply_symmetry(be_substream, rtd->cpu_dai);
+			if (err < 0)
+				return err;
+		}
+
+		for (i = 0; i < rtd->num_codecs; i++) {
+			if (rtd->codec_dais[i]->active) {
+				err = soc_pcm_apply_symmetry(be_substream,
+							     rtd->codec_dais[i]);
+				if (err < 0)
+					return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 {
 	struct snd_soc_pcm_runtime *fe = fe_substream->private_data;
@@ -1642,6 +1692,13 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
 	dpcm_set_fe_runtime(fe_substream);
 	snd_pcm_limit_hw_rates(runtime);
 
+	ret = dpcm_apply_symmetry(fe_substream, stream);
+	if (ret < 0) {
+		dev_err(fe->dev, "ASoC: failed to apply dpcm symmetry %d\n",
+			ret);
+		goto unwind;
+	}
+
 	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
 	return 0;
 
-- 
1.7.9.5
