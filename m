From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 11:28:40 +0100
Subject: [PATCH 07/21] ASoC: io: Prevent use of regmap if request fails
In-Reply-To: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a sound codec fails to request a regmap, the 'using_regmap' is
set as true regardless, despite there being no regmap to use. As a
repercussion, when a latter read function checks to see if we are
using regmaps, it assumes we are and attempts to. Only the kernel
oopes, because regmap_* tries to extract information from a NULL
pointer.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/soc-io.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 29183ef..601cb7f 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -52,10 +52,13 @@ static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
 		if (codec->cache_only)
 			return -1;
 
-		ret = regmap_read(codec->control_data, reg, &val);
-		if (ret == 0)
-			return val;
-		else
+		if (codec->using_regmap) {
+			ret = regmap_read(codec->control_data, reg, &val);
+			if (ret == 0)
+				return val;
+			else
+				return -1;
+		} else
 			return -1;
 	}
 
@@ -141,11 +144,12 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 
 	case SND_SOC_REGMAP:
 		/* Device has made its own regmap arrangements */
-		codec->using_regmap = true;
 		if (!codec->control_data)
 			codec->control_data = dev_get_regmap(codec->dev, NULL);
 
 		if (codec->control_data) {
+			codec->using_regmap = true;
+
 			ret = regmap_get_val_bytes(codec->control_data);
 			/* Errors are legitimate for non-integer byte
 			 * multiples */
-- 
1.7.9.5
