From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Oct 2016 19:07:55 +0800
Subject: [PATCH 03/12] ASoC: dapm: Introduce DAPM_DOUBLE dual channel control
 type
In-Reply-To: <20161003110804.28235-1-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
Message-ID: <20161003110804.28235-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A DAPM_DOUBLE control type can be used for dual channel mixer input
selectors / mute controls in one register, possibly toggling both
channels together.

The control is meant to be shared by 2 widgets, 1 for each channel,
such that the mixer control exposed to userspace remains a combined
stereo control.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/sound/soc-dapm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d5f4677776ce..f74ec19687f8 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -272,6 +272,11 @@ struct device;
 
 
 /* dapm kcontrol types */
+#define SOC_DAPM_DOUBLE(xname, reg, lshift, rshift, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value = SOC_DOUBLE_VALUE(reg, lshift, rshift, max, invert, 0) }
 #define SOC_DAPM_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
-- 
2.9.3
