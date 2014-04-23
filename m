From: joelf@ti.com (Joel Fernandes)
Date: Tue, 22 Apr 2014 20:27:06 -0500
Subject: [PATCH 5/8] ARM: OMAP2+: timer: Use of_clk_get for DT platforms
In-Reply-To: <1398216429-4681-1-git-send-email-joelf@ti.com>
References: <1398216429-4681-1-git-send-email-joelf@ti.com>
Message-ID: <1398216429-4681-6-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For DT-booting platforms, use of_clk_get to get the fclk for system timers.
Separate out the legacy code for non-DT platform use.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ea91ef9..4fcfd7a 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -277,6 +277,10 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		if (!timer->io_base)
 			return -ENXIO;
 
+		timer->fclk = of_clk_get(np, 0);
+		if (IS_ERR(timer->fclk))
+			return PTR_ERR(timer->fclk);
+
 		r = omap_dmtimer_powerup(np);
 		if (r)
 			return r;
@@ -308,14 +312,13 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		if (!timer->io_base)
 			return -ENXIO;
 
+		timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
+		if (IS_ERR(timer->fclk))
+			return PTR_ERR(timer->fclk);
 
 		omap_hwmod_setup_one(oh_name);
 		omap_hwmod_enable(oh);
 	}
-	/* After the dmtimer is using hwmod these clocks won't be needed */
-	timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
-	if (IS_ERR(timer->fclk))
-		return PTR_ERR(timer->fclk);
 
 	/*
 	 * Clock reparenting code, goes away for DT-boot atleast,
-- 
1.7.9.5
