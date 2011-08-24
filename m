From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 24 Aug 2011 19:02:08 +0800
Subject: [PATCH v2 1/1] ASoC: soc-core: check rate for symmetry only when pcm
	is active
Message-ID: <1314183728-23627-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the playback and record using different dai links,
checking !rtd->rate for symmetry may not be accurate because that
pcm may be acutually not running and the default new open rate is 0,
then the warning message "Not enforcing symmetric_rates" will
happen each time with running arecord | aplay.

Now we only check rate for symmetry when the pcm is really active
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
index 3fe658e..17970fd 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -851,6 +851,7 @@ struct snd_soc_pcm_runtime  {
 
 	/* Symmetry data - only valid if symmetry is being enforced */
 	unsigned int rate;
+	unsigned int active;
 	long pmdown_time;
 
 	/* runtime devices */
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1aee9fc..72a7b34 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -39,6 +39,9 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
 	    !rtd->dai_link->symmetric_rates)
 		return 0;
 
+	if (!rtd->active)
+		return 0;
+
 	/* This can happen if multiple streams are starting simultaneously -
 	 * the second can need to get its constraints before the first has
 	 * picked a rate.  Complain and allow the application to carry on.
@@ -209,6 +212,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	cpu_dai->active++;
 	codec_dai->active++;
 	rtd->codec->active++;
+	rtd->active++;
 	mutex_unlock(&rtd->pcm_mutex);
 	return 0;
 
@@ -287,6 +291,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	cpu_dai->active--;
 	codec_dai->active--;
 	codec->active--;
+	rtd->active--;
 
 	if (!cpu_dai->active && !codec_dai->active)
 		rtd->rate = 0;
-- 
1.7.0.4
