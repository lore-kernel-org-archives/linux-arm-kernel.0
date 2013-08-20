From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 20 Aug 2013 12:45:53 -0300
Subject: [PATCH v3 4/5] clocksource: armada-370-xp: Get reference fixed-clock
 by name
In-Reply-To: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377013554-23389-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP timer has two mandatory clock inputs: nbclk and refclk,
as specified by the device-tree binding.

This commit fixes the clock selection. Instead of hard-coding the clock
rate for the 25 MHz reference fixed-clock, obtain the clock by its name.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-armada-370-xp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index fca318f..99f9a41 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -292,8 +292,11 @@ static void __init armada_370_xp_timer_common_init(struct device_node *np)
 
 static void __init armada_xp_timer_init(struct device_node *np)
 {
-	/* The fixed 25MHz timer is required, timer25Mhz is true by default */
-	timer_clk = 25000000;
+	struct clk *clk = of_clk_get_by_name(np, "fixed");
+
+	/* The 25Mhz fixed clock is mandatory, and must always be available */
+	BUG_ON(IS_ERR(clk));
+	timer_clk = clk_get_rate(clk);
 
 	armada_370_xp_timer_common_init(np);
 }
-- 
1.8.1.5
