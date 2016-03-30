From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 30 Mar 2016 14:23:03 +0200
Subject: [PATCH BUGFIX] clk: imx6q: fix typo in CAN clock definition
Message-ID: <1459340583-14743-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit ee36027427c7 ("clk: imx: Add clock support for imx6qp")
introduced a regression due to a subtle typo in the 'can_root' clock
definition. The effect is that trying to configure the bitrate of the
can interfaces fails with -EDOM or produces a division by zero error
due to the clock_freq of the can serial clock being reported as '0'.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/clk/imx/clk-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 02e1818..2beb396f 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -394,7 +394,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk[IMX6QDL_CLK_LDB_DI1_DIV_3_5] = imx_clk_fixed_factor("ldb_di1_div_3_5", "ldb_di1", 2, 7);
 	} else {
 		clk[IMX6QDL_CLK_ECSPI_ROOT] = imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19, 6);
-		clk[IMX6QDL_CLK_CAN_ROOT] = imx_clk_divider("can_root", "pll3_60", base + 0x20, 2, 6);
+		clk[IMX6QDL_CLK_CAN_ROOT] = imx_clk_divider("can_root", "pll3_60m", base + 0x20, 2, 6);
 		clk[IMX6QDL_CLK_IPG_PER] = imx_clk_fixup_divider("ipg_per", "ipg", base + 0x1c, 0, 6, imx_cscmr1_fixup);
 		clk[IMX6QDL_CLK_UART_SERIAL_PODF] = imx_clk_divider("uart_serial_podf", "pll3_80m",          base + 0x24, 0,  6);
 		clk[IMX6QDL_CLK_LDB_DI0_DIV_3_5] = imx_clk_fixed_factor("ldb_di0_div_3_5", "ldb_di0_sel", 2, 7);
-- 
2.1.4
