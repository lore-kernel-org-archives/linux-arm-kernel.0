From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:02:40 +0900
Subject: [PATCH 08/10] S3C64XX I2S: Return correct codec clock
Message-ID: <1253008960-10666-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I2S controller is driven by PCLK, instead of SCLK_AUDIO, we
like to have iis_pclk.
Check the source clock selected and return appropriate clock pointer.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 62a7fce..66f4ded 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -133,8 +133,12 @@ static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai)
 {
 	struct s3c_i2sv2_info *i2s = to_info(dai);
+	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
 
-	return i2s->iis_cclk;
+	if(iismod & S3C64XX_IISMOD_IMS_SYSMUX)
+		return i2s->iis_cclk;
+	else
+		return i2s->iis_pclk;
 }
 EXPORT_SYMBOL_GPL(s3c64xx_i2s_get_clock);
 
-- 
1.6.2.5
