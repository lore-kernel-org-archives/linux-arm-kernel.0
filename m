From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 22:27:55 +0100
Subject: [PATCH] cpufreq: mediatek: fix build error
Message-ID: <3905943.jgsUmEgmnP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added mt8173 cpufreq driver relies on the cpu topology
that is always present on ARM64 but optional on ARM32:

drivers/cpufreq/mt8173-cpufreq.c: In function 'mtk_cpufreq_init':
drivers/cpufreq/mt8173-cpufreq.c:441:30: error: 'cpu_topology' undeclared (first use in this function)
  cpumask_copy(policy->cpus, &cpu_topology[policy->cpu].core_sibling);

This refines the Kconfig dependencies so that we can still build on
ARM32, but only if COMPILE_TEST is selected and the CPU topology
code is present.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1582c1c016b0..8014c2307332 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -84,6 +84,7 @@ config ARM_KIRKWOOD_CPUFREQ
 config ARM_MT8173_CPUFREQ
 	bool "Mediatek MT8173 CPUFreq support"
 	depends on ARCH_MEDIATEK && REGULATOR
+	depends on ARM64 || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
 	depends on !CPU_THERMAL || THERMAL=y
 	select PM_OPP
 	help
