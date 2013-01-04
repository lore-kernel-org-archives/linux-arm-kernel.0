From: josh.coombs@gmail.com (Josh Coombs)
Date: Fri, 4 Jan 2013 11:12:20 -0500
Subject: [Patch v1] arm: MVBEU Clk: Remove inappropriate __init tagging
Message-ID: <CAMW5UfY_J8fOM8kGPXXUUL1dmAAksNsCJUxX2Pmq_3BvhxjT+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is based on my prior problem report and discussion on a 3.8-rc1
kernel Oops and reboot hang.  I've tested it on top of 3.8-rc2 with
the pending missing clk for USB patch on my Seagate GoFlex Net
successfully.  Without this, 3.8 will not reboot on my system, the
Orion WDT fails to probe correctly as well.

MVEBU: Remove invalid __init tag from clk function
Modules need to be able to use this function outside of kernel init.
This corrects an Oops triggered by the Orion WDT driver being built as
a module.
Signed-off-by: Joshua Coombs <josh.coombs@gmail.com>
--- a/drivers/clk/mvebu/clk-gating-ctrl.c 2013-01-02 21:13:21.000000000 -0500
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c 2013-01-03 11:40:44.000000000 -0500
@@ -32,7 +32,7 @@

 #define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)

-static struct clk __init *mvebu_clk_gating_get_src(
+static struct clk *mvebu_clk_gating_get_src(
  struct of_phandle_args *clkspec, void *data)
 {
  struct mvebu_gating_ctrl *ctrl = (struct mvebu_gating_ctrl *)data;
