From: hanetzer@startmail.com (Marty E. Plummer)
Date: Tue, 17 Oct 2017 17:38:52 -0500
Subject: [PATCH v2 1/3] clk: hisilicon: add CRG driver Hi3521A SoC
In-Reply-To: <20171017223854.6980-1-hanetzer@startmail.com>
References: <20171017223854.6980-1-hanetzer@startmail.com>
Message-ID: <20171017223854.6980-2-hanetzer@startmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CRG driver for Hi3521A SoC. CRG (Clock and Reset Generator) module
generates clock and reset signals used by other module blocks on SoC.

Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
---
Changes in v2:
  - Switched to SPDX tags and GPL-2.0+

 drivers/clk/hisilicon/Kconfig             |   7 ++
 drivers/clk/hisilicon/Makefile            |   1 +
 drivers/clk/hisilicon/crg-hi3521a.c       | 196 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/hi3521a-clock.h |  23 ++++
 4 files changed, 227 insertions(+)
 create mode 100644 drivers/clk/hisilicon/crg-hi3521a.c
 create mode 100644 include/dt-bindings/clock/hi3521a-clock.h

diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index 7098bfd32b1b..d93e3180a04f 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -14,6 +14,13 @@ config COMMON_CLK_HI3519
 	help
 	  Build the clock driver for hi3519.
 
+config COMMON_CLK_HI3521A
+	bool "Hi3521A/Hi3520DV300 Clock Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	default ARCH_HISI
+	help
+	  Build the clock driver for hi3521a/hi3520dv300
+
 config COMMON_CLK_HI3660
 	bool "Hi3660 Clock Driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index 1e4c3ddbad84..46f8d619c923 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
 obj-$(CONFIG_ARCH_HIX5HD2)	+= clk-hix5hd2.o
 obj-$(CONFIG_COMMON_CLK_HI3516CV300)	+= crg-hi3516cv300.o
 obj-$(CONFIG_COMMON_CLK_HI3519)	+= clk-hi3519.o
+obj-$(CONFIG_COMMON_CLK_HI3521A)+= crg-hi3521a.o
 obj-$(CONFIG_COMMON_CLK_HI3660) += clk-hi3660.o
 obj-$(CONFIG_COMMON_CLK_HI3798CV200)	+= crg-hi3798cv200.o
 obj-$(CONFIG_COMMON_CLK_HI6220)	+= clk-hi6220.o
