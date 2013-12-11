From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 11 Dec 2013 17:27:07 +0530
Subject: [PATCH 3/5] clk: max77686: Replace is_enabled() with is_prepared
 call-back
In-Reply-To: <1386763029-8516-1-git-send-email-a.kesavan@samsung.com>
References: <1386763029-8516-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1386763029-8516-4-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following messages are observed when unused PMIC clocks are being
disabled during boot-up:
[ 2921.969560] BUG: scheduling while atomic: swapper/0/1/0x00000002
[ 2921.974080] Modules linked in:
[ 2921.977120] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc1-00018-g8465d57 #27
[ 2921.984772] [<c0013c80>] (unwind_backtrace+0x0/0xf8) from [<c00110cc>] (show_stack+0x10/0x14)
[ 2921.993269] [<c00110cc>] (show_stack+0x10/0x14) from [<c032c10c>] (dump_stack+0x64/0xa4)
[ 2922.001340] [<c032c10c>] (dump_stack+0x64/0xa4) from [<c0329b00>] (__schedule_bug+0x48/0x60)
[ 2922.009758] [<c0329b00>] (__schedule_bug+0x48/0x60) from [<c032d414>] (__schedule+0x468/0x504)
[ 2922.018351] [<c032d414>] (__schedule+0x468/0x504) from [<c032caac>] (schedule_timeout+0x114/0x19c)
[ 2922.027294] [<c032caac>] (schedule_timeout+0x114/0x19c) from [<c0255c00>] (s3c24xx_i2c_xfer+0x1cc/0x320)
[ 2922.036754] [<c0255c00>] (s3c24xx_i2c_xfer+0x1cc/0x320) from [<c0252e08>] (__i2c_transfer+0x44/0x7c)
[ 2922.045868] [<c0252e08>] (__i2c_transfer+0x44/0x7c) from [<c025416c>] (i2c_transfer+0x74/0x98)
[ 2922.054462] [<c025416c>] (i2c_transfer+0x74/0x98) from [<c021ed38>] (regmap_i2c_read+0x48/0x64)
[ 2922.063142] [<c021ed38>] (regmap_i2c_read+0x48/0x64) from [<c021b41c>] (_regmap_raw_read+0xa8/0xfc)
[ 2922.072168] [<c021b41c>] (_regmap_raw_read+0xa8/0xfc) from [<c021b780>] (_regmap_bus_read+0x28/0x48)
[ 2922.081281] [<c021b780>] (_regmap_bus_read+0x28/0x48) from [<c0219d30>] (_regmap_read+0x5c/0xc4)
[ 2922.090048] [<c0219d30>] (_regmap_read+0x5c/0xc4) from [<c0219ddc>] (regmap_read+0x44/0x5c)
[ 2922.098383] [<c0219ddc>] (regmap_read+0x44/0x5c) from [<c0290bdc>] (max77686_clk_is_enabled+0x20/0x3c)
[ 2922.107670] [<c0290bdc>] (max77686_clk_is_enabled+0x20/0x3c) from [<c028cfdc>] (clk_disable_unused_subtree+0x6c/0xa8)
[ 2922.118258] [<c028cfdc>] (clk_disable_unused_subtree+0x6c/0xa8) from [<c028dc90>] (clk_disable_unused+0x30/0xd8)
[ 2922.128414] [<c028dc90>] (clk_disable_unused+0x30/0xd8) from [<c00087a8>] (do_one_initcall+0x38/0x160)

Fix it by replacing is_enabled call-back with is_prepared as the i2c driver may
sleep during a transfer.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/clk-max77686.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 9f57bc3..e39d463 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -66,7 +66,7 @@ static void max77686_clk_unprepare(struct clk_hw *hw)
 		MAX77686_REG_32KHZ, max77686->mask, ~max77686->mask);
 }
 
-static int max77686_clk_is_enabled(struct clk_hw *hw)
+static int max77686_clk_is_prepared(struct clk_hw *hw)
 {
 	struct max77686_clk *max77686 = to_max77686_clk(hw);
 	int ret;
@@ -84,7 +84,7 @@ static int max77686_clk_is_enabled(struct clk_hw *hw)
 static struct clk_ops max77686_clk_ops = {
 	.prepare	= max77686_clk_prepare,
 	.unprepare	= max77686_clk_unprepare,
-	.is_enabled	= max77686_clk_is_enabled,
+	.is_prepared	= max77686_clk_is_prepared,
 };
 
 static struct clk_init_data max77686_clks_init[MAX77686_CLKS_NUM] = {
-- 
1.7.9.5
