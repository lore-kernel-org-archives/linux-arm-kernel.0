From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 29 Apr 2016 17:42:36 +0000
Subject: [PATCH V4 2/2] clk: bcm2835: use CLK_ENABLE_HAND_OFF instead of
 CLK_IS_CRITICAL
In-Reply-To: <1461951756-16804-1-git-send-email-kernel@martin.sperl.org>
References: <1461951756-16804-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1461951756-16804-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The use of CLK_IS_CRITICAL is just a stop-gap to avoid unpreparing
essential PLLs that may result stopping the system without intention.

This moves to use CLK_ENABLE_HAND_OFF instead of CLK_IS_CRITICAL,
so that clocks (and their parents) may get released
if there is a driver that claims (and then later releases) a
specific clock.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

--
Note that this requires the following patches applied:
* clk: introduce CLK_ENABLE_HAND_OFF flag
* clk: per-user clk prepare & enable ref counts
---
 drivers/clk/bcm/clk-bcm2835.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 03b7f01..6303c3a 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1251,12 +1251,12 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 		init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 	}
 
-	/* if the clock is running, then enable CRITICAL */
+	/* if the clock is running, then enable CLK_ENABLE_HAND_OFF */
 	if (cprman_read(cprman, data->ctl_reg) & CM_ENABLE) {
 		dev_dbg(cprman->dev,
-			"found firmware enabled clock %s - enabling critical\n",
+			"found firmware enabled clock %s - enabling hand off\n",
 			data->name);
-		init.flags |= CLK_IS_CRITICAL;
+		init.flags |= CLK_ENABLE_HAND_OFF;
 	}
 
 	clock = devm_kzalloc(cprman->dev, sizeof(*clock), GFP_KERNEL);
-- 
2.1.4
