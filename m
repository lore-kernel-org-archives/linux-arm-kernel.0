From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Tue,  9 Feb 2010 18:13:36 +0100
Subject: [PATCH 3/3] mx31moboard: support for the smartbot baseboard
In-Reply-To: <1265735616-476-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1265735616-476-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1265735616-476-4-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This baseboard is used on the handbot and eybot robots.

The sel gpios are used as enables and rst signals on smartbot, thus the
sel init is moved from mx31moboard file to board files.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/Makefile                         |    2 +-
 arch/arm/mach-mx3/mach-mx31moboard.c               |   36 +----
 arch/arm/mach-mx3/mx31moboard-devboard.c           |   32 ++++
 arch/arm/mach-mx3/mx31moboard-marxbot.c            |   33 ++++
 arch/arm/mach-mx3/mx31moboard-smartbot.c           |  162 ++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/board-mx31moboard.h |    2 +
 6 files changed, 233 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/mach-mx3/mx31moboard-smartbot.c

diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 62b6093..5d650fd 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_MACH_PCM037_EET)	+= mach-pcm037_eet.o
 obj-$(CONFIG_MACH_MX31_3DS)	+= mach-mx31_3ds.o
 CFLAGS_mach-mx31_3ds.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 obj-$(CONFIG_MACH_MX31MOBOARD)	+= mach-mx31moboard.o mx31moboard-devboard.o \
-				   mx31moboard-marxbot.o
+				   mx31moboard-marxbot.o mx31moboard-smartbot.o
 obj-$(CONFIG_MACH_QONG)		+= mach-qong.o
 obj-$(CONFIG_MACH_PCM043)	+= mach-pcm043.o
 obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 6056b64..ae39bb0 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -96,9 +96,6 @@ static unsigned int moboard_pins[] = {
 	/* LEDs */
 	MX31_PIN_SVEN0__GPIO2_0, MX31_PIN_STX0__GPIO2_1,
 	MX31_PIN_SRX0__GPIO2_2, MX31_PIN_SIMPD0__GPIO2_3,
-	/* SEL */
-	MX31_PIN_DTR_DCE1__GPIO2_8, MX31_PIN_DSR_DCE1__GPIO2_9,
-	MX31_PIN_RI_DCE1__GPIO2_10, MX31_PIN_DCD_DCE1__GPIO2_11,
 	/* SPI1 */
 	MX31_PIN_CSPI2_MOSI__MOSI, MX31_PIN_CSPI2_MISO__MISO,
 	MX31_PIN_CSPI2_SCLK__SCLK, MX31_PIN_CSPI2_SPI_RDY__SPI_RDY,
@@ -432,34 +429,6 @@ static struct platform_device mx31moboard_leds_device = {
 	},
 };
 
-#define SEL0 IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1)
-#define SEL1 IOMUX_TO_GPIO(MX31_PIN_DSR_DCE1)
-#define SEL2 IOMUX_TO_GPIO(MX31_PIN_RI_DCE1)
-#define SEL3 IOMUX_TO_GPIO(MX31_PIN_DCD_DCE1)
-
-static void mx31moboard_init_sel_gpios(void)
-{
-	if (!gpio_request(SEL0, "sel0")) {
-		gpio_direction_input(SEL0);
-		gpio_export(SEL0, true);
-	}
-
-	if (!gpio_request(SEL1, "sel1")) {
-		gpio_direction_input(SEL1);
-		gpio_export(SEL1, true);
-	}
-
-	if (!gpio_request(SEL2, "sel2")) {
-		gpio_direction_input(SEL2);
-		gpio_export(SEL2, true);
-	}
-
-	if (!gpio_request(SEL3, "sel3")) {
-		gpio_direction_input(SEL3);
-		gpio_export(SEL3, true);
-	}
-}
-
 static struct ipu_platform_data mx3_ipu_data = {
 	.irq_base = MXC_IPU_IRQ_START,
 };
