From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Oct 2014 13:59:27 +0200
Subject: [PATCH 14/17] ARM: mvebu: synchronize secondary CPU clocks on resume
In-Reply-To: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414151970-6626-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP has multiple cores clocked by independent clocks. The
SMP startup code contains a function called set_secondary_cpus_clock()
called in armada_xp_smp_prepare_cpus() to ensure the clocks of the
secondary CPUs match the clock of the boot CPU.

With the introduction of suspend/resume, this operation is no longer
needed when booting the system, but also when existing the suspend to
RAM state. Therefore this commit reworks a bit the logic: instead of
configuring the clock of all secondary CPUs in
armada_xp_smp_prepare_cpus(), we do it on a per-secondary CPU basis in
armada_xp_boot_secondary(), as this function gets called when existing
suspend to RAM for each secondary CPU.

Since the function now only takes care of one CPU, we rename it from
set_secondary_cpus_clock() to set_secondary_cpu_clock(), and it looses
its __init marker, as it is now used beyond the system initialization.

Note that we can't use smp_processor_id() directly, because when
exiting from suspend to RAM, the code is apparently executed with
preemption enabled, so smp_processor_id() is not happy (prints a
warning). We therefore switch to using get_cpu()/put_cpu(), even
though we pretty much have the guarantee that the code starting the
secondary CPUs is going to run on the boot CPU and will not be
migrated.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/platsmp.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 895dc37..e65e69a 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -33,7 +33,7 @@
 #define AXP_BOOTROM_BASE 0xfff00000
 #define AXP_BOOTROM_SIZE 0x100000
 
-static struct clk *__init get_cpu_clk(int cpu)
+static struct clk *get_cpu_clk(int cpu)
 {
 	struct clk *cpu_clk;
 	struct device_node *np = of_get_cpu_node(cpu, NULL);
@@ -46,29 +46,28 @@ static struct clk *__init get_cpu_clk(int cpu)
 	return cpu_clk;
 }
 
-static void __init set_secondary_cpus_clock(void)
+static void set_secondary_cpu_clock(unsigned int cpu)
 {
-	int thiscpu, cpu;
+	int thiscpu;
 	unsigned long rate;
 	struct clk *cpu_clk;
 
-	thiscpu = smp_processor_id();
+	thiscpu = get_cpu();
+
 	cpu_clk = get_cpu_clk(thiscpu);
 	if (!cpu_clk)
-		return;
+		goto out;
 	clk_prepare_enable(cpu_clk);
 	rate = clk_get_rate(cpu_clk);
 
-	/* set all the other CPU clk to the same rate than the boot CPU */
-	for_each_possible_cpu(cpu) {
-		if (cpu == thiscpu)
-			continue;
-		cpu_clk = get_cpu_clk(cpu);
-		if (!cpu_clk)
-			return;
-		clk_set_rate(cpu_clk, rate);
-		clk_prepare_enable(cpu_clk);
-	}
+	cpu_clk = get_cpu_clk(cpu);
+	if (!cpu_clk)
+		goto out;
+	clk_set_rate(cpu_clk, rate);
+	clk_prepare_enable(cpu_clk);
+
+out:
+	put_cpu();
 }
 
 static int armada_xp_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -78,6 +77,7 @@ static int armada_xp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	pr_info("Booting CPU %d\n", cpu);
 
 	hw_cpu = cpu_logical_map(cpu);
+	set_secondary_cpu_clock(hw_cpu);
 	mvebu_pmsu_set_cpu_boot_addr(hw_cpu, armada_xp_secondary_startup);
 
 	/*
@@ -126,7 +126,6 @@ static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 	struct resource res;
 	int err;
 
-	set_secondary_cpus_clock();
 	flush_cache_all();
 	set_cpu_coherent();
 
-- 
2.0.0
