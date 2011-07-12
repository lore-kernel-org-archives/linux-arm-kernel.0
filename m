From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jul 2011 13:18:38 +0200
Subject: [PATCH] i.MX53: Initial Ka-Ro electronics TX53 board support
Message-ID: <1310469518-23615-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initial board support for the Ka-Ro electronics TX53
processor module (MACH_TX53).

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/mach-mx5/Kconfig                   |   15 +
 arch/arm/mach-mx5/Makefile                  |    1 +
 arch/arm/mach-mx5/board-tx53.c              |  400 +++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
 4 files changed, 417 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-tx53.c

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index b4e7c58..c40f41b 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -221,6 +221,21 @@ config MACH_MX53_ARD
 	  Include support for MX53 ARD platform. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_TX53
+	bool "Support Ka-Ro electronics TX53 module"
+	select SOC_IMX53
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select LEDS_GPIO_REGISTER
+	help
+	  Include support for TX53 platform. This includes specific
+	  configurations for the board and its peripherals.
+
 endif # ARCH_MX53_SUPPORTED
 
 endif
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 383e7cd..e4da5e8 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_MACH_MX53_EVK) += board-mx53_evk.o
 obj-$(CONFIG_MACH_MX53_SMD) += board-mx53_smd.o
 obj-$(CONFIG_MACH_MX53_LOCO) += board-mx53_loco.o
 obj-$(CONFIG_MACH_MX53_ARD) += board-mx53_ard.o
+obj-$(CONFIG_MACH_TX53) += board-tx53.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
 obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += board-cpuimx51sd.o
