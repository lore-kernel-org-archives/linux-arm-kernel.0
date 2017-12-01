From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 1 Dec 2017 09:24:51 +0800
Subject: [PATCH v4 3/4] clk: meson-axg: add clock controller drivers
In-Reply-To: <20171201012452.27086-1-yixun.lan@amlogic.com>
References: <20171201012452.27086-1-yixun.lan@amlogic.com>
Message-ID: <20171201012452.27086-4-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qiufang Dai <qiufang.dai@amlogic.com>

Add clock controller drivers for Amlogic Meson-AXG SoC.

Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/Kconfig.platforms |   1 +
 drivers/clk/meson/Kconfig    |   8 +
 drivers/clk/meson/Makefile   |   1 +
 drivers/clk/meson/axg.c      | 944 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/axg.h      | 126 ++++++
 5 files changed, 1080 insertions(+)
 create mode 100644 drivers/clk/meson/axg.c
 create mode 100644 drivers/clk/meson/axg.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2401373565ff..fbedbd8f619a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -105,6 +105,7 @@ config ARCH_MESON
 	select PINCTRL_MESON
 	select COMMON_CLK_AMLOGIC
 	select COMMON_CLK_GXBB
+	select COMMON_CLK_AXG
 	select MESON_IRQ_GPIO
 	help
 	  This enables support for the Amlogic S905 SoCs.
diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index d2d0174a6eca..7694302c70a4 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -19,3 +19,11 @@ config COMMON_CLK_GXBB
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
 	  Say Y if you want peripherals and CPU frequency scaling to work.
