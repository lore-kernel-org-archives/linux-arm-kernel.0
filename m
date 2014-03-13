From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 13 Mar 2014 17:24:28 -0300
Subject: [PATCH v3 1/6] clk: mvebu: Support Armada 380 SoC on the core divider
 clock
In-Reply-To: <1394742273-5113-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394742273-5113-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394742273-5113-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds support for the Core Divider clocks of the Armada
380 SoCs. Similarly to Armada 370 and XP, the Core Divider clocks of
the 380 have gate capabilities. The only difference is the register layout.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clk/mvebu/clk-corediv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
index 4da6076..911dbb6 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -204,6 +204,22 @@ static const struct clk_corediv_soc_desc armada370_corediv_soc = {
 	.ratio_offset = 0x8,
 };
 
+static const struct clk_corediv_soc_desc armada380_corediv_soc = {
+	.descs = mvebu_corediv_desc,
+	.ndescs = ARRAY_SIZE(mvebu_corediv_desc),
+	.ops = {
+		.enable = clk_corediv_enable,
+		.disable = clk_corediv_disable,
+		.is_enabled = clk_corediv_is_enabled,
+		.recalc_rate = clk_corediv_recalc_rate,
+		.round_rate = clk_corediv_round_rate,
+		.set_rate = clk_corediv_set_rate,
+	},
+	.ratio_reload = BIT(8),
+	.enable_bit_offset = 16,
+	.ratio_offset = 0x4,
+};
+
 static const struct clk_corediv_soc_desc armada375_corediv_soc = {
 	.descs = mvebu_corediv_desc,
 	.ndescs = ARRAY_SIZE(mvebu_corediv_desc),
@@ -290,3 +306,10 @@ static void __init armada375_corediv_clk_init(struct device_node *node)
 }
 CLK_OF_DECLARE(armada375_corediv_clk, "marvell,armada-375-corediv-clock",
 	       armada375_corediv_clk_init);
+
+static void __init armada380_corediv_clk_init(struct device_node *node)
+{
+	return mvebu_corediv_clk_init(node, &armada380_corediv_soc);
+}
+CLK_OF_DECLARE(armada380_corediv_clk, "marvell,armada-380-corediv-clock",
+	       armada380_corediv_clk_init);
-- 
1.9.0
