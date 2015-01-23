From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 23 Jan 2015 15:44:13 -0800
Subject: [PATCH] clk: zynq: Force CPU_2X clock to be ungated
Message-ID: <1422056653-11271-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU_2X clock does not have a classical in kernel user, but is,
amongst other things, required for OCM and debug access. Make sure this
clock does not mistakenly disabled during boot up by enabling it in the
platforms clock driver.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
I just noticed this on Linus' latest tip. I can't remember having had issues
connecting the debugger before, but it might be a candidate for stable in case
people report something like that.

	S?ren

 drivers/clk/zynq/clkc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index c363106ed726..f8469315161d 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -346,6 +346,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 	clks[cpu_2x] = clk_register_gate(NULL, clk_output_name[cpu_2x],
 			"cpu_2x_div", CLK_IGNORE_UNUSED, SLCR_ARM_CLK_CTRL,
 			26, 0, &armclk_lock);
+	clk_prepare_enable(clks[cpu_2x]);
 
 	clk = clk_register_fixed_factor(NULL, "cpu_1x_div", "cpu_div", 0, 1,
 			4 + 2 * tmp);
-- 
2.2.2.1.g63c5777
