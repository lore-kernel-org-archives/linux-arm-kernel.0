From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 15 Jan 2018 13:15:28 -0600
Subject: [PATCH] soc: xilinx: xlnx_vcu: Use bitwise & rather than logical &&
 on clkoutdiv
Message-ID: <20180115191528.GA26210@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently clkoutdiv is being operated on by a logical && operator rather
than a bitwise & operator. This looks incorrect as these should be bit
flag operations.

Addresses-Coverity-ID: 1463959 ("Logical vs. bitwise operator")
Fixes: cee8113a295a ("soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/soc/xilinx/xlnx_vcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/xlnx_vcu.c b/drivers/soc/xilinx/xlnx_vcu.c
index c1d6f1b..a840c02 100644
--- a/drivers/soc/xilinx/xlnx_vcu.c
+++ b/drivers/soc/xilinx/xlnx_vcu.c
@@ -334,7 +334,7 @@ static int xvcu_set_vcu_pll_info(struct xvcu_device *xvcu)
 	 */
 	vcu_pll_ctrl = xvcu_read(xvcu->vcu_slcr_ba, VCU_PLL_CTRL);
 	clkoutdiv = vcu_pll_ctrl >> VCU_PLL_CTRL_CLKOUTDIV_SHIFT;
-	clkoutdiv = clkoutdiv && VCU_PLL_CTRL_CLKOUTDIV_MASK;
+	clkoutdiv = clkoutdiv & VCU_PLL_CTRL_CLKOUTDIV_MASK;
 	if (clkoutdiv != 1) {
 		dev_err(xvcu->dev, "clkoutdiv value is invalid\n");
 		return -EINVAL;
-- 
2.7.4
