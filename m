From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 24 Aug 2011 15:57:20 +0800
Subject: [PATCH 1/1] ASoC: soc-core: check rate for symmetry only when pcm is
	ongoing
Message-ID: <1314172640-26972-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the playback and record using different dai links,
checking !rtd->rate for symmetry may not be accurate because that
pcm may be acutually not running and the default new open rate is 0,
then the warning message "Not enforcing symmetric_rates" will
happen each time with running arecord | aplay.

Now we only check rate for symmetry when the pcm is really ongoing
which seems more sensible.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 include/sound/soc.h |    1 +
 sound/soc/soc-pcm.c |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3fe658e..8e9931c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -851,6 +851,7 @@ struct snd_soc_pcm_runtime  {
 
 	/* Symmetry data - only valid if symmetry is being enforced */
 	unsigned int rate;
+	unsigned int ongoing;
 	long pmdown_time;
 
 	/* runtime devices */
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1aee9fc..f3c1a66 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -39,6 +39,9 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
 	    !rtd->dai_link->symmetric_rates)
 		return 0;
 
+	if (!rtd->ongoing)
+		return 0;
+
 	/* This can happen if multiple streams are starting simultaneously -
 	 * the second can need to get its constraints before the first has
 	 * picked a rate.  Complain and allow the application to carry on.
@@ -209,6 +212,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	cpu_dai->active++;
 	codec_dai->active++;
 	rtd->codec->active++;
+	rtd->ongoing = 1;
 	mutex_unlock(&rtd->pcm_mutex);
 	return 0;
 
@@ -322,6 +326,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 			SND_SOC_DAPM_STREAM_STOP);
 	}
 
+	rtd->ongoing = 0;
 	mutex_unlock(&rtd->pcm_mutex);
 	return 0;
 }
-- 
1.7.0.4