diff --git a/arch/arm/mach-mx5/board-tx53.c b/arch/arm/mach-mx5/board-tx53.c
new file mode 100644
index 0000000..3ff8bb0
--- /dev/null
+++ b/arch/arm/mach-mx5/board-tx53.c
@@ -0,0 +1,400 @@
+/*
+ * Copyright (C) 2011 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/fec.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <linux/i2c/tsc2007.h>
+#include <linux/regulator/lp3972.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx53.h>
+
+#define TX53_FEC_PHY_RST	IMX_GPIO_NR(7, 6)
+#define TX53_FEC_PHY_PWR	IMX_GPIO_NR(3, 20)
+#define TX53_FEC_PHY_INT	IMX_GPIO_NR(2, 4)
+
+#include "crm_regs.h"
+#include "devices-imx53.h"
+
+static iomux_v3_cfg_t tx53_pads[] = {
+	/* UART pads */
+	MX53_PAD_PATA_DIOW__UART1_TXD_MUX,
+	MX53_PAD_PATA_DMACK__UART1_RXD_MUX,
+	MX53_PAD_PATA_IORDY__UART1_RTS,
+	MX53_PAD_PATA_RESET_B__UART1_CTS,
+
+	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
+	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
+	MX53_PAD_PATA_DIOR__UART2_RTS,
+	MX53_PAD_PATA_INTRQ__UART2_CTS,
+
+	MX53_PAD_PATA_CS_0__UART3_TXD_MUX,
+	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
+	MX53_PAD_PATA_DA_2__UART3_RTS,
+	MX53_PAD_PATA_DA_1__UART3_CTS,
+
+	/* (e)CSPI pads */
+	MX53_PAD_EIM_D16__ECSPI1_SCLK,
+	MX53_PAD_EIM_D17__ECSPI1_MISO,
+	MX53_PAD_EIM_D18__ECSPI1_MOSI,
+
+	/* eCSPI chip select lines */
+	MX53_PAD_EIM_EB2__GPIO2_30,
+	MX53_PAD_EIM_D19__GPIO3_19,
+
+	/* Starterkit LED */
+	MX53_PAD_EIM_A18__GPIO2_20,
+
+	/* eSDHC 1 */
+	MX53_PAD_SD1_CMD__ESDHC1_CMD,
+	MX53_PAD_SD1_CLK__ESDHC1_CLK,
+	MX53_PAD_SD1_DATA0__ESDHC1_DAT0,
+	MX53_PAD_SD1_DATA1__ESDHC1_DAT1,
+	MX53_PAD_SD1_DATA2__ESDHC1_DAT2,
+	MX53_PAD_SD1_DATA3__ESDHC1_DAT3,
+	/* SD1 CD */
+	MX53_PAD_EIM_D24__GPIO3_24,
+
+	/* eSDHC 2 */
+	MX53_PAD_SD2_CMD__ESDHC2_CMD,
+	MX53_PAD_SD2_CLK__ESDHC2_CLK,
+	MX53_PAD_SD2_DATA0__ESDHC2_DAT0,
+	MX53_PAD_SD2_DATA1__ESDHC2_DAT1,
+	MX53_PAD_SD2_DATA2__ESDHC2_DAT2,
+	MX53_PAD_SD2_DATA3__ESDHC2_DAT3,
+	/* SD2 CD */
+	MX53_PAD_EIM_D25__GPIO3_25,
+};
+
+static const struct imxuart_platform_data tx53_uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static inline void tx53_init_uart(void)
+{
+	imx53_add_imx_uart(0, &tx53_uart_pdata);
+	imx53_add_imx_uart(1, &tx53_uart_pdata);
+	imx53_add_imx_uart(2, &tx53_uart_pdata);
+}
+
+static const struct gpio_led tx53_stk5_leds[] __initconst = {
+	{
+		.name = "GPIO-LED",
+		.default_trigger = "heartbeat",
+		.gpio = IMX_GPIO_NR(2, 20),
+	},
+};
+
+static const struct gpio_led_platform_data tx53_stk5_led_data __initconst = {
+	.leds = tx53_stk5_leds,
+	.num_leds = ARRAY_SIZE(tx53_stk5_leds),
+};
+
+static int __init tx53_stk5v3_led_init(void)
+{
+	gpio_led_register_device(0, &tx53_stk5_led_data);
+	return 0;
+}
+
+static iomux_v3_cfg_t tx53_i2c_pads[][2] = {
+	[0] = {
+		MX53_PAD_EIM_D28__I2C1_SDA,
+		MX53_PAD_EIM_D21__I2C1_SCL,
+	},
+	[2] = {
+		MX53_PAD_GPIO_6__I2C3_SDA,
+		MX53_PAD_GPIO_3__I2C3_SCL,
+	},
+};
+
+static int tx53_i2c_init(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	switch (pdev->id) {
+	case 0:
+	case 2:
+		mxc_iomux_v3_setup_multiple_pads(tx53_i2c_pads[pdev->id],
+				ARRAY_SIZE(tx53_i2c_pads[pdev->id]));
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct imxi2c_platform_data tx53_i2c1_data __initconst = {
+	.bitrate = 100000,
+	.init = tx53_i2c_init,
+};
+
+static const struct imxi2c_platform_data tx53_i2c3_data __initconst = {
+	.bitrate = 100000,
+	.init = tx53_i2c_init,
+};
+
+#define TSC2007_PEN_GPIO	IMX_GPIO_NR(3, 26)
+
+static int tx53_stk5_tsc2007_init(void)
+{
+	int ret;
+
+	ret = gpio_request(TSC2007_PEN_GPIO, "TSC2007");
+	if (ret)
+		return ret;
+
+	return gpio_direction_input(TSC2007_PEN_GPIO);
+}
+
+static void tx53_stk5_tsc2007_exit(void)
+{
+	gpio_free(TSC2007_PEN_GPIO);
+}
+
+static int tx53_stk5_get_pendown(void)
+{
+	int val = gpio_get_value(TSC2007_PEN_GPIO);
+
+	pr_debug("%s: TS pen is %s\n", __func__, val ? "up" : "down");
+	return !val;
+}
+
+static struct tsc2007_platform_data tx53_stk5v3_tsc2007_pdata = {
+	.model = 2007,
+	.x_plate_ohms = 660,
+	.get_pendown_state = tx53_stk5_get_pendown,
+	.init_platform_hw = tx53_stk5_tsc2007_init,
+	.exit_platform_hw = tx53_stk5_tsc2007_exit,
+};
+
+static struct lp3972_regulator_subdev tx53_lp3972_regulators[] = {
+};
+
+static struct lp3972_platform_data tx53_lp3972_pdata = {
+	.regulators = tx53_lp3972_regulators,
+	.num_regulators = ARRAY_SIZE(tx53_lp3972_regulators),
+};
+
+static struct i2c_board_info tx53_stk5v3_i2c1_boardinfo[] __initdata = {
+	{
+		I2C_BOARD_INFO("lp3972", 0x34),
+		.platform_data = &tx53_lp3972_pdata,
+	},
+	{
+		I2C_BOARD_INFO("ds1339", 0x68),
+	},
+};
+
+static struct i2c_board_info tx53_stk5v3_i2c3_boardinfo[] __initdata = {
+	{
+		I2C_BOARD_INFO("tsc2007", 0x48),
+		.irq = gpio_to_irq(TSC2007_PEN_GPIO),
+		.platform_data = &tx53_stk5v3_tsc2007_pdata,
+	},
+	{
+		I2C_BOARD_INFO("sgtl5000-i2c", 0x0a),
+	},
+};
+
+static struct gpio tx53_fec_gpios[] = {
+	{ TX53_FEC_PHY_RST, GPIOF_OUT_INIT_HIGH, "fec-phy-reset", },
+	{ TX53_FEC_PHY_PWR, GPIOF_OUT_INIT_HIGH, "fec-phy-power", },
+	{ TX53_FEC_PHY_INT, GPIOF_IN, "fec-phy-interrupt", },
+};
+
+static struct fec_platform_data tx53_fec_pdata = {
+	.phy = PHY_INTERFACE_MODE_RMII,
+};
+
+static int __init tx53_read_mac(unsigned char addr[ETH_ALEN])
+{
+	int ret;
+	int i;
+	void __iomem *ioaddr;
+	unsigned long fec_mac_base = 0;
+	struct clk *iim_clk;
+
+	iim_clk = clk_get(NULL, "iim_clk");
+	if (IS_ERR(iim_clk)) {
+		printk(KERN_ERR "%s: Failed to get IIM clock\n", __func__);
+		return PTR_ERR(iim_clk);
+	}
+	ret = clk_enable(iim_clk);
+	if (ret) {
+		printk(KERN_ERR "%s: Failed to enable IIM clock: %d\n",
+			__func__, ret);
+		goto put_clk;
+	}
+	fec_mac_base = MX53_IIM_BASE_ADDR + 0xc24;
+	ioaddr = ioremap(fec_mac_base, ETH_ALEN * sizeof(long));
+	if (ioaddr == NULL) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
+	printk(KERN_INFO "Copying MAC address from fuse bank %08lx\n",
+		fec_mac_base);
+	for (i = 0; i < ETH_ALEN; i++)
+		addr[ETH_ALEN - i - 1] = __raw_readl(ioaddr + i * 4);
+	iounmap(ioaddr);
+disable_clk:
+	clk_disable(iim_clk);
+put_clk:
+	clk_put(iim_clk);
+	return ret;
+}
+
+static inline int tx53_fec_init(void)
+{
+	int ret;
+
+	/* reset FEC PHY */
+	ret = gpio_request_array(tx53_fec_gpios, ARRAY_SIZE(tx53_fec_gpios));
+	if (ret) {
+		printk(KERN_ERR "failed to get FEC GPIOs: %d\n", ret);
+		return ret;
+	}
+	gpio_set_value(TX53_FEC_PHY_PWR, 1);
+	gpio_set_value(TX53_FEC_PHY_RST, 1);
+
+	ret = tx53_read_mac(tx53_fec_pdata.mac);
+	if (ret) {
+		printk(KERN_ERR "%s: Failed to read MAC from fuses: %d\n",
+			__func__, ret);
+		return ret;
+	}
+	return ret;
+}
+
+static struct spi_board_info tx53_spi_board_info[] __initdata = {
+	{
+		.modalias = "spidev",
+		.max_speed_hz = 25000000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.mode = SPI_MODE_0,
+		.platform_data = NULL,
+	},
+};
+
+static int tx53_spi_cs[] = {
+	IMX_GPIO_NR(2, 30),
+	IMX_GPIO_NR(3, 19),
+};
+
+static const struct spi_imx_master tx53_spi_data __initconst = {
+	.chipselect     = tx53_spi_cs,
+	.num_chipselect = ARRAY_SIZE(tx53_spi_cs),
+};
+
+#define MX53_UUID_ADDR		(MX53_IIM_BASE_ADDR + 0x820)
+#define MX53_UUID_LEN		8
+
+static void __init tx53_set_system_serial(void)
+{
+	void __iomem *mx53_serial_addr = ioremap(MX53_UUID_ADDR, MX53_UUID_LEN);
+	struct clk *iim_clk;
+
+	if (mx53_serial_addr == NULL) {
+		printk(KERN_WARNING "Failed to map MX53_UUID_ADDR; cannot set system serial number\n");
+		return;
+	}
+
+	iim_clk = clk_get(NULL, "iim_clk");
+	if (IS_ERR(iim_clk)) {
+		printk(KERN_ERR "%s: Failed to get IIM clock: %ld\n", __func__,
+			PTR_ERR(iim_clk));
+		iounmap(mx53_serial_addr);
+		return;
+	}
+
+	if (clk_enable(iim_clk) == 0) {
+		int i, n;
+		unsigned int __iomem *p = mx53_serial_addr;
+
+		for (i = n = 0; i < sizeof(system_serial_low) &&
+			     n < MX53_UUID_LEN; i++, n++, p++) {
+			system_serial_low |= readl(p) << (i * 8);
+		}
+		for (i = 0; i < sizeof(system_serial_high) &&
+			     n < MX53_UUID_LEN; i++, n++, p++) {
+			system_serial_high |= readl(p) << (i * 8);
+		}
+	} else {
+		printk(KERN_ERR "Failed to enable IIM clock\n");
+	}
+	clk_disable(iim_clk);
+	clk_put(iim_clk);
+	iounmap(mx53_serial_addr);
+}
+
+static void __init tx53_stk5v3_board_init(void)
+{
+	tx53_stk5v3_led_init();
+	imx53_add_imx_i2c(2, &tx53_i2c3_data);
+	i2c_register_board_info(2, tx53_stk5v3_i2c3_boardinfo,
+				ARRAY_SIZE(tx53_stk5v3_i2c3_boardinfo));
+}
+
+static void __init tx53_board_init(void)
+{
+	imx53_soc_init();
+	tx53_set_system_serial();
+
+	mxc_iomux_v3_setup_multiple_pads(tx53_pads,
+					ARRAY_SIZE(tx53_pads));
+	tx53_init_uart();
+	tx53_fec_init();
+	imx53_add_fec(&tx53_fec_pdata);
+
+	imx53_add_imx_i2c(0, &tx53_i2c1_data);
+	i2c_register_board_info(0, tx53_stk5v3_i2c1_boardinfo,
+				ARRAY_SIZE(tx53_stk5v3_i2c1_boardinfo));
+
+	imx53_add_sdhci_esdhc_imx(0, NULL);
+	imx53_add_sdhci_esdhc_imx(1, NULL);
+
+	spi_register_board_info(tx53_spi_board_info,
+		ARRAY_SIZE(tx53_spi_board_info));
+	imx53_add_ecspi(0, &tx53_spi_data);
+	imx53_add_imx2_wdt(0, NULL);
+
+	tx53_stk5v3_board_init();
+}
+
+static void __init tx53_timer_init(void)
+{
+	mx53_clocks_init(32768, 24000000, 0, 0);
+}
+
+static struct sys_timer tx53_timer = {
+	.init	= tx53_timer_init,
+};
+
+MACHINE_START(TX53, "Ka-Ro TX53 module")
+	.map_io = mx53_map_io,
+	.init_early = imx53_init_early,
+	.init_irq = mx53_init_irq,
+	.timer = &tx53_timer,
+	.init_machine = tx53_board_init,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 88fd404..7bbec05 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -118,6 +118,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	case MACH_TYPE_MX53_LOCO:
 	case MACH_TYPE_MX53_SMD:
 	case MACH_TYPE_MX53_ARD:
+	case MACH_TYPE_TX53:
 		uart_base = MX53_UART1_BASE_ADDR;
 		break;
 	default:
-- 
1.5.6.5
