From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 09 Apr 2014 16:39:06 +0100
Subject: [PATCH] ARM: imx: propagate DI clock changes up the clock tree to PLL5
Message-ID: <E1WXuag-0007Gs-Ku@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows clk_set_rate() on the DI clocks to propagate up to PLL5.

This allows imx-drm to produce the exact clock rate required with no
modulation due to the fractional divider.  Modulation of the clock rate
can and does prevent TVs from locking to the HDMI signal - they will
report no signal rather than trying to lock to such a signal.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
I still have this patch which is required so that imx-drm is capable of
producing HDMI clocks which are close enough to the HDMI defined
frequencies such that TVs and similar can recognise the signal.  Without
this, I don't get any kind of output on my TV desite imx-drm being set
to the correct mode.  I have proven that this is because the HDMI clock
is *very* wrong without this patch.

 arch/arm/mach-imx/clk-imx6q.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 4d677f442539..3cf03a132534 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -262,10 +262,10 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[ipu1_di1_pre_sel] = imx_clk_mux("ipu1_di1_pre_sel", base + 0x34, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
 	clk[ipu2_di0_pre_sel] = imx_clk_mux("ipu2_di0_pre_sel", base + 0x38, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
 	clk[ipu2_di1_pre_sel] = imx_clk_mux("ipu2_di1_pre_sel", base + 0x38, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
-	clk[ipu1_di0_sel]     = imx_clk_mux("ipu1_di0_sel",     base + 0x34, 0,  3, ipu1_di0_sels,     ARRAY_SIZE(ipu1_di0_sels));
-	clk[ipu1_di1_sel]     = imx_clk_mux("ipu1_di1_sel",     base + 0x34, 9,  3, ipu1_di1_sels,     ARRAY_SIZE(ipu1_di1_sels));
-	clk[ipu2_di0_sel]     = imx_clk_mux("ipu2_di0_sel",     base + 0x38, 0,  3, ipu2_di0_sels,     ARRAY_SIZE(ipu2_di0_sels));
-	clk[ipu2_di1_sel]     = imx_clk_mux("ipu2_di1_sel",     base + 0x38, 9,  3, ipu2_di1_sels,     ARRAY_SIZE(ipu2_di1_sels));
+	clk[ipu1_di0_sel]     = imx_clk_mux_flags("ipu1_di0_sel",     base + 0x34, 0,  3, ipu1_di0_sels,     ARRAY_SIZE(ipu1_di0_sels), CLK_SET_RATE_PARENT);
+	clk[ipu1_di1_sel]     = imx_clk_mux_flags("ipu1_di1_sel",     base + 0x34, 9,  3, ipu1_di1_sels,     ARRAY_SIZE(ipu1_di1_sels), CLK_SET_RATE_PARENT);
+	clk[ipu2_di0_sel]     = imx_clk_mux_flags("ipu2_di0_sel",     base + 0x38, 0,  3, ipu2_di0_sels,     ARRAY_SIZE(ipu2_di0_sels), CLK_SET_RATE_PARENT);
+	clk[ipu2_di1_sel]     = imx_clk_mux_flags("ipu2_di1_sel",     base + 0x38, 9,  3, ipu2_di1_sels,     ARRAY_SIZE(ipu2_di1_sels), CLK_SET_RATE_PARENT);
 	clk[hsi_tx_sel]       = imx_clk_mux("hsi_tx_sel",       base + 0x30, 28, 1, hsi_tx_sels,       ARRAY_SIZE(hsi_tx_sels));
 	clk[pcie_axi_sel]     = imx_clk_mux("pcie_axi_sel",     base + 0x18, 10, 1, pcie_axi_sels,     ARRAY_SIZE(pcie_axi_sels));
 	clk[ssi1_sel]         = imx_clk_fixup_mux("ssi1_sel",   base + 0x1c, 10, 2, ssi_sels,          ARRAY_SIZE(ssi_sels),          imx_cscmr1_fixup);
@@ -307,9 +307,9 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[ipu1_podf]        = imx_clk_divider("ipu1_podf",        "ipu1_sel",          base + 0x3c, 11, 3);
 	clk[ipu2_podf]        = imx_clk_divider("ipu2_podf",        "ipu2_sel",          base + 0x3c, 16, 3);
 	clk[ldb_di0_div_3_5]  = imx_clk_fixed_factor("ldb_di0_div_3_5", "ldb_di0_sel", 2, 7);
-	clk[ldb_di0_podf]     = imx_clk_divider_flags("ldb_di0_podf", "ldb_di0_div_3_5", base + 0x20, 10, 1, 0);
+	clk[ldb_di0_podf]     = imx_clk_divider("ldb_di0_podf", "ldb_di0_div_3_5", base + 0x20, 10, 1);
 	clk[ldb_di1_div_3_5]  = imx_clk_fixed_factor("ldb_di1_div_3_5", "ldb_di1_sel", 2, 7);
-	clk[ldb_di1_podf]     = imx_clk_divider_flags("ldb_di1_podf", "ldb_di1_div_3_5", base + 0x20, 11, 1, 0);
+	clk[ldb_di1_podf]     = imx_clk_divider("ldb_di1_podf", "ldb_di1_div_3_5", base + 0x20, 11, 1);
 	clk[ipu1_di0_pre]     = imx_clk_divider("ipu1_di0_pre",     "ipu1_di0_pre_sel",  base + 0x34, 3,  3);
 	clk[ipu1_di1_pre]     = imx_clk_divider("ipu1_di1_pre",     "ipu1_di1_pre_sel",  base + 0x34, 12, 3);
 	clk[ipu2_di0_pre]     = imx_clk_divider("ipu2_di0_pre",     "ipu2_di0_pre_sel",  base + 0x38, 3,  3);
-- 
1.8.3.1
