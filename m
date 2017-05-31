From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 31 May 2017 17:59:58 +0300
Subject: [PATCHv4 1/6] ARM: OMAP2+: timer: add support for fetching fck handle
 from DT
In-Reply-To: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
References: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
Message-ID: <1496242803-6101-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mux clock handle shall be provided via "fck" DT handle. This avoids
the need to lookup the main clock via hwmod core, which will not work
with the clkctrl clock support anymore; the main clock is not going to
be a mux.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 07dd692..af90f95 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -255,6 +255,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 		timer->io_base = of_iomap(np, 0);
 
+		timer->fclk = of_clk_get_by_name(np, "fck");
+
 		of_node_put(np);
 	} else {
 		if (omap_dm_timer_reserve_systimer(timer->id))
@@ -292,7 +294,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	omap_hwmod_setup_one(oh_name);
 
 	/* After the dmtimer is using hwmod these clocks won't be needed */
-	timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
+	if (IS_ERR_OR_NULL(timer->fclk))
+		timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
 	if (IS_ERR(timer->fclk))
 		return PTR_ERR(timer->fclk);
 
-- 
1.9.1
