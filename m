From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 30 Jun 2016 16:15:01 +0300
Subject: [PATCH 3/5] ARM: OMAP2+: timer: change order of hwmod data handling
In-Reply-To: <1467292503-4376-1-git-send-email-t-kristo@ti.com>
References: <1467292503-4376-1-git-send-email-t-kristo@ti.com>
Message-ID: <1467292503-4376-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of hwmod module clocks, the name of the hwmod
main clk may not be available before hwmod setup, as hwmod setup
may lookup the main clock dynamically based on the hwmod name.
Thus, change the order of hwmod setup and main clock handling for
the timer code, to make sure the main clock is going to be
available.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 5b385bb..e7eccf6 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -289,6 +289,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (!timer->io_base)
 		return -ENXIO;
 
+	omap_hwmod_setup_one(oh_name);
+
 	/* After the dmtimer is using hwmod these clocks won't be needed */
 	timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
 	if (IS_ERR(timer->fclk))
@@ -303,7 +305,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	clk_put(src);
 
-	omap_hwmod_setup_one(oh_name);
 	omap_hwmod_enable(oh);
 	__omap_dm_timer_init_regs(timer);
 
-- 
1.9.1
