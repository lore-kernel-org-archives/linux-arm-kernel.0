From: wenpan@hisilicon.com (Pan Wen)
Date: Mon, 17 Oct 2016 20:07:04 +0800
Subject: [PATCH 2/3] clk: hisilicon: add CRG driver for Hi3516CV300 SoC
In-Reply-To: <20161017120705.3726-1-wenpan@hisilicon.com>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
Message-ID: <20161017120705.3726-3-wenpan@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CRG driver for Hi3516CV300 SoC. CRG(Clock and Reset
Generator) module generates clock and reset signals used
by other module blocks on SoC.

Signed-off-by: Pan Wen <wenpan@hisilicon.com>
---
 .../devicetree/bindings/clock/hisi-crg.txt         |  50 ++++
 drivers/clk/hisilicon/Kconfig                      |   8 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/crg-hi3516cv300.c            | 330 +++++++++++++++++++++
 drivers/clk/hisilicon/crg.h                        |  34 +++
 include/dt-bindings/clock/hi3516cv300-clock.h      |  48 +++
 6 files changed, 471 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hisi-crg.txt
 create mode 100644 drivers/clk/hisilicon/crg-hi3516cv300.c
 create mode 100644 drivers/clk/hisilicon/crg.h
 create mode 100644 include/dt-bindings/clock/hi3516cv300-clock.h

diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
new file mode 100644
index 0000000..cc60b3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hisi-crg.txt
@@ -0,0 +1,50 @@
+* HiSilicon Clock and Reset Generator(CRG)
+
+The CRG module provides clock and reset signals to various
+modules within the SoC.
+
+This binding uses the following bindings:
+    Documentation/devicetree/bindings/clock/clock-bindings.txt
+    Documentation/devicetree/bindings/reset/reset.txt
+
+Required Properties:
+
+- compatible: should be one of the following.
+  - "hisilicon,hi3516cv300-crg"
+  - "hisilicon,hi3516cv300-sysctrl"
+  - "hisilicon,hi3519-crg"
+  - "hisilicon,hi3798cv200-crg"
+  - "hisilicon,hi3798cv200-sysctrl"
+
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+- #clock-cells: should be 1.
+
+Each clock is assigned an identifier and client nodes use this identifier
+to specify the clock which they consume.
+
+All these identifier could be found in <dt-bindings/clock/hi3519-clock.h>.
+
+- #reset-cells: should be 2.
+
+A reset signal can be controlled by writing a bit register in the CRG module.
+The reset specifier consists of two cells. The first cell represents the
+register offset relative to the base address. The second cell represents the
+bit index in the register.
+
+Example: CRG nodes
+CRG: clock-reset-controller at 12010000 {
+	compatible = "hisilicon,hi3519-crg";
+	reg = <0x12010000 0x10000>;
+	#clock-cells = <1>;
+	#reset-cells = <2>;
+};
+
+Example: consumer nodes
+i2c0: i2c at 12110000 {
+	compatible = "hisilicon,hi3519-i2c";
+	reg = <0x12110000 0x1000>;
+	clocks = <&CRG HI3519_I2C0_RST>;
+	resets = <&CRG 0xe4 0>;
+};
diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index 3f537a0..5ceb42f 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -1,3 +1,11 @@
+config COMMON_CLK_HI3516CV300
+	tristate "HI3516CV300 Clock Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	select RESET_HISI
+	default ARCH_HISI
+	help
+	  Build the clock driver for hi3516cv300.
+
 config COMMON_CLK_HI3519
 	tristate "Hi3519 Clock Driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index e169ec7..6c5c34d 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -7,6 +7,7 @@ obj-y	+= clk.o clkgate-separated.o clkdivider-hi6220.o
 obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3620.o
 obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
 obj-$(CONFIG_ARCH_HIX5HD2)	+= clk-hix5hd2.o
+obj-$(CONFIG_COMMON_CLK_HI3516CV300)	+= crg-hi3516cv300.o
 obj-$(CONFIG_COMMON_CLK_HI3519)	+= clk-hi3519.o
 obj-$(CONFIG_COMMON_CLK_HI6220)	+= clk-hi6220.o
 obj-$(CONFIG_RESET_HISI)	+= reset.o
diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
new file mode 100644
index 0000000..2007123
--- /dev/null
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -0,0 +1,330 @@
+/*
+ * Hi3516CV300 Clock and Reset Generator Driver
+ *
+ * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
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
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <dt-bindings/clock/hi3516cv300-clock.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "clk.h"
+#include "crg.h"
+#include "reset.h"
+
+/* hi3516CV300 core CRG */
+#define HI3516CV300_INNER_CLK_OFFSET	64
+#define HI3516CV300_FIXED_3M		65
+#define HI3516CV300_FIXED_6M		66
+#define HI3516CV300_FIXED_24M		67
+#define HI3516CV300_FIXED_49P5		68
+#define HI3516CV300_FIXED_50M		69
+#define HI3516CV300_FIXED_83P3M		70
+#define HI3516CV300_FIXED_99M		71
+#define HI3516CV300_FIXED_100M		72
+#define HI3516CV300_FIXED_148P5M	73
+#define HI3516CV300_FIXED_198M		74
+#define HI3516CV300_FIXED_297M		75
+#define HI3516CV300_UART_MUX		76
+#define HI3516CV300_FMC_MUX		77
+#define HI3516CV300_MMC0_MUX		78
+#define HI3516CV300_MMC1_MUX		79
+#define HI3516CV300_MMC2_MUX		80
+#define HI3516CV300_MMC3_MUX		81
+#define HI3516CV300_PWM_MUX		82
+#define HI3516CV300_CRG_NR_CLKS		128
+
+static const struct hisi_fixed_rate_clock hi3516cv300_fixed_rate_clks[] = {
+	{ HI3516CV300_FIXED_3M, "3m", NULL, 0, 3000000, },
+	{ HI3516CV300_FIXED_6M, "6m", NULL, 0, 6000000, },
+	{ HI3516CV300_FIXED_24M, "24m", NULL, 0, 24000000, },
+	{ HI3516CV300_FIXED_49P5, "49.5m", NULL, 0, 49500000, },
+	{ HI3516CV300_FIXED_50M, "50m", NULL, 0, 50000000, },
+	{ HI3516CV300_FIXED_83P3M, "83.3m", NULL, 0, 83300000, },
+	{ HI3516CV300_FIXED_99M, "99m", NULL, 0, 99000000, },
+	{ HI3516CV300_FIXED_100M, "100m", NULL, 0, 100000000, },
+	{ HI3516CV300_FIXED_148P5M, "148.5m", NULL, 0, 148500000, },
+	{ HI3516CV300_FIXED_198M, "198m", NULL, 0, 198000000, },
+	{ HI3516CV300_FIXED_297M, "297m", NULL, 0, 297000000, },
+	{ HI3516CV300_APB_CLK, "apb", NULL, 0, 50000000, },
+};
+
+static const char *const uart_mux_p[] = {"24m", "6m"};
+static const char *const fmc_mux_p[] = {
+	"24m", "83.3m", "148.5m", "198m", "297m"
+};
+static const char *const mmc_mux_p[] = {"49.5m"};
+static const char *const mmc2_mux_p[] = {"99m", "49.5m"};
+static const char *const pwm_mux_p[] = {"3m", "50m", "24m", "24m"};
+
+static u32 uart_mux_table[] = {0, 1};
+static u32 fmc_mux_table[] = {0, 1, 2, 3, 4};
+static u32 mmc_mux_table[] = {0};
+static u32 mmc2_mux_table[] = {0, 2};
+static u32 pwm_mux_table[] = {0, 1, 2, 3};
+
+static const struct hisi_mux_clock hi3516cv300_mux_clks[] = {
+	{ HI3516CV300_UART_MUX, "uart_mux", uart_mux_p, ARRAY_SIZE(uart_mux_p),
+		CLK_SET_RATE_PARENT, 0xe4, 19, 1, 0, uart_mux_table, },
+	{ HI3516CV300_FMC_MUX, "fmc_mux", fmc_mux_p, ARRAY_SIZE(fmc_mux_p),
+		CLK_SET_RATE_PARENT, 0xc0, 2, 3, 0, fmc_mux_table, },
+	{ HI3516CV300_MMC0_MUX, "mmc0_mux", mmc_mux_p, ARRAY_SIZE(mmc_mux_p),
+		CLK_SET_RATE_PARENT, 0xc4, 4, 2, 0, mmc_mux_table, },
+	{ HI3516CV300_MMC1_MUX, "mmc1_mux", mmc_mux_p, ARRAY_SIZE(mmc_mux_p),
+		CLK_SET_RATE_PARENT, 0xc4, 12, 2, 0, mmc_mux_table, },
+	{ HI3516CV300_MMC2_MUX, "mmc2_mux", mmc2_mux_p, ARRAY_SIZE(mmc2_mux_p),
+		CLK_SET_RATE_PARENT, 0xc4, 20, 2, 0, mmc2_mux_table, },
+	{ HI3516CV300_MMC3_MUX, "mmc3_mux", mmc_mux_p, ARRAY_SIZE(mmc_mux_p),
+		CLK_SET_RATE_PARENT, 0xc8, 4, 2, 0, mmc_mux_table, },
+	{ HI3516CV300_PWM_MUX, "pwm_mux", pwm_mux_p, ARRAY_SIZE(pwm_mux_p),
+		CLK_SET_RATE_PARENT, 0x38, 2, 2, 0, pwm_mux_table, },
+};
+
+static const struct hisi_gate_clock hi3516cv300_gate_clks[] = {
+
+	{ HI3516CV300_UART0_CLK, "clk_uart0", "uart_mux", CLK_SET_RATE_PARENT,
+		0xe4, 15, 0, },
+	{ HI3516CV300_UART1_CLK, "clk_uart1", "uart_mux", CLK_SET_RATE_PARENT,
+		0xe4, 16, 0, },
+	{ HI3516CV300_UART2_CLK, "clk_uart2", "uart_mux", CLK_SET_RATE_PARENT,
+		0xe4, 17, 0, },
+
+	{ HI3516CV300_SPI0_CLK, "clk_spi0", "100m", CLK_SET_RATE_PARENT,
+		0xe4, 13, 0, },
+	{ HI3516CV300_SPI1_CLK, "clk_spi1", "100m", CLK_SET_RATE_PARENT,
+		0xe4, 14, 0, },
+
+	{ HI3516CV300_FMC_CLK, "clk_fmc", "fmc_mux", CLK_SET_RATE_PARENT,
+		0xc0, 1, 0, },
+	{ HI3516CV300_MMC0_CLK, "clk_mmc0", "mmc0_mux", CLK_SET_RATE_PARENT,
+		0xc4, 1, 0, },
+	{ HI3516CV300_MMC1_CLK, "clk_mmc1", "mmc1_mux", CLK_SET_RATE_PARENT,
+		0xc4, 9, 0, },
+	{ HI3516CV300_MMC2_CLK, "clk_mmc2", "mmc2_mux", CLK_SET_RATE_PARENT,
+		0xc4, 17, 0, },
+	{ HI3516CV300_MMC3_CLK, "clk_mmc3", "mmc3_mux", CLK_SET_RATE_PARENT,
+		0xc8, 1, 0, },
+
+	{ HI3516CV300_ETH_CLK, "clk_eth", NULL, 0, 0xec, 1, 0, },
+
+	{ HI3516CV300_DMAC_CLK, "clk_dmac", NULL, 0, 0xd8, 5, 0, },
+	{ HI3516CV300_PWM_CLK, "clk_pwm", "pwm_mux", CLK_SET_RATE_PARENT,
+		0x38, 1, 0, },
+
+	{ HI3516CV300_USB2_BUS_CLK, "clk_usb2_bus", NULL, 0, 0xb8, 0, 0, },
+	{ HI3516CV300_USB2_OHCI48M_CLK, "clk_usb2_ohci48m", NULL, 0,
+		0xb8, 1, 0, },
+	{ HI3516CV300_USB2_OHCI12M_CLK, "clk_usb2_ohci12m", NULL, 0,
+		0xb8, 2, 0, },
+	{ HI3516CV300_USB2_OTG_UTMI_CLK, "clk_usb2_otg_utmi", NULL, 0,
+		0xb8, 3, 0, },
+	{ HI3516CV300_USB2_HST_PHY_CLK, "clk_usb2_hst_phy", NULL, 0,
+		0xb8, 4, 0, },
+	{ HI3516CV300_USB2_UTMI0_CLK, "clk_usb2_utmi0", NULL, 0, 0xb8, 5, 0, },
+	{ HI3516CV300_USB2_PHY_CLK, "clk_usb2_phy", NULL, 0, 0xb8, 7, 0, },
+};
+
+static struct hisi_clock_data *hi3516cv300_clk_register(
+		struct platform_device *pdev)
+{
+	struct hisi_clock_data *clk_data;
+	int ret;
+
+	clk_data = hisi_clk_alloc(pdev, HI3516CV300_CRG_NR_CLKS);
+	if (!clk_data)
+		return ERR_PTR(-ENOMEM);
+
+	ret = hisi_clk_register_fixed_rate(hi3516cv300_fixed_rate_clks,
+			ARRAY_SIZE(hi3516cv300_fixed_rate_clks), clk_data);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = hisi_clk_register_mux(hi3516cv300_mux_clks,
+			ARRAY_SIZE(hi3516cv300_mux_clks), clk_data);
+	if (ret)
+		goto unregister_fixed_rate;
+
+	ret = hisi_clk_register_gate(hi3516cv300_gate_clks,
+			ARRAY_SIZE(hi3516cv300_gate_clks), clk_data);
+	if (ret)
+		goto unregister_mux;
+
+	ret = of_clk_add_provider(pdev->dev.of_node,
+			of_clk_src_onecell_get, &clk_data->clk_data);
+	if (ret)
+		goto unregister_gate;
+
+	return clk_data;
+
+unregister_gate:
+	hisi_clk_unregister_gate(hi3516cv300_gate_clks,
+				ARRAY_SIZE(hi3516cv300_gate_clks), clk_data);
+unregister_mux:
+	hisi_clk_unregister_mux(hi3516cv300_mux_clks,
+			ARRAY_SIZE(hi3516cv300_mux_clks), clk_data);
+unregister_fixed_rate:
+	hisi_clk_unregister_fixed_rate(hi3516cv300_fixed_rate_clks,
+			ARRAY_SIZE(hi3516cv300_fixed_rate_clks), clk_data);
+	return ERR_PTR(ret);
+}
+
+static void hi3516cv300_clk_unregister(struct platform_device *pdev)
+{
+	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+
+	hisi_clk_unregister_gate(hi3516cv300_gate_clks,
+			ARRAY_SIZE(hi3516cv300_gate_clks), crg->clk_data);
+	hisi_clk_unregister_mux(hi3516cv300_mux_clks,
+			ARRAY_SIZE(hi3516cv300_mux_clks), crg->clk_data);
+	hisi_clk_unregister_fixed_rate(hi3516cv300_fixed_rate_clks,
+			ARRAY_SIZE(hi3516cv300_fixed_rate_clks), crg->clk_data);
+}
+
+static const struct hisi_crg_funcs hi3516cv300_crg_funcs = {
+	.register_clks = hi3516cv300_clk_register,
+	.unregister_clks = hi3516cv300_clk_unregister,
+};
+
+/* hi3516CV300 sysctrl CRG */
+#define HI3516CV300_SYSCTRL_NR_CLKS 16
+
+static const char *wdt_mux_p[] __initconst = { "3m", "apb" };
+static u32 wdt_mux_table[] = {0, 1};
+
+static const struct hisi_mux_clock hi3516cv300_sysctrl_mux_clks[] = {
+	{ HI3516CV300_WDT_CLK, "wdt", wdt_mux_p, ARRAY_SIZE(wdt_mux_p),
+		CLK_SET_RATE_PARENT, 0x0, 23, 1, 0, wdt_mux_table, },
+};
+
+static struct hisi_clock_data *hi3516cv300_sysctrl_clk_register(
+		struct platform_device *pdev)
+{
+	struct hisi_clock_data *clk_data;
+	int ret;
+
+	clk_data = hisi_clk_alloc(pdev, HI3516CV300_SYSCTRL_NR_CLKS);
+	if (!clk_data)
+		return ERR_PTR(-ENOMEM);
+
+	ret = hisi_clk_register_mux(hi3516cv300_sysctrl_mux_clks,
+			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks), clk_data);
+	if (ret)
+		return ERR_PTR(ret);
+
+
+	ret = of_clk_add_provider(pdev->dev.of_node,
+			of_clk_src_onecell_get, &clk_data->clk_data);
+	if (ret)
+		goto unregister_mux;
+
+	return clk_data;
+
+unregister_mux:
+	hisi_clk_unregister_mux(hi3516cv300_sysctrl_mux_clks,
+			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks), clk_data);
+	return ERR_PTR(ret);
+}
+
+static void hi3516cv300_sysctrl_clk_unregister(struct platform_device *pdev)
+{
+	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+
+	hisi_clk_unregister_mux(hi3516cv300_sysctrl_mux_clks,
+			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks),
+			crg->clk_data);
+}
+
+static const struct hisi_crg_funcs hi3516cv300_sysctrl_funcs = {
+	.register_clks = hi3516cv300_sysctrl_clk_register,
+	.unregister_clks = hi3516cv300_sysctrl_clk_unregister,
+};
+
+static const struct of_device_id hi3516cv300_crg_match_table[] = {
+	{
+		.compatible = "hisilicon,hi3516cv300-crg",
+		.data = &hi3516cv300_crg_funcs
+	},
+	{
+		.compatible = "hisilicon,hi3516cv300-sysctrl",
+		.data = &hi3516cv300_sysctrl_funcs
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hi3516cv300_crg_match_table);
+
+static int hi3516cv300_crg_probe(struct platform_device *pdev)
+{
+	struct hisi_crg_dev *crg;
+
+	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
+	if (!crg)
+		return -ENOMEM;
+
+	crg->funcs = of_device_get_match_data(&pdev->dev);
+	if (!crg->funcs)
+		return -ENOENT;
+
+	crg->rstc = hisi_reset_init(pdev);
+	if (!crg->rstc)
+		return -ENOMEM;
+
+	crg->clk_data = crg->funcs->register_clks(pdev);
+	if (IS_ERR(crg->clk_data)) {
+		hisi_reset_exit(crg->rstc);
+		return PTR_ERR(crg->clk_data);
+	}
+
+	platform_set_drvdata(pdev, crg);
+	return 0;
+}
+
+static int hi3516cv300_crg_remove(struct platform_device *pdev)
+{
+	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
+
+	hisi_reset_exit(crg->rstc);
+	crg->funcs->unregister_clks(pdev);
+	return 0;
+}
+
+static struct platform_driver hi3516cv300_crg_driver = {
+	.probe          = hi3516cv300_crg_probe,
+	.remove		= hi3516cv300_crg_remove,
+	.driver         = {
+		.name   = "hi3516cv300-crg",
+		.of_match_table = hi3516cv300_crg_match_table,
+	},
+};
+
+static int __init hi3516cv300_crg_init(void)
+{
+	return platform_driver_register(&hi3516cv300_crg_driver);
+}
+core_initcall(hi3516cv300_crg_init);
+
+static void __exit hi3516cv300_crg_exit(void)
+{
+	platform_driver_unregister(&hi3516cv300_crg_driver);
+}
+module_exit(hi3516cv300_crg_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi3516CV300 CRG Driver");
diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
new file mode 100644
index 0000000..e073971
--- /dev/null
+++ b/drivers/clk/hisilicon/crg.h
@@ -0,0 +1,34 @@
+/*
+ * HiSilicon Clock and Reset Driver Header
+ *
+ * Copyright (c) 2016 HiSilicon Limited.
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
+#ifndef __HISI_CRG_H
+#define __HISI_CRG_H
+
+struct hisi_clock_data;
+struct hisi_reset_controller;
+
+struct hisi_crg_funcs {
+	struct hisi_clock_data*	(*register_clks)(struct platform_device *pdev);
+	void (*unregister_clks)(struct platform_device *pdev);
+};
+
+struct hisi_crg_dev {
+	struct hisi_clock_data *clk_data;
+	struct hisi_reset_controller *rstc;
+	const struct hisi_crg_funcs *funcs;
+};
+
+#endif	/* __HISI_CRG_H */
diff --git a/include/dt-bindings/clock/hi3516cv300-clock.h b/include/dt-bindings/clock/hi3516cv300-clock.h
new file mode 100644
index 0000000..5ba51b8
--- /dev/null
+++ b/include/dt-bindings/clock/hi3516cv300-clock.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
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
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __DTS_HI3516CV300_CLOCK_H
+#define __DTS_HI3516CV300_CLOCK_H
+
+/* hi3516CV300 core CRG */
+#define HI3516CV300_APB_CLK		0
+#define HI3516CV300_UART0_CLK		1
+#define HI3516CV300_UART1_CLK		2
+#define HI3516CV300_UART2_CLK		3
+#define HI3516CV300_SPI0_CLK		4
+#define HI3516CV300_SPI1_CLK		5
+#define HI3516CV300_FMC_CLK		6
+#define HI3516CV300_MMC0_CLK		7
+#define HI3516CV300_MMC1_CLK		8
+#define HI3516CV300_MMC2_CLK		9
+#define HI3516CV300_MMC3_CLK		10
+#define HI3516CV300_ETH_CLK		11
+#define HI3516CV300_ETH_MACIF_CLK	12
+#define HI3516CV300_DMAC_CLK		13
+#define HI3516CV300_PWM_CLK		14
+#define HI3516CV300_USB2_BUS_CLK	15
+#define HI3516CV300_USB2_OHCI48M_CLK	16
+#define HI3516CV300_USB2_OHCI12M_CLK	17
+#define HI3516CV300_USB2_OTG_UTMI_CLK	18
+#define HI3516CV300_USB2_HST_PHY_CLK	19
+#define HI3516CV300_USB2_UTMI0_CLK	20
+#define HI3516CV300_USB2_PHY_CLK	21
+
+/* hi3516CV300 sysctrl CRG */
+#define HI3516CV300_WDT_CLK		1
+
+#endif	/* __DTS_HI3516CV300_CLOCK_H */
-- 
2.9.3
