From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 29 Apr 2016 17:42:35 +0000
Subject: [PATCH V4 1/2] clk: bcm2835: mark enabled clocks with CLK_IS_CRITICAL
In-Reply-To: <1461951756-16804-1-git-send-email-kernel@martin.sperl.org>
References: <1461951756-16804-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1461951756-16804-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835 firmware enables several clocks and plls before
booting the linux kernel.

These plls should never get disabled as it may result in a
stopped system clock and more.

So during probing we check if the clock is enabled
and if it is then mark that clock with CLK_IS_CRITICAL.

As a consequence this will also enable the corresponding
parent plls and pll-divs.

This is intended as a stop-gap until CLK_ENABLE_HAND_OFF
becomes available, at which point it should be used instead.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 35f8de7..03b7f01 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1251,6 +1251,14 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 		init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 	}
 
+	/* if the clock is running, then enable CRITICAL */
+	if (cprman_read(cprman, data->ctl_reg) & CM_ENABLE) {
+		dev_dbg(cprman->dev,
+			"found firmware enabled clock %s - enabling critical\n",
+			data->name);
+		init.flags |= CLK_IS_CRITICAL;
+	}
+
 	clock = devm_kzalloc(cprman->dev, sizeof(*clock), GFP_KERNEL);
 	if (!clock)
 		return NULL;
-- 
2.1.4