diff --git a/drivers/clk/hisilicon/crg-hi3521a.c b/drivers/clk/hisilicon/crg-hi3521a.c
new file mode 100644
index 000000000000..aea00fecdff3
--- /dev/null
+++ b/drivers/clk/hisilicon/crg-hi3521a.c
@@ -0,0 +1,196 @@
+/*
+ * Copyright (C) 2017  Marty E. Plummer <hanetzer@startmail.com>
+ *
+ * SPDX-License-Identifier:	GPL-2.0+
+ */
+
+#include <dt-bindings/clock/hi3521a-clock.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "clk.h"
+#include "reset.h"
+
+#define HI3521A_INNER_CLK_OFFSET	64
+#define HI3521A_FIXED_2M		65
+#define HI3521A_FIXED_24M		66
+#define HI3521A_FIXED_50M		67
+#define HI3521A_FIXED_83M		68
+#define HI3521A_FIXED_100M		69
+#define HI3521A_FIXED_150M		70
+#define HI3521A_FMC_MUX			71
+#define HI3521A_UART_MUX		72
+
+#define HI3521A_NR_CLKS			128
+
+struct hi3521a_crg_data {
+	struct hisi_clock_data *clk_data;
+	struct hisi_reset_controller *rstc;
+};
+
+static const struct hisi_fixed_rate_clock hi3521a_fixed_rate_clks[] = {
+	{ HI3521A_FIXED_2M,     "2m", NULL, 0,   2000000, },
+	{ HI3521A_FIXED_24M,   "24m", NULL, 0,  24000000, },
+	{ HI3521A_FIXED_50M,   "50m", NULL, 0,  50000000, },
+	{ HI3521A_FIXED_83M,   "83m", NULL, 0,  83000000, },
+	{ HI3521A_FIXED_100M, "100m", NULL, 0, 100000000, },
+	{ HI3521A_FIXED_150M, "150m", NULL, 0, 150000000, },
+};
+
+static const char *const uart_mux_p[] = { "50m", "2m", "24m", };
+static const char *const fmc_mux_p[] = { "24m", "83m", "150m", };
+
+static u32 uart_mux_table[] = {0, 1, 2};
+static u32 fmc_mux_table[] = {0, 1, 2};
+
+static const struct hisi_mux_clock hi3521a_mux_clks[] = {
+	{ HI3521A_UART_MUX, "uart_mux", uart_mux_p, ARRAY_SIZE(uart_mux_p),
+		CLK_SET_RATE_PARENT, 0x84, 18, 2, 0, uart_mux_table, },
+	{ HI3521A_FMC_MUX, "fmc_mux", fmc_mux_p, ARRAY_SIZE(fmc_mux_p),
+		CLK_SET_RATE_PARENT, 0x74, 2, 2, 0, fmc_mux_table, },
+};
+
+static const struct hisi_gate_clock hi3521a_gate_clks[] = {
+	{ HI3521A_FMC_CLK, "clk_fmc", "fmc_mux", CLK_SET_RATE_PARENT,
+		0x74, 1, 0, },
+	{ HI3521A_UART0_CLK, "clk_uart0", "uart_mux", CLK_SET_RATE_PARENT,
+		0x84, 15, 0, },
+	{ HI3521A_UART1_CLK, "clk_uart1", "uart_mux", CLK_SET_RATE_PARENT,
+		0x84, 16, 0, },
+	{ HI3521A_UART2_CLK, "clk_uart2", "uart_mux", CLK_SET_RATE_PARENT,
+		0x84, 17, 0, },
+	{ HI3521A_SPI0_CLK, "clk_spi0", "50m", CLK_SET_RATE_PARENT,
+		0x84, 13, 0, },
+	/* { HI3521A_ETH_CLK, "clk_eth", NULL, */
+	/* 	0, 0x78, 1, 0, }, */
+	/* { HI3521A_ETH_MACIF_CLK, "clk_eth_macif", NULL, */
+	/* 	0, 0x78, 3, 0 }, */
+};
+
+static struct hisi_clock_data *hi3521a_clk_register(struct platform_device *pdev)
+{
+	struct hisi_clock_data *clk_data;
+	int ret;
+
+	clk_data = hisi_clk_alloc(pdev, HI3521A_NR_CLKS);
+	if (!clk_data)
+		return ERR_PTR(-ENOMEM);
+
+	ret = hisi_clk_register_fixed_rate(hi3521a_fixed_rate_clks,
+				     ARRAY_SIZE(hi3521a_fixed_rate_clks),
+				     clk_data);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = hisi_clk_register_mux(hi3521a_mux_clks,
+				ARRAY_SIZE(hi3521a_mux_clks),
+				clk_data);
+	if (ret)
+		goto unregister_fixed_rate;
+
+	ret = hisi_clk_register_gate(hi3521a_gate_clks,
+				ARRAY_SIZE(hi3521a_gate_clks),
+				clk_data);
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
+unregister_fixed_rate:
+	hisi_clk_unregister_fixed_rate(hi3521a_fixed_rate_clks,
+				ARRAY_SIZE(hi3521a_fixed_rate_clks),
+				clk_data);
+
+unregister_mux:
+	hisi_clk_unregister_mux(hi3521a_mux_clks,
+				ARRAY_SIZE(hi3521a_mux_clks),
+				clk_data);
+unregister_gate:
+	hisi_clk_unregister_gate(hi3521a_gate_clks,
+				ARRAY_SIZE(hi3521a_gate_clks),
+				clk_data);
+	return ERR_PTR(ret);
+}
+
+static void hi3521a_clk_unregister(struct platform_device *pdev)
+{
+	struct hi3521a_crg_data *crg = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+
+	hisi_clk_unregister_gate(hi3521a_gate_clks,
+				ARRAY_SIZE(hi3521a_mux_clks),
+				crg->clk_data);
+	hisi_clk_unregister_mux(hi3521a_mux_clks,
+				ARRAY_SIZE(hi3521a_mux_clks),
+				crg->clk_data);
+	hisi_clk_unregister_fixed_rate(hi3521a_fixed_rate_clks,
+				ARRAY_SIZE(hi3521a_fixed_rate_clks),
+				crg->clk_data);
+}
+
+static int hi3521a_clk_probe(struct platform_device *pdev)
+{
+	struct hi3521a_crg_data *crg;
+
+	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
+	if (!crg)
+		return -ENOMEM;
+
+	crg->rstc = hisi_reset_init(pdev);
+	if (!crg->rstc)
+		return -ENOMEM;
+
+	crg->clk_data = hi3521a_clk_register(pdev);
+	if (IS_ERR(crg->clk_data)) {
+		hisi_reset_exit(crg->rstc);
+		return PTR_ERR(crg->clk_data);
+	}
+
+	platform_set_drvdata(pdev, crg);
+	return 0;
+}
+
+static int hi3521a_clk_remove(struct platform_device *pdev)
+{
+	struct hi3521a_crg_data *crg = platform_get_drvdata(pdev);
+
+	hisi_reset_exit(crg->rstc);
+	hi3521a_clk_unregister(pdev);
+	return 0;
+}
+
+static const struct of_device_id hi3521a_clk_match_table[] = {
+	{ .compatible = "hisilicon,hi3521a-crg" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hi3521a_clk_match_table);
+
+static struct platform_driver hi3521a_clk_driver = {
+	.probe		= hi3521a_clk_probe,
+	.remove		= hi3521a_clk_remove,
+	.driver		= {
+		.name	= "hi3521a-clk",
+		.of_match_table = hi3521a_clk_match_table,
+	},
+};
+
+static int __init hi3521a_clk_init(void)
+{
+	return platform_driver_register(&hi3521a_clk_driver);
+}
+core_initcall(hi3521a_clk_init);
+
+static void __exit hi3521a_clk_exit(void)
+{
+	platform_driver_unregister(&hi3521a_clk_driver);
+}
+module_exit(hi3521a_clk_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi3521a Clock Driver");
diff --git a/include/dt-bindings/clock/hi3521a-clock.h b/include/dt-bindings/clock/hi3521a-clock.h
new file mode 100644
index 000000000000..9f8c526b34d9
--- /dev/null
+++ b/include/dt-bindings/clock/hi3521a-clock.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2017 Marty E. Plummer <hanetzer@startmail.com>
+ *
+ * SPDX-License-Identifier:	GPL-2.0+
+ */
+
+#ifndef __DTS_HI3521A_CLOCK_H
+#define __DTS_HI3521A_CLOCK_H
+
+#define HI3521A_FMC_CLK			1
+#define HI3521A_SPI0_CLK		2
+#define HI3521A_UART0_CLK		3
+#define HI3521A_UART1_CLK		4
+#define HI3521A_UART2_CLK		5
+#define HI3521A_DMA_CLK			6
+#define HI3521A_IR_CLK			7
+#define HI3521A_ETH_PHY_CLK		8
+#define HI3521A_ETH_CLK			9
+#define HI3521A_ETH_MACIF_CLK		10
+#define HI3521A_USB2_BUS_CLK		11
+#define HI3521A_USB2_PORT_CLK		12
+
+#endif /* __DTS_HI3521A_CLK_H */
-- 
2.14.2
