From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  8 Mar 2016 15:18:53 +0100
Subject: [PATCH] ARM: mvebu: Fix of_clk_get() call in a non sleeping context
Message-ID: <1457446733-7137-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_clk_get() is called armada_xp_smp_prepare_cpus() function. This
callback can be called in a context where it should not sleep as pointed
when enabling CONFIG_DEBUG_ATOMIC_SLEEP. However of_clk_get() can sleep.

This patch solved this issue by moving the of_clk_get() during
initialization by gathering the list of reference on the clock, and only
access to this list later.

Fixes: f6cec7cd0777 ("ARM: mvebu: remove device tree parsing for cpu
nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/platsmp.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index f9597b701028..33ef7f9f4ef2 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -35,17 +35,11 @@
 #define AXP_BOOTROM_BASE 0xfff00000
 #define AXP_BOOTROM_SIZE 0x100000
 
+static struct clk *cpu_clks[ARMADA_XP_MAX_CPUS];
+
 static struct clk *get_cpu_clk(int cpu)
 {
-	struct clk *cpu_clk;
-	struct device_node *np = of_get_cpu_node(cpu, NULL);
-
-	if (WARN(!np, "missing cpu node\n"))
-		return NULL;
-	cpu_clk = of_clk_get(np, 0);
-	if (WARN_ON(IS_ERR(cpu_clk)))
-		return NULL;
-	return cpu_clk;
+	return cpu_clks[cpu];
 }
 
 static void set_secondary_cpu_clock(unsigned int cpu)
@@ -126,7 +120,7 @@ static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 {
 	struct device_node *node;
 	struct resource res;
-	int err;
+	int err, cpu;
 
 	flush_cache_all();
 	set_cpu_coherent();
@@ -146,6 +140,24 @@ static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 	if (res.start != AXP_BOOTROM_BASE ||
 	    resource_size(&res) != AXP_BOOTROM_SIZE)
 		panic("The address for the BootROM is incorrect");
+
+	/*
+	 * of_clk_get() can sleep, but we need a clk reference in
+	 * armada_xp_smp_prepare_cpus and the smp_prepare_cpus() call
+	 * back must not sleep. So we gather the list of reference on
+	 * the clock now.
+	 */
+	for (cpu = 0; cpu < ARMADA_XP_MAX_CPUS; cpu++) {
+		struct clk *cpu_clk;
+
+		node = of_get_cpu_node(cpu, NULL);
+		if (WARN(!node, "missing cpu node\n"))
+			continue;
+		cpu_clk = of_clk_get(node, 0);
+		if (WARN_ON(IS_ERR(cpu_clk)))
+			cpu_clk = NULL;
+		cpu_clks[cpu] = cpu_clk;
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.5.0
