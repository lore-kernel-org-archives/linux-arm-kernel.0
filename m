From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 16:48:24 +0100
Subject: [PATCH 10/12] pcm043: add sound support
In-Reply-To: <1258645706-9071-10-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-8-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-9-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-10-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258645706-9071-11-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/pcm043.c |  102 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 102 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/pcm043.c b/arch/arm/mach-mx3/pcm043.c
index e3aa829..072f9b4 100644
--- a/arch/arm/mach-mx3/pcm043.c
+++ b/arch/arm/mach-mx3/pcm043.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
+#include <linux/delay.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -44,6 +45,8 @@
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
 #include <mach/mxc_nand.h>
+#include <mach/audmux.h>
+#include <mach/ssi.h>
 
 #include "devices.h"
 
@@ -205,6 +208,91 @@ static struct pad_desc pcm043_pads[] = {
 	MX35_PAD_D3_CLS__IPU_DISPB_D3_CLS,
 	/* gpio */
 	MX35_PAD_ATA_CS0__GPIO2_6,
+	/* SSI */
+	MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS,
+	MX35_PAD_STXD4__AUDMUX_AUD4_TXD,
+	MX35_PAD_SRXD4__AUDMUX_AUD4_RXD,
+	MX35_PAD_SCK4__AUDMUX_AUD4_TXC,
+};
+
+#define AC97_GPIO_TXFS	(1 * 32 + 31)
+#define AC97_GPIO_TXD	(1 * 32 + 28)
+#define AC97_GPIO_RESET	(1 * 32 + 0)
+
+static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	struct pad_desc txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
+	struct pad_desc txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
+	int ret;
+
+	ret = gpio_request(AC97_GPIO_TXFS, "SSI");
+	if (ret) {
+		printk("failed to get GPIO_TXFS: %d\n", ret);
+		return;
+	}
+
+	mxc_iomux_v3_setup_pad(&txfs_gpio);
+
+	/* warm reset */
+	gpio_direction_output(AC97_GPIO_TXFS, 1);
+	udelay(2);
+	gpio_set_value(AC97_GPIO_TXFS, 0);
+
+	gpio_free(AC97_GPIO_TXFS);
+	mxc_iomux_v3_setup_pad(&txfs);
+}
+
+static void pcm043_ac97_cold_reset(struct snd_ac97 *ac97)
+{
+	struct pad_desc txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
+	struct pad_desc txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
+	struct pad_desc txd_gpio = MX35_PAD_STXD4__GPIO2_28;
+	struct pad_desc txd = MX35_PAD_STXD4__AUDMUX_AUD4_TXD;
+	struct pad_desc reset_gpio = MX35_PAD_SD2_CMD__GPIO2_0;
+	int ret;
+
+	ret = gpio_request(AC97_GPIO_TXFS, "SSI");
+	if (ret)
+		goto err1;
+
+	ret = gpio_request(AC97_GPIO_TXD, "SSI");
+	if (ret)
+		goto err2;
+
+	ret = gpio_request(AC97_GPIO_RESET, "SSI");
+	if (ret)
+		goto err3;
+
+	mxc_iomux_v3_setup_pad(&txfs_gpio);
+	mxc_iomux_v3_setup_pad(&txd_gpio);
+	mxc_iomux_v3_setup_pad(&reset_gpio);
+
+	gpio_direction_output(AC97_GPIO_TXFS, 0);
+	gpio_direction_output(AC97_GPIO_TXD, 0);
+
+	/* cold reset */
+	gpio_direction_output(AC97_GPIO_RESET, 0);
+	udelay(10);
+	gpio_direction_output(AC97_GPIO_RESET, 1);
+
+	mxc_iomux_v3_setup_pad(&txd);
+	mxc_iomux_v3_setup_pad(&txfs);
+
+	gpio_free(AC97_GPIO_RESET);
+err3:
+	gpio_free(AC97_GPIO_TXD);
+err2:
+	gpio_free(AC97_GPIO_TXFS);
+err1:
+	if (ret)
+		printk("%s failed with %d\n", __func__, ret);
+	mdelay(1);
+}
+
+static struct imx_ssi_platform_data pcm043_ssi_pdata = {
+	.ac97_reset = pcm043_ac97_cold_reset,
+	.ac97_warm_reset = pcm043_ac97_warm_reset,
+	.flags = IMX_SSI_USE_AC97,
 };
 
 static struct mxc_nand_platform_data pcm037_nand_board_info = {
@@ -219,12 +307,25 @@ static void __init mxc_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(pcm043_pads, ARRAY_SIZE(pcm043_pads));
 
+	mxc_audmux_v2_configure_port(3,
+			MXC_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+			MXC_AUDMUX_V2_PTCR_TFSEL(0) |
+			MXC_AUDMUX_V2_PTCR_TFSDIR,
+			MXC_AUDMUX_V2_PDCR_RXDSEL(0));
+
+	mxc_audmux_v2_configure_port(0,
+			MXC_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+			MXC_AUDMUX_V2_PTCR_TCSEL(3) |
+			MXC_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
+			MXC_AUDMUX_V2_PDCR_RXDSEL(3));
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxc_nand_device, &pcm037_nand_board_info);
 
 	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+	mxc_register_device(&imx_ssi_device0, &pcm043_ssi_pdata);
 
 #if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
 	i2c_register_board_info(0, pcm043_i2c_devices,
@@ -239,6 +340,7 @@ static void __init mxc_board_init(void)
 
 static void __init pcm043_timer_init(void)
 {
+	printk("mx35_clocks_init()\n");
 	mx35_clocks_init();
 }
 
-- 
1.6.5.2
