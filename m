From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 10 Jul 2012 22:54:27 +0400
Subject: [PATCH 1/3] ARM: i.MX5x clocks: Add EPIT support
In-Reply-To: <20120709082700.GM24458@pengutronix.de>
References: <20120709082700.GM24458@pengutronix.de>
Message-ID: <1341946469-25984-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Enhanced Periodic Interrupt Timer (EPIT)
to clock subsystem.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index a2200c7..d9cb79f 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -81,6 +81,7 @@ enum imx5_clks {
 	ssi1_root_podf, ssi2_root_pred, ssi2_root_podf, ssi_ext1_pred,
 	ssi_ext1_podf, ssi_ext2_pred, ssi_ext2_podf, ssi1_root_gate,
 	ssi2_root_gate, ssi3_root_gate, ssi_ext1_gate, ssi_ext2_gate,
+	epit1_ipg_gate, epit1_per_gate, epit2_ipg_gate, epit2_per_gate,
 	clk_max
 };
 
@@ -226,6 +227,10 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[ssi3_root_gate] = imx_clk_gate2("ssi3_root_gate", "ssi3_root_sel", MXC_CCM_CCGR3, 26);
 	clk[ssi_ext1_gate] = imx_clk_gate2("ssi_ext1_gate", "ssi_ext1_com_sel", MXC_CCM_CCGR3, 28);
 	clk[ssi_ext2_gate] = imx_clk_gate2("ssi_ext2_gate", "ssi_ext2_com_sel", MXC_CCM_CCGR3, 30);
+	clk[epit1_ipg_gate] = imx_clk_gate2("epit1_ipg_gate", "ipg", MXC_CCM_CCGR2, 2);
+	clk[epit1_per_gate] = imx_clk_gate2("epit1_per_gate", "per_root", MXC_CCM_CCGR2, 4);
+	clk[epit2_ipg_gate] = imx_clk_gate2("epit2_ipg_gate", "ipg", MXC_CCM_CCGR2, 6);
+	clk[epit2_per_gate] = imx_clk_gate2("epit2_per_gate", "per_root", MXC_CCM_CCGR2, 8);
 
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
 		if (IS_ERR(clk[i]))
@@ -279,6 +284,10 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[dummy], NULL, "imx-keypad");
 	clk_register_clkdev(clk[tve_gate], NULL, "imx-tve.0");
 	clk_register_clkdev(clk[ipu_di1_gate], "di1", "imx-tve.0");
+	clk_register_clkdev(clk[epit1_ipg_gate], "ipg", "imx-epit.0");
+	clk_register_clkdev(clk[epit1_per_gate], "per", "imx-epit.0");
+	clk_register_clkdev(clk[epit2_ipg_gate], "ipg", "imx-epit.1");
+	clk_register_clkdev(clk[epit2_per_gate], "per", "imx-epit.1");
 
 	/* Set SDHC parents to be PLL2 */
 	clk_set_parent(clk[esdhc_a_sel], clk[pll2_sw]);
-- 
1.7.3.4
