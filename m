From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 26 Apr 2016 08:56:29 +0000
Subject: [PATCH V2] clk: bcm2835: mark enabled pll_dividers as critical
Message-ID: <1461660989-11846-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835 firmware enables several clocks and plls before
booting the linux kernel.

These plls should never get disabled as it may result in a
stopped system clock and more.

So during probing we check if the pll_divider is enabled
and if it is then mark that pll_divider as critical.
As a consequence this will also enable the corresponding parent pll.

Here the list of pll_div that are marked as critical:
[    2.022437] bcm2835-clk 20101000.cprman: found enabled pll_div plla_core - marking it as critical
[    2.031640] bcm2835-clk 20101000.cprman: found enabled pll_div pllb_arm - marking it as critical
[    2.040966] bcm2835-clk 20101000.cprman: found enabled pll_div pllc_core0 - marking it as critical
[    2.050351] bcm2835-clk 20101000.cprman: found enabled pll_div pllc_per - marking it as critical
[    2.059427] bcm2835-clk 20101000.cprman: found enabled pll_div plld_core - marking it as critical
[    2.068590] bcm2835-clk 20101000.cprman: found enabled pll_div plld_per - marking it as critical
[    2.077724] bcm2835-clk 20101000.cprman: found enabled pll_div pllh_pix - marking it as critical

Changelog:
  V1 -> V2: apply to pll_dividers instead of clocks
            use CLK_IS_CRITICAL flag instead of prepare/enable manually

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 6479283c..7f6838f 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1086,6 +1086,15 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
 	divider->cprman = cprman;
 	divider->data = data;
 
+	/* if the pll-divider is running, then mark is as critical */
+	if ((cprman_read(cprman, data->a2w_reg) &
+	     A2W_PLL_CHANNEL_DISABLE) == 0) {
+		dev_info(cprman->dev,
+			 "found enabled pll_div %s - marking it as critical\n",
+			 data->name);
+		init.flags |= CLK_IS_CRITICAL;
+	}
+
 	clk = devm_clk_register(cprman->dev, &divider->div.hw);
 	if (IS_ERR(clk))
 		return clk;
-- 
2.1.4