+
+config COMMON_CLK_AXG
+	bool
+	depends on COMMON_CLK_AMLOGIC
+	select RESET_CONTROLLER
+	help
+	  Support for the clock controller on AmLogic A113D devices, aka axg.
+	  Say Y if you want peripherals and CPU frequency scaling to work.
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index b139d41b25da..3c03ce583798 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-cpu.o clk-mpll.o clk-audio-divider.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-regmap.o gxbb-aoclk-32k.o
+obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
new file mode 100644
index 000000000000..03f57541bc1e
--- /dev/null
+++ b/drivers/clk/meson/axg.c
@@ -0,0 +1,944 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AmLogic Meson-AXG Clock Controller Driver
+ *
+ * Copyright (c) 2016 Baylibre SAS.
+ * Author: Michael Turquette <mturquette@baylibre.com>
+ *
+ * Copyright (c) 2017 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+
+#include "clkc.h"
+#include "axg.h"
+
+static DEFINE_SPINLOCK(clk_lock);
+
+static const struct pll_rate_table sys_pll_rate_table[] = {
+	PLL_RATE(24000000, 56, 1, 2),
+	PLL_RATE(48000000, 64, 1, 2),
+	PLL_RATE(72000000, 72, 1, 2),
+	PLL_RATE(96000000, 64, 1, 2),
+	PLL_RATE(120000000, 80, 1, 2),
+	PLL_RATE(144000000, 96, 1, 2),
+	PLL_RATE(168000000, 56, 1, 1),
+	PLL_RATE(192000000, 64, 1, 1),
+	PLL_RATE(216000000, 72, 1, 1),
+	PLL_RATE(240000000, 80, 1, 1),
+	PLL_RATE(264000000, 88, 1, 1),
+	PLL_RATE(288000000, 96, 1, 1),
+	PLL_RATE(312000000, 52, 1, 2),
+	PLL_RATE(336000000, 56, 1, 2),
+	PLL_RATE(360000000, 60, 1, 2),
+	PLL_RATE(384000000, 64, 1, 2),
+	PLL_RATE(408000000, 68, 1, 2),
+	PLL_RATE(432000000, 72, 1, 2),
+	PLL_RATE(456000000, 76, 1, 2),
+	PLL_RATE(480000000, 80, 1, 2),
+	PLL_RATE(504000000, 84, 1, 2),
+	PLL_RATE(528000000, 88, 1, 2),
+	PLL_RATE(552000000, 92, 1, 2),
+	PLL_RATE(576000000, 96, 1, 2),
+	PLL_RATE(600000000, 50, 1, 1),
+	PLL_RATE(624000000, 52, 1, 1),
+	PLL_RATE(648000000, 54, 1, 1),
+	PLL_RATE(672000000, 56, 1, 1),
+	PLL_RATE(696000000, 58, 1, 1),
+	PLL_RATE(720000000, 60, 1, 1),
+	PLL_RATE(744000000, 62, 1, 1),
+	PLL_RATE(768000000, 64, 1, 1),
+	PLL_RATE(792000000, 66, 1, 1),
+	PLL_RATE(816000000, 68, 1, 1),
+	PLL_RATE(840000000, 70, 1, 1),
+	PLL_RATE(864000000, 72, 1, 1),
+	PLL_RATE(888000000, 74, 1, 1),
+	PLL_RATE(912000000, 76, 1, 1),
+	PLL_RATE(936000000, 78, 1, 1),
+	PLL_RATE(960000000, 80, 1, 1),
+	PLL_RATE(984000000, 82, 1, 1),
+	PLL_RATE(1008000000, 84, 1, 1),
+	PLL_RATE(1032000000, 86, 1, 1),
+	PLL_RATE(1056000000, 88, 1, 1),
+	PLL_RATE(1080000000, 90, 1, 1),
+	PLL_RATE(1104000000, 92, 1, 1),
+	PLL_RATE(1128000000, 94, 1, 1),
+	PLL_RATE(1152000000, 96, 1, 1),
+	PLL_RATE(1176000000, 98, 1, 1),
+	PLL_RATE(1200000000, 50, 1, 0),
+	PLL_RATE(1224000000, 51, 1, 0),
+	PLL_RATE(1248000000, 52, 1, 0),
+	PLL_RATE(1272000000, 53, 1, 0),
+	PLL_RATE(1296000000, 54, 1, 0),
+	PLL_RATE(1320000000, 55, 1, 0),
+	PLL_RATE(1344000000, 56, 1, 0),
+	PLL_RATE(1368000000, 57, 1, 0),
+	PLL_RATE(1392000000, 58, 1, 0),
+	PLL_RATE(1416000000, 59, 1, 0),
+	PLL_RATE(1440000000, 60, 1, 0),
+	PLL_RATE(1464000000, 61, 1, 0),
+	PLL_RATE(1488000000, 62, 1, 0),
+	PLL_RATE(1512000000, 63, 1, 0),
+	PLL_RATE(1536000000, 64, 1, 0),
+	PLL_RATE(1560000000, 65, 1, 0),
+	PLL_RATE(1584000000, 66, 1, 0),
+	PLL_RATE(1608000000, 67, 1, 0),
+	PLL_RATE(1632000000, 68, 1, 0),
+	PLL_RATE(1656000000, 68, 1, 0),
+	PLL_RATE(1680000000, 68, 1, 0),
+	PLL_RATE(1704000000, 68, 1, 0),
+	PLL_RATE(1728000000, 69, 1, 0),
+	PLL_RATE(1752000000, 69, 1, 0),
+	PLL_RATE(1776000000, 69, 1, 0),
+	PLL_RATE(1800000000, 69, 1, 0),
+	PLL_RATE(1824000000, 70, 1, 0),
+	PLL_RATE(1848000000, 70, 1, 0),
+	PLL_RATE(1872000000, 70, 1, 0),
+	PLL_RATE(1896000000, 70, 1, 0),
+	PLL_RATE(1920000000, 71, 1, 0),
+	PLL_RATE(1944000000, 71, 1, 0),
+	PLL_RATE(1968000000, 71, 1, 0),
+	PLL_RATE(1992000000, 71, 1, 0),
+	PLL_RATE(2016000000, 72, 1, 0),
+	PLL_RATE(2040000000, 72, 1, 0),
+	PLL_RATE(2064000000, 72, 1, 0),
+	PLL_RATE(2088000000, 72, 1, 0),
+	PLL_RATE(2112000000, 73, 1, 0),
+	{ /* sentinel */ },
+};
+
+static struct meson_clk_pll axg_fixed_pll = {
+	.m = {
+		.reg_off = HHI_MPLL_CNTL,
+		.shift   = 0,
+		.width   = 9,
+	},
+	.n = {
+		.reg_off = HHI_MPLL_CNTL,
+		.shift   = 9,
+		.width   = 5,
+	},
+	.od = {
+		.reg_off = HHI_MPLL_CNTL,
+		.shift   = 16,
+		.width   = 2,
+	},
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "fixed_pll",
+		.ops = &meson_clk_pll_ro_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct meson_clk_pll axg_sys_pll = {
+	.m = {
+		.reg_off = HHI_SYS_PLL_CNTL,
+		.shift   = 0,
+		.width   = 9,
+	},
+	.n = {
+		.reg_off = HHI_SYS_PLL_CNTL,
+		.shift   = 9,
+		.width   = 5,
+	},
+	.od = {
+		.reg_off = HHI_SYS_PLL_CNTL,
+		.shift   = 10,
+		.width   = 2,
+	},
+	.rate_table = sys_pll_rate_table,
+	.rate_count = ARRAY_SIZE(sys_pll_rate_table),
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_pll",
+		.ops = &meson_clk_pll_ro_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static const struct pll_rate_table axg_gp0_pll_rate_table[] = {
+	PLL_RATE(240000000, 40, 1, 2),
+	PLL_RATE(246000000, 41, 1, 2),
+	PLL_RATE(252000000, 42, 1, 2),
+	PLL_RATE(258000000, 43, 1, 2),
+	PLL_RATE(264000000, 44, 1, 2),
+	PLL_RATE(270000000, 45, 1, 2),
+	PLL_RATE(276000000, 46, 1, 2),
+	PLL_RATE(282000000, 47, 1, 2),
+	PLL_RATE(288000000, 48, 1, 2),
+	PLL_RATE(294000000, 49, 1, 2),
+	PLL_RATE(300000000, 50, 1, 2),
+	PLL_RATE(306000000, 51, 1, 2),
+	PLL_RATE(312000000, 52, 1, 2),
+	PLL_RATE(318000000, 53, 1, 2),
+	PLL_RATE(324000000, 54, 1, 2),
+	PLL_RATE(330000000, 55, 1, 2),
+	PLL_RATE(336000000, 56, 1, 2),
+	PLL_RATE(342000000, 57, 1, 2),
+	PLL_RATE(348000000, 58, 1, 2),
+	PLL_RATE(354000000, 59, 1, 2),
+	PLL_RATE(360000000, 60, 1, 2),
+	PLL_RATE(366000000, 61, 1, 2),
+	PLL_RATE(372000000, 62, 1, 2),
+	PLL_RATE(378000000, 63, 1, 2),
+	PLL_RATE(384000000, 64, 1, 2),
+	PLL_RATE(390000000, 65, 1, 3),
+	PLL_RATE(396000000, 66, 1, 3),
+	PLL_RATE(402000000, 67, 1, 3),
+	PLL_RATE(408000000, 68, 1, 3),
+	PLL_RATE(480000000, 40, 1, 1),
+	PLL_RATE(492000000, 41, 1, 1),
+	PLL_RATE(504000000, 42, 1, 1),
+	PLL_RATE(516000000, 43, 1, 1),
+	PLL_RATE(528000000, 44, 1, 1),
+	PLL_RATE(540000000, 45, 1, 1),
+	PLL_RATE(552000000, 46, 1, 1),
+	PLL_RATE(564000000, 47, 1, 1),
+	PLL_RATE(576000000, 48, 1, 1),
+	PLL_RATE(588000000, 49, 1, 1),
+	PLL_RATE(600000000, 50, 1, 1),
+	PLL_RATE(612000000, 51, 1, 1),
+	PLL_RATE(624000000, 52, 1, 1),
+	PLL_RATE(636000000, 53, 1, 1),
+	PLL_RATE(648000000, 54, 1, 1),
+	PLL_RATE(660000000, 55, 1, 1),
+	PLL_RATE(672000000, 56, 1, 1),
+	PLL_RATE(684000000, 57, 1, 1),
+	PLL_RATE(696000000, 58, 1, 1),
+	PLL_RATE(708000000, 59, 1, 1),
+	PLL_RATE(720000000, 60, 1, 1),
+	PLL_RATE(732000000, 61, 1, 1),
+	PLL_RATE(744000000, 62, 1, 1),
+	PLL_RATE(756000000, 63, 1, 1),
+	PLL_RATE(768000000, 64, 1, 1),
+	PLL_RATE(780000000, 65, 1, 1),
+	PLL_RATE(792000000, 66, 1, 1),
+	PLL_RATE(804000000, 67, 1, 1),
+	PLL_RATE(816000000, 68, 1, 1),
+	PLL_RATE(960000000, 40, 1, 0),
+	PLL_RATE(984000000, 41, 1, 0),
+	PLL_RATE(1008000000, 42, 1, 0),
+	PLL_RATE(1032000000, 43, 1, 0),
+	PLL_RATE(1056000000, 44, 1, 0),
+	PLL_RATE(1080000000, 45, 1, 0),
+	PLL_RATE(1104000000, 46, 1, 0),
+	PLL_RATE(1128000000, 47, 1, 0),
+	PLL_RATE(1152000000, 48, 1, 0),
+	PLL_RATE(1176000000, 49, 1, 0),
+	PLL_RATE(1200000000, 50, 1, 0),
+	PLL_RATE(1224000000, 51, 1, 0),
+	PLL_RATE(1248000000, 52, 1, 0),
+	PLL_RATE(1272000000, 53, 1, 0),
+	PLL_RATE(1296000000, 54, 1, 0),
+	PLL_RATE(1320000000, 55, 1, 0),
+	PLL_RATE(1344000000, 56, 1, 0),
+	PLL_RATE(1368000000, 57, 1, 0),
+	PLL_RATE(1392000000, 58, 1, 0),
+	PLL_RATE(1416000000, 59, 1, 0),
+	PLL_RATE(1440000000, 60, 1, 0),
+	PLL_RATE(1464000000, 61, 1, 0),
+	PLL_RATE(1488000000, 62, 1, 0),
+	PLL_RATE(1512000000, 63, 1, 0),
+	PLL_RATE(1536000000, 64, 1, 0),
+	PLL_RATE(1560000000, 65, 1, 0),
+	PLL_RATE(1584000000, 66, 1, 0),
+	PLL_RATE(1608000000, 67, 1, 0),
+	PLL_RATE(1632000000, 68, 1, 0),
+	{ /* sentinel */ },
+};
+
+struct pll_params_table axg_gp0_params_table[] = {
+	PLL_PARAM(HHI_GP0_PLL_CNTL, 0x40010250),
+	PLL_PARAM(HHI_GP0_PLL_CNTL1, 0xc084a000),
+	PLL_PARAM(HHI_GP0_PLL_CNTL2, 0xb75020be),
+	PLL_PARAM(HHI_GP0_PLL_CNTL3, 0x0a59a288),
+	PLL_PARAM(HHI_GP0_PLL_CNTL4, 0xc000004d),
+	PLL_PARAM(HHI_GP0_PLL_CNTL5, 0x00078000),
+};
+
+static struct meson_clk_pll axg_gp0_pll = {
+	.m = {
+		.reg_off = HHI_GP0_PLL_CNTL,
+		.shift   = 0,
+		.width   = 9,
+	},
+	.n = {
+		.reg_off = HHI_GP0_PLL_CNTL,
+		.shift   = 9,
+		.width   = 5,
+	},
+	.od = {
+		.reg_off = HHI_GP0_PLL_CNTL,
+		.shift   = 16,
+		.width   = 2,
+	},
+	.params = {
+		.params_table = axg_gp0_params_table,
+		.params_count =	ARRAY_SIZE(axg_gp0_params_table),
+		.no_init_reset = true,
+		.reset_lock_loop = true,
+	},
+	.rate_table = axg_gp0_pll_rate_table,
+	.rate_count = ARRAY_SIZE(axg_gp0_pll_rate_table),
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "gp0_pll",
+		.ops = &meson_clk_pll_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+
+static struct clk_fixed_factor axg_fclk_div2 = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor axg_fclk_div3 = {
+	.mult = 1,
+	.div = 3,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div3",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor axg_fclk_div4 = {
+	.mult = 1,
+	.div = 4,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div4",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor axg_fclk_div5 = {
+	.mult = 1,
+	.div = 5,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div5",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor axg_fclk_div7 = {
+	.mult = 1,
+	.div = 7,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div7",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+static struct meson_clk_mpll axg_mpll0 = {
+	.sdm = {
+		.reg_off = HHI_MPLL_CNTL7,
+		.shift   = 0,
+		.width   = 14,
+	},
+	.sdm_en = {
+		.reg_off = HHI_MPLL_CNTL7,
+		.shift   = 15,
+		.width	 = 1,
+	},
+	.n2 = {
+		.reg_off = HHI_MPLL_CNTL7,
+		.shift   = 16,
+		.width   = 9,
+	},
+	.en = {
+		.reg_off = HHI_MPLL_CNTL7,
+		.shift   = 14,
+		.width	 = 1,
+	},
+	.ssen = {
+		.reg_off = HHI_MPLL_CNTL,
+		.shift   = 25,
+		.width	 = 1,
+	},
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll0",
+		.ops = &meson_clk_mpll_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+static struct meson_clk_mpll axg_mpll1 = {
+	.sdm = {
+		.reg_off = HHI_MPLL_CNTL8,
+		.shift   = 0,
+		.width   = 14,
+	},
+	.sdm_en = {
+		.reg_off = HHI_MPLL_CNTL8,
+		.shift   = 15,
+		.width	 = 1,
+	},
+	.n2 = {
+		.reg_off = HHI_MPLL_CNTL8,
+		.shift   = 16,
+		.width   = 9,
+	},
+	.en = {
+		.reg_off = HHI_MPLL_CNTL8,
+		.shift   = 14,
+		.width	 = 1,
+	},
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll1",
+		.ops = &meson_clk_mpll_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+static struct meson_clk_mpll axg_mpll2 = {
+	.sdm = {
+		.reg_off = HHI_MPLL_CNTL9,
+		.shift   = 0,
+		.width   = 14,
+	},
+	.sdm_en = {
+		.reg_off = HHI_MPLL_CNTL9,
+		.shift   = 15,
+		.width	 = 1,
+	},
+	.n2 = {
+		.reg_off = HHI_MPLL_CNTL9,
+		.shift   = 16,
+		.width   = 9,
+	},
+	.en = {
+		.reg_off = HHI_MPLL_CNTL9,
+		.shift   = 14,
+		.width	 = 1,
+	},
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll2",
+		.ops = &meson_clk_mpll_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+static struct meson_clk_mpll axg_mpll3 = {
+	.sdm = {
+		.reg_off = HHI_MPLL3_CNTL0,
+		.shift   = 12,
+		.width   = 14,
+	},
+	.sdm_en = {
+		.reg_off = HHI_MPLL3_CNTL0,
+		.shift   = 11,
+		.width	 = 1,
+	},
+	.n2 = {
+		.reg_off = HHI_MPLL3_CNTL0,
+		.shift   = 2,
+		.width   = 9,
+	},
+	.en = {
+		.reg_off = HHI_MPLL3_CNTL0,
+		.shift   = 0,
+		.width	 = 1,
+	},
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll3",
+		.ops = &meson_clk_mpll_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+/*
+ * FIXME The legacy composite clocks (e.g. clk81) are both PLL post-dividers
+ * and should be modeled with their respective PLLs via the forthcoming
+ * coordinated clock rates feature
+ */
+static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
+static const char * const clk81_parent_names[] = {
+	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
+	"fclk_div3", "fclk_div5"
+};
+
+static struct clk_mux axg_mpeg_clk_sel = {
+	.reg = (void *)HHI_MPEG_CLK_CNTL,
+	.mask = 0x7,
+	.shift = 12,
+	.flags = CLK_MUX_READ_ONLY,
+	.table = mux_table_clk81,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mpeg_clk_sel",
+		.ops = &clk_mux_ro_ops,
+		/*
+		 * bits 14:12 selects from 8 possible parents:
+		 * xtal, 1'b0 (wtf), fclk_div7, mpll_clkout1, mpll_clkout2,
+		 * fclk_div4, fclk_div3, fclk_div5
+		 */
+		.parent_names = clk81_parent_names,
+		.num_parents = ARRAY_SIZE(clk81_parent_names),
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+static struct clk_divider axg_mpeg_clk_div = {
+	.reg = (void *)HHI_MPEG_CLK_CNTL,
+	.shift = 0,
+	.width = 7,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "mpeg_clk_div",
+		.ops = &clk_divider_ops,
+		.parent_names = (const char *[]){ "mpeg_clk_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_gate axg_clk81 = {
+	.reg = (void *)HHI_MPEG_CLK_CNTL,
+	.bit_idx = 7,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "clk81",
+		.ops = &clk_gate_ops,
+		.parent_names = (const char *[]){ "mpeg_clk_div" },
+		.num_parents = 1,
+		.flags = (CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
+	},
+};
+
+static const char * const axg_sd_emmc_clk0_parent_names[] = {
+	"xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
+
+	/*
+	 * Following these parent clocks, we should also have had mpll2, mpll3
+	 * and gp0_pll but these clocks are too precious to be used here. All
+	 * the necessary rates for MMC and NAND operation can be acheived using
+	 * xtal or fclk_div clocks
+	 */
+};
+
+/* SDcard clock */
+static struct clk_mux axg_sd_emmc_b_clk0_sel = {
+	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
+	.mask = 0x7,
+	.shift = 25,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_b_clk0_sel",
+		.ops = &clk_mux_ops,
+		.parent_names = axg_sd_emmc_clk0_parent_names,
+		.num_parents = ARRAY_SIZE(axg_sd_emmc_clk0_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_divider axg_sd_emmc_b_clk0_div = {
+	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
+	.shift = 16,
+	.width = 7,
+	.lock = &clk_lock,
+	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_b_clk0_div",
+		.ops = &clk_divider_ops,
+		.parent_names = (const char *[]){ "sd_emmc_b_clk0_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_gate axg_sd_emmc_b_clk0 = {
+	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
+	.bit_idx = 23,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_b_clk0",
+		.ops = &clk_gate_ops,
+		.parent_names = (const char *[]){ "sd_emmc_b_clk0_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* EMMC/NAND clock */
+static struct clk_mux axg_sd_emmc_c_clk0_sel = {
+	.reg = (void *)HHI_NAND_CLK_CNTL,
+	.mask = 0x7,
+	.shift = 9,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_c_clk0_sel",
+		.ops = &clk_mux_ops,
+		.parent_names = axg_sd_emmc_clk0_parent_names,
+		.num_parents = ARRAY_SIZE(axg_sd_emmc_clk0_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_divider axg_sd_emmc_c_clk0_div = {
+	.reg = (void *)HHI_NAND_CLK_CNTL,
+	.shift = 0,
+	.width = 7,
+	.lock = &clk_lock,
+	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_c_clk0_div",
+		.ops = &clk_divider_ops,
+		.parent_names = (const char *[]){ "sd_emmc_c_clk0_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_gate axg_sd_emmc_c_clk0 = {
+	.reg = (void *)HHI_NAND_CLK_CNTL,
+	.bit_idx = 7,
+	.lock = &clk_lock,
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_c_clk0",
+		.ops = &clk_gate_ops,
+		.parent_names = (const char *[]){ "sd_emmc_c_clk0_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* Everything Else (EE) domain gates */
+static MESON_GATE(axg_ddr, HHI_GCLK_MPEG0, 0);
+static MESON_GATE(axg_audio_locker, HHI_GCLK_MPEG0, 2);
+static MESON_GATE(axg_mipi_dsi_host, HHI_GCLK_MPEG0, 3);
+static MESON_GATE(axg_isa, HHI_GCLK_MPEG0, 5);
+static MESON_GATE(axg_pl301, HHI_GCLK_MPEG0, 6);
+static MESON_GATE(axg_periphs, HHI_GCLK_MPEG0, 7);
+static MESON_GATE(axg_spicc_0, HHI_GCLK_MPEG0, 8);
+static MESON_GATE(axg_i2c, HHI_GCLK_MPEG0, 9);
+static MESON_GATE(axg_rng0, HHI_GCLK_MPEG0, 12);
+static MESON_GATE(axg_uart0, HHI_GCLK_MPEG0, 13);
+static MESON_GATE(axg_mipi_dsi_phy, HHI_GCLK_MPEG0, 14);
+static MESON_GATE(axg_spicc_1, HHI_GCLK_MPEG0, 15);
+static MESON_GATE(axg_pcie_a, HHI_GCLK_MPEG0, 16);
+static MESON_GATE(axg_pcie_b, HHI_GCLK_MPEG0, 17);
+static MESON_GATE(axg_hiu_reg, HHI_GCLK_MPEG0, 19);
+static MESON_GATE(axg_assist_misc, HHI_GCLK_MPEG0, 23);
+static MESON_GATE(axg_emmc_b, HHI_GCLK_MPEG0, 25);
+static MESON_GATE(axg_emmc_c, HHI_GCLK_MPEG0, 26);
+static MESON_GATE(axg_dma, HHI_GCLK_MPEG0, 27);
+static MESON_GATE(axg_spi, HHI_GCLK_MPEG0, 30);
+
+static MESON_GATE(axg_audio, HHI_GCLK_MPEG1, 0);
+static MESON_GATE(axg_eth_core, HHI_GCLK_MPEG1, 3);
+static MESON_GATE(axg_uart1, HHI_GCLK_MPEG1, 16);
+static MESON_GATE(axg_g2d, HHI_GCLK_MPEG1, 20);
+static MESON_GATE(axg_usb0, HHI_GCLK_MPEG1, 21);
+static MESON_GATE(axg_usb1, HHI_GCLK_MPEG1, 22);
+static MESON_GATE(axg_reset, HHI_GCLK_MPEG1, 23);
+static MESON_GATE(axg_usb_general, HHI_GCLK_MPEG1, 26);
+static MESON_GATE(axg_ahb_arb0, HHI_GCLK_MPEG1, 29);
+static MESON_GATE(axg_efuse, HHI_GCLK_MPEG1, 30);
+static MESON_GATE(axg_boot_rom, HHI_GCLK_MPEG1, 31);
+
+static MESON_GATE(axg_ahb_data_bus, HHI_GCLK_MPEG2, 1);
+static MESON_GATE(axg_ahb_ctrl_bus, HHI_GCLK_MPEG2, 2);
+static MESON_GATE(axg_usb1_to_ddr, HHI_GCLK_MPEG2, 8);
+static MESON_GATE(axg_usb0_to_ddr, HHI_GCLK_MPEG2, 9);
+static MESON_GATE(axg_mmc_pclk, HHI_GCLK_MPEG2, 11);
+static MESON_GATE(axg_vpu_intr, HHI_GCLK_MPEG2, 25);
+static MESON_GATE(axg_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
+static MESON_GATE(axg_gic, HHI_GCLK_MPEG2, 30);
+
+/* Always On (AO) domain gates */
+
+static MESON_GATE(axg_ao_media_cpu, HHI_GCLK_AO, 0);
+static MESON_GATE(axg_ao_ahb_sram, HHI_GCLK_AO, 1);
+static MESON_GATE(axg_ao_ahb_bus, HHI_GCLK_AO, 2);
+static MESON_GATE(axg_ao_iface, HHI_GCLK_AO, 3);
+static MESON_GATE(axg_ao_i2c, HHI_GCLK_AO, 4);
+
+/* Array of all clocks provided by this provider */
+
+static struct clk_hw_onecell_data axg_hw_onecell_data = {
+	.hws = {
+		[CLKID_SYS_PLL]			= &axg_sys_pll.hw,
+		[CLKID_FIXED_PLL]		= &axg_fixed_pll.hw,
+		[CLKID_FCLK_DIV2]		= &axg_fclk_div2.hw,
+		[CLKID_FCLK_DIV3]		= &axg_fclk_div3.hw,
+		[CLKID_FCLK_DIV4]		= &axg_fclk_div4.hw,
+		[CLKID_FCLK_DIV5]		= &axg_fclk_div5.hw,
+		[CLKID_FCLK_DIV7]		= &axg_fclk_div7.hw,
+		[CLKID_GP0_PLL]			= &axg_gp0_pll.hw,
+		[CLKID_MPEG_SEL]		= &axg_mpeg_clk_sel.hw,
+		[CLKID_MPEG_DIV]		= &axg_mpeg_clk_div.hw,
+		[CLKID_CLK81]			= &axg_clk81.hw,
+		[CLKID_MPLL0]			= &axg_mpll0.hw,
+		[CLKID_MPLL1]			= &axg_mpll1.hw,
+		[CLKID_MPLL2]			= &axg_mpll2.hw,
+		[CLKID_MPLL3]			= &axg_mpll3.hw,
+		[CLKID_DDR]			= &axg_ddr.hw,
+		[CLKID_AUDIO_LOCKER]		= &axg_audio_locker.hw,
+		[CLKID_MIPI_DSI_HOST]		= &axg_mipi_dsi_host.hw,
+		[CLKID_ISA]			= &axg_isa.hw,
+		[CLKID_PL301]			= &axg_pl301.hw,
+		[CLKID_PERIPHS]			= &axg_periphs.hw,
+		[CLKID_SPICC0]			= &axg_spicc_0.hw,
+		[CLKID_I2C]			= &axg_i2c.hw,
+		[CLKID_RNG0]			= &axg_rng0.hw,
+		[CLKID_UART0]			= &axg_uart0.hw,
+		[CLKID_MIPI_DSI_PHY]		= &axg_mipi_dsi_phy.hw,
+		[CLKID_SPICC1]			= &axg_spicc_1.hw,
+		[CLKID_PCIE_A]			= &axg_pcie_a.hw,
+		[CLKID_PCIE_B]			= &axg_pcie_b.hw,
+		[CLKID_HIU_IFACE]		= &axg_hiu_reg.hw,
+		[CLKID_ASSIST_MISC]		= &axg_assist_misc.hw,
+		[CLKID_SD_EMMC_B]		= &axg_emmc_b.hw,
+		[CLKID_SD_EMMC_C]		= &axg_emmc_c.hw,
+		[CLKID_DMA]			= &axg_dma.hw,
+		[CLKID_SPI]			= &axg_spi.hw,
+		[CLKID_AUDIO]			= &axg_audio.hw,
+		[CLKID_ETH]			= &axg_eth_core.hw,
+		[CLKID_UART1]			= &axg_uart1.hw,
+		[CLKID_G2D]			= &axg_g2d.hw,
+		[CLKID_USB0]			= &axg_usb0.hw,
+		[CLKID_USB1]			= &axg_usb1.hw,
+		[CLKID_RESET]			= &axg_reset.hw,
+		[CLKID_USB]			= &axg_usb_general.hw,
+		[CLKID_AHB_ARB0]		= &axg_ahb_arb0.hw,
+		[CLKID_EFUSE]			= &axg_efuse.hw,
+		[CLKID_BOOT_ROM]		= &axg_boot_rom.hw,
+		[CLKID_AHB_DATA_BUS]		= &axg_ahb_data_bus.hw,
+		[CLKID_AHB_CTRL_BUS]		= &axg_ahb_ctrl_bus.hw,
+		[CLKID_USB1_DDR_BRIDGE]		= &axg_usb1_to_ddr.hw,
+		[CLKID_USB0_DDR_BRIDGE]		= &axg_usb0_to_ddr.hw,
+		[CLKID_MMC_PCLK]		= &axg_mmc_pclk.hw,
+		[CLKID_VPU_INTR]		= &axg_vpu_intr.hw,
+		[CLKID_SEC_AHB_AHB3_BRIDGE]	= &axg_sec_ahb_ahb3_bridge.hw,
+		[CLKID_GIC]			= &axg_gic.hw,
+		[CLKID_AO_MEDIA_CPU]		= &axg_ao_media_cpu.hw,
+		[CLKID_AO_AHB_SRAM]		= &axg_ao_ahb_sram.hw,
+		[CLKID_AO_AHB_BUS]		= &axg_ao_ahb_bus.hw,
+		[CLKID_AO_IFACE]		= &axg_ao_iface.hw,
+		[CLKID_AO_I2C]			= &axg_ao_i2c.hw,
+		[CLKID_SD_EMMC_B_CLK0_SEL]	= &axg_sd_emmc_b_clk0_sel.hw,
+		[CLKID_SD_EMMC_B_CLK0_DIV]	= &axg_sd_emmc_b_clk0_div.hw,
+		[CLKID_SD_EMMC_B_CLK0]		= &axg_sd_emmc_b_clk0.hw,
+		[CLKID_SD_EMMC_C_CLK0_SEL]	= &axg_sd_emmc_c_clk0_sel.hw,
+		[CLKID_SD_EMMC_C_CLK0_DIV]	= &axg_sd_emmc_c_clk0_div.hw,
+		[CLKID_SD_EMMC_C_CLK0]		= &axg_sd_emmc_c_clk0.hw,
+		[NR_CLKS]			= NULL,
+	},
+	.num = NR_CLKS,
+};
+
+/* Convenience tables to populate base addresses in .probe */
+
+static struct meson_clk_pll *const axg_clk_plls[] = {
+	&axg_fixed_pll,
+	&axg_sys_pll,
+	&axg_gp0_pll,
+};
+
+static struct meson_clk_mpll *const axg_clk_mplls[] = {
+	&axg_mpll0,
+	&axg_mpll1,
+	&axg_mpll2,
+	&axg_mpll3,
+};
+
+static struct clk_gate *const axg_clk_gates[] = {
+	&axg_clk81,
+	&axg_ddr,
+	&axg_audio_locker,
+	&axg_mipi_dsi_host,
+	&axg_isa,
+	&axg_pl301,
+	&axg_periphs,
+	&axg_spicc_0,
+	&axg_i2c,
+	&axg_rng0,
+	&axg_uart0,
+	&axg_mipi_dsi_phy,
+	&axg_spicc_1,
+	&axg_pcie_a,
+	&axg_pcie_b,
+	&axg_hiu_reg,
+	&axg_assist_misc,
+	&axg_emmc_b,
+	&axg_emmc_c,
+	&axg_dma,
+	&axg_spi,
+	&axg_audio,
+	&axg_eth_core,
+	&axg_uart1,
+	&axg_g2d,
+	&axg_usb0,
+	&axg_usb1,
+	&axg_reset,
+	&axg_usb_general,
+	&axg_ahb_arb0,
+	&axg_efuse,
+	&axg_boot_rom,
+	&axg_ahb_data_bus,
+	&axg_ahb_ctrl_bus,
+	&axg_usb1_to_ddr,
+	&axg_usb0_to_ddr,
+	&axg_mmc_pclk,
+	&axg_vpu_intr,
+	&axg_sec_ahb_ahb3_bridge,
+	&axg_gic,
+	&axg_ao_media_cpu,
+	&axg_ao_ahb_sram,
+	&axg_ao_ahb_bus,
+	&axg_ao_iface,
+	&axg_ao_i2c,
+	&axg_sd_emmc_b_clk0,
+	&axg_sd_emmc_c_clk0,
+};
+
+static struct clk_mux *const axg_clk_muxes[] = {
+	&axg_mpeg_clk_sel,
+	&axg_sd_emmc_b_clk0_sel,
+	&axg_sd_emmc_c_clk0_sel,
+};
+
+static struct clk_divider *const axg_clk_dividers[] = {
+	&axg_mpeg_clk_div,
+	&axg_sd_emmc_b_clk0_div,
+	&axg_sd_emmc_c_clk0_div,
+};
+
+struct clkc_data {
+	struct clk_gate *const *clk_gates;
+	unsigned int clk_gates_count;
+	struct meson_clk_mpll *const *clk_mplls;
+	unsigned int clk_mplls_count;
+	struct meson_clk_pll *const *clk_plls;
+	unsigned int clk_plls_count;
+	struct clk_mux *const *clk_muxes;
+	unsigned int clk_muxes_count;
+	struct clk_divider *const *clk_dividers;
+	unsigned int clk_dividers_count;
+	struct clk_hw_onecell_data *hw_onecell_data;
+};
+
+static const struct clkc_data axg_clkc_data = {
+	.clk_gates = axg_clk_gates,
+	.clk_gates_count = ARRAY_SIZE(axg_clk_gates),
+	.clk_mplls = axg_clk_mplls,
+	.clk_mplls_count = ARRAY_SIZE(axg_clk_mplls),
+	.clk_plls = axg_clk_plls,
+	.clk_plls_count = ARRAY_SIZE(axg_clk_plls),
+	.clk_muxes = axg_clk_muxes,
+	.clk_muxes_count = ARRAY_SIZE(axg_clk_muxes),
+	.clk_dividers = axg_clk_dividers,
+	.clk_dividers_count = ARRAY_SIZE(axg_clk_dividers),
+	.hw_onecell_data = &axg_hw_onecell_data,
+};
+
+static const struct of_device_id clkc_match_table[] = {
+	{ .compatible = "amlogic,axg-clkc", .data = &axg_clkc_data },
+	{}
+};
+
+static int axg_clkc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct clkc_data *clkc_data;
+	struct resource *res;
+	void __iomem *clk_base;
+	int ret, clkid, i;
+
+	clkc_data = of_device_get_match_data(&pdev->dev);
+	if (!clkc_data)
+		return -EINVAL;
+
+	/*  Generic clocks and PLLs */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	clk_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(clk_base)) {
+		dev_err(&pdev->dev, "Unable to map clk base\n");
+		return -ENXIO;
+	}
+
+	/* Populate base address for PLLs */
+	for (i = 0; i < clkc_data->clk_plls_count; i++)
+		clkc_data->clk_plls[i]->base = clk_base;
+
+	/* Populate base address for MPLLs */
+	for (i = 0; i < clkc_data->clk_mplls_count; i++)
+		clkc_data->clk_mplls[i]->base = clk_base;
+
+	/* Populate base address for gates */
+	for (i = 0; i < clkc_data->clk_gates_count; i++)
+		clkc_data->clk_gates[i]->reg = clk_base +
+			(u64)clkc_data->clk_gates[i]->reg;
+
+	/* Populate base address for muxes */
+	for (i = 0; i < clkc_data->clk_muxes_count; i++)
+		clkc_data->clk_muxes[i]->reg = clk_base +
+			(u64)clkc_data->clk_muxes[i]->reg;
+
+	/* Populate base address for dividers */
+	for (i = 0; i < clkc_data->clk_dividers_count; i++)
+		clkc_data->clk_dividers[i]->reg = clk_base +
+			(u64)clkc_data->clk_dividers[i]->reg;
+
+	for (clkid = 0; clkid < clkc_data->hw_onecell_data->num; clkid++) {
+		/* array might be sparse */
+		if (!clkc_data->hw_onecell_data->hws[clkid])
+			continue;
+
+		ret = devm_clk_hw_register(dev,
+					clkc_data->hw_onecell_data->hws[clkid]);
+		if (ret) {
+			dev_err(&pdev->dev, "Clock registration failed\n");
+			return ret;
+		}
+	}
+
+	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+			clkc_data->hw_onecell_data);
+}
+
+static struct platform_driver axg_driver = {
+	.probe		= axg_clkc_probe,
+	.driver		= {
+		.name	= "axg-clkc",
+		.of_match_table = clkc_match_table,
+	},
+};
+
+builtin_platform_driver(axg_driver);
diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
new file mode 100644
index 000000000000..ce0bafdb6b28
--- /dev/null
+++ b/drivers/clk/meson/axg.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2016 AmLogic, Inc.
+ * Author: Michael Turquette <mturquette@baylibre.com>
+ *
+ * Copyright (c) 2017 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ *
+ */
+#ifndef __AXG_H
+#define __AXG_H
+
+/*
+ * Clock controller register offsets
+ *
+ * Register offsets from the data sheet must be multiplied by 4 before
+ * adding them to the base address to get the right value.
+ */
+#define HHI_GP0_PLL_CNTL		0x40
+#define HHI_GP0_PLL_CNTL2		0x44
+#define HHI_GP0_PLL_CNTL3		0x48
+#define HHI_GP0_PLL_CNTL4		0x4c
+#define HHI_GP0_PLL_CNTL5		0x50
+#define HHI_GP0_PLL_STS			0x54
+#define HHI_GP0_PLL_CNTL1		0x58
+#define HHI_HIFI_PLL_CNTL		0x80
+#define HHI_HIFI_PLL_CNTL2		0x84
+#define HHI_HIFI_PLL_CNTL3		0x88
+#define HHI_HIFI_PLL_CNTL4		0x8C
+#define HHI_HIFI_PLL_CNTL5		0x90
+#define HHI_HIFI_PLL_STS		0x94
+#define HHI_HIFI_PLL_CNTL1		0x98
+
+#define HHI_XTAL_DIVN_CNTL		0xbc
+#define HHI_GCLK2_MPEG0			0xc0
+#define HHI_GCLK2_MPEG1			0xc4
+#define HHI_GCLK2_MPEG2			0xc8
+#define HHI_GCLK2_OTHER			0xd0
+#define HHI_GCLK2_AO			0xd4
+#define HHI_PCIE_PLL_CNTL		0xd8
+#define HHI_PCIE_PLL_CNTL1		0xdC
+#define HHI_PCIE_PLL_CNTL2		0xe0
+#define HHI_PCIE_PLL_CNTL3		0xe4
+#define HHI_PCIE_PLL_CNTL4		0xe8
+#define HHI_PCIE_PLL_CNTL5		0xec
+#define HHI_PCIE_PLL_CNTL6		0xf0
+#define HHI_PCIE_PLL_STS		0xf4
+
+#define HHI_MEM_PD_REG0			0x100
+#define HHI_VPU_MEM_PD_REG0		0x104
+#define HHI_VIID_CLK_DIV		0x128
+#define HHI_VIID_CLK_CNTL		0x12c
+
+#define HHI_GCLK_MPEG0			0x140
+#define HHI_GCLK_MPEG1			0x144
+#define HHI_GCLK_MPEG2			0x148
+#define HHI_GCLK_OTHER			0x150
+#define HHI_GCLK_AO			0x154
+#define HHI_SYS_CPU_CLK_CNTL1		0x15c
+#define HHI_SYS_CPU_RESET_CNTL		0x160
+#define HHI_VID_CLK_DIV			0x164
+#define HHI_SPICC_HCLK_CNTL		0x168
+
+#define HHI_MPEG_CLK_CNTL		0x174
+#define HHI_VID_CLK_CNTL		0x17c
+#define HHI_TS_CLK_CNTL			0x190
+#define HHI_VID_CLK_CNTL2		0x194
+#define HHI_SYS_CPU_CLK_CNTL0		0x19c
+#define HHI_VID_PLL_CLK_DIV		0x1a0
+#define HHI_VPU_CLK_CNTL		0x1bC
+
+#define HHI_VAPBCLK_CNTL		0x1F4
+
+#define HHI_GEN_CLK_CNTL		0x228
+
+#define HHI_VDIN_MEAS_CLK_CNTL		0x250
+#define HHI_NAND_CLK_CNTL		0x25C
+#define HHI_SD_EMMC_CLK_CNTL		0x264
+
+#define HHI_MPLL_CNTL			0x280
+#define HHI_MPLL_CNTL2			0x284
+#define HHI_MPLL_CNTL3			0x288
+#define HHI_MPLL_CNTL4			0x28C
+#define HHI_MPLL_CNTL5			0x290
+#define HHI_MPLL_CNTL6			0x294
+#define HHI_MPLL_CNTL7			0x298
+#define HHI_MPLL_CNTL8			0x29C
+#define HHI_MPLL_CNTL9			0x2A0
+#define HHI_MPLL_CNTL10			0x2A4
+
+#define HHI_MPLL3_CNTL0			0x2E0
+#define HHI_MPLL3_CNTL1			0x2E4
+#define HHI_PLL_TOP_MISC		0x2E8
+
+#define HHI_SYS_PLL_CNTL1		0x2FC
+#define HHI_SYS_PLL_CNTL		0x300
+#define HHI_SYS_PLL_CNTL2		0x304
+#define HHI_SYS_PLL_CNTL3		0x308
+#define HHI_SYS_PLL_CNTL4		0x30c
+#define HHI_SYS_PLL_CNTL5		0x310
+#define HHI_SYS_PLL_STS			0x314
+#define HHI_DPLL_TOP_I			0x318
+#define HHI_DPLL_TOP2_I			0x31C
+
+/*
+ * CLKID index values
+ *
+ * These indices are entirely contrived and do not map onto the hardware.
+ * It has now been decided to expose everything by default in the DT header:
+ * include/dt-bindings/clock/axg-clkc.h. Only the clocks ids we don't want
+ * to expose, such as the internal muxes and dividers of composite clocks,
+ * will remain defined here.
+ */
+#define CLKID_MPEG_SEL				8
+#define CLKID_MPEG_DIV				9
+#define CLKID_SD_EMMC_B_CLK0_SEL		61
+#define CLKID_SD_EMMC_B_CLK0_DIV		62
+#define CLKID_SD_EMMC_C_CLK0_SEL		63
+#define CLKID_SD_EMMC_C_CLK0_DIV		64
+
+#define NR_CLKS					65
+
+/* include the CLKIDs that have been made part of the DT binding */
+#include <dt-bindings/clock/axg-clkc.h>
+
+#endif /* __AXG_H */
-- 
2.15.0
