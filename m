From: xobs@kosagi.com (Sean Cross)
Date: Wed, 10 Apr 2013 08:53:09 +0000
Subject: [PATCH] ARM: imx: add lvds clocks
Message-ID: <1365583989-10308-1-git-send-email-xobs@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two LVDS clocks on the i.MX6 that may be used for a variety of
purposes, including PCI Express.  Add these clocks, as well as their
selectors.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 .../devicetree/bindings/clock/imx6q-clock.txt      |    4 ++++
 arch/arm/mach-imx/clk-imx6q.c                      |   10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
index 969b38e..0d3b919 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
@@ -205,6 +205,10 @@ clocks and IDs.
 	enet_ref		190
 	usbphy1_gate		191
 	usbphy2_gate		192
+	lvds1_sel		193
+	lvds2_sel		194
+	lvds1			195
+	lvds2			196
 
 Examples:
 
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 2f9ff93..23d7f80 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -132,6 +132,8 @@ static const char *vpu_axi_sels[]	= { "axi", "pll2_pfd2_396m", "pll2_pfd0_352m",
 static const char *cko1_sels[]	= { "pll3_usb_otg", "pll2_bus", "pll1_sys", "pll5_video",
 				    "dummy", "axi", "enfc", "ipu1_di0", "ipu1_di1", "ipu2_di0",
 				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_audio", };
+static const char *lvds1_sels[] = { "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "pll4_audio", "pll5_video", "pll8_mlb", "enet_ref", "pcie_ref", "sata_ref", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "lvds1", "lvds2", };
+static const char *lvds2_sels[] = { "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "pll4_audio", "pll5_video", "pll8_mlb", "enet_ref", "pcie_ref", "sata_ref", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "lvds1", "lvds2", };
 
 enum mx6q_clks {
 	dummy, ckil, ckih, osc, pll2_pfd0_352m, pll2_pfd1_594m, pll2_pfd2_396m,
@@ -165,7 +167,7 @@ enum mx6q_clks {
 	pll4_audio, pll5_video, pll8_mlb, pll7_usb_host, pll6_enet, ssi1_ipg,
 	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
 	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
-	usbphy2_gate, clk_max
+	usbphy2_gate, lvds1_sel, lvds2_sel, lvds1, lvds2, clk_max
 };
 
 static struct clk *clk[clk_max];
@@ -260,6 +262,12 @@ int __init mx6q_clocks_init(void)
 	clk[pll3_60m]  = imx_clk_fixed_factor("pll3_60m",  "pll3_usb_otg",   1, 8);
 	clk[twd]       = imx_clk_fixed_factor("twd",       "arm",            1, 2);
 
+	/*                                  name                reg       shift width parent_names     num_parents */
+	clk[lvds1_sel]        = imx_clk_mux("lvds1_sel",	base + 0x160, 0, 5, lvds1_sels,		ARRAY_SIZE(lvds1_sels));
+	clk[lvds2_sel]        = imx_clk_mux("lvds2_sel",	base + 0x160, 0, 5, lvds2_sels,		ARRAY_SIZE(lvds2_sels));
+
+	clk[lvds1] = imx_clk_gate("lvds1", "dummy", base + 0x160, 10);
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ccm");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
-- 
1.7.9.5
