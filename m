From: robherring2@gmail.com (Rob Herring)
Date: Wed, 20 Mar 2013 17:54:05 -0500
Subject: [PATCH 05/11] ARM: vexpress: remove sp804 OF init
In-Reply-To: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
Message-ID: <1363820051-24428-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove the vexpress specific setup for the sp804 timer now that
clocksource_of_init will do it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-vexpress/v2m.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 9fbfbe4..09e571d 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -428,20 +428,9 @@ void __init v2m_dt_init_early(void)
 
 static void __init v2m_dt_timer_init(void)
 {
-	struct device_node *node = NULL;
-
 	vexpress_clk_of_init();
 
 	clocksource_of_init();
-	do {
-		node = of_find_compatible_node(node, NULL, "arm,sp804");
-	} while (node && vexpress_get_site_by_node(node) != VEXPRESS_SITE_MB);
-	if (node) {
-		pr_info("Using SP804 '%s' as a clock & events source\n",
-				node->full_name);
-		v2m_sp804_init(of_iomap(node, 0),
-				irq_of_parse_and_map(node, 0));
-	}
 
 	versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
 				24000000);
-- 
1.7.10.4
