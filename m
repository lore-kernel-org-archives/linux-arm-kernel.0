From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Wed, 22 Jun 2011 11:25:37 +0530
Subject: [PATCH 3/3 v2] ARM: pxa168: Add board support for gplugD
In-Reply-To: <yes>
References: <yes>
Message-ID: <453554c85ebd364f14cd10953730171d6814d009.1308721057.git.tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested UART console, Ethernet & I2C interfaces

v2 - move definitions from mfp-gplugd.h to mfp-pxa168.h

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/mach-mmp/Kconfig                   |    7 +
 arch/arm/mach-mmp/Makefile                  |    1 +
 arch/arm/mach-mmp/gplugd.c                  |  197 +++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h |   37 +++++-
 4 files changed, 237 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-mmp/gplugd.c

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 67793a6..019d70a 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -77,6 +77,13 @@ config MACH_TETON_BGA
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  Teton BGA Development Board.
 
+config MACH_SHEEVAD
+	bool "Marvell's PXA168 gplugD Board"
+	select CPU_PXA168
+	help
+	  Say 'Y' here if you want to support the Marvell PXA168-based
+	  GuruPlug Display(gplugD) Development Board
+
 endmenu
 
 config CPU_PXA168
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 5c68382..b0ac942 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_MACH_BROWNSTONE)	+= brownstone.o
 obj-$(CONFIG_MACH_FLINT)	+= flint.o
 obj-$(CONFIG_MACH_MARVELL_JASPER) += jasper.o
 obj-$(CONFIG_MACH_TETON_BGA)	+= teton_bga.o
