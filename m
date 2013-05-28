From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 28 May 2013 16:47:54 +0200
Subject: [PATCH v6 06/10] ARM: imx: Export ac97 reset functions
In-Reply-To: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1369752478-30260-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/mach-imx/mach-pca100.c | 7 +++++--
 arch/arm/mach-imx/mach-pcm043.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index b8b15bb..68badf8 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -22,6 +22,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
 #include <linux/dma-mapping.h>
+#include <linux/export.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/irq.h>
@@ -208,7 +209,7 @@ static const struct spi_imx_master pca100_spi0_data __initconst = {
 	.num_chipselect = ARRAY_SIZE(pca100_spi_cs),
 };
 
-static void pca100_ac97_warm_reset(struct snd_ac97 *ac97)
+void pca100_ac97_warm_reset(struct snd_ac97 *ac97)
 {
 	mxc_gpio_mode(GPIO_PORTC | 20 | GPIO_GPIO | GPIO_OUT);
 	gpio_set_value(GPIO_PORTC + 20, 1);
@@ -217,8 +218,9 @@ static void pca100_ac97_warm_reset(struct snd_ac97 *ac97)
 	mxc_gpio_mode(PC20_PF_SSI1_FS);
 	msleep(2);
 }
+EXPORT_SYMBOL(pca100_ac97_warm_reset);
 
-static void pca100_ac97_cold_reset(struct snd_ac97 *ac97)
+void pca100_ac97_cold_reset(struct snd_ac97 *ac97)
 {
 	mxc_gpio_mode(GPIO_PORTC | 20 | GPIO_GPIO | GPIO_OUT);  /* FS */
 	gpio_set_value(GPIO_PORTC + 20, 0);
@@ -232,6 +234,7 @@ static void pca100_ac97_cold_reset(struct snd_ac97 *ac97)
 	mxc_gpio_mode(PC22_PF_SSI1_TXD);
 	msleep(2);
 }
+EXPORT_SYMBOL(pca100_ac97_cold_reset);
 
 static const struct imx_ssi_platform_data pca100_ssi_pdata __initconst = {
 	.ac97_reset		= pca100_ac97_cold_reset,
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 8ed533f..4f318ca 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -27,6 +27,7 @@
 #include <linux/i2c/at24.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
+#include <linux/export.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -217,7 +218,7 @@ static iomux_v3_cfg_t pcm043_pads[] = {
 #define SD1_GPIO_WP	IMX_GPIO_NR(2, 23)
 #define SD1_GPIO_CD	IMX_GPIO_NR(2, 24)
 
-static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
+void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
 {
 	iomux_v3_cfg_t txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
 	iomux_v3_cfg_t txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
@@ -239,8 +240,9 @@ static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
 	gpio_free(AC97_GPIO_TXFS);
 	mxc_iomux_v3_setup_pad(txfs);
 }
+EXPORT_SYMBOL(pcm043_ac97_warm_reset);
 
-static void pcm043_ac97_cold_reset(struct snd_ac97 *ac97)
+void pcm043_ac97_cold_reset(struct snd_ac97 *ac97)
 {
 	iomux_v3_cfg_t txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
 	iomux_v3_cfg_t txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
@@ -286,6 +288,7 @@ err1:
 		printk("%s failed with %d\n", __func__, ret);
 	mdelay(1);
 }
+EXPORT_SYMBOL(pcm043_ac97_cold_reset);
 
 static const struct imx_ssi_platform_data pcm043_ssi_pdata __initconst = {
 	.ac97_reset = pcm043_ac97_cold_reset,
-- 
1.8.2.1
