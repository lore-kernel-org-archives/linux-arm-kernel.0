From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon, 23 Jul 2018 09:26:03 -0700
Subject: [PATCH i2c-next] i2c: aspeed: Add an implicit type casting for
 *get_clk_reg_val
Message-ID: <20180723162603.3703-1-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit fixes this sparse warning:
drivers/i2c/busses/i2c-aspeed.c:875:38: warning: incorrect type in assignment (different modifiers)
drivers/i2c/busses/i2c-aspeed.c:875:38:    expected unsigned int ( *get_clk_reg_val )( ... )
drivers/i2c/busses/i2c-aspeed.c:875:38:    got void const *const data

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index efb89422d496..a4f956c6d567 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -872,7 +872,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	if (!match)
 		bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
 	else
-		bus->get_clk_reg_val = match->data;
+		bus->get_clk_reg_val = (u32 (*)(u32))match->data;
 
 	/* Initialize the I2C adapter */
 	spin_lock_init(&bus->lock);
-- 
2.18.0
