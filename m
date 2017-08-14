From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 15:06:52 -0700
Subject: [PATCH 4/9] ASoC: cygnus: Only enable MCLK pins when in use
In-Reply-To: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502748417-26417-5-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MCLK pins are now only enabled when they are in use.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 sound/soc/bcm/cygnus-ssp.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 00fd4dc..4c476ce 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -41,10 +41,10 @@
 /* Begin register offset defines */
 #define AUD_MISC_SEROUT_OE_REG_BASE  0x01c
 #define AUD_MISC_SEROUT_SPDIF_OE  12
-#define AUD_MISC_SEROUT_MCLK_OE   3
-#define AUD_MISC_SEROUT_LRCK_OE   2
-#define AUD_MISC_SEROUT_SCLK_OE   1
-#define AUD_MISC_SEROUT_SDAT_OE   0
+#define AUD_MISC_SEROUT_MCLK_OE    3
+#define AUD_MISC_SEROUT_LRCK_OE    2
+#define AUD_MISC_SEROUT_SCLK_OE    1
+#define AUD_MISC_SEROUT_SDAT_OE    0
 
 /* AUD_FMM_BF_CTRL_xxx regs */
 #define BF_DST_CFG0_OFFSET  0x100
@@ -684,6 +684,11 @@ static int cygnus_ssp_set_sysclk(struct snd_soc_dai *dai,
 	value |= (sel << I2S_OUT_PLLCLKSEL_SHIFT);
 	writel(value, aio->cygaud->audio + aio->regs.i2s_mclk_cfg);
 
+	/* Clear bit for active */
+	value = readl(aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
+	value &= ~BIT(AUD_MISC_SEROUT_MCLK_OE + (aio->portnum * 4));
+	writel(value, aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
+
 	return 0;
 }
 
@@ -827,15 +832,12 @@ static int cygnus_ssp_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	 * Shift the mask based upon port number.
 	 */
 	mask = BIT(AUD_MISC_SEROUT_LRCK_OE)
-			| BIT(AUD_MISC_SEROUT_SCLK_OE)
-			| BIT(AUD_MISC_SEROUT_MCLK_OE);
+			| BIT(AUD_MISC_SEROUT_SCLK_OE);
 	mask = mask << (aio->portnum * 4);
 	if (aio->is_slave)
-		/* Set bit for tri-state */
-		val |= mask;
+		val |= mask;   /* Set bit for tri-state */
 	else
-		/* Clear bit for drive */
-		val &= ~mask;
+		val &= ~mask;  /* Clear bit for drive */
 
 	dev_dbg(aio->cygaud->dev, "%s  Set OE bits 0x%x\n", __func__, val);
 	writel(val, aio->cygaud->audio + AUD_MISC_SEROUT_OE_REG_BASE);
-- 
1.9.1
