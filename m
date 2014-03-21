From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 21 Mar 2014 09:48:14 +0000
Subject: [PATCH 2/2] ARM: highbank: avoid L2 cache smc calls when PL310 is not
 present
In-Reply-To: <20140320233920.GD24571@kroah.com>
References: <20140320233920.GD24571@kroah.com>
Message-ID: <1395395294-17848-2-git-send-email-ian.campbell@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

commit a56a5cf1f2ec895599eace0ac6eba1e4a489e4bf upstream.

While Midway firmware handles L2 smc calls as nops, the custom smc calls
present a problem when running virtualized Midway guest. They aren't
needed so just avoid calling them.

In the process, cleanup the L2X0 ifdefs and use IS_ENABLED instead.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
---
 arch/arm/mach-highbank/highbank.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 5ed19e8..35d1029 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -65,14 +65,12 @@ void highbank_set_cpu_jump(int cpu, void *jump_addr)
 			  HB_JUMP_TABLE_PHYS(cpu) + 15);
 }
 
-#ifdef CONFIG_CACHE_L2X0
 static void highbank_l2x0_disable(void)
 {
 	outer_flush_all();
 	/* Disable PL310 L2 Cache controller */
 	highbank_smc1(0x102, 0x0);
 }
-#endif
 
 static void __init highbank_init_irq(void)
 {
@@ -81,12 +79,13 @@ static void __init highbank_init_irq(void)
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
1.7.10.4
