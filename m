From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  3 Mar 2016 12:40:01 +0100
Subject: [PATCH 08/17] clk: Add PLX Technology OXNAS Standard Clocks
In-Reply-To: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1457005210-18485-9-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PLX Technology OXNAS SoC Family Standard Clocks support.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/Kconfig     |   6 ++
 drivers/clk/Makefile    |   1 +
 drivers/clk/clk-oxnas.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 drivers/clk/clk-oxnas.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index eca8e01..b75ef5c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -192,6 +192,12 @@ config COMMON_CLK_PXA
 	---help---
 	  Sypport for the Marvell PXA SoC.
 
+config COMMON_CLK_OXNAS
+	def_bool COMMON_CLK
+	select MFD_SYSCON
+	---help---
+	  Sypport for the OXNAS SoC Family clocks.
+
 config COMMON_CLK_CDCE706
 	tristate "Clock driver for TI CDCE706 clock synthesizer"
 	depends on I2C
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index bae4be6..a5d45d8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_ARCH_MB86S7X)		+= clk-mb86s7x.o
 obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
+obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
diff --git a/drivers/clk/clk-oxnas.c b/drivers/clk/clk-oxnas.c
new file mode 100644
index 0000000..c4b903f
--- /dev/null
+++ b/drivers/clk/clk-oxnas.c
@@ -0,0 +1,159 @@
+/*
+ * Copyright (C) 2010 Broadcom
+ * Copyright (C) 2012 Stephen Warren
+ * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/stringify.h>
+#include <linux/reset.h>
+#include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+/* Standard regmap gate clocks */
+struct clk_std {
+	struct clk_hw hw;
+	signed char bit;
+	struct regmap *regmap;
+};
+
+/* Regmap offsets */
+#define CLK_STAT_REGOFFSET	0x24
+#define CLK_SET_REGOFFSET	0x2c
+#define CLK_CLR_REGOFFSET	0x30
+
+#define NUM_STD_CLKS 10
+#define to_stdclk(_hw) container_of(_hw, struct clk_std, hw)
+
+static int std_clk_is_enabled(struct clk_hw *hw)
+{
+	struct clk_std *std = to_stdclk(hw);
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(std->regmap, CLK_STAT_REGOFFSET, &val);
+	if (ret < 0)
+		return ret;
+
+	return val & BIT(std->bit);
+}
+
+static int std_clk_enable(struct clk_hw *hw)
+{
+	struct clk_std *std = to_stdclk(hw);
+
+	regmap_write(std->regmap, CLK_SET_REGOFFSET, BIT(std->bit));
+
+	return 0;
+}
+
+static void std_clk_disable(struct clk_hw *hw)
+{
+	struct clk_std *std = to_stdclk(hw);
+
+	regmap_write(std->regmap, CLK_CLR_REGOFFSET, BIT(std->bit));
+}
+
+static struct clk_ops std_clk_ops = {
+	.enable = std_clk_enable,
+	.disable = std_clk_disable,
+	.is_enabled = std_clk_is_enabled,
+};
+
+static const char *const std_clk_parents[] = {
+	"oscillator",
+};
+
+static const char *const eth_parents[] = {
+	"gmacclk",
+};
+
+#define DECLARE_STD_CLKP(__clk, __bit, __parent)	\
+static struct clk_init_data clk_##__clk##_init = {	\
+	.name = __stringify(__clk),			\
+	.ops = &std_clk_ops,				\
+	.parent_names = __parent,		\
+	.num_parents = ARRAY_SIZE(__parent),	\
+};							\
+							\
+static struct clk_std clk_##__clk = {			\
+	.bit = __bit,					\
+	.hw = {						\
+		.init = &clk_##__clk##_init,		\
+	},						\
+}
+
+#define DECLARE_STD_CLK(__clk, __bit) DECLARE_STD_CLKP(__clk, __bit, \
+							std_clk_parents)
+
+DECLARE_STD_CLK(leon, 0);
+DECLARE_STD_CLK(dma_sgdma, 1);
+DECLARE_STD_CLK(cipher, 2);
+/* DECLARE_STD_CLK(sd, 3); - Do not touch DDR clock */
+DECLARE_STD_CLK(sata, 4);
+DECLARE_STD_CLK(audio, 5);
+DECLARE_STD_CLK(usbmph, 6);
+DECLARE_STD_CLKP(etha, 7, eth_parents);
+DECLARE_STD_CLK(pciea, 8);
+DECLARE_STD_CLK(nand, 9);
+
+static struct clk_hw *std_clk_hw_tbl[] = {
+	&clk_leon.hw,
+	&clk_dma_sgdma.hw,
+	&clk_cipher.hw,
+	&clk_sata.hw,
+	&clk_audio.hw,
+	&clk_usbmph.hw,
+	&clk_etha.hw,
+	&clk_pciea.hw,
+	&clk_nand.hw,
+};
+
+static struct clk *std_clk_tbl[ARRAY_SIZE(std_clk_hw_tbl)];
+
+static struct clk_onecell_data std_clk_data;
+
+static void __init oxnas_init_stdclk(struct device_node *np)
+{
+	int i;
+	struct regmap *regmap = syscon_node_to_regmap(of_get_parent(np));
+
+	if (!regmap)
+		panic("failed to have parent regmap\n");
+
+	for (i = 0; i < ARRAY_SIZE(std_clk_hw_tbl); i++) {
+		struct clk_std *std = container_of(std_clk_hw_tbl[i],
+						   struct clk_std, hw);
+
+		if (WARN_ON(!std))
+			return;
+		std->regmap = regmap;
+
+		std_clk_tbl[i] = clk_register(NULL, std_clk_hw_tbl[i]);
+		if (WARN_ON(IS_ERR(std_clk_tbl[i])))
+			return;
+	}
+
+	std_clk_data.clks = std_clk_tbl;
+	std_clk_data.clk_num = ARRAY_SIZE(std_clk_tbl);
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &std_clk_data);
+}
+CLK_OF_DECLARE(oxnas_pllstd, "plxtech,ox810se-stdclk", oxnas_init_stdclk);
-- 
1.9.1