+obj-$(CONFIG_MACH_SHEEVAD)	+= gplugd.o
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
new file mode 100644
index 0000000..7fe2d12
--- /dev/null
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -0,0 +1,197 @@
+/*
+ *  linux/arch/arm/mach-mmp/gplugd.c
+ *
+ *  Support for the Marvell PXA168-based gplugD Development Platform.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <mach/gpio.h>
+#include <mach/pxa168.h>
+#include <mach/mfp-pxa168.h>
+
+#include "common.h"
+
+static unsigned long gplugd_pin_config[] __initdata = {
+	/* UART3 */
+	GPIO8_UART3_TXD,
+	GPIO9_UART3_RXD,
+	GPI1O_UART3_CTS,
+	GPI11_UART3_RTS,
+
+	/* USB OTG PEN */
+	GPIO18_GPIO,
+
+	/* MMC2 */
+	GPIO28_MMC2_CMD,
+	GPIO29_MMC2_CLK,
+	GPIO30_MMC2_DAT0,
+	GPIO31_MMC2_DAT1,
+	GPIO32_MMC2_DAT2,
+	GPIO33_MMC2_DAT3,
+
+	/* LCD & HDMI clock selection GPIO: 0: 74.176MHz, 1: 74.25 MHz */
+	GPIO35_GPIO,
+	GPIO36_GPIO, /* CEC Interrupt */
+
+	/* MMC1 */
+	GPIO43_MMC1_CLK,
+	GPIO49_MMC1_CMD,
+	GPIO41_MMC1_DAT0,
+	GPIO40_MMC1_DAT1,
+	GPIO52_MMC1_DAT2,
+	GPIO51_MMC1_DAT3,
+	GPIO53_MMC1_CD,
+
+	/* LCD */
+	GPIO56_LCD_FCLK_RD,
+	GPIO57_LCD_LCLK_A0,
+	GPIO58_LCD_PCLK_WR,
+	GPIO59_LCD_DENA_BIAS,
+	GPIO60_LCD_DD0,
+	GPIO61_LCD_DD1,
+	GPIO62_LCD_DD2,
+	GPIO63_LCD_DD3,
+	GPIO64_LCD_DD4,
+	GPIO65_LCD_DD5,
+	GPIO66_LCD_DD6,
+	GPIO67_LCD_DD7,
+	GPIO68_LCD_DD8,
+	GPIO69_LCD_DD9,
+	GPIO70_LCD_DD10,
+	GPIO71_LCD_DD11,
+	GPIO72_LCD_DD12,
+	GPIO73_LCD_DD13,
+	GPIO74_LCD_DD14,
+	GPIO75_LCD_DD15,
+	GPIO76_LCD_DD16,
+	GPIO77_LCD_DD17,
+	GPIO78_LCD_DD18,
+	GPIO79_LCD_DD19,
+	GPIO80_LCD_DD20,
+	GPIO81_LCD_DD21,
+	GPIO82_LCD_DD22,
+	GPIO83_LCD_DD23,
+
+	/* GPIO */
+	GPIO84_GPIO,
+	GPIO85_GPIO,
+
+	/* Fast-Ethernet*/
+	GPIO86_TX_CLK,
+	GPIO87_TX_EN,
+	GPIO88_TX_DQ3,
+	GPIO89_TX_DQ2,
+	GPIO90_TX_DQ1,
+	GPIO91_TX_DQ0,
+	GPIO92_MII_CRS,
+	GPIO93_MII_COL,
+	GPIO94_RX_CLK,
+	GPIO95_RX_ER,
+	GPIO96_RX_DQ3,
+	GPIO97_RX_DQ2,
+	GPIO98_RX_DQ1,
+	GPIO99_RX_DQ0,
+	GPIO100_MII_MDC,
+	GPIO101_MII_MDIO,
+	GPIO103_RX_DV,
+	GPIO104_GPIO,     /* Reset PHY */
+
+	/* RTC interrupt */
+	GPIO102_GPIO,
+
+	/* I2C */
+	GPIO105_CI2C_SDA,
+	GPIO106_CI2C_SCL,
+
+	/* SPI NOR Flash no SSP2 */
+	GPIO107_SSP2_RXD,
+	GPIO108_SSP2_TXD,
+	GPIO110_GPIO,         /* SPI_CSn */
+	GPIO111_SSP2_CLK,
+
+	/* Select JTAG */
+	GPIO109_GPIO,
+
+	/* I2S */
+	GPIO114_I2S_FRM,
+	GPIO115_I2S_BCLK,
+	GPIO116_I2S_TXD
+};
+
+static struct i2c_board_info gplugd_i2c_board_info[] = {
+	{
+		.type = "isl1208",
+		.addr = 0x6F,
+	}
+};
+
+/* Bring PHY out of reset by setting GPIO 104 */
+static int gplugd_eth_init(void)
+{
+	if (unlikely(gpio_request(104, "ETH_RESET_N"))) {
+		printk(KERN_ERR "Can't get hold of GPIO 104 to bring Ethernet "
+				"PHY out of reset\n");
+		return -EIO;
+	}
+
+	gpio_direction_output(104, 1);
+	gpio_free(104);
+	return 0;
+}
+
+struct pxa168_eth_platform_data gplugd_eth_platform_data = {
+	.port_number = 0,
+	.phy_addr    = 0,
+	.speed       = 0, /* Autonagotiation */
+	.init        = gplugd_eth_init,
+};
+
+static void __init select_disp_freq(void)
+{
+	/* set GPIO 35 & clear GPIO 85 to set LCD External Clock to 74.25 MHz */
+	if (unlikely(gpio_request(35, "DISP_FREQ_SEL"))) {
+		printk(KERN_ERR "Can't get hold of GPIO 35 to select display "
+				"frequency\n");
+	} else {
+		gpio_direction_output(35, 1);
+		gpio_free(104);
+	}
+
+	if (unlikely(gpio_request(85, "DISP_FREQ_SEL_2"))) {
+		printk(KERN_ERR "Can't get hold of GPIO 85 to select display "
+				"frequency\n");
+	} else {
+		gpio_direction_output(85, 0);
+		gpio_free(104);
+	}
+}
+
+static void __init gplugd_init(void)
+{
+	mfp_config(ARRAY_AND_SIZE(gplugd_pin_config));
+
+	select_disp_freq();
+
+	/* on-chip devices */
+	pxa168_add_uart(3);
+	pxa168_add_ssp(0);
+	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
+
+	pxa168_add_eth(&gplugd_eth_platform_data);
+}
+
+MACHINE_START(SHEEVAD, "PXA168-based gplugD Development Platform")
+	.map_io		= mmp_map_io,
+	.nr_irqs	= IRQ_BOARD_START,
+	.init_irq       = pxa168_init_irq,
+	.timer          = &pxa168_timer,
+	.init_machine   = gplugd_init,
+MACHINE_END
diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
index 8c78232..bb2a4e1 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
@@ -217,6 +217,10 @@
 #define GPIO111_UART1_DSR	MFP_CFG(GPIO111, AF2)
 #define GPIO112_UART1_DTR	MFP_CFG(GPIO111, AF1)
 #define GPIO112_UART1_DCD	MFP_CFG(GPIO112, AF2)
