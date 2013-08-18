From: robherring2@gmail.com (Rob Herring)
Date: Sun, 18 Aug 2013 14:35:18 -0500
Subject: [PATCH 2/2] ARM: highbank: avoid L2 cache smc calls when PL310 is not
 present
In-Reply-To: <1376854518-22596-1-git-send-email-robherring2@gmail.com>
References: <1376854518-22596-1-git-send-email-robherring2@gmail.com>
Message-ID: <1376854518-22596-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

While Midway firmware handles L2 smc calls as nops, the custom smc calls
present a problem when running virtualized Midway guest. They aren't
needed so just avoid calling them.

In the process, cleanup the L2X0 ifdefs and use IS_ENABLED instead.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/highbank.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 0749b42..42ac14b 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -65,13 +65,11 @@ void highbank_set_cpu_jump(int cpu, void *jump_addr)
 			  HB_JUMP_TABLE_PHYS(cpu) + 15);
 }
 
-#ifdef CONFIG_CACHE_L2X0
 static void highbank_l2x0_disable(void)
 {
 	/* Disable PL310 L2 Cache controller */
 	highbank_smc1(0x102, 0x0);
 }
-#endif
 
 static void __init highbank_init_irq(void)
 {
@@ -80,12 +78,13 @@ static void __init highbank_init_irq(void)
 	if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
 		highbank_scu_map_io();
 
-#ifdef CONFIG_CACHE_L2X0
 	/* Enable PL310 L2 Cache controller */
-	highbank_smc1(0x102, 0x1);
-	l2x0_of_init(0, ~0UL);
-	outer_cache.disable = highbank_l2x0_disable;
-#endif
+	if (IS_ENABLED(CONFIG_CACHE_L2X0) &&
+	    of_find_compatible_node(NULL, NULL, "arm,pl310-cache")) {
+		highbank_smc1(0x102, 0x1);
+		l2x0_of_init(0, ~0UL);
+		outer_cache.disable = highbank_l2x0_disable;
+	}
 }
 
 static void __init highbank_timer_init(void)
-- 
1.8.1.2
