From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 15 Nov 2018 15:30:28 +0100
Subject: [PATCH v2 3/3] clk: imx6q: handle ENET PLL bypass
In-Reply-To: <20181115143028.19087-1-l.stach@pengutronix.de>
References: <20181115143028.19087-1-l.stach@pengutronix.de>
Message-ID: <20181115143028.19087-3-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ENET PLL is different from the other i.MX6 PLLs, as it has
multiple outputs with different post-dividers, which are all
bypassed if the single bypass bit is activated. The hardware setup
looks something like this:
                                _
refclk-o---PLL---o----DIV1-----| \
       |         |             |M |----OUT1
       o-----------------------|_/
       |         |              _
       |         o----DIV2-----| \
       |         |             |M |----OUT2
       o-----------------------|_/
       |         |              _
       |         `----DIV3-----| \
       |                       |M |----OUT3
       `-----------------------|_/

The bypass bit not only bypasses the PLL, but also the attached
post-dividers. This would be reasonbly straight forward to model
with a single output, or with different bypass bits for each output,
but sadly the HW guys decided that it would be good to actuate all
3 muxes with a single bit.

So the need to have the PLL bypassed for one of the outputs always
affects 2 other (in our model) independent branches of the clock
tree.

This means the decision to bypass this PLL is a system wide design
choice and should not be changed on-the-fly, so we can treat any
bapass configuration as static. As such we can just register the
post-dividiers with a ratio that reflects the bypass status, which
allows us to bypass the PLL without breaking our abstraction model
and with it DT stability.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx6q.c | 63 +++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index bd53c403bcc1..bf988912a5ed 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -225,6 +225,41 @@ static void of_assigned_ldb_sels(struct device_node *node,
 	}
 }
 
+static bool pll6_bypassed(struct device_node *node)
+{
+	int index, ret, num_clocks;
+	struct of_phandle_args clkspec;
+
+	num_clocks = of_count_phandle_with_args(node, "assigned-clocks",
+						"#clock-cells");
+	if (num_clocks < 0)
+		return false;
+
+	for (index = 0; index < num_clocks; index++) {
+		ret = of_parse_phandle_with_args(node, "assigned-clocks",
+						 "#clock-cells", index,
+						 &clkspec);
+		if (ret < 0)
+			return false;
+
+		if (clkspec.np == node &&
+		    clkspec.args[0] == IMX6QDL_PLL6_BYPASS)
+			break;
+	}
+
+	/* PLL6 bypass is not part of the assigned clock list */
+	if (index == num_clocks)
+		return false;
+
+	ret = of_parse_phandle_with_args(node, "assigned-clock-parents",
+					 "#clock-cells", index, &clkspec);
+
+	if (clkspec.args[0] != IMX6QDL_CLK_PLL6)
+		return true;
+
+	return false;
+}
+
 #define CCM_CCDR		0x04
 #define CCM_CCSR		0x0c
 #define CCM_CS2CDR		0x2c
@@ -503,16 +538,32 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_USBPHY1_GATE] = imx_clk_gate("usbphy1_gate", "dummy", base + 0x10, 6);
 	clk[IMX6QDL_CLK_USBPHY2_GATE] = imx_clk_gate("usbphy2_gate", "dummy", base + 0x20, 6);
 
-	clk[IMX6QDL_CLK_SATA_REF] = imx_clk_fixed_factor("sata_ref", "pll6_enet", 1, 5);
-	clk[IMX6QDL_CLK_PCIE_REF] = imx_clk_fixed_factor("pcie_ref", "pll6_enet", 1, 4);
+	/*
+	 * The ENET PLL is special in that is has multiple outputs with
+	 * different post-dividers that are all affected by the single bypass
+	 * bit, so a single mux bit affects 3 independent branches of the clock
+	 * tree. There is no good way to model this in the clock framework and
+	 * dynamically changing the bypass bit, will yield unexpected results.
+	 * So we treat any configuration that bypasses the ENET PLL as
+	 * essentially static with the divider ratios refelcting the bypass
+	 * status.
+	 *
+	 */
+	if (!pll6_bypassed(ccm_node)) {
+		clk[IMX6QDL_CLK_SATA_REF] = imx_clk_fixed_factor("sata_ref", "pll6_enet", 1, 5);
+		clk[IMX6QDL_CLK_PCIE_REF] = imx_clk_fixed_factor("pcie_ref", "pll6_enet", 1, 4);
+		clk[IMX6QDL_CLK_ENET_REF] = clk_register_divider_table(NULL, "enet_ref", "pll6_enet", 0,
+						base + 0xe0, 0, 2, 0, clk_enet_ref_table,
+						&imx_ccm_lock);
+	} else {
+		clk[IMX6QDL_CLK_SATA_REF] = imx_clk_fixed_factor("sata_ref", "pll6_enet", 1, 1);
+		clk[IMX6QDL_CLK_PCIE_REF] = imx_clk_fixed_factor("pcie_ref", "pll6_enet", 1, 1);
+		clk[IMX6QDL_CLK_ENET_REF] = imx_clk_fixed_factor("enet_ref", "pll6_enet", 1, 1);
+	}
 
 	clk[IMX6QDL_CLK_SATA_REF_100M] = imx_clk_gate("sata_ref_100m", "sata_ref", base + 0xe0, 20);
 	clk[IMX6QDL_CLK_PCIE_REF_125M] = imx_clk_gate("pcie_ref_125m", "pcie_ref", base + 0xe0, 19);
 
-	clk[IMX6QDL_CLK_ENET_REF] = clk_register_divider_table(NULL, "enet_ref", "pll6_enet", 0,
-			base + 0xe0, 0, 2, 0, clk_enet_ref_table,
-			&imx_ccm_lock);
-
 	clk[IMX6QDL_CLK_LVDS1_SEL] = imx_clk_mux("lvds1_sel", base + 0x160, 0, 5, lvds_sels, ARRAY_SIZE(lvds_sels));
 	clk[IMX6QDL_CLK_LVDS2_SEL] = imx_clk_mux("lvds2_sel", base + 0x160, 5, 5, lvds_sels, ARRAY_SIZE(lvds_sels));
 
-- 
2.19.1
