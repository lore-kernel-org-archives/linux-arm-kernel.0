From: eric@anholt.net (Eric Anholt)
Date: Tue, 26 Apr 2016 12:39:44 -0700
Subject: [PATCH 1/2] clk: bcm2835: Mark the VPU clock as critical
Message-ID: <1461699585-6649-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VPU clock is also the clock for our AXI bus, so we really can't
disable it.  This might have happened during boot if, for example,
uart1 (aux_uart clock) probed and was then disabled before the other
consumers of the VPU clock had probed.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/clk/bcm/clk-bcm2835.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 5a7e3eca5d12..14f3066194ac 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1267,6 +1267,7 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 
 	if (data->is_vpu_clock) {
 		init.ops = &bcm2835_vpu_clock_clk_ops;
+		init.flags |= CLK_IS_CRITICAL;
 	} else {
 		init.ops = &bcm2835_clock_clk_ops;
 		init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
-- 
2.8.0.rc3
