From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:26:08 +0900
Subject: [PATCH 3/4] ARM: mach-shmobile: add shmobile_cpu_disable_any()
In-Reply-To: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613569-26981-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

Method to disable any core to be used on platforms where CPU0 does not
need special treatment.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/hotplug.c             |    6 ++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/hotplug.c b/arch/arm/mach-shmobile/hotplug.c
index b09a0bd..a1524e3 100644
--- a/arch/arm/mach-shmobile/hotplug.c
+++ b/arch/arm/mach-shmobile/hotplug.c
@@ -56,6 +56,12 @@ int shmobile_cpu_disable(unsigned int cpu)
 	return cpu == 0 ? -EPERM : 0;
 }
 
+int shmobile_cpu_disable_any(unsigned int cpu)
+{
+	cpumask_clear_cpu(cpu, &dead_cpus);
+	return 0;
+}
+
 int shmobile_cpu_is_dead(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, &dead_cpus);
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 64c0622..e48606d 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -84,6 +84,7 @@ static inline int shmobile_cpuidle_init(void) { return 0; }
 
 extern void shmobile_cpu_die(unsigned int cpu);
 extern int shmobile_cpu_disable(unsigned int cpu);
+extern int shmobile_cpu_disable_any(unsigned int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
 extern int shmobile_cpu_is_dead(unsigned int cpu);
-- 
1.7.10.4
