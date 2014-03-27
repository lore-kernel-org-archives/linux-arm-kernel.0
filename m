From: gcembed@gmail.com (=?UTF-8?q?Ga=C3=ABtan=20Carlier?=)
Date: Thu, 27 Mar 2014 16:29:13 +0100
Subject: [PATCH 1/1] ARM: imx: Add DTSC02 platform (i.MX27)
Message-ID: <1395934153-19416-1-git-send-email-gcembed@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
---
 arch/arm/mach-imx/Kconfig       |   17 ++
 arch/arm/mach-imx/Makefile      |    1 +
 arch/arm/mach-imx/mach-dtsc02.c |  416 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 434 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-imx/mach-dtsc02.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 5740296d..dd3679e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -419,6 +419,23 @@ config MACH_IMX27IPCAM
 	  Include support for IMX27 IPCAM platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_DTSC02
+	bool "DTSC02 platform"
+	select SOC_IMX27
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select IMX_HAVE_PLATFORM_MXC_MMC
+	select MMC
+	select MMC_MXC
+	select IMX_HAVE_PLATFORM_IMX_FB
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	help
+	  Include support for i.MX27 DTSC02 platform. This includes specific
+	  configurations for the board and its peripherals.
+
 config MACH_IMX27_DT
 	bool "Support i.MX27 platforms from device tree"
 	select SOC_IMX27
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index f4ed830..d9c4848 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD) += eukrea_mbimx27-baseboard.o
 obj-$(CONFIG_MACH_PCA100) += mach-pca100.o
 obj-$(CONFIG_MACH_MXT_TD60) += mach-mxt_td60.o
 obj-$(CONFIG_MACH_IMX27IPCAM) += mach-imx27ipcam.o
+obj-$(CONFIG_MACH_DTSC02) += mach-dtsc02.o
 obj-$(CONFIG_MACH_IMX27_DT) += imx27-dt.o
 
 # i.MX31 based machines
