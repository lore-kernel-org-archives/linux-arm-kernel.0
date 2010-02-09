From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  9 Feb 2010 11:25:32 +0100
Subject: [PATCH 2/3] pca100: add sound support
In-Reply-To: <1265711133-7587-2-git-send-email-s.hauer@pengutronix.de>
References: <1265711133-7587-1-git-send-email-s.hauer@pengutronix.de>
	<1265711133-7587-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1265711133-7587-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/mach-pca100.c |   48 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index cda52a6..d12bdb1 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -25,6 +25,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/irq.h>
+#include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -41,6 +42,8 @@
 #include <mach/spi.h>
 #endif
 #include <mach/imx-uart.h>
+#include <mach/audmux.h>
+#include <mach/ssi.h>
 #include <mach/mxc_nand.h>
 #include <mach/irqs.h>
 #include <mach/mmc.h>
@@ -193,6 +196,37 @@ static struct spi_imx_master pca100_spi_0_data = {
 };
 #endif
 
+static void pca100_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	mxc_gpio_mode(GPIO_PORTC | 20 | GPIO_GPIO | GPIO_OUT);
+	gpio_set_value(GPIO_PORTC + 20, 1);
+	udelay(2);
+	gpio_set_value(GPIO_PORTC + 20, 0);
+	mxc_gpio_mode(PC20_PF_SSI1_FS);
+	msleep(2);
+}
+
+static void pca100_ac97_cold_reset(struct snd_ac97 *ac97)
+{
+	mxc_gpio_mode(GPIO_PORTC | 20 | GPIO_GPIO | GPIO_OUT);  /* FS */
+	gpio_set_value(GPIO_PORTC + 20, 0);
+	mxc_gpio_mode(GPIO_PORTC | 22 | GPIO_GPIO | GPIO_OUT);  /* TX */
+	gpio_set_value(GPIO_PORTC + 22, 0);
+	mxc_gpio_mode(GPIO_PORTC | 28 | GPIO_GPIO | GPIO_OUT);  /* reset */
+	gpio_set_value(GPIO_PORTC + 28, 0);
+	udelay(10);
+	gpio_set_value(GPIO_PORTC + 28, 1);
+	mxc_gpio_mode(PC20_PF_SSI1_FS);
+	mxc_gpio_mode(PC22_PF_SSI1_TXD);
+	msleep(2);
+}
+
+static struct imx_ssi_platform_data pca100_ssi_pdata = {
+	.ac97_reset		= pca100_ac97_cold_reset,
+	.ac97_warm_reset	= pca100_ac97_warm_reset,
+	.flags			= IMX_SSI_USE_AC97,
+};
+
 static int pca100_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 		void *data)
 {
@@ -266,11 +300,25 @@ static void __init pca100_init(void)
 {
 	int ret;
 
+	/* SSI unit */
+	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+				  MXC_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+				  MXC_AUDMUX_V1_PCR_TFCSEL(3) |
+				  MXC_AUDMUX_V1_PCR_TCLKDIR | /* clock is output */
+				  MXC_AUDMUX_V1_PCR_RXDSEL(3));
+	mxc_audmux_v1_configure_port(3,
+				  MXC_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+				  MXC_AUDMUX_V1_PCR_TFCSEL(0) |
+				  MXC_AUDMUX_V1_PCR_TFSDIR |
+				  MXC_AUDMUX_V1_PCR_RXDSEL(0));
+
 	ret = mxc_gpio_setup_multiple_pins(pca100_pins,
 			ARRAY_SIZE(pca100_pins), "PCA100");
 	if (ret)
 		printk(KERN_ERR "pca100: Failed to setup pins (%d)\n", ret);
 
+	mxc_register_device(&imx_ssi_device0, &pca100_ssi_pdata);
+
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 
 	mxc_gpio_mode(GPIO_PORTC | 29 | GPIO_GPIO | GPIO_IN);
-- 
1.6.6
