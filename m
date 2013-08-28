From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:42:01 +0900
Subject: [PATCH 1/5] ARM: shmobile: Introduce shmobile_smp_cpu_disable()
In-Reply-To: <cover.1377651075.git.horms+renesas@verge.net.au>
References: <cover.1377651075.git.horms+renesas@verge.net.au>
Message-ID: <90b7ba85d6d3e7ccb6b73b9c334e34637e928ab0.1377651075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Introduce the shared CPU Hotplug function shmobile_smp_cpu_disable()
for mach-shmobile. It is useful for the case when all CPUs may be
hotplugged, including CPU 0.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h | 1 +
 arch/arm/mach-shmobile/platsmp.c             | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 3880cf5..2eda447 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -14,6 +14,7 @@ extern void shmobile_smp_boot(void);
 extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
+extern int shmobile_smp_cpu_disable(unsigned int cpu);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index d4ae616..3741562 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -44,3 +44,10 @@ void shmobile_smp_hook(unsigned int cpu, unsigned long fn, unsigned long arg)
 	shmobile_smp_arg[cpu] = arg;
 	flush_cache_all();
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+int shmobile_smp_cpu_disable(unsigned int cpu)
+{
+	return 0; /* Hotplug of any CPU is supported */
+}
+#endif
-- 
1.8.3.2