@@ -519,8 +488,6 @@ static void __init mxc_board_init(void)
 
 	mxc_register_device(&mxc_uart_device4, &uart4_pdata);
 
-	mx31moboard_init_sel_gpios();
-
 	mxc_register_device(&mxc_i2c_device0, &moboard_i2c0_pdata);
 	mxc_register_device(&mxc_i2c_device1, &moboard_i2c1_pdata);
 
@@ -553,6 +520,9 @@ static void __init mxc_board_init(void)
 	case MX31MARXBOT:
 		mx31moboard_marxbot_init();
 		break;
+	case MX31SMARTBOT:
+		mx31moboard_smartbot_init();
+		break;
 	default:
 		printk(KERN_ERR "Illegal mx31moboard_baseboard type %d\n",
 			mx31moboard_baseboard);
diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
index 438428e..9fbad2e 100644
--- a/arch/arm/mach-mx3/mx31moboard-devboard.c
+++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
@@ -49,6 +49,9 @@ static unsigned int devboard_pins[] = {
 	MX31_PIN_CSPI1_SS2__USBH1_RCV, MX31_PIN_CSPI1_SCLK__USBH1_OEB,
 	MX31_PIN_CSPI1_SPI_RDY__USBH1_FS, MX31_PIN_SFS6__USBH1_SUSPEND,
 	MX31_PIN_NFRE_B__GPIO1_11, MX31_PIN_NFALE__GPIO1_12,
+	/* SEL */
+	MX31_PIN_DTR_DCE1__GPIO2_8, MX31_PIN_DSR_DCE1__GPIO2_9,
+	MX31_PIN_RI_DCE1__GPIO2_10, MX31_PIN_DCD_DCE1__GPIO2_11,
 };
 
 static struct imxuart_platform_data uart_pdata = {
@@ -108,6 +111,33 @@ static struct imxmmc_platform_data sdhc2_pdata = {
 	.exit	= devboard_sdhc2_exit,
 };
 
+#define SEL0 IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1)
+#define SEL1 IOMUX_TO_GPIO(MX31_PIN_DSR_DCE1)
+#define SEL2 IOMUX_TO_GPIO(MX31_PIN_RI_DCE1)
+#define SEL3 IOMUX_TO_GPIO(MX31_PIN_DCD_DCE1)
+
+static void devboard_init_sel_gpios(void)
+{
+	if (!gpio_request(SEL0, "sel0")) {
+		gpio_direction_input(SEL0);
+		gpio_export(SEL0, true);
+	}
+
+	if (!gpio_request(SEL1, "sel1")) {
+		gpio_direction_input(SEL1);
+		gpio_export(SEL1, true);
+	}
+
+	if (!gpio_request(SEL2, "sel2")) {
+		gpio_direction_input(SEL2);
+		gpio_export(SEL2, true);
+	}
+
+	if (!gpio_request(SEL3, "sel3")) {
+		gpio_direction_input(SEL3);
+		gpio_export(SEL3, true);
+	}
+}
 #define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
 			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
 
@@ -196,5 +226,7 @@ void __init mx31moboard_devboard_init(void)
 
 	mxc_register_device(&mxcsdhc_device1, &sdhc2_pdata);
 
+	devboard_init_sel_gpios();
+
 	devboard_usbh1_init();
 }
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 7f6f58c..3958515 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -66,6 +66,9 @@ static unsigned int marxbot_pins[] = {
 	MX31_PIN_CSPI1_SS2__USBH1_RCV, MX31_PIN_CSPI1_SCLK__USBH1_OEB,
 	MX31_PIN_CSPI1_SPI_RDY__USBH1_FS, MX31_PIN_SFS6__USBH1_SUSPEND,
 	MX31_PIN_NFRE_B__GPIO1_11, MX31_PIN_NFALE__GPIO1_12,
+	/* SEL */
+	MX31_PIN_DTR_DCE1__GPIO2_8, MX31_PIN_DSR_DCE1__GPIO2_9,
+	MX31_PIN_RI_DCE1__GPIO2_10, MX31_PIN_DCD_DCE1__GPIO2_11,
 };
 
 #define SDHC2_CD IOMUX_TO_GPIO(MX31_PIN_ATA_DIOR)
