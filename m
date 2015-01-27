From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 27 Jan 2015 11:05:27 -0800
Subject: [PATCH v2] clk: zynq: Force CPU_2X clock to be ungated
Message-ID: <1422385549-2550-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU_2X clock does not have a classical in-kernel user, but is,
amongst other things, required for OCM and debug access. Make sure this
clock is not mistakenly disabled during boot up by enabling it in the
platform's clock driver.

Cc: stable at vger.kernel.org # 3.11+
Fixes: 0ee52b157b8e 'clk: zynq: Add clock controller driver'
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v2:
 - Fixed some typo's in the commit message
 - added Fixes and Cc tags to commit message

As reference, the v1 submission: https://patchwork.kernel.org/patch/5698251/
---
 drivers/clk/zynq/clkc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 9037bebd69f7..f870aad57711 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -303,6 +303,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 	clks[cpu_2x] = clk_register_gate(NULL, clk_output_name[cpu_2x],
 			"cpu_2x_div", CLK_IGNORE_UNUSED, SLCR_ARM_CLK_CTRL,
 			26, 0, &armclk_lock);
+	clk_prepare_enable(clks[cpu_2x]);
 
 	clk = clk_register_fixed_factor(NULL, "cpu_1x_div", "cpu_div", 0, 1,
 			4 + 2 * tmp);
-- 
2.2.2.1.g63c5777
