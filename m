From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Thu, 31 Mar 2016 16:10:07 +0800
Subject: [RESEND PATCH v10 2/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <1459411811-12390-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1459411811-12390-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1459411811-12390-3-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiancheng Xue <xuejiancheng@huawei.com>

The CRG(Clock and Reset Generator) block provides clock
and reset signals for other modules in hi3519 soc.

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/clock/hi3519-crg.txt       |  46 ++++++++
 drivers/clk/hisilicon/Kconfig                      |  15 +++
 drivers/clk/hisilicon/Makefile                     |   2 +
 drivers/clk/hisilicon/clk-hi3519.c                 | 129 +++++++++++++++++++++
 drivers/clk/hisilicon/reset.c                      | 124 ++++++++++++++++++++
 drivers/clk/hisilicon/reset.h                      |  32 +++++
 include/dt-bindings/clock/hi3519-clock.h           |  40 +++++++
 7 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3519-crg.txt
 create mode 100644 drivers/clk/hisilicon/clk-hi3519.c
 create mode 100644 drivers/clk/hisilicon/reset.c
 create mode 100644 drivers/clk/hisilicon/reset.h
 create mode 100644 include/dt-bindings/clock/hi3519-clock.h

diff --git a/Documentation/devicetree/bindings/clock/hi3519-crg.txt b/Documentation/devicetree/bindings/clock/hi3519-crg.txt
new file mode 100644
index 0000000..acd1f23
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hi3519-crg.txt
@@ -0,0 +1,46 @@
+* Hisilicon Hi3519 Clock and Reset Generator(CRG)
+
+The Hi3519 CRG module provides clock and reset signals to various
+controllers within the SoC.
+
+This binding uses the following bindings:
+    Documentation/devicetree/bindings/clock/clock-bindings.txt
+    Documentation/devicetree/bindings/reset/reset.txt
+
+Required Properties:
+
+- compatible: should be one of the following.
+  - "hisilicon,hi3519-crg" - controller compatible with Hi3519 SoC.
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
index e434854..3f537a0 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -1,3 +1,11 @@
+config COMMON_CLK_HI3519
+	tristate "Hi3519 Clock Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	select RESET_HISI
+	default ARCH_HISI
+	help
+	  Build the clock driver for hi3519.
+
 config COMMON_CLK_HI6220
 	bool "Hi6220 Clock Driver"
 	depends on ARCH_HISI || COMPILE_TEST
@@ -5,6 +13,13 @@ config COMMON_CLK_HI6220
 	help
 	  Build the Hisilicon Hi6220 clock driver based on the common clock framework.
 
+config RESET_HISI
+	bool "HiSilicon Reset Controller Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	select RESET_CONTROLLER
+	help
+	  Build reset controller driver for HiSilicon device chipsets.
+
 config STUB_CLK_HI6220
 	bool "Hi6220 Stub Clock Driver"
 	depends on COMMON_CLK_HI6220 && MAILBOX
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index 74dba31..e169ec7 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -7,5 +7,7 @@ obj-y	+= clk.o clkgate-separated.o clkdivider-hi6220.o
 obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3620.o
 obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
 obj-$(CONFIG_ARCH_HIX5HD2)	+= clk-hix5hd2.o
+obj-$(CONFIG_COMMON_CLK_HI3519)	+= clk-hi3519.o
 obj-$(CONFIG_COMMON_CLK_HI6220)	+= clk-hi6220.o
+obj-$(CONFIG_RESET_HISI)	+= reset.o
 obj-$(CONFIG_STUB_CLK_HI6220)	+= clk-hi6220-stub.o
diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
new file mode 100644
index 0000000..ee9df82
--- /dev/null
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -0,0 +1,129 @@
+/*
+ * Hi3519 Clock Driver
+ *
+ * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
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
+#include <dt-bindings/clock/hi3519-clock.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "clk.h"
+#include "reset.h"
+
+#define HI3519_INNER_CLK_OFFSET	64
+#define HI3519_FIXED_24M	65
+#define HI3519_FIXED_50M	66
+#define HI3519_FIXED_75M	67
+#define HI3519_FIXED_125M	68
+#define HI3519_FIXED_150M	69
+#define HI3519_FIXED_200M	70
+#define HI3519_FIXED_250M	71
+#define HI3519_FIXED_300M	72
+#define HI3519_FIXED_400M	73
+#define HI3519_FMC_MUX		74
+
+#define HI3519_NR_CLKS		128
+
+static const struct hisi_fixed_rate_clock hi3519_fixed_rate_clks[] = {
+	{ HI3519_FIXED_24M, "24m", NULL, CLK_IS_ROOT, 24000000, },
+	{ HI3519_FIXED_50M, "50m", NULL, CLK_IS_ROOT, 50000000, },
+	{ HI3519_FIXED_75M, "75m", NULL, CLK_IS_ROOT, 75000000, },
+	{ HI3519_FIXED_125M, "125m", NULL, CLK_IS_ROOT, 125000000, },
+	{ HI3519_FIXED_150M, "150m", NULL, CLK_IS_ROOT, 150000000, },
+	{ HI3519_FIXED_200M, "200m", NULL, CLK_IS_ROOT, 200000000, },
+	{ HI3519_FIXED_250M, "250m", NULL, CLK_IS_ROOT, 250000000, },
+	{ HI3519_FIXED_300M, "300m", NULL, CLK_IS_ROOT, 300000000, },
+	{ HI3519_FIXED_400M, "400m", NULL, CLK_IS_ROOT, 400000000, },
+};
+
+static const char *const fmc_mux_p[] = {
+		"24m", "75m", "125m", "150m", "200m", "250m", "300m", "400m", };
+static u32 fmc_mux_table[] = {0, 1, 2, 3, 4, 5, 6, 7};
+
+static const struct hisi_mux_clock hi3519_mux_clks[] = {
+	{ HI3519_FMC_MUX, "fmc_mux", fmc_mux_p, ARRAY_SIZE(fmc_mux_p),
+		CLK_SET_RATE_PARENT, 0xc0, 2, 3, 0, fmc_mux_table, },
+};
+
+static const struct hisi_gate_clock hi3519_gate_clks[] = {
+	{ HI3519_FMC_CLK, "clk_fmc", "fmc_mux",
+		CLK_SET_RATE_PARENT, 0xc0, 1, 0, },
+	{ HI3519_UART0_CLK, "clk_uart0", "24m",
+		CLK_SET_RATE_PARENT, 0xe4, 20, 0, },
+	{ HI3519_UART1_CLK, "clk_uart1", "24m",
+		CLK_SET_RATE_PARENT, 0xe4, 21, 0, },
+	{ HI3519_UART2_CLK, "clk_uart2", "24m",
+		CLK_SET_RATE_PARENT, 0xe4, 22, 0, },
+	{ HI3519_UART3_CLK, "clk_uart3", "24m",
+		CLK_SET_RATE_PARENT, 0xe4, 23, 0, },
+	{ HI3519_UART4_CLK, "clk_uart4", "24m",
+		CLK_SET_RATE_PARENT, 0xe4, 24, 0, },
+	{ HI3519_SPI0_CLK, "clk_spi0", "50m",
+		CLK_SET_RATE_PARENT, 0xe4, 16, 0, },
+	{ HI3519_SPI1_CLK, "clk_spi1", "50m",
+		CLK_SET_RATE_PARENT, 0xe4, 17, 0, },
+	{ HI3519_SPI2_CLK, "clk_spi2", "50m",
+		CLK_SET_RATE_PARENT, 0xe4, 18, 0, },
+};
+
+static int hi3519_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct hisi_clock_data *clk_data;
+
+	clk_data = hisi_clk_init(np, HI3519_NR_CLKS);
+	if (!clk_data)
+		return -ENODEV;
+
+	hisi_clk_register_fixed_rate(hi3519_fixed_rate_clks,
+				     ARRAY_SIZE(hi3519_fixed_rate_clks),
+				     clk_data);
+	hisi_clk_register_mux(hi3519_mux_clks, ARRAY_SIZE(hi3519_mux_clks),
+					clk_data);
+	hisi_clk_register_gate(hi3519_gate_clks,
+			ARRAY_SIZE(hi3519_gate_clks), clk_data);
+
+	return hisi_reset_init(np);
+}
+
+static const struct of_device_id hi3519_clk_match_table[] = {
+	{ .compatible = "hisilicon,hi3519-crg" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hi3519_clk_match_table);
+
+static struct platform_driver hi3519_clk_driver = {
+	.probe          = hi3519_clk_probe,
+	.driver         = {
+		.name   = "hi3519-clk",
+		.of_match_table = hi3519_clk_match_table,
+	},
+};
+
+static int __init hi3519_clk_init(void)
+{
+	return platform_driver_register(&hi3519_clk_driver);
+}
+core_initcall(hi3519_clk_init);
+
+static void __exit hi3519_clk_exit(void)
+{
+	platform_driver_unregister(&hi3519_clk_driver);
+}
+module_exit(hi3519_clk_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi3519 Clock Driver");
diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
new file mode 100644
index 0000000..8035366
--- /dev/null
+++ b/drivers/clk/hisilicon/reset.c
@@ -0,0 +1,124 @@
+/*
+ * Hisilicon Reset Controller Driver
+ *
+ * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
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
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define	HISI_RESET_BIT_MASK	0x1f
+#define	HISI_RESET_OFFSET_SHIFT	8
+#define	HISI_RESET_OFFSET_MASK	0xffff00
+
+struct hisi_reset_controller {
+	spinlock_t	lock;
+	void __iomem	*membase;
+	struct reset_controller_dev	rcdev;
+};
+
+
+#define to_hisi_reset_controller(rcdev)  \
+	container_of(rcdev, struct hisi_reset_controller, rcdev)
+
+static int hisi_reset_of_xlate(struct reset_controller_dev *rcdev,
+			const struct of_phandle_args *reset_spec)
+{
+	u32 offset;
+	u8 bit;
+
+	if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
+		return -EINVAL;
+
+	offset = (reset_spec->args[0] << HISI_RESET_OFFSET_SHIFT)
+		& HISI_RESET_OFFSET_MASK;
+	bit = reset_spec->args[1] & HISI_RESET_BIT_MASK;
+	return (offset | bit);
+}
+
+static int hisi_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct hisi_reset_controller *rstc = to_hisi_reset_controller(rcdev);
+	unsigned long flags;
+	u32 offset, reg;
+	u8 bit;
+
+	offset = (id & HISI_RESET_OFFSET_MASK) >> HISI_RESET_OFFSET_SHIFT;
+	bit = id & HISI_RESET_BIT_MASK;
+
+	spin_lock_irqsave(&rstc->lock, flags);
+
+	reg = readl(rstc->membase + offset);
+	writel(reg | BIT(bit), rstc->membase + offset);
+
+	spin_unlock_irqrestore(&rstc->lock, flags);
+
+	return 0;
+}
+
+static int hisi_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct hisi_reset_controller *rstc = to_hisi_reset_controller(rcdev);
+	unsigned long flags;
+	u32 offset, reg;
+	u8 bit;
+
+	offset = (id & HISI_RESET_OFFSET_MASK) >> HISI_RESET_OFFSET_SHIFT;
+	bit = id & HISI_RESET_BIT_MASK;
+
+	spin_lock_irqsave(&rstc->lock, flags);
+
+	reg = readl(rstc->membase + offset);
+	writel(reg & ~BIT(bit), rstc->membase + offset);
+
+	spin_unlock_irqrestore(&rstc->lock, flags);
+
+	return 0;
+}
+
+static struct reset_control_ops hisi_reset_ops = {
+	.assert		= hisi_reset_assert,
+	.deassert	= hisi_reset_deassert,
+};
+
+int hisi_reset_init(struct device_node *np)
+{
+	struct hisi_reset_controller *rstc;
+
+	rstc = kzalloc(sizeof(*rstc), GFP_KERNEL);
+	if (!rstc)
+		return -ENOMEM;
+
+	rstc->membase = of_iomap(np, 0);
+	if (!rstc->membase)
+		return -EINVAL;
+
+	spin_lock_init(&rstc->lock);
+
+	rstc->rcdev.owner = THIS_MODULE;
+	rstc->rcdev.ops = &hisi_reset_ops;
+	rstc->rcdev.of_node = np;
+	rstc->rcdev.of_reset_n_cells = 2;
+	rstc->rcdev.of_xlate = hisi_reset_of_xlate;
+
+	return reset_controller_register(&rstc->rcdev);
+}
+EXPORT_SYMBOL_GPL(hisi_reset_init);
diff --git a/drivers/clk/hisilicon/reset.h b/drivers/clk/hisilicon/reset.h
new file mode 100644
index 0000000..ffad4d7
--- /dev/null
+++ b/drivers/clk/hisilicon/reset.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
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
+#ifndef	__HISI_RESET_H
+#define	__HISI_RESET_H
+
+struct device_node;
+
+#ifdef CONFIG_RESET_CONTROLLER
+int hisi_reset_init(struct device_node *np);
+#else
+static inline int hisi_reset_init(struct device_node *np)
+{
+	return 0;
+}
+#endif
+
+#endif	/* __HISI_RESET_H */
diff --git a/include/dt-bindings/clock/hi3519-clock.h b/include/dt-bindings/clock/hi3519-clock.h
new file mode 100644
index 0000000..14f4d21
--- /dev/null
+++ b/include/dt-bindings/clock/hi3519-clock.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
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
+#ifndef __DTS_HI3519_CLOCK_H
+#define __DTS_HI3519_CLOCK_H
+
+#define HI3519_FMC_CLK			1
+#define HI3519_SPI0_CLK			2
+#define HI3519_SPI1_CLK			3
+#define HI3519_SPI2_CLK			4
+#define HI3519_UART0_CLK		5
+#define HI3519_UART1_CLK		6
+#define HI3519_UART2_CLK		7
+#define HI3519_UART3_CLK		8
+#define HI3519_UART4_CLK		9
+#define HI3519_PWM_CLK			10
+#define HI3519_DMA_CLK			11
+#define HI3519_IR_CLK			12
+#define HI3519_ETH_PHY_CLK		13
+#define HI3519_ETH_MAC_CLK		14
+#define HI3519_ETH_MACIF_CLK		15
+#define HI3519_USB2_BUS_CLK		16
+#define HI3519_USB2_PORT_CLK		17
+#define HI3519_USB3_CLK			18
+
+#endif	/* __DTS_HI3519_CLOCK_H */
-- 
1.9.1
