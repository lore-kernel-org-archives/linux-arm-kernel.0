From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Sep 2015 22:12:34 +0800
Subject: [PATCH 3/5] clk: berlin: add clk support for berlin4ct
In-Reply-To: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
References: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442931156-5877-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports the gate-clk and berlin-clk in berlin4ct SoC.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clk/berlin/Makefile        |   2 +-
 drivers/clk/berlin/clk-berlin4ct.c | 164 +++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/berlin/clk-berlin4ct.c

diff --git a/drivers/clk/berlin/Makefile b/drivers/clk/berlin/Makefile
index 741ba22..fe29dd3 100644
--- a/drivers/clk/berlin/Makefile
+++ b/drivers/clk/berlin/Makefile
@@ -1,4 +1,4 @@
-obj-y += pll.o clk.o berlin2-avpll.o berlin2-pll.o berlin2-div.o
+obj-y += pll.o clk.o clk-berlin4ct.o berlin2-avpll.o berlin2-pll.o berlin2-div.o
 obj-$(CONFIG_MACH_BERLIN_BG2)	+= bg2.o
 obj-$(CONFIG_MACH_BERLIN_BG2CD)	+= bg2.o
 obj-$(CONFIG_MACH_BERLIN_BG2Q)	+= bg2q.o
diff --git a/drivers/clk/berlin/clk-berlin4ct.c b/drivers/clk/berlin/clk-berlin4ct.c
new file mode 100644
index 0000000..b9d4a9b
--- /dev/null
+++ b/drivers/clk/berlin/clk-berlin4ct.c
@@ -0,0 +1,164 @@
+/*
+ * Copyright (c) 2015 Marvell Technology Group Ltd.
+ *
+ * Author: Jisheng Zhang <jszhang@marvell.com>
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
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+#define CLK_SOURCE_MAX	5
+
+static struct clk_onecell_data gateclk_data;
+static struct clk_onecell_data clk_data;
+
+static DEFINE_SPINLOCK(lock);
+
+static const struct gateclk_desc berlin4ct_gates[] __initconst = {
+	{ "tspsysclk",		"perifsysclk",	0 },
+	{ "usb0coreclk",	"perifsysclk",	1 },
+	{ "zspsysclk",		"perifsysclk",	2 },
+	{ "sdiosysclk",		"perifsysclk",	3 },
+	{ "ethcoreclk",		"perifsysclk",	4 },
+	{ "pcie0sys",		"perifsysclk",	6 },
+	{ "sata0core",		"perifsysclk",	7 },
+	{ "nfcsysclk",		"perifsysclk",	8 },
+	{ "emmcsysclk",		"perifsysclk",	9 },
+	{ "ihb0sysclk",		"perifsysclk",	10 },
+};
+
+static const struct clk_desc berlin4ct_descs[] __initconst = {
+	{ "cpufastrefclk",	0x0 },
+	{ "memfastrefclk",	0x4 },
+	{ "cfgclk",		0x20,	CLK_IGNORE_UNUSED },
+	{ "perifsysclk",	0x24,	CLK_IGNORE_UNUSED },
+	{ "hbclk",		0x28 },
+	{ "atbclk",		0x2c },
+	{ "decoderclk",		0x40 },
+	{ "decoderm3clk",	0x44 },
+	{ "decoderpcubeclk",	0x48 },
+	{ "encoderclk",		0x4c },
+	{ "ovpcoreclk",		0x50 },
+	{ "gfx2dcoreclk",	0x60 },
+	{ "gfx3dcoreclk",	0x64 },
+	{ "gfx3dshclk",		0x68 },
+	{ "gfx3dsysclk",	0x6c },
+	{ "gfx2dsysclk",	0x70 },
+	{ "aviosysclk",		0x80 },
+	{ "vppsysclk",		0x84 },
+	{ "eddcclk",		0x88 },
+	{ "aviobiuclk",		0x8c },
+	{ "zspclk",		0xa0 },
+	{ "tspclk",		0xc0 },
+	{ "tsprefclk",		0xc4 },
+	{ "ndsclk",		0xc8 },
+	{ "nocsclk",		0xcc },
+	{ "apbcoreclk",		0xd0,	CLK_IGNORE_UNUSED },
+	{ "emmcclk",		0xe0 },
+	{ "sd0clk",		0xe4 },
+	{ "sd1clk",		0xe8 },
+	{ "dllmstrefclk",	0xec },
+	{ "gethrgmiiclk",	0xf0 },
+	{ "gethrgmiisysclk",	0xf4 },
+	{ "usim0clk",		0x100 },
+	{ "pcietestclk",	0x110 },
+	{ "usb2testclk",	0x120 },
+	{ "usb3testclk",	0x124 },
+	{ "usb3coreclk",	0x128 },
+	{ "nfceccclk",		0x130 },
+	{ "bcmclk",		0x140 },
+};
+
+static void __init berlin4ct_gateclk_setup(struct device_node *np)
+{
+	int i, n, ret;
+	void __iomem *base;
+	struct clk **clks;
+
+	base = of_iomap(np, 0);
+	if (WARN_ON(!base))
+		return;
+
+	n = ARRAY_SIZE(berlin4ct_gates);
+	clks = kzalloc(n * sizeof(struct clk *), GFP_KERNEL);
+	if (WARN_ON(!clks))
+		return;
+
+	for (i = 0; i < n; i++) {
+		clks[i] = clk_register_gate(NULL, berlin4ct_gates[i].name,
+				berlin4ct_gates[i].parent_name,
+				berlin4ct_gates[i].flags, base,
+				berlin4ct_gates[i].bit_idx, 0, &lock);
+		WARN_ON(IS_ERR(clks[i]));
+	}
+
+	gateclk_data.clks = clks;
+	gateclk_data.clk_num = i;
+
+	ret = of_clk_add_provider(np, of_clk_src_onecell_get,
+				  &gateclk_data);
+	if (WARN_ON(ret))
+		return;
+
+}
+CLK_OF_DECLARE(berlin4ct_gateclk, "marvell,berlin4ct-gateclk",
+	       berlin4ct_gateclk_setup);
+
+static void __init berlin4ct_clk_setup(struct device_node *np)
+{
+	int i, n, ret, num_parents;
+	void __iomem *base;
+	struct clk **clks;
+	const char *parent_names[CLK_SOURCE_MAX];
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents <= 0 || num_parents > CLK_SOURCE_MAX)
+		return;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+
+	base = of_iomap(np, 0);
+	if (WARN_ON(!base))
+		return;
+
+	n = ARRAY_SIZE(berlin4ct_descs);
+	clks = kzalloc(n * sizeof(struct clk *), GFP_KERNEL);
+	if (WARN_ON(!clks))
+		return;
+
+	for (i = 0; i < n; i++) {
+		clks[i] = berlin_clk_register(berlin4ct_descs[i].name,
+				num_parents, parent_names,
+				berlin4ct_descs[i].flags,
+				base + berlin4ct_descs[i].offset);
+		WARN_ON(IS_ERR(clks[i]));
+	}
+
+	clk_data.clks = clks;
+	clk_data.clk_num = i;
+
+	ret = of_clk_add_provider(np, of_clk_src_onecell_get,
+				  &clk_data);
+	if (WARN_ON(ret))
+		return;
+
+}
+CLK_OF_DECLARE(berlin4ct_clk, "marvell,berlin4ct-clk",
+	       berlin4ct_clk_setup);
-- 
2.5.3
