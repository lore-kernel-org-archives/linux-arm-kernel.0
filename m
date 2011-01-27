From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Thu, 27 Jan 2011 19:17:43 +0530
Subject: [PATCH] ASoC: DaVinci: fix kernel panic due to uninitialized
	platform_data
Message-ID: <1296136063-31625-1-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the Kernel panic issue on accessing davinci_vc in
cq93vc_probe function. struct davinci_vc is part of platform device's
private driver data(codec->dev->p->driver_data) and this is populated
by DaVinci Voice Codec MFD driver.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
This patch applies to Linus's tree at [1].

[1] http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
---
 sound/soc/codecs/cq93vc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 46dbfd0..347a567 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -153,7 +153,7 @@ static int cq93vc_resume(struct snd_soc_codec *codec)
 
 static int cq93vc_probe(struct snd_soc_codec *codec)
 {
-	struct davinci_vc *davinci_vc = codec->dev->platform_data;
+	struct davinci_vc *davinci_vc = snd_soc_codec_get_drvdata(codec);
 
 	davinci_vc->cq93vc.codec = codec;
 	codec->control_data = davinci_vc;
-- 
1.7.1
