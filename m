From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 14 Feb 2014 17:15:03 -0300
Subject: [PATCH 4/4] clk: mvebu: add Armada 375 support to the corediv clock
 driver
In-Reply-To: <1392408903-31237-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392408903-31237-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1392408903-31237-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <1392408903-31237-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <1392408903-31237-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392408903-31237-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit adds support for the Core Divider clocks of the Armada
375. Compared to Armada 370 and XP the Core Divider clocks of the 375
cannot be gated: only their ratio can be changed. This is reflected by
the fact that the enable, disable and is_enabled clock operations are
not defined, and that the enable_bit_offset field is also undefined.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clk/mvebu/clk-corediv.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
index f9e8a12..4da6076 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -204,6 +204,18 @@ static const struct clk_corediv_soc_desc armada370_corediv_soc = {
 	.ratio_offset = 0x8,
 };
 
+static const struct clk_corediv_soc_desc armada375_corediv_soc = {
+	.descs = mvebu_corediv_desc,
+	.ndescs = ARRAY_SIZE(mvebu_corediv_desc),
+	.ops = {
+		.recalc_rate = clk_corediv_recalc_rate,
+		.round_rate = clk_corediv_round_rate,
+		.set_rate = clk_corediv_set_rate,
+	},
+	.ratio_reload = BIT(8),
+	.ratio_offset = 0x8,
+};
+
 static void __init
 mvebu_corediv_clk_init(struct device_node *node,
 		       const struct clk_corediv_soc_desc *soc_desc)
@@ -271,3 +283,10 @@ static void __init armada370_corediv_clk_init(struct device_node *node)
 }
 CLK_OF_DECLARE(armada370_corediv_clk, "marvell,armada-370-corediv-clock",
 	       armada370_corediv_clk_init);
+
+static void __init armada375_corediv_clk_init(struct device_node *node)
+{
+	return mvebu_corediv_clk_init(node, &armada375_corediv_soc);
+}
+CLK_OF_DECLARE(armada375_corediv_clk, "marvell,armada-375-corediv-clock",
+	       armada375_corediv_clk_init);
-- 
1.8.1.5
