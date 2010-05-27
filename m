From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 10:58:54 +0200
Subject: [PATCH v2 1/4] imx-ssi.c: add new choices to platform configuration
Message-ID: <1274950737-26498-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* introduce 3 new flags to allow a more detailed configuration
of the SSI link :
	IMX_SSI_NET : enable Network Mode
	IMX_SSI_SYN : enable Synchronous Mode
	IMX_SSI_USE_I2S_SLAVE : enable I2S Slave Mode
* new platform can use these settings without breaking actual
platforms.

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/plat-mxc/include/mach/ssi.h |    3 +++
 sound/soc/imx/imx-ssi.c              |   11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/ssi.h b/arch/arm/plat-mxc/include/mach/ssi.h
index c34ded5..63f3c28 100644
--- a/arch/arm/plat-mxc/include/mach/ssi.h
+++ b/arch/arm/plat-mxc/include/mach/ssi.h
@@ -10,6 +10,9 @@ struct imx_ssi_platform_data {
 	unsigned int flags;
 #define IMX_SSI_DMA            (1 << 0)
 #define IMX_SSI_USE_AC97       (1 << 1)
+#define IMX_SSI_NET            (1 << 2)
+#define IMX_SSI_SYN            (1 << 3)
+#define IMX_SSI_USE_I2S_SLAVE  (1 << 4)
 	void (*ac97_reset) (struct snd_ac97 *ac97);
 	void (*ac97_warm_reset)(struct snd_ac97 *ac97);
 };
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 80b4fee..50f5162 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -83,8 +83,6 @@ static int imx_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 /*
  * SSI DAI format configuration.
  * Should only be called when port is inactive (i.e. SSIEN = 0).
- * Note: We don't use the I2S modes but instead manually configure the
- * SSI for I2S because the I2S mode is only a register preset.
  */
 static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
@@ -99,6 +97,10 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		/* data on rising edge of bclk, frame low 1clk before data */
 		strcr |= SSI_STCR_TFSI | SSI_STCR_TEFS | SSI_STCR_TXBIT0;
 		scr |= SSI_SCR_NET;
+		if (ssi->flags & IMX_SSI_USE_I2S_SLAVE) {
+			scr &= ~SSI_I2S_MODE_MASK;
+			scr |= SSI_SCR_I2S_MODE_SLAVE;
+		}
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		/* data on rising edge of bclk, frame high with data */
@@ -143,6 +145,11 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 
 	strcr |= SSI_STCR_TFEN0;
 
+	if (ssi->flags & IMX_SSI_NET)
+		scr |= SSI_SCR_NET;
+	if (ssi->flags & IMX_SSI_SYN)
+		scr |= SSI_SCR_SYN;
+
 	writel(strcr, ssi->base + SSI_STCR);
 	writel(strcr, ssi->base + SSI_SRCR);
 	writel(scr, ssi->base + SSI_SCR);
-- 
1.6.3.3
