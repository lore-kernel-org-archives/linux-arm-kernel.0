From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 10 Dec 2016 11:51:11 +0200
Subject: [PATCH] ASoC: samsung: Remove tests of member address
Message-ID: <1481363471-21364-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver was checking for non-NULL address of struct's members:
 - s3c_audio_pdata->type (union),
 - s3c_audio_pdata->type.i2s (embedded struct).

This is pointless as these will be always non-NULL.  The 's3c_audio_pdata'
is always initialized in static memory so it will be zeroed.
Additionally the 'type' member was an union with only one member.

It is safe to reorganize the structures to get rid of useless union and
checks for addresses to fix the coccinelle warning:
	>> sound/soc/samsung/i2s.c:1270:2-4: ERROR: test of a variable/field address

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on the hardware.
---
 arch/arm/mach-s3c64xx/dev-audio.c      |  4 +---
 include/linux/platform_data/asoc-s3c.h |  6 ++----
 sound/soc/samsung/i2s.c                | 10 ++--------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index b57783371d52..247dcc0b691e 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -106,9 +106,7 @@ static struct s3c_audio_pdata i2sv4_pdata = {
 	.dma_playback = DMACH_HSI_I2SV40_TX,
 	.dma_capture = DMACH_HSI_I2SV40_RX,
 	.type = {
-		.i2s = {
-			.quirks = QUIRK_PRI_6CHAN,
-		},
+		.quirks = QUIRK_PRI_6CHAN,
 	},
 };
 
diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index 15bf56ee8af7..90641a5daaf0 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -18,7 +18,7 @@
 
 extern void s3c64xx_ac97_setup_gpio(int);
 
-struct samsung_i2s {
+struct samsung_i2s_type {
 /* If the Primary DAI has 5.1 Channels */
 #define QUIRK_PRI_6CHAN		(1 << 0)
 /* If the I2S block has a Stereo Overlay Channel */
@@ -47,7 +47,5 @@ struct s3c_audio_pdata {
 	void *dma_capture;
 	void *dma_play_sec;
 	void *dma_capture_mic;
-	union {
-		struct samsung_i2s i2s;
-	} type;
+	struct samsung_i2s_type type;
 };
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index e00974bc5616..d55326289a4a 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1218,7 +1218,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
 	struct s3c_audio_pdata *i2s_pdata = pdev->dev.platform_data;
-	struct samsung_i2s *i2s_cfg = NULL;
 	struct resource *res;
 	u32 regs_base, quirks = 0, idma_addr = 0;
 	struct device_node *np = pdev->dev.of_node;
@@ -1267,13 +1266,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->dma_capture.filter_data = i2s_pdata->dma_capture;
 		pri_dai->filter = i2s_pdata->dma_filter;
 
-		if (&i2s_pdata->type)
-			i2s_cfg = &i2s_pdata->type.i2s;
-
-		if (i2s_cfg) {
-			quirks = i2s_cfg->quirks;
-			idma_addr = i2s_cfg->idma_addr;
-		}
+		quirks = i2s_pdata->type.quirks;
+		idma_addr = i2s_pdata->type.idma_addr;
 	} else {
 		quirks = i2s_dai_data->quirks;
 		if (of_property_read_u32(np, "samsung,idma-addr",
-- 
2.7.4
