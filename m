From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed,  4 May 2016 07:53:05 +0000
Subject: [PATCH V5] clk: bcm2835: mark enabled clocks and pll with
 CLK_ENABLE_HAND_OFF
Message-ID: <1462348385-16167-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835 firmware enables several clocks and plls before
booting the linux kernel.

These plls should never get disabled as it may result in a
stopped system clock and more.

So during probing we check if the clock and plls are enabled
and if it is then mark that clock/pll with CLK_ENABLE_HAND_OFF.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Note: This requires the CLK_ENABLE_HAND_OFF patch to be applied.

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 0fc71cb..0663b6c 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1211,6 +1211,15 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
 	divider->cprman = cprman;
 	divider->data = data;
 
+	/* if the pll-divider is running, then enable CLK_ENABLE_HAND_OFF */
+	if ((cprman_read(cprman, data->a2w_reg) &
+	     A2W_PLL_CHANNEL_DISABLE) == 0) {
+		dev_dbg(cprman->dev,
+			"found firmware enabled pll_div %s - enabling hand off\n",
+			data->name);
+		init.flags |= CLK_ENABLE_HAND_OFF;
+	}
+
 	clk = devm_clk_register(cprman->dev, &divider->div.hw);
 	if (IS_ERR(clk))
 		return clk;
@@ -1262,6 +1271,14 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 		init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 	}
 
+	/* if the clock is running, then enable CLK_ENABLE_HAND_OFF */
+	if (cprman_read(cprman, data->ctl_reg) & CM_ENABLE) {
+		dev_dbg(cprman->dev,
+			"found firmware enabled clock %s - enabling hand off\n",
+			data->name);
+		init.flags |= CLK_ENABLE_HAND_OFF;
+	}
+
 	clock = devm_kzalloc(cprman->dev, sizeof(*clock), GFP_KERNEL);
 	if (!clock)
 		return NULL;
-- 
2.1.4