diff --git a/arch/arm/mach-imx/mach-dtsc02.c b/arch/arm/mach-imx/mach-dtsc02.c
new file mode 100644
index 0000000..da91c12
--- /dev/null
+++ b/arch/arm/mach-imx/mach-dtsc02.c
@@ -0,0 +1,416 @@
+/*
+ * Copyright (C) 2014 Gaetan Carlier <gcembed@gmail.com>.
+ *
+ * based on mach-mx27_3ds.c which is
+ * Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ * and authored by Fabio Estevam <fabio.estevam@freescale.com>
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
+ */
+
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <linux/mfd/mc13783.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/machine.h>
+#include <linux/platform_data/at24.h>
+#include <linux/platform_data/mtd-mxc_nand.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include "common.h"
+#include "devices-imx27.h"
+#include "hardware.h"
+#include "iomux-mx27.h"
+
+#define SPI2_SS0		IMX_GPIO_NR(4, 21)
+#define PMIC_INT		IMX_GPIO_NR(3, 14)
+#define LCD_RESET		IMX_GPIO_NR(1, 3)
+#define LCD_ENABLE		IMX_GPIO_NR(1, 31)
+#define SD1_CD                  IMX_GPIO_NR(2, 26)
+#define SD1_EN_GPIO             IMX_GPIO_NR(2, 25)
+
+static const int dtsc02_pins[] __initconst = {
+	/* UART1 */
+	PE12_PF_UART1_TXD,
+	PE13_PF_UART1_RXD,
+	PE14_PF_UART1_CTS,
+	PE15_PF_UART1_RTS,
+	/* UART2 */
+	PE6_PF_UART2_TXD,
+	PE7_PF_UART2_RXD,
+	PE3_PF_UART2_CTS,
+	PE4_PF_UART2_RTS,
+	/* UART3 */
+	PE8_PF_UART3_TXD,
+	PE9_PF_UART3_RXD,
+	PE10_PF_UART3_CTS,
+	PE11_PF_UART3_RTS,
+	/* FEC */
+	PD0_AIN_FEC_TXD0,
+	PD1_AIN_FEC_TXD1,
+	PD2_AIN_FEC_TXD2,
+	PD3_AIN_FEC_TXD3,
+	PD4_AOUT_FEC_RX_ER,
+	PD5_AOUT_FEC_RXD1,
+	PD6_AOUT_FEC_RXD2,
+	PD7_AOUT_FEC_RXD3,
+	PD8_AF_FEC_MDIO,
+	PD9_AIN_FEC_MDC,
+	PD10_AOUT_FEC_CRS,
+	PD11_AOUT_FEC_TX_CLK,
+	PD12_AOUT_FEC_RXD0,
+	PD13_AOUT_FEC_RX_DV,
+	PD14_AOUT_FEC_RX_CLK,
+	PD15_AOUT_FEC_COL,
+	PD16_AIN_FEC_TX_ER,
+	PF23_AIN_FEC_TX_EN,
+	/* SDHC1 */
+	PE18_PF_SD1_D0,
+	PE19_PF_SD1_D1,
+	PE20_PF_SD1_D2,
+	PE21_PF_SD1_D3,
+	PE22_PF_SD1_CMD,
+	PE23_PF_SD1_CLK,
+	SD1_EN_GPIO | GPIO_GPIO | GPIO_OUT,
+	/* I2C2 */
+	PC5_PF_I2C2_SDA,
+	PC6_PF_I2C2_SCL,
+	/* CSPI2 */
+	PD22_PF_CSPI2_SCLK,
+	PD23_PF_CSPI2_MISO,
+	PD24_PF_CSPI2_MOSI,
+	SPI2_SS0 | GPIO_GPIO | GPIO_OUT,
+	/* I2C1 */
+	PD17_PF_I2C_DATA,
+	PD18_PF_I2C_CLK,
+	/* PMIC INT */
+	PMIC_INT | GPIO_GPIO | GPIO_IN,
+	/* LCD */
+	PA5_PF_LSCLK,
+	PA6_PF_LD0,
+	PA7_PF_LD1,
+	PA8_PF_LD2,
+	PA9_PF_LD3,
+	PA10_PF_LD4,
+	PA11_PF_LD5,
+	PA12_PF_LD6,
+	PA13_PF_LD7,
+	PA14_PF_LD8,
+	PA15_PF_LD9,
+	PA16_PF_LD10,
+	PA17_PF_LD11,
+	PA18_PF_LD12,
+	PA19_PF_LD13,
+	PA20_PF_LD14,
+	PA21_PF_LD15,
+	PA22_PF_LD16,
+	PA23_PF_LD17,
+	PA28_PF_HSYNC,
+	PA29_PF_VSYNC,
+	PA30_PF_CONTRAST,
+	LCD_ENABLE | GPIO_GPIO | GPIO_OUT,
+	LCD_RESET | GPIO_GPIO | GPIO_OUT,
+};
+
+static const struct imxuart_platform_data uart0_pdata __initconst = {
+	/* Console port */
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static const struct imxuart_platform_data uart1_pdata __initconst = {
+	/* IR port */
+};
+
+static const struct imxuart_platform_data uart2_pdata __initconst = {
+	/* BUS port */
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static int dtsc02_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
+				void *data)
+{
+	return request_irq(gpio_to_irq(SD1_CD), detect_irq,
+			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+			"sdhc1-card-detect", data);
+}
+
+static void dtsc02_sdhc1_exit(struct device *dev, void *data)
+{
+	free_irq(gpio_to_irq(SD1_CD), data);
+}
+
+static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
+	.init = dtsc02_sdhc1_init,
+	.exit = dtsc02_sdhc1_exit,
+};
+
+static void dtsc02_sdhc1_enable_level_translator(void)
+{
+	/* Turn on TXB0108 OE pin */
+	gpio_request(SD1_EN_GPIO, "sd1_enable");
+	gpio_direction_output(SD1_EN_GPIO, 1);
+}
+
+/* Regulators */
+static struct regulator_consumer_supply vgen_consumers[] = {
+	REGULATOR_SUPPLY("lcd", "imx21-fb.0"),
+};
+
+static struct regulator_init_data vgen_init = {
+	.constraints = {
+		.min_uV	= 2775000,
+		.max_uV = 2775000,
+		.apply_uV = 1,
+		.always_on = 1,
+		.boot_on = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+			REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(vgen_consumers),
+	.consumer_supplies = vgen_consumers,
+};
+
+static struct regulator_init_data sw1a_init = {
+	.constraints = {
+		.min_uV	= 1600000,
+		.max_uV = 1600000,
+		.apply_uV = 1,
+		.always_on = 1,
+		.boot_on = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+			REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data sw2a_init = {
+	.constraints = {
+		.min_uV	= 1800000,
+		.max_uV = 1800000,
+		.apply_uV = 1,
+		.always_on = 1,
+		.boot_on = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+			REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_init_data sw2b_init = {
+	.constraints = {
+		.min_uV	= 1800000,
+		.max_uV = 1800000,
+		.apply_uV = 1,
+		.always_on = 1,
+		.boot_on = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+			REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct regulator_consumer_supply sw3_consumers[] = {
+	/* Needed for external adapter */
+	REGULATOR_SUPPLY("vdd", "imx21-uart.0"),
+	/* Needed for external IR receiver */
+	REGULATOR_SUPPLY("vdd", "imx21-uart.1"),
+};
+
+static struct regulator_init_data sw3_init = {
+	.constraints = {
+		.min_uV	= 5000000,
+		.max_uV = 5000000,
+		.apply_uV = 1,
+		.always_on = 1,
+		.boot_on = 1,
+		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+			REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(sw3_consumers),
+	.consumer_supplies = sw3_consumers,
+};
+
+static struct regulator_init_data gpo_init = {
+	.constraints = {
+		.boot_on = 1,
+		.always_on = 1,
+	}
+};
+
+static struct mc13xxx_regulator_init_data dtsc02_regulators[] = {
+	{
+		.id = MC13783_REG_VGEN,
+		.init_data = &vgen_init,
+	}, {
+		/* 1.6V */
+		.id = MC13783_REG_SW1A,
+		.init_data = &sw1a_init,
+	}, {
+		/* 1.8V */
+		.id = MC13783_REG_SW2A,
+		.init_data = &sw2a_init,
+	}, {
+		/* 1.8V */
+		.id = MC13783_REG_SW2B,
+		.init_data = &sw2b_init,
+	}, {
+		/* 3.3V */
+		.id = MC13783_REG_SW3,
+		.init_data = &sw3_init,
+	}, {
+		.id = MC13783_REG_GPO1, /* Turn on 1.8V */
+		.init_data = &gpo_init,
+	}, {
+		.id = MC13783_REG_GPO3, /* Turn on SW2B 1.8V */
+		.init_data = &gpo_init,
+	}
+};
+
+
+/* MC13783 */
+static struct mc13xxx_platform_data mc13783_pdata = {
+	.regulators = {
+		.regulators = dtsc02_regulators,
+		.num_regulators = ARRAY_SIZE(dtsc02_regulators),
+
+	},
+	.flags  = MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_ADC |
+		MC13XXX_USE_RTC,
+};
+
+/* SPI */
+static int spi2_chipselect[] = {SPI2_SS0};
+
+static const struct spi_imx_master spi2_pdata __initconst = {
+	.chipselect	= spi2_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi2_chipselect),
+};
+
+/* AT24 eeprom */
+static struct at24_platform_data at24c01 = {
+	.byte_len	= SZ_1K / 8,
+	.page_size	= 1,
+	.flags		= AT24_FLAG_IRUGO,
+};
+
+static struct i2c_board_info dtsc02_i2c1_devices[] = {
+	{
+		I2C_BOARD_INFO("24c01", 0x50),
+		.platform_data = &at24c01,
+	},
+	/* more devices can be added using expansion connectors */
+};
+
+static struct imx_fb_videomode dtsc02_modes[] = {
+	{	/* 640x480 @ 60 Hz */
+		.mode = {
+			.name		= "Hitachi-VGA",
+			.refresh	= 60,
+			.xres		= 640,
+			.yres		= 480,
+			.pixclock	= 39710,
+			.left_margin	= 144,
+			.right_margin	= 82,
+			.upper_margin	= 12,
+			.lower_margin	= 2,
+			.hsync_len	= 1,
+			.vsync_len	= 1,
+			.sync		= FB_SYNC_HOR_HIGH_ACT |
+				FB_SYNC_VERT_HIGH_ACT,
+			.vmode		= FB_VMODE_NONINTERLACED,
+			.flag		= 0,
+		},
+		.bpp		= 16,
+		.pcr		= 0xFAC08B84,
+	},
+};
+
+static const struct imx_fb_platform_data dtsc02_fb_data __initconst = {
+	.mode = dtsc02_modes,
+	.num_modes = ARRAY_SIZE(dtsc02_modes),
+	.pwmr		= 0x00A903FF,
+	.lscr1		= 0x00120300,
+	.dmacr		= 0x00040060,
+};
+
+static struct spi_board_info dtsc02_spi_devs[] __initdata = {
+	{
+		.modalias	= "mc13783",
+		.max_speed_hz	= 1000000,
+		.bus_num	= 1,
+		.chip_select	= 0, /* SS0 */
+		.platform_data	= &mc13783_pdata,
+		/* irq number is run-time assigned */
+		.mode = SPI_CS_HIGH,
+	},
+};
+
+static const struct mxc_nand_platform_data dtsc02_nand_info __initconst = {
+	.width = 1,
+	.hw_ecc = 1,
+	.flash_bbt = 1,
+};
+
+static const struct imxi2c_platform_data dtsc02_i2c1_data __initconst = {
+	.bitrate = 100000,
+};
+
+
+static void __init dtsc02_init(void)
+{
+	imx27_soc_init();
+
+	mxc_gpio_setup_multiple_pins(dtsc02_pins, ARRAY_SIZE(dtsc02_pins),
+		"dtsc02");
+	imx27_add_mxc_nand(&dtsc02_nand_info);
+	/* Console */
+	imx27_add_imx_uart0(&uart0_pdata);
+	/* IR port */
+	imx27_add_imx_uart1(&uart1_pdata);
+	/* BUS */
+	imx27_add_imx_uart2(&uart2_pdata);
+	imx27_add_fec(NULL);
+	imx27_add_imx2_wdt();
+
+	imx27_add_spi_imx1(&spi2_pdata);
+	dtsc02_spi_devs[0].irq = gpio_to_irq(PMIC_INT);
+	spi_register_board_info(dtsc02_spi_devs,
+			ARRAY_SIZE(dtsc02_spi_devs));
+
+	/* I2C-2 */
+	i2c_register_board_info(1, dtsc02_i2c1_devices,
+			ARRAY_SIZE(dtsc02_i2c1_devices));
+	imx27_add_imx_i2c(1, &dtsc02_i2c1_data);
+
+	imx27_add_imx_fb(&dtsc02_fb_data);
+
+	dtsc02_sdhc1_enable_level_translator();
+	imx27_add_mxc_mmc(0, &sdhc1_pdata);
+}
+
+static void __init dtsc02_timer_init(void)
+{
+	mx27_clocks_init(26000000);
+}
+
+MACHINE_START(DTSC02, "DTSC02")
+	/* maintainer: Gaetan Carlier. */
+	.atag_offset = 0x100,
+	.map_io = mx27_map_io,
+	.init_early = imx27_init_early,
+	.init_irq = mx27_init_irq,
+	.handle_irq = imx27_handle_irq,
+	.init_time = dtsc02_timer_init,
+	.init_machine = dtsc02_init,
+	.restart	= mxc_restart,
+MACHINE_END
-- 
1.7.7.4
