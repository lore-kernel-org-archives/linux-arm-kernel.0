From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 10 Aug 2016 15:14:27 +0200
Subject: [PATCH v2] clocksource/drivers/time-armada-370-xp: Fix the clock
 reference
Message-ID: <1470834867-25932-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While converting the init function to return an error, the wrong clock
was get. This lead to wrong clock rate and slow down the kernel. For
example, before the patch a typical boot was around 15s after it was 1
minute slower.

Fixes: 12549e27c63c ("clocksource/drivers/time-armada-370-xp: Convert init function to return error")

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Changelog:

v1 -> v2
Move the of_clk_get_by_name out of the declaration as sugested by
Thomas Petazzoni.

 drivers/clocksource/time-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 719b478d136e..376ed13fe739 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -335,10 +335,10 @@ static int __init armada_370_xp_timer_common_init(struct device_node *np)
 
 static int __init armada_xp_timer_init(struct device_node *np)
 {
-	struct clk *clk = of_clk_get_by_name(np, "fixed");
+	struct clk *clk;
 	int ret;
 
-	clk = of_clk_get(np, 0);
+	clk = of_clk_get_by_name(np, "fixed");
 	if (IS_ERR(clk)) {
 		pr_err("Failed to get clock");
 		return PTR_ERR(clk);
-- 
2.8.1
