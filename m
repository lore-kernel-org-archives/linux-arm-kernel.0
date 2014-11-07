From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 07 Nov 2014 12:24:39 +0530
Subject: [PATCH 1/2] ASoC: Samsung: Add quirk for internal DMA
In-Reply-To: <1415343280-18916-1-git-send-email-padma.v@samsung.com>
References: <1415343280-18916-1-git-send-email-padma.v@samsung.com>
Message-ID: <1415343280-18916-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Internal DMA is available only on some of Samsung platforms.
So added a quirk for the same and made it optional.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 include/linux/platform_data/asoc-s3c.h |    1 +
 sound/soc/samsung/i2s.c                |   12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index a6591c6..5e0bc77 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -27,6 +27,7 @@ struct samsung_i2s {
 #define QUIRK_NO_MUXPSR		(1 << 2)
 #define QUIRK_NEED_RSTCLR	(1 << 3)
 #define QUIRK_SUPPORTS_TDM	(1 << 4)
+#define QUIRK_SUPPORTS_IDMA	(1 << 5)
 	/* Quirks of the I2S controller */
 	u32 quirks;
 	dma_addr_t idma_addr;
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9d51347..38b9a52 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -987,7 +987,7 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	if (i2s->quirks & QUIRK_NEED_RSTCLR)
 		writel(CON_RSTCLR, i2s->addr + I2SCON);
 
-	if (i2s->quirks & QUIRK_SEC_DAI)
+	if (i2s->quirks & QUIRK_SUPPORTS_IDMA)
 		idma_reg_addr_init(i2s->addr,
 					i2s->sec_dai->idma_playback.dma_addr);
 
@@ -1199,10 +1199,9 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		quirks = i2s_dai_data->quirks;
 		if (of_property_read_u32(np, "samsung,idma-addr",
 					 &idma_addr)) {
-			if (quirks & QUIRK_SEC_DAI) {
-				dev_err(&pdev->dev, "idma address is not"\
+			if (quirks & QUIRK_SUPPORTS_IDMA) {
+				dev_info(&pdev->dev, "idma address is not"\
 						"specified");
-				return -EINVAL;
 			}
 		}
 	}
@@ -1309,13 +1308,14 @@ static const struct samsung_i2s_dai_data i2sv3_dai_type = {
 
 static const struct samsung_i2s_dai_data i2sv5_dai_type = {
 	.dai_type = TYPE_PRI,
-	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR,
+	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR |
+			QUIRK_SUPPORTS_IDMA,
 };
 
 static const struct samsung_i2s_dai_data i2sv6_dai_type = {
 	.dai_type = TYPE_PRI,
 	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR |
-			QUIRK_SUPPORTS_TDM,
+			QUIRK_SUPPORTS_TDM | QUIRK_SUPPORTS_IDMA,
 };
 
 static const struct samsung_i2s_dai_data samsung_dai_type_pri = {
-- 
1.7.4.4
