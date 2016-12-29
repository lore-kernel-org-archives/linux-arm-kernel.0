From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 29 Dec 2016 10:33:25 +0800
Subject: [PATCH v2 2/2] clk: hisilicon: Add clock driver for hi3660 SoC
In-Reply-To: <1482978805-6981-1-git-send-email-zhangfei.gao@linaro.org>
References: <1482978805-6981-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1482978805-6981-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock drivers for hi3660 SoC, this driver controls the SoC
registers to supply different clocks to different IPs in the SoC.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/clk/hisilicon/Kconfig            |   7 +
 drivers/clk/hisilicon/Makefile           |   1 +
 drivers/clk/hisilicon/clk-hi3660.c       | 592 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/hi3660-clock.h | 194 ++++++++++
 4 files changed, 794 insertions(+)
 create mode 100644 drivers/clk/hisilicon/clk-hi3660.c
 create mode 100644 include/dt-bindings/clock/hi3660-clock.h

diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index cbed660..7098bfd 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -14,6 +14,13 @@ config COMMON_CLK_HI3519
 	help
 	  Build the clock driver for hi3519.
 
+config COMMON_CLK_HI3660
+	bool "Hi3660 Clock Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	default ARCH_HISI
+	help
+	  Build the clock driver for hi3660.
+
 config COMMON_CLK_HI3798CV200
 	tristate "Hi3798CV200 Clock Driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index 4eec5e5..1e4c3dd 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
 obj-$(CONFIG_ARCH_HIX5HD2)	+= clk-hix5hd2.o
 obj-$(CONFIG_COMMON_CLK_HI3516CV300)	+= crg-hi3516cv300.o
 obj-$(CONFIG_COMMON_CLK_HI3519)	+= clk-hi3519.o
+obj-$(CONFIG_COMMON_CLK_HI3660) += clk-hi3660.o
 obj-$(CONFIG_COMMON_CLK_HI3798CV200)	+= crg-hi3798cv200.o
 obj-$(CONFIG_COMMON_CLK_HI6220)	+= clk-hi6220.o
 obj-$(CONFIG_RESET_HISI)	+= reset.o
diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
new file mode 100644
index 0000000..4e752c6
--- /dev/null
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -0,0 +1,592 @@
+/*
+ * Copyright (c) 2016-2017 Linaro Ltd.
+ * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <dt-bindings/clock/hi3660-clock.h>
+#include <linux/clk-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "clk.h"
+
+enum hi3660_clk_type {
+	HI3660_CRGCTRL = 1,
+	HI3660_PCTRL,
+	HI3660_PMUCTRL,
+	HI3660_SCTRL,
+	HI3660_IOMCU,
+};
+
+static const struct hisi_fixed_rate_clock hi3660_fixed_rate_clks[] = {
+	{ HI3660_CLKIN_SYS, "clkin_sys", NULL, 0, 19200000, },
+	{ HI3660_CLKIN_REF, "clkin_ref", NULL, 0, 32764, },
+	{ HI3660_CLK_FLL_SRC, "clk_fll_src", NULL, 0, 128000000, },
+	{ HI3660_CLK_PPLL0, "clk_ppll0", NULL, 0, 1600000000, },
+	{ HI3660_CLK_PPLL1, "clk_ppll1", NULL, 0, 1866000000, },
+	{ HI3660_CLK_PPLL2, "clk_ppll2", NULL, 0, 960000000, },
+	{ HI3660_CLK_PPLL3, "clk_ppll3", NULL, 0, 1290000000, },
+	{ HI3660_CLK_SCPLL, "clk_scpll", NULL, 0, 245760000, },
+	{ HI3660_PCLK, "pclk", NULL, 0, 20000000, },
+	{ HI3660_CLK_UART0_DBG, "clk_uart0_dbg", NULL, 0, 19200000, },
+	{ HI3660_CLK_UART6, "clk_uart6", NULL, 0, 19200000, },
+	{ HI3660_OSC32K, "osc32k", NULL, 0, 32764, },
+	{ HI3660_OSC19M, "osc19m", NULL, 0, 19200000, },
+	{ HI3660_CLK_480M, "clk_480m", NULL, 0, 480000000, },
+	{ HI3660_CLK_INV, "clk_inv", NULL, 0, 10000000, },
+};
+
+/* crgctrl */
+static const struct hisi_fixed_factor_clock hi3660_crg_fixed_factor_clks[] = {
+	{ HI3660_FACTOR_UART3, "clk_factor_uart3", "iomcu_peri0", 1, 8, 0, },
+	{ HI3660_CLK_FACTOR_MMC, "clk_factor_mmc", "clkin_sys", 1, 6, 0, },
+	{ HI3660_CLK_GATE_I2C0, "clk_gate_i2c0", "clk_i2c0_iomcu", 1, 4, 0, },
+	{ HI3660_CLK_GATE_I2C1, "clk_gate_i2c1", "clk_i2c1_iomcu", 1, 4, 0, },
+	{ HI3660_CLK_GATE_I2C2, "clk_gate_i2c2", "clk_i2c2_iomcu", 1, 4, 0, },
+	{ HI3660_CLK_GATE_I2C6, "clk_gate_i2c6", "clk_i2c6_iomcu", 1, 4, 0, },
+	{ HI3660_CLK_DIV_SYSBUS, "clk_div_sysbus", "clk_mux_sysbus", 1, 7, 0, },
+	{ HI3660_CLK_DIV_320M, "clk_div_320m", "clk_320m_pll_gt", 1, 5, 0, },
+	{ HI3660_CLK_DIV_A53, "clk_div_a53hpm", "clk_a53hpm_andgt", 1, 2, 0, },
+	{ HI3660_CLK_GATE_SPI0, "clk_gate_spi0", "clk_ppll0", 1, 8, 0, },
+	{ HI3660_CLK_GATE_SPI2, "clk_gate_spi2", "clk_ppll0", 1, 8, 0, },
+	{ HI3660_PCIEPHY_REF, "clk_pciephy_ref", "clk_div_pciephy", 1, 1, 0, },
+	{ HI3660_CLK_ABB_USB, "clk_abb_usb", "clk_gate_usb_tcxo_en", 1, 1, 0 },
+};
+
+static const struct hisi_gate_clock hi3660_crgctrl_gate_sep_clks[] = {
+	{ HI3660_HCLK_GATE_SDIO0, "hclk_gate_sdio0", "clk_div_sysbus",
+	  CLK_SET_RATE_PARENT, 0x0, 21, 0, },
+	{ HI3660_HCLK_GATE_SD, "hclk_gate_sd", "clk_div_sysbus",
+	  CLK_SET_RATE_PARENT, 0x0, 30, 0, },
+	{ HI3660_CLK_GATE_AOMM, "clk_gate_aomm", "clk_div_aomm",
+	  CLK_SET_RATE_PARENT, 0x0, 31, 0, },
+	{ HI3660_PCLK_GPIO0, "pclk_gpio0", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 0, 0, },
+	{ HI3660_PCLK_GPIO1, "pclk_gpio1", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 1, 0, },
+	{ HI3660_PCLK_GPIO2, "pclk_gpio2", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 2, 0, },
+	{ HI3660_PCLK_GPIO3, "pclk_gpio3", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 3, 0, },
+	{ HI3660_PCLK_GPIO4, "pclk_gpio4", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 4, 0, },
+	{ HI3660_PCLK_GPIO5, "pclk_gpio5", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 5, 0, },
+	{ HI3660_PCLK_GPIO6, "pclk_gpio6", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 6, 0, },
+	{ HI3660_PCLK_GPIO7, "pclk_gpio7", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 7, 0, },
+	{ HI3660_PCLK_GPIO8, "pclk_gpio8", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 8, 0, },
+	{ HI3660_PCLK_GPIO9, "pclk_gpio9", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 9, 0, },
+	{ HI3660_PCLK_GPIO10, "pclk_gpio10", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 10, 0, },
+	{ HI3660_PCLK_GPIO11, "pclk_gpio11", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 11, 0, },
+	{ HI3660_PCLK_GPIO12, "pclk_gpio12", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 12, 0, },
+	{ HI3660_PCLK_GPIO13, "pclk_gpio13", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 13, 0, },
+	{ HI3660_PCLK_GPIO14, "pclk_gpio14", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 14, 0, },
+	{ HI3660_PCLK_GPIO15, "pclk_gpio15", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 15, 0, },
+	{ HI3660_PCLK_GPIO16, "pclk_gpio16", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 16, 0, },
+	{ HI3660_PCLK_GPIO17, "pclk_gpio17", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 17, 0, },
+	{ HI3660_PCLK_GPIO18, "pclk_gpio18", "clk_div_ioperi",
+	  CLK_SET_RATE_PARENT, 0x10, 18, 0, },
+	{ HI3660_PCLK_GPIO19, "pclk_gpio19", "clk_div_ioperi",
+	  CLK_SET_RATE_PARENT, 0x10, 19, 0, },
+	{ HI3660_PCLK_GPIO20, "pclk_gpio20", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 20, 0, },
+	{ HI3660_PCLK_GPIO21, "pclk_gpio21", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x10, 21, 0, },
+	{ HI3660_CLK_GATE_SPI3, "clk_gate_spi3", "clk_div_ioperi",
+	  CLK_SET_RATE_PARENT, 0x10, 30, 0, },
+	{ HI3660_CLK_GATE_I2C7, "clk_gate_i2c7", "clk_mux_i2c",
+	  CLK_SET_RATE_PARENT, 0x10, 31, 0, },
+	{ HI3660_CLK_GATE_I2C3, "clk_gate_i2c3", "clk_mux_i2c",
+	  CLK_SET_RATE_PARENT, 0x20, 7, 0, },
+	{ HI3660_CLK_GATE_SPI1, "clk_gate_spi1", "clk_mux_spi",
+	  CLK_SET_RATE_PARENT, 0x20, 9, 0, },
+	{ HI3660_CLK_GATE_UART1, "clk_gate_uart1", "clk_mux_uarth",
+	  CLK_SET_RATE_PARENT, 0x20, 11, 0, },
+	{ HI3660_CLK_GATE_UART2, "clk_gate_uart2", "clk_mux_uart1",
+	  CLK_SET_RATE_PARENT, 0x20, 12, 0, },
+	{ HI3660_CLK_GATE_UART4, "clk_gate_uart4", "clk_mux_uarth",
+	  CLK_SET_RATE_PARENT, 0x20, 14, 0, },
+	{ HI3660_CLK_GATE_UART5, "clk_gate_uart5", "clk_mux_uart1",
+	  CLK_SET_RATE_PARENT, 0x20, 15, 0, },
+	{ HI3660_CLK_GATE_I2C4, "clk_gate_i2c4", "clk_mux_i2c",
+	  CLK_SET_RATE_PARENT, 0x20, 27, 0, },
+	{ HI3660_CLK_GATE_DMAC, "clk_gate_dmac", "clk_div_sysbus",
+	  CLK_SET_RATE_PARENT, 0x30, 1, 0, },
+	{ HI3660_PCLK_GATE_DSS, "pclk_gate_dss", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x30, 12, 0, },
+	{ HI3660_ACLK_GATE_DSS, "aclk_gate_dss", "clk_gate_vivobus",
+	  CLK_SET_RATE_PARENT, 0x30, 13, 0, },
+	{ HI3660_CLK_GATE_LDI1, "clk_gate_ldi1", "clk_div_ldi1",
+	  CLK_SET_RATE_PARENT, 0x30, 14, 0, },
+	{ HI3660_CLK_GATE_LDI0, "clk_gate_ldi0", "clk_div_ldi0",
+	  CLK_SET_RATE_PARENT, 0x30, 15, 0, },
+	{ HI3660_CLK_GATE_VIVOBUS, "clk_gate_vivobus", "clk_div_vivobus",
+	  CLK_SET_RATE_PARENT, 0x30, 16, 0, },
+	{ HI3660_CLK_GATE_EDC0, "clk_gate_edc0", "clk_div_edc0",
+	  CLK_SET_RATE_PARENT, 0x30, 17, 0, },
+	{ HI3660_CLK_GATE_TXDPHY0_CFG, "clk_gate_txdphy0_cfg", "clkin_sys",
+	  CLK_SET_RATE_PARENT, 0x30, 28, 0, },
+	{ HI3660_CLK_GATE_TXDPHY0_REF, "clk_gate_txdphy0_ref", "clkin_sys",
+	  CLK_SET_RATE_PARENT, 0x30, 29, 0, },
+	{ HI3660_CLK_GATE_TXDPHY1_CFG, "clk_gate_txdphy1_cfg", "clkin_sys",
+	  CLK_SET_RATE_PARENT, 0x30, 30, 0, },
+	{ HI3660_CLK_GATE_TXDPHY1_REF, "clk_gate_txdphy1_ref", "clkin_sys",
+	  CLK_SET_RATE_PARENT, 0x30, 31, 0, },
+	{ HI3660_ACLK_GATE_USB3OTG, "aclk_gate_usb3otg", "clk_div_mmc0bus",
+	  CLK_SET_RATE_PARENT, 0x40, 1, 0, },
+	{ HI3660_CLK_GATE_SPI4, "clk_gate_spi4", "clk_mux_spi",
+	  CLK_SET_RATE_PARENT, 0x40, 4, 0, },
+	{ HI3660_CLK_GATE_SD, "clk_gate_sd", "clk_mux_sd_sys",
+	  CLK_SET_RATE_PARENT, 0x40, 17, 0, },
+	{ HI3660_CLK_GATE_SDIO0, "clk_gate_sdio0", "clk_mux_sdio_sys",
+	  CLK_SET_RATE_PARENT, 0x40, 19, 0, },
+	{ HI3660_CLK_GATE_UFS_SUBSYS, "clk_gate_ufs_subsys", "clk_div_sysbus",
+	  CLK_SET_RATE_PARENT, 0x50, 21, 0, },
+	{ HI3660_PCLK_GATE_DSI0, "pclk_gate_dsi0", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x50, 28, 0, },
+	{ HI3660_PCLK_GATE_DSI1, "pclk_gate_dsi1", "clk_div_cfgbus",
+	  CLK_SET_RATE_PARENT, 0x50, 29, 0, },
+	{ HI3660_ACLK_GATE_PCIE, "aclk_gate_pcie", "clk_div_mmc1bus",
+	  CLK_SET_RATE_PARENT, 0x420, 5, 0, },
+	{ HI3660_PCLK_GATE_PCIE_SYS, "pclk_gate_pcie_sys", "clk_div_mmc1bus",
+	  CLK_SET_RATE_PARENT, 0x420, 7, 0, },
+	{ HI3660_CLK_GATE_PCIEAUX, "clk_gate_pcieaux", "clkin_sys",
+	  CLK_SET_RATE_PARENT, 0x420, 8, 0, },
+	{ HI3660_PCLK_GATE_PCIE_PHY, "pclk_gate_pcie_phy", "clk_div_mmc1bus",
+	  CLK_SET_RATE_PARENT, 0x420, 9, 0, },
+};
+
+static const struct hisi_gate_clock hi3660_crgctrl_gate_clks[] = {
+	{ HI3660_CLK_ANDGT_LDI0, "clk_andgt_ldi0", "clk_mux_ldi0",
+	  CLK_SET_RATE_PARENT, 0xf0, 6, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_LDI1, "clk_andgt_ldi1", "clk_mux_ldi1",
+	  CLK_SET_RATE_PARENT, 0xf0, 7, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_EDC0, "clk_andgt_edc0", "clk_mux_edc0",
+	  CLK_SET_RATE_PARENT, 0xf0, 8, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_GATE_UFSPHY_GT, "clk_gate_ufsphy_gt", "clk_div_ufsperi",
+	  CLK_SET_RATE_PARENT, 0xf4, 1, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_MMC, "clk_andgt_mmc", "clk_mux_mmc_pll",
+	  CLK_SET_RATE_PARENT, 0xf4, 2, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_SD, "clk_andgt_sd", "clk_mux_sd_pll",
+	  CLK_SET_RATE_PARENT, 0xf4, 3, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_A53HPM_ANDGT, "clk_a53hpm_andgt", "clk_mux_a53hpm",
+	  CLK_SET_RATE_PARENT, 0xf4, 7, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_SDIO, "clk_andgt_sdio", "clk_mux_sdio_pll",
+	  CLK_SET_RATE_PARENT, 0xf4, 8, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_UART0, "clk_andgt_uart0", "clk_div_320m",
+	  CLK_SET_RATE_PARENT, 0xf4, 9, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_UART1, "clk_andgt_uart1", "clk_div_320m",
+	  CLK_SET_RATE_PARENT, 0xf4, 10, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_UARTH, "clk_andgt_uarth", "clk_div_320m",
+	  CLK_SET_RATE_PARENT, 0xf4, 11, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_SPI, "clk_andgt_spi", "clk_div_320m",
+	  CLK_SET_RATE_PARENT, 0xf4, 13, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_VIVOBUS_ANDGT, "clk_vivobus_andgt", "clk_mux_vivobus",
+	  CLK_SET_RATE_PARENT, 0xf8, 1, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_AOMM_ANDGT, "clk_aomm_andgt", "clk_ppll2",
+	  CLK_SET_RATE_PARENT, 0xf8, 3, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_320M_PLL_GT, "clk_320m_pll_gt", "clk_mux_320m",
+	  CLK_SET_RATE_PARENT, 0xf8, 10, 0, },
+	{ HI3660_AUTODIV_EMMC0BUS, "autodiv_emmc0bus", "autodiv_sysbus",
+	  CLK_SET_RATE_PARENT, 0x404, 1, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_AUTODIV_SYSBUS, "autodiv_sysbus", "clk_div_sysbus",
+	  CLK_SET_RATE_PARENT, 0x404, 5, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_GATE_UFSPHY_CFG, "clk_gate_ufsphy_cfg",
+	  "clk_div_ufsphy_cfg", CLK_SET_RATE_PARENT, 0x420, 12, 0, },
+	{ HI3660_CLK_GATE_UFSIO_REF, "clk_gate_ufsio_ref",
+	  "clk_gate_ufs_tcxo_en", CLK_SET_RATE_PARENT, 0x420, 14, 0, },
+};
+
+static const char *const
+clk_mux_sdio_sys_p[] = {"clk_factor_mmc", "clk_div_sdio",};
+static const char *const
+clk_mux_sd_sys_p[] = {"clk_factor_mmc", "clk_div_sd",};
+static const char *const
+clk_mux_pll_p[] = {"clk_ppll0", "clk_ppll1", "clk_ppll2", "clk_ppll2",};
+static const char *const
+clk_mux_pll0123_p[] = {"clk_ppll0", "clk_ppll1", "clk_ppll2", "clk_ppll3",};
+static const char *const
+clk_mux_edc0_p[] = {"clk_inv", "clk_ppll0", "clk_ppll1", "clk_inv",
+		    "clk_ppll2", "clk_inv", "clk_inv", "clk_inv",
+		    "clk_ppll3", "clk_inv", "clk_inv", "clk_inv",
+		    "clk_inv", "clk_inv", "clk_inv", "clk_inv",};
+static const char *const
+clk_mux_ldi0_p[] = {"clk_inv", "clk_ppll0", "clk_ppll2", "clk_inv",
+		    "clk_ppll1", "clk_inv", "clk_inv", "clk_inv",
+		    "clk_ppll3", "clk_inv", "clk_inv", "clk_inv",
+		    "clk_inv", "clk_inv", "clk_inv", "clk_inv",};
+static const char *const
+clk_mux_uart0_p[] = {"clkin_sys", "clk_div_uart0",};
+static const char *const
+clk_mux_uart1_p[] = {"clkin_sys", "clk_div_uart1",};
+static const char *const
+clk_mux_uarth_p[] = {"clkin_sys", "clk_div_uarth",};
+static const char *const
+clk_mux_pll02p[] = {"clk_ppll0", "clk_ppll2",};
+static const char *const
+clk_mux_ioperi_p[] = {"clk_div_320m", "clk_div_a53hpm",};
+static const char *const
+clk_mux_spi_p[] = {"clkin_sys", "clk_div_spi",};
+static const char *const
+clk_mux_i2c_p[] = {"clkin_sys", "clk_div_i2c",};
+
+static const struct hisi_mux_clock hi3660_crgctrl_mux_clks[] = {
+	{ HI3660_CLK_MUX_SYSBUS, "clk_mux_sysbus", clk_mux_sdio_sys_p,
+	  ARRAY_SIZE(clk_mux_sdio_sys_p), CLK_SET_RATE_PARENT, 0xac, 0, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_UART0, "clk_mux_uart0", clk_mux_uart0_p,
+	  ARRAY_SIZE(clk_mux_uart0_p), CLK_SET_RATE_PARENT, 0xac, 2, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_UART1, "clk_mux_uart1", clk_mux_uart1_p,
+	  ARRAY_SIZE(clk_mux_uart1_p), CLK_SET_RATE_PARENT, 0xac, 3, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_UARTH, "clk_mux_uarth", clk_mux_uarth_p,
+	  ARRAY_SIZE(clk_mux_uarth_p), CLK_SET_RATE_PARENT, 0xac, 4, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_SPI, "clk_mux_spi", clk_mux_spi_p,
+	  ARRAY_SIZE(clk_mux_spi_p), CLK_SET_RATE_PARENT, 0xac, 8, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_I2C, "clk_mux_i2c", clk_mux_i2c_p,
+	  ARRAY_SIZE(clk_mux_i2c_p), CLK_SET_RATE_PARENT, 0xac, 13, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_MMC_PLL, "clk_mux_mmc_pll", clk_mux_pll02p,
+	  ARRAY_SIZE(clk_mux_pll02p), CLK_SET_RATE_PARENT, 0xb4, 0, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_LDI1, "clk_mux_ldi1", clk_mux_ldi0_p,
+	  ARRAY_SIZE(clk_mux_ldi0_p), CLK_SET_RATE_PARENT, 0xb4, 8, 4,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_LDI0, "clk_mux_ldi0", clk_mux_ldi0_p,
+	  ARRAY_SIZE(clk_mux_ldi0_p), CLK_SET_RATE_PARENT, 0xb4, 12, 4,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_SD_PLL, "clk_mux_sd_pll", clk_mux_pll_p,
+	  ARRAY_SIZE(clk_mux_pll_p), CLK_SET_RATE_PARENT, 0xb8, 4, 2,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_SD_SYS, "clk_mux_sd_sys", clk_mux_sd_sys_p,
+	  ARRAY_SIZE(clk_mux_sd_sys_p), CLK_SET_RATE_PARENT, 0xb8, 6, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_EDC0, "clk_mux_edc0", clk_mux_edc0_p,
+	  ARRAY_SIZE(clk_mux_edc0_p), CLK_SET_RATE_PARENT, 0xbc, 6, 4,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_SDIO_SYS, "clk_mux_sdio_sys", clk_mux_sdio_sys_p,
+	  ARRAY_SIZE(clk_mux_sdio_sys_p), CLK_SET_RATE_PARENT, 0xc0, 6, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_SDIO_PLL, "clk_mux_sdio_pll", clk_mux_pll_p,
+	  ARRAY_SIZE(clk_mux_pll_p), CLK_SET_RATE_PARENT, 0xc0, 4, 2,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_VIVOBUS, "clk_mux_vivobus", clk_mux_pll0123_p,
+	  ARRAY_SIZE(clk_mux_pll0123_p), CLK_SET_RATE_PARENT, 0xd0, 12, 2,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_A53HPM, "clk_mux_a53hpm", clk_mux_pll02p,
+	  ARRAY_SIZE(clk_mux_pll02p), CLK_SET_RATE_PARENT, 0xd4, 9, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_320M, "clk_mux_320m", clk_mux_pll02p,
+	  ARRAY_SIZE(clk_mux_pll02p), CLK_SET_RATE_PARENT, 0x100, 0, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_IOPERI, "clk_mux_ioperi", clk_mux_ioperi_p,
+	  ARRAY_SIZE(clk_mux_ioperi_p), CLK_SET_RATE_PARENT, 0x108, 10, 1,
+	  CLK_MUX_HIWORD_MASK, },
+};
+
+static const struct hisi_divider_clock hi3660_crgctrl_divider_clks[] = {
+	{ HI3660_CLK_DIV_UART0, "clk_div_uart0", "clk_andgt_uart0",
+	  CLK_SET_RATE_PARENT, 0xb0, 4, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_UART1, "clk_div_uart1", "clk_andgt_uart1",
+	  CLK_SET_RATE_PARENT, 0xb0, 8, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_UARTH, "clk_div_uarth", "clk_andgt_uarth",
+	  CLK_SET_RATE_PARENT, 0xb0, 12, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_MMC, "clk_div_mmc", "clk_andgt_mmc",
+	  CLK_SET_RATE_PARENT, 0xb4, 3, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_SD, "clk_div_sd", "clk_andgt_sd",
+	  CLK_SET_RATE_PARENT, 0xb8, 0, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_EDC0, "clk_div_edc0", "clk_andgt_edc0",
+	  CLK_SET_RATE_PARENT, 0xbc, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_LDI0, "clk_div_ldi0", "clk_andgt_ldi0",
+	  CLK_SET_RATE_PARENT, 0xbc, 10, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_SDIO, "clk_div_sdio", "clk_andgt_sdio",
+	  CLK_SET_RATE_PARENT, 0xc0, 0, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_LDI1, "clk_div_ldi1", "clk_andgt_ldi1",
+	  CLK_SET_RATE_PARENT, 0xc0, 8, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_SPI, "clk_div_spi", "clk_andgt_spi",
+	  CLK_SET_RATE_PARENT, 0xc4, 12, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_VIVOBUS, "clk_div_vivobus", "clk_vivobus_andgt",
+	  CLK_SET_RATE_PARENT, 0xd0, 7, 5, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_I2C, "clk_div_i2c", "clk_div_320m",
+	  CLK_SET_RATE_PARENT, 0xe8, 4, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_UFSPHY, "clk_div_ufsphy_cfg", "clk_gate_ufsphy_gt",
+	  CLK_SET_RATE_PARENT, 0xe8, 9, 2, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_CFGBUS, "clk_div_cfgbus", "clk_div_sysbus",
+	  CLK_SET_RATE_PARENT, 0xec, 0, 2, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_MMC0BUS, "clk_div_mmc0bus", "autodiv_emmc0bus",
+	  CLK_SET_RATE_PARENT, 0xec, 2, 1, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_MMC1BUS, "clk_div_mmc1bus", "clk_div_sysbus",
+	  CLK_SET_RATE_PARENT, 0xec, 3, 1, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_UFSPERI, "clk_div_ufsperi", "clk_gate_ufs_subsys",
+	  CLK_SET_RATE_PARENT, 0xec, 14, 1, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_AOMM, "clk_div_aomm", "clk_aomm_andgt",
+	  CLK_SET_RATE_PARENT, 0x100, 7, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_IOPERI, "clk_div_ioperi", "clk_mux_ioperi",
+	  CLK_SET_RATE_PARENT, 0x108, 11, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+};
+
+/* clk_pmuctrl */
+/* pmu register need shift 2 bits */
+static const struct hisi_gate_clock hi3660_pmu_gate_clks[] = {
+	{ HI3660_GATE_ABB_192, "clk_gate_abb_192", "clkin_sys",
+	  CLK_SET_RATE_PARENT, (0x10a << 2), 3, 0, },
+};
+
+/* clk_pctrl */
+static const struct hisi_gate_clock hi3660_pctrl_gate_clks[] = {
+	{ HI3660_GATE_UFS_TCXO_EN, "clk_gate_ufs_tcxo_en",
+	  "clk_gate_abb_192", CLK_SET_RATE_PARENT, 0x10, 0,
+	  CLK_GATE_HIWORD_MASK, },
+	{ HI3660_GATE_USB_TCXO_EN, "clk_gate_usb_tcxo_en", "clk_gate_abb_192",
+	  CLK_SET_RATE_PARENT, 0x10, 1, CLK_GATE_HIWORD_MASK, },
+};
+
+/* clk_sctrl */
+static const struct hisi_gate_clock hi3660_sctrl_gate_sep_clks[] = {
+	{ HI3660_PCLK_AO_GPIO0, "pclk_ao_gpio0", "clk_div_aobus",
+	  CLK_SET_RATE_PARENT, 0x160, 11, 0, },
+	{ HI3660_PCLK_AO_GPIO1, "pclk_ao_gpio1", "clk_div_aobus",
+	  CLK_SET_RATE_PARENT, 0x160, 12, 0, },
+	{ HI3660_PCLK_AO_GPIO2, "pclk_ao_gpio2", "clk_div_aobus",
+	  CLK_SET_RATE_PARENT, 0x160, 13, 0, },
+	{ HI3660_PCLK_AO_GPIO3, "pclk_ao_gpio3", "clk_div_aobus",
+	  CLK_SET_RATE_PARENT, 0x160, 14, 0, },
+	{ HI3660_PCLK_AO_GPIO4, "pclk_ao_gpio4", "clk_div_aobus",
+	  CLK_SET_RATE_PARENT, 0x160, 21, 0, },
+	{ HI3660_PCLK_AO_GPIO5, "pclk_ao_gpio5", "clk_div_aobus",
+	  CLK_SET_RATE_PARENT, 0x160, 22, 0, },
+	{ HI3660_PCLK_AO_GPIO6, "pclk_ao_gpio6", "clk_div_aobus",
+	  CLK_SET_RATE_PARENT, 0x160, 25, 0, },
+	{ HI3660_PCLK_GATE_MMBUF, "pclk_gate_mmbuf", "pclk_div_mmbuf",
+	  CLK_SET_RATE_PARENT, 0x170, 23, 0, },
+	{ HI3660_CLK_GATE_DSS_AXI_MM, "clk_gate_dss_axi_mm", "aclk_mux_mmbuf",
+	  CLK_SET_RATE_PARENT, 0x170, 24, 0, },
+};
+
+static const struct hisi_gate_clock hi3660_sctrl_gate_clks[] = {
+	{ HI3660_PCLK_MMBUF_ANDGT, "pclk_mmbuf_andgt", "clk_sw_mmbuf",
+	  CLK_SET_RATE_PARENT, 0x258, 7, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_MMBUF_PLL_ANDGT, "clk_mmbuf_pll_andgt", "clk_ppll0",
+	  CLK_SET_RATE_PARENT, 0x260, 11, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_FLL_MMBUF_ANDGT, "clk_fll_mmbuf_andgt", "clk_fll_src",
+	  CLK_SET_RATE_PARENT, 0x260, 12, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_SYS_MMBUF_ANDGT, "clk_sys_mmbuf_andgt", "clkin_sys",
+	  CLK_SET_RATE_PARENT, 0x260, 13, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_GATE_PCIEPHY_GT, "clk_gate_pciephy_gt", "clk_ppll0",
+	  CLK_SET_RATE_PARENT, 0x268, 11, CLK_DIVIDER_HIWORD_MASK, 0, },
+};
+
+static const char *const
+aclk_mux_mmbuf_p[] = {"aclk_div_mmbuf", "clk_gate_aomm",};
+static const char *const
+clk_sw_mmbuf_p[] = {"clk_sys_mmbuf_andgt", "clk_fll_mmbuf_andgt",
+		    "aclk_mux_mmbuf", "aclk_mux_mmbuf"};
+
+static const struct hisi_mux_clock hi3660_sctrl_mux_clks[] = {
+	{ HI3660_ACLK_MUX_MMBUF, "aclk_mux_mmbuf", aclk_mux_mmbuf_p,
+	  ARRAY_SIZE(aclk_mux_mmbuf_p), CLK_SET_RATE_PARENT, 0x250, 12, 1,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_SW_MMBUF, "clk_sw_mmbuf", clk_sw_mmbuf_p,
+	  ARRAY_SIZE(clk_sw_mmbuf_p), CLK_SET_RATE_PARENT, 0x258, 8, 2,
+	  CLK_MUX_HIWORD_MASK, },
+};
+
+static const struct hisi_divider_clock hi3660_sctrl_divider_clks[] = {
+	{ HI3660_CLK_DIV_AOBUS, "clk_div_aobus", "clk_ppll0",
+	  CLK_SET_RATE_PARENT, 0x254, 0, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_PCLK_DIV_MMBUF, "pclk_div_mmbuf", "pclk_mmbuf_andgt",
+	  CLK_SET_RATE_PARENT, 0x258, 10, 2, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_ACLK_DIV_MMBUF, "aclk_div_mmbuf", "clk_mmbuf_pll_andgt",
+	  CLK_SET_RATE_PARENT, 0x258, 12, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_PCIEPHY, "clk_div_pciephy", "clk_gate_pciephy_gt",
+	  CLK_SET_RATE_PARENT, 0x268, 12, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+};
+
+/* clk_iomcu */
+static const struct hisi_gate_clock hi3660_iomcu_gate_sep_clks[] = {
+	{ HI3660_CLK_I2C0_IOMCU, "clk_i2c0_iomcu", "clk_fll_src",
+	  CLK_SET_RATE_PARENT, 0x10, 3, 0, },
+	{ HI3660_CLK_I2C1_IOMCU, "clk_i2c1_iomcu", "clk_fll_src",
+	  CLK_SET_RATE_PARENT, 0x10, 4, 0, },
+	{ HI3660_CLK_I2C2_IOMCU, "clk_i2c2_iomcu", "clk_fll_src",
+	  CLK_SET_RATE_PARENT, 0x10, 5, 0, },
+	{ HI3660_CLK_I2C6_IOMCU, "clk_i2c6_iomcu", "clk_fll_src",
+	  CLK_SET_RATE_PARENT, 0x10, 27, 0, },
+	{ HI3660_CLK_IOMCU_PERI0, "iomcu_peri0", "clk_ppll0",
+	  CLK_SET_RATE_PARENT, 0x90, 0, 0, },
+};
+
+static void hi3660_clk_iomcu_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+	int nr = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks);
+
+	clk_data = hisi_clk_init(np, nr);
+	if (!clk_data)
+		return;
+
+	hisi_clk_register_gate_sep(hi3660_iomcu_gate_sep_clks,
+				   ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
+				   clk_data);
+}
+
+static void hi3660_clk_pmuctrl_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+	int nr = ARRAY_SIZE(hi3660_pmu_gate_clks);
+
+	clk_data = hisi_clk_init(np, nr);
+	if (!clk_data)
+		return;
+
+	hisi_clk_register_gate(hi3660_pmu_gate_clks,
+			       ARRAY_SIZE(hi3660_pmu_gate_clks), clk_data);
+}
+
+static void hi3660_clk_pctrl_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+	int nr = ARRAY_SIZE(hi3660_pctrl_gate_clks);
+
+	clk_data = hisi_clk_init(np, nr);
+	if (!clk_data)
+		return;
+	hisi_clk_register_gate(hi3660_pctrl_gate_clks,
+			       ARRAY_SIZE(hi3660_pctrl_gate_clks), clk_data);
+}
+
+static void hi3660_clk_sctrl_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+	int nr = ARRAY_SIZE(hi3660_sctrl_gate_clks) +
+		 ARRAY_SIZE(hi3660_sctrl_gate_sep_clks) +
+		 ARRAY_SIZE(hi3660_sctrl_mux_clks) +
+		 ARRAY_SIZE(hi3660_sctrl_divider_clks);
+
+	clk_data = hisi_clk_init(np, nr);
+	if (!clk_data)
+		return;
+	hisi_clk_register_gate(hi3660_sctrl_gate_clks,
+			       ARRAY_SIZE(hi3660_sctrl_gate_clks), clk_data);
+	hisi_clk_register_gate_sep(hi3660_sctrl_gate_sep_clks,
+				   ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
+				   clk_data);
+	hisi_clk_register_mux(hi3660_sctrl_mux_clks,
+			      ARRAY_SIZE(hi3660_sctrl_mux_clks), clk_data);
+	hisi_clk_register_divider(hi3660_sctrl_divider_clks,
+				  ARRAY_SIZE(hi3660_sctrl_divider_clks),
+				  clk_data);
+}
+
+static void hi3660_clk_crgctrl_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+	int nr = ARRAY_SIZE(hi3660_fixed_rate_clks) +
+		 ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks) +
+		 ARRAY_SIZE(hi3660_crgctrl_gate_clks) +
+		 ARRAY_SIZE(hi3660_crgctrl_mux_clks) +
+		 ARRAY_SIZE(hi3660_crg_fixed_factor_clks) +
+		 ARRAY_SIZE(hi3660_crgctrl_divider_clks);
+
+	clk_data = hisi_clk_init(np, nr);
+	if (!clk_data)
+		return;
+
+	hisi_clk_register_fixed_rate(hi3660_fixed_rate_clks,
+				     ARRAY_SIZE(hi3660_fixed_rate_clks),
+				     clk_data);
+	hisi_clk_register_gate_sep(hi3660_crgctrl_gate_sep_clks,
+				   ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
+				   clk_data);
+	hisi_clk_register_gate(hi3660_crgctrl_gate_clks,
+			       ARRAY_SIZE(hi3660_crgctrl_gate_clks),
+			       clk_data);
+	hisi_clk_register_mux(hi3660_crgctrl_mux_clks,
+			      ARRAY_SIZE(hi3660_crgctrl_mux_clks),
+			      clk_data);
+	hisi_clk_register_fixed_factor(hi3660_crg_fixed_factor_clks,
+				       ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
+				       clk_data);
+	hisi_clk_register_divider(hi3660_crgctrl_divider_clks,
+				  ARRAY_SIZE(hi3660_crgctrl_divider_clks),
+				  clk_data);
+}
+
+static const struct of_device_id hi3660_clk_match_table[] = {
+	{ .compatible = "hisilicon,hi3660-crgctrl",
+	  .data = (void *)HI3660_CRGCTRL },
+	{ .compatible = "hisilicon,hi3660-pctrl",
+	  .data = (void *)HI3660_PCTRL },
+	{ .compatible = "hisilicon,hi3660-pmuctrl",
+	  .data = (void *)HI3660_PMUCTRL },
+	{ .compatible = "hisilicon,hi3660-sctrl",
+	  .data = (void *)HI3660_SCTRL },
+	{ .compatible = "hisilicon,hi3660-iomcu",
+	  .data = (void *)HI3660_IOMCU },
+	{ }
+};
+
+static int hi3660_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	enum hi3660_clk_type type;
+
+	type = (enum hi3660_clk_type)of_device_get_match_data(dev);
+	if (!type)
+		return -ENODEV;
+
+	switch (type) {
+	case HI3660_CRGCTRL:
+		hi3660_clk_crgctrl_init(np);
+		break;
+	case HI3660_PCTRL:
+		hi3660_clk_pctrl_init(np);
+		break;
+	case HI3660_PMUCTRL:
+		hi3660_clk_pmuctrl_init(np);
+		break;
+	case HI3660_SCTRL:
+		hi3660_clk_sctrl_init(np);
+		break;
+	case HI3660_IOMCU:
+		hi3660_clk_iomcu_init(np);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static struct platform_driver hi3660_clk_driver = {
+	.probe          = hi3660_clk_probe,
+	.driver         = {
+		.name   = "hi3660-clk",
+		.of_match_table = hi3660_clk_match_table,
+	},
+};
+
+static int __init hi3660_clk_init(void)
+{
+	return platform_driver_register(&hi3660_clk_driver);
+}
+core_initcall(hi3660_clk_init);
diff --git a/include/dt-bindings/clock/hi3660-clock.h b/include/dt-bindings/clock/hi3660-clock.h
new file mode 100644
index 0000000..1c00b7f
--- /dev/null
+++ b/include/dt-bindings/clock/hi3660-clock.h
@@ -0,0 +1,194 @@
+/*
+ * Copyright (c) 2016-2017 Linaro Ltd.
+ * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DTS_HI3660_CLOCK_H
+#define __DTS_HI3660_CLOCK_H
+
+/* fixed rate clocks */
+#define HI3660_CLKIN_SYS		0
+#define HI3660_CLKIN_REF		1
+#define HI3660_CLK_FLL_SRC		2
+#define HI3660_CLK_PPLL0		3
+#define HI3660_CLK_PPLL1		4
+#define HI3660_CLK_PPLL2		5
+#define HI3660_CLK_PPLL3		6
+#define HI3660_CLK_SCPLL		7
+#define HI3660_PCLK			8
+#define HI3660_CLK_UART0_DBG		9
+#define HI3660_CLK_UART6		10
+#define HI3660_OSC32K			11
+#define HI3660_OSC19M			12
+#define HI3660_CLK_480M			13
+#define HI3660_CLK_INV			14
+
+/* clk in crgctrl */
+#define HI3660_FACTOR_UART3		15
+#define HI3660_CLK_FACTOR_MMC		16
+#define HI3660_CLK_GATE_I2C0		17
+#define HI3660_CLK_GATE_I2C1		18
+#define HI3660_CLK_GATE_I2C2		19
+#define HI3660_CLK_GATE_I2C6		20
+#define HI3660_CLK_DIV_SYSBUS		21
+#define HI3660_CLK_DIV_320M		22
+#define HI3660_CLK_DIV_A53		23
+#define HI3660_CLK_GATE_SPI0		24
+#define HI3660_CLK_GATE_SPI2		25
+#define HI3660_PCIEPHY_REF		26
+#define HI3660_CLK_ABB_USB		27
+#define HI3660_HCLK_GATE_SDIO0		28
+#define HI3660_HCLK_GATE_SD		29
+#define HI3660_CLK_GATE_AOMM		30
+#define HI3660_PCLK_GPIO0		31
+#define HI3660_PCLK_GPIO1		32
+#define HI3660_PCLK_GPIO2		33
+#define HI3660_PCLK_GPIO3		34
+#define HI3660_PCLK_GPIO4		35
+#define HI3660_PCLK_GPIO5		36
+#define HI3660_PCLK_GPIO6		37
+#define HI3660_PCLK_GPIO7		38
+#define HI3660_PCLK_GPIO8		39
+#define HI3660_PCLK_GPIO9		40
+#define HI3660_PCLK_GPIO10		41
+#define HI3660_PCLK_GPIO11		42
+#define HI3660_PCLK_GPIO12		43
+#define HI3660_PCLK_GPIO13		44
+#define HI3660_PCLK_GPIO14		45
+#define HI3660_PCLK_GPIO15		46
+#define HI3660_PCLK_GPIO16		47
+#define HI3660_PCLK_GPIO17		48
+#define HI3660_PCLK_GPIO18		49
+#define HI3660_PCLK_GPIO19		50
+#define HI3660_PCLK_GPIO20		51
+#define HI3660_PCLK_GPIO21		52
+#define HI3660_CLK_GATE_SPI3		53
+#define HI3660_CLK_GATE_I2C7		54
+#define HI3660_CLK_GATE_I2C3		55
+#define HI3660_CLK_GATE_SPI1		56
+#define HI3660_CLK_GATE_UART1		57
+#define HI3660_CLK_GATE_UART2		58
+#define HI3660_CLK_GATE_UART4		59
+#define HI3660_CLK_GATE_UART5		60
+#define HI3660_CLK_GATE_I2C4		61
+#define HI3660_CLK_GATE_DMAC		62
+#define HI3660_PCLK_GATE_DSS		63
+#define HI3660_ACLK_GATE_DSS		64
+#define HI3660_CLK_GATE_LDI1		65
+#define HI3660_CLK_GATE_LDI0		66
+#define HI3660_CLK_GATE_VIVOBUS		67
+#define HI3660_CLK_GATE_EDC0		68
+#define HI3660_CLK_GATE_TXDPHY0_CFG	69
+#define HI3660_CLK_GATE_TXDPHY0_REF	70
+#define HI3660_CLK_GATE_TXDPHY1_CFG	71
+#define HI3660_CLK_GATE_TXDPHY1_REF	72
+#define HI3660_ACLK_GATE_USB3OTG	73
+#define HI3660_CLK_GATE_SPI4		74
+#define HI3660_CLK_GATE_SD		75
+#define HI3660_CLK_GATE_SDIO0		76
+#define HI3660_CLK_GATE_UFS_SUBSYS	77
+#define HI3660_PCLK_GATE_DSI0		78
+#define HI3660_PCLK_GATE_DSI1		79
+#define HI3660_ACLK_GATE_PCIE		80
+#define HI3660_PCLK_GATE_PCIE_SYS       81
+#define HI3660_CLK_GATE_PCIEAUX		82
+#define HI3660_PCLK_GATE_PCIE_PHY	83
+#define HI3660_CLK_ANDGT_LDI0		84
+#define HI3660_CLK_ANDGT_LDI1		85
+#define HI3660_CLK_ANDGT_EDC0		86
+#define HI3660_CLK_GATE_UFSPHY_GT	87
+#define HI3660_CLK_ANDGT_MMC		88
+#define HI3660_CLK_ANDGT_SD		89
+#define HI3660_CLK_A53HPM_ANDGT		90
+#define HI3660_CLK_ANDGT_SDIO		91
+#define HI3660_CLK_ANDGT_UART0		92
+#define HI3660_CLK_ANDGT_UART1		93
+#define HI3660_CLK_ANDGT_UARTH		94
+#define HI3660_CLK_ANDGT_SPI		95
+#define HI3660_CLK_VIVOBUS_ANDGT	96
+#define HI3660_CLK_AOMM_ANDGT		97
+#define HI3660_CLK_320M_PLL_GT		98
+#define HI3660_AUTODIV_EMMC0BUS		99
+#define HI3660_AUTODIV_SYSBUS		100
+#define HI3660_CLK_GATE_UFSPHY_CFG	101
+#define HI3660_CLK_GATE_UFSIO_REF	102
+#define HI3660_CLK_MUX_SYSBUS		103
+#define HI3660_CLK_MUX_UART0		104
+#define HI3660_CLK_MUX_UART1		105
+#define HI3660_CLK_MUX_UARTH		106
+#define HI3660_CLK_MUX_SPI		107
+#define HI3660_CLK_MUX_I2C		108
+#define HI3660_CLK_MUX_MMC_PLL		109
+#define HI3660_CLK_MUX_LDI1		110
+#define HI3660_CLK_MUX_LDI0		111
+#define HI3660_CLK_MUX_SD_PLL		112
+#define HI3660_CLK_MUX_SD_SYS		113
+#define HI3660_CLK_MUX_EDC0		114
+#define HI3660_CLK_MUX_SDIO_SYS		115
+#define HI3660_CLK_MUX_SDIO_PLL		116
+#define HI3660_CLK_MUX_VIVOBUS		117
+#define HI3660_CLK_MUX_A53HPM		118
+#define HI3660_CLK_MUX_320M		119
+#define HI3660_CLK_MUX_IOPERI		120
+#define HI3660_CLK_DIV_UART0		121
+#define HI3660_CLK_DIV_UART1		122
+#define HI3660_CLK_DIV_UARTH		123
+#define HI3660_CLK_DIV_MMC		124
+#define HI3660_CLK_DIV_SD		125
+#define HI3660_CLK_DIV_EDC0		126
+#define HI3660_CLK_DIV_LDI0		127
+#define HI3660_CLK_DIV_SDIO		128
+#define HI3660_CLK_DIV_LDI1		129
+#define HI3660_CLK_DIV_SPI		130
+#define HI3660_CLK_DIV_VIVOBUS		131
+#define HI3660_CLK_DIV_I2C		132
+#define HI3660_CLK_DIV_UFSPHY		133
+#define HI3660_CLK_DIV_CFGBUS		134
+#define HI3660_CLK_DIV_MMC0BUS		135
+#define HI3660_CLK_DIV_MMC1BUS		136
+#define HI3660_CLK_DIV_UFSPERI		137
+#define HI3660_CLK_DIV_AOMM		138
+#define HI3660_CLK_DIV_IOPERI		139
+
+/* clk in pmuctrl */
+#define HI3660_GATE_ABB_192		0
+
+/* clk in pctrl */
+#define HI3660_GATE_UFS_TCXO_EN		0
+#define HI3660_GATE_USB_TCXO_EN		1
+
+/* clk in sctrl */
+#define HI3660_PCLK_AO_GPIO0		0
+#define HI3660_PCLK_AO_GPIO1		1
+#define HI3660_PCLK_AO_GPIO2		2
+#define HI3660_PCLK_AO_GPIO3		3
+#define HI3660_PCLK_AO_GPIO4		4
+#define HI3660_PCLK_AO_GPIO5		5
+#define HI3660_PCLK_AO_GPIO6		6
+#define HI3660_PCLK_GATE_MMBUF		7
+#define HI3660_CLK_GATE_DSS_AXI_MM	8
+#define HI3660_PCLK_MMBUF_ANDGT		9
+#define HI3660_CLK_MMBUF_PLL_ANDGT	10
+#define HI3660_CLK_FLL_MMBUF_ANDGT	11
+#define HI3660_CLK_SYS_MMBUF_ANDGT	12
+#define HI3660_CLK_GATE_PCIEPHY_GT	13
+#define HI3660_ACLK_MUX_MMBUF		14
+#define HI3660_CLK_SW_MMBUF		15
+#define HI3660_CLK_DIV_AOBUS		16
+#define HI3660_PCLK_DIV_MMBUF		17
+#define HI3660_ACLK_DIV_MMBUF		18
+#define HI3660_CLK_DIV_PCIEPHY		19
+
+/* clk in iomcu */
+#define HI3660_CLK_I2C0_IOMCU		0
+#define HI3660_CLK_I2C1_IOMCU		1
+#define HI3660_CLK_I2C2_IOMCU		2
+#define HI3660_CLK_I2C6_IOMCU		3
+#define HI3660_CLK_IOMCU_PERI0		4
+
+#endif	/* __DTS_HI3660_CLOCK_H */
-- 
2.7.4