+#define GPIO8_UART3_TXD		MFP_CFG(GPIO8, AF2)
+#define GPIO9_UART3_RXD		MFP_CFG(GPIO9, AF2)
+#define GPI1O_UART3_CTS		MFP_CFG(GPIO10, AF2)
+#define GPI11_UART3_RTS		MFP_CFG(GPIO11, AF2)
 
 /* MMC1 */
 #define GPIO37_MMC1_DAT7	MFP_CFG(GPIO37, AF1)
@@ -232,6 +236,22 @@
 #define GPIO53_MMC1_CD		MFP_CFG(GPIO53, AF1)
 #define GPIO46_MMC1_WP		MFP_CFG(GPIO46, AF1)
 
+/* MMC2 */
+#define	GPIO28_MMC2_CMD		MFP_CFG_DRV(GPIO28, AF6, FAST)
+#define	GPIO29_MMC2_CLK		MFP_CFG_DRV(GPIO29, AF6, FAST)
+#define	GPIO30_MMC2_DAT0	MFP_CFG_DRV(GPIO30, AF6, FAST)
+#define	GPIO31_MMC2_DAT1	MFP_CFG_DRV(GPIO31, AF6, FAST)
+#define	GPIO32_MMC2_DAT2	MFP_CFG_DRV(GPIO32, AF6, FAST)
+#define	GPIO33_MMC2_DAT3	MFP_CFG_DRV(GPIO33, AF6, FAST)
+
+/* MMC4 */
+#define GPIO125_MMC4_DAT3       MFP_CFG_DRV(GPIO125, AF7, FAST)
+#define GPIO126_MMC4_DAT2       MFP_CFG_DRV(GPIO126, AF7, FAST)
+#define GPIO127_MMC4_DAT1       MFP_CFG_DRV(GPIO127, AF7, FAST)
+#define GPIO0_2_MMC4_DAT0       MFP_CFG_DRV(GPIO0_2, AF7, FAST)
+#define GPIO1_2_MMC4_CMD        MFP_CFG_DRV(GPIO1_2, AF7, FAST)
+#define GPIO2_2_MMC4_CLK        MFP_CFG_DRV(GPIO2_2, AF7, FAST)
+
 /* LCD */
 #define GPIO84_LCD_CS		MFP_CFG(GPIO84, AF1)
 #define GPIO60_LCD_DD0		MFP_CFG(GPIO60, AF1)
@@ -269,11 +289,12 @@
 #define GPIO106_CI2C_SCL	MFP_CFG(GPIO106, AF1)
 
 /* I2S */
-#define GPIO113_I2S_MCLK	MFP_CFG(GPIO113,AF6)
-#define GPIO114_I2S_FRM		MFP_CFG(GPIO114,AF1)
-#define GPIO115_I2S_BCLK	MFP_CFG(GPIO115,AF1)
-#define GPIO116_I2S_RXD		MFP_CFG(GPIO116,AF2)
-#define GPIO117_I2S_TXD		MFP_CFG(GPIO117,AF2)
+#define GPIO113_I2S_MCLK	MFP_CFG(GPIO113, AF6)
+#define GPIO114_I2S_FRM		MFP_CFG(GPIO114, AF1)
+#define GPIO115_I2S_BCLK	MFP_CFG(GPIO115, AF1)
+#define GPIO116_I2S_RXD		MFP_CFG(GPIO116, AF2)
+#define GPIO117_I2S_TXD		MFP_CFG(GPIO117, AF2)
+#define GPIO116_I2S_TXD         MFP_CFG(GPIO116, AF1)
 
 /* PWM */
 #define GPIO96_PWM3_OUT		MFP_CFG(GPIO96, AF1)
@@ -324,4 +345,10 @@
 #define GPIO101_MII_MDIO	MFP_CFG(GPIO101, AF5)
 #define GPIO103_RX_DV		MFP_CFG(GPIO103, AF5)
 
+/* SSP2 */
+#define GPIO107_SSP2_RXD	MFP_CFG(GPIO107, AF4)
+#define GPIO108_SSP2_TXD	MFP_CFG(GPIO108, AF4)
+#define GPIO111_SSP2_CLK	MFP_CFG(GPIO111, AF4)
+#define GPIO112_SSP2_FRM	MFP_CFG(GPIO112, AF4)
+
 #endif /* __ASM_MACH_MFP_PXA168_H */
-- 
1.7.0.4
