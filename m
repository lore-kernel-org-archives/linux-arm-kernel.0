From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:02:35 +0900
Subject: [PATCH 03/10] S3C64XX I2S: Codec Clock Gating Option
Message-ID: <1253008955-10505-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In SoC-Master mode, CODCLK maybe gated out as MCLK of the CODEC.
In SoC-Slave mode, CODCLK needs to be cut-off from PAD inorder
to avoid collision with MCLK from CODEC.
Option to gate/block CODCLK is implemented in this patch.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h |    2 ++
 sound/soc/s3c24xx/s3c64xx-i2s.c                   |    8 ++++++++
 sound/soc/s3c24xx/s3c64xx-i2s.h                   |    2 ++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h b/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
index 07659da..08ae50f 100644
--- a/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
+++ b/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
@@ -38,6 +38,8 @@
 #define S3C64XX_IISMOD_BLC_24BIT	(2 << 13)
 #define S3C64XX_IISMOD_BLC_MASK		(3 << 13)
 
+#define S3C64XX_IISMOD_CDCLK_EXT	(1 << 12)
+
 #define S3C64XX_IISMOD_IMS_PCLK		(0 << 10)
 #define S3C64XX_IISMOD_IMS_SYSMUX	(1 << 10)
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 3c06c40..6f8959d 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -99,6 +99,14 @@ static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 		iismod |= S3C64XX_IISMOD_IMS_SYSMUX;
 		break;
 
+	case S3C64XX_CODCLKSRC_INT:
+		iismod &= ~S3C64XX_IISMOD_CDCLK_EXT;
+		break;
+
+	case S3C64XX_CODCLKSRC_EXT:
+		iismod |= S3C64XX_IISMOD_CDCLK_EXT;
+		break;
+
 	default:
 		return -EINVAL;
 	}
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
index 02148ce..4197da5 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.h
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.h
@@ -25,6 +25,8 @@ struct clk;
 
 #define S3C64XX_CLKSRC_PCLK	(0)
 #define S3C64XX_CLKSRC_MUX	(1)
+#define S3C64XX_CODCLKSRC_INT	(2)
+#define S3C64XX_CODCLKSRC_EXT	(3)
 
 extern struct snd_soc_dai s3c64xx_i2s_dai[];
 
-- 
1.6.2.5
