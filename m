From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 22 Mar 2013 13:25:55 +0100
Subject: [RFC PATCH v3 6/6] ARM: sched: clear SD_SHARE_POWERDOMAIN
In-Reply-To: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1363955155-18382-7-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM platforms take advantage of packing small tasks on few cores.
This is true even when the cores of a cluster can't be power gated
independantly. So we clear SD_SHARE_POWERDOMAIN at MC and CPU level.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 arch/arm/kernel/topology.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 79282eb..f89a4a2 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -201,6 +201,15 @@ static inline void update_cpu_power(unsigned int cpuid, unsigned int mpidr) {}
  */
 struct cputopo_arm cpu_topology[NR_CPUS];
 
+int arch_sd_local_flags(int level)
+{
+	/* Powergate at threading level doesn't make sense */
+	if (level & SD_SHARE_CPUPOWER)
+		return 1*SD_SHARE_POWERDOMAIN;
+
+	return 0*SD_SHARE_POWERDOMAIN;
+}
+
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
 	return &cpu_topology[cpu].core_sibling;
-- 
1.7.9.5