@@ -223,6 +226,34 @@ static int __init marxbot_cam_init(void)
 	return 0;
 }
 
+#define SEL0 IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1)
+#define SEL1 IOMUX_TO_GPIO(MX31_PIN_DSR_DCE1)
+#define SEL2 IOMUX_TO_GPIO(MX31_PIN_RI_DCE1)
+#define SEL3 IOMUX_TO_GPIO(MX31_PIN_DCD_DCE1)
+
+static void marxbot_init_sel_gpios(void)
+{
+	if (!gpio_request(SEL0, "sel0")) {
+		gpio_direction_input(SEL0);
+		gpio_export(SEL0, true);
+	}
+
+	if (!gpio_request(SEL1, "sel1")) {
+		gpio_direction_input(SEL1);
+		gpio_export(SEL1, true);
+	}
+
+	if (!gpio_request(SEL2, "sel2")) {
+		gpio_direction_input(SEL2);
+		gpio_export(SEL2, true);
+	}
+
+	if (!gpio_request(SEL3, "sel3")) {
+		gpio_direction_input(SEL3);
+		gpio_export(SEL3, true);
+	}
+}
+
 #define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
 			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
 
@@ -307,6 +338,8 @@ void __init mx31moboard_marxbot_init(void)
 	mxc_iomux_setup_multiple_pins(marxbot_pins, ARRAY_SIZE(marxbot_pins),
 		"marxbot");
 
+	marxbot_init_sel_gpios();
+
 	dspics_resets_init();
 
 	mxc_register_device(&mxcsdhc_device1, &sdhc2_pdata);
diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
new file mode 100644
index 0000000..52a69fc
--- /dev/null
+++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
@@ -0,0 +1,162 @@
+/*
+ * Copyright (C) 2009 Valentin Longchamp, EPFL Mobots group
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx3.h>
+
+#include <media/soc_camera.h>
+
+#include "devices.h"
+
+static unsigned int smartbot_pins[] = {
+	/* UART1 */
+	MX31_PIN_CTS2__CTS2, MX31_PIN_RTS2__RTS2,
+	MX31_PIN_TXD2__TXD2, MX31_PIN_RXD2__RXD2,
+	/* CSI */
+	MX31_PIN_CSI_D4__CSI_D4, MX31_PIN_CSI_D5__CSI_D5,
+	MX31_PIN_CSI_D6__CSI_D6, MX31_PIN_CSI_D7__CSI_D7,
+	MX31_PIN_CSI_D8__CSI_D8, MX31_PIN_CSI_D9__CSI_D9,
+	MX31_PIN_CSI_D10__CSI_D10, MX31_PIN_CSI_D11__CSI_D11,
+	MX31_PIN_CSI_D12__CSI_D12, MX31_PIN_CSI_D13__CSI_D13,
+	MX31_PIN_CSI_D14__CSI_D14, MX31_PIN_CSI_D15__CSI_D15,
+	MX31_PIN_CSI_HSYNC__CSI_HSYNC, MX31_PIN_CSI_MCLK__CSI_MCLK,
+	MX31_PIN_CSI_PIXCLK__CSI_PIXCLK, MX31_PIN_CSI_VSYNC__CSI_VSYNC,
+	MX31_PIN_GPIO3_0__GPIO3_0, MX31_PIN_GPIO3_1__GPIO3_1,
+	/* ENABLES */
+	MX31_PIN_DTR_DCE1__GPIO2_8, MX31_PIN_DSR_DCE1__GPIO2_9,
+	MX31_PIN_RI_DCE1__GPIO2_10, MX31_PIN_DCD_DCE1__GPIO2_11,
+};
+
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+#define CAM_POWER	IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)
+#define CAM_RST_B	IOMUX_TO_GPIO(MX31_PIN_GPIO3_0)
+
+static int smartbot_cam_power(struct device *dev, int on)
+{
+	gpio_set_value(CAM_POWER, !on);
+	return 0;
+}
+
+static int smartbot_cam_reset(struct device *dev)
+{
+	gpio_set_value(CAM_RST_B, 0);
+	udelay(100);
+	gpio_set_value(CAM_RST_B, 1);
+	return 0;
+}
+
+static struct i2c_board_info smartbot_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("mt9t031", 0x5d),
+	},
+};
+
+static struct soc_camera_link base_iclink = {
+	.bus_id		= 0,		/* Must match with the camera ID */
+	.power		= smartbot_cam_power,
+	.reset		= smartbot_cam_reset,
+	.board_info	= &smartbot_i2c_devices[0],
+	.i2c_adapter_id	= 0,
+	.module_name	= "mt9t031",
+};
+
+static struct platform_device smartbot_camera[] = {
+	{
+		.name	= "soc-camera-pdrv",
+		.id	= 0,
+		.dev	= {
+			.platform_data = &base_iclink,
+		},
+	},
+};
+
+static struct platform_device *smartbot_cameras[] __initdata = {
+	&smartbot_camera[0],
+};
+
+static int __init smartbot_cam_init(void)
+{
+	int ret = gpio_request(CAM_RST_B, "cam-reset");
+	if (ret)
+		return ret;
+	gpio_direction_output(CAM_RST_B, 1);
+	ret = gpio_request(CAM_POWER, "cam-standby");
+	if (ret)
+		return ret;
+	gpio_direction_output(CAM_POWER, 0);
+
+	return 0;
+}
+
+#define POWER_EN IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1)
+#define DSPIC_RST_B IOMUX_TO_GPIO(MX31_PIN_DSR_DCE1)
+#define TRSLAT_RST_B IOMUX_TO_GPIO(MX31_PIN_RI_DCE1)
+#define SEL3 IOMUX_TO_GPIO(MX31_PIN_DCD_DCE1)
+
+static void smartbot_resets_init(void)
+{
+	if (!gpio_request(POWER_EN, "power-enable")) {
+		gpio_direction_output(POWER_EN, 0);
+		gpio_export(POWER_EN, false);
+	}
+
+	if (!gpio_request(DSPIC_RST_B, "dspic-rst")) {
+		gpio_direction_output(DSPIC_RST_B, 0);
+		gpio_export(DSPIC_RST_B, false);
+	}
+
+	if (!gpio_request(TRSLAT_RST_B, "translator-rst")) {
+		gpio_direction_output(TRSLAT_RST_B, 0);
+		gpio_export(TRSLAT_RST_B, false);
+	}
+
+	if (!gpio_request(SEL3, "sel3")) {
+		gpio_direction_input(SEL3);
+		gpio_export(SEL3, true);
+	}
+}
+/*
+ * system init for baseboard usage. Will be called by mx31moboard init.
+ */
+void __init mx31moboard_smartbot_init(void)
+{
+	printk(KERN_INFO "Initializing mx31smartbot peripherals\n");
+
+	mxc_iomux_setup_multiple_pins(smartbot_pins, ARRAY_SIZE(smartbot_pins),
+		"smartbot");
+
+	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+
+	smartbot_resets_init();
+
+	smartbot_cam_init();
+	platform_add_devices(smartbot_cameras, ARRAY_SIZE(smartbot_cameras));
+}
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31moboard.h b/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
index d5be6b5..fc5fec9 100644
--- a/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
+++ b/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
@@ -25,6 +25,7 @@ enum mx31moboard_boards {
 	MX31NOBOARD	= 0,
 	MX31DEVBOARD	= 1,
 	MX31MARXBOT	= 2,
+	MX31SMARTBOT	= 3,
 };
 
 /*
@@ -34,6 +35,7 @@ enum mx31moboard_boards {
 
 extern void mx31moboard_devboard_init(void);
 extern void mx31moboard_marxbot_init(void);
+extern void mx31moboard_smartbot_init(void);
 
 #endif
 
-- 
1.6.3.3
