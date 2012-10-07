From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Sun,  7 Oct 2012 09:43:54 +0200
Subject: [RFC 2/6] sched: add a new SD SHARE_POWERLINE flag for sched_domain
In-Reply-To: <1349595838-31274-1-git-send-email-vincent.guittot@linaro.org>
References: <1349595838-31274-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1349595838-31274-3-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new flag SD SHARE_POWERLINE reflects the sharing of the power rail
between the members of a domain. As this is the current assumption of the
scheduler, the flag is added to all sched_domain

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/ia64/include/asm/topology.h |    1 +
 arch/tile/include/asm/topology.h |    1 +
 include/linux/sched.h            |    1 +
 include/linux/topology.h         |    3 +++
 kernel/sched/core.c              |    5 +++++
 5 files changed, 11 insertions(+)

diff --git a/arch/ia64/include/asm/topology.h b/arch/ia64/include/asm/topology.h
index a2496e4..065c720 100644
--- a/arch/ia64/include/asm/topology.h
+++ b/arch/ia64/include/asm/topology.h
@@ -65,6 +65,7 @@ void build_cpu_to_node_map(void);
 				| SD_BALANCE_EXEC	\
 				| SD_BALANCE_FORK	\
 				| SD_WAKE_AFFINE,	\
+				| arch_sd_share_power_line()		\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
diff --git a/arch/tile/include/asm/topology.h b/arch/tile/include/asm/topology.h
index 7a7ce39..d39ed0b 100644
--- a/arch/tile/include/asm/topology.h
+++ b/arch/tile/include/asm/topology.h
@@ -72,6 +72,7 @@ static inline const struct cpumask *cpumask_of_node(int node)
 				| 0*SD_PREFER_LOCAL			\
 				| 0*SD_SHARE_CPUPOWER			\
 				| 0*SD_SHARE_PKG_RESOURCES		\
+				| arch_sd_share_power_line()		\
 				| 0*SD_SERIALIZE			\
 				,					\
 	.last_balance		= jiffies,				\
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4786b20..74f2daf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -862,6 +862,7 @@ enum cpu_idle_type {
 #define SD_WAKE_AFFINE		0x0020	/* Wake task to waking CPU */
 #define SD_PREFER_LOCAL		0x0040  /* Prefer to keep tasks local to this domain */
 #define SD_SHARE_CPUPOWER	0x0080	/* Domain members share cpu power */
+#define SD_SHARE_POWERLINE	0x0100	/* Domain members share power domain */
 #define SD_SHARE_PKG_RESOURCES	0x0200	/* Domain members share cpu pkg resources */
 #define SD_SERIALIZE		0x0400	/* Only a single load balancing instance */
 #define SD_ASYM_PACKING		0x0800  /* Place busy groups earlier in the domain */
diff --git a/include/linux/topology.h b/include/linux/topology.h
index fec12d6..20964ab 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -99,6 +99,7 @@ int arch_update_cpu_topology(void);
 				| 1*SD_WAKE_AFFINE			\
 				| 1*SD_SHARE_CPUPOWER			\
 				| 1*SD_SHARE_PKG_RESOURCES		\
+				| arch_sd_share_power_line()		\
 				| 0*SD_SERIALIZE			\
 				| 0*SD_PREFER_SIBLING			\
 				| arch_sd_sibling_asym_packing()	\
@@ -132,6 +133,7 @@ int arch_update_cpu_topology(void);
 				| 0*SD_PREFER_LOCAL			\
 				| 0*SD_SHARE_CPUPOWER			\
 				| 1*SD_SHARE_PKG_RESOURCES		\
+				| arch_sd_share_power_line()		\
 				| 0*SD_SERIALIZE			\
 				,					\
 	.last_balance		= jiffies,				\
@@ -163,6 +165,7 @@ int arch_update_cpu_topology(void);
 				| 0*SD_PREFER_LOCAL			\
 				| 0*SD_SHARE_CPUPOWER			\
 				| 0*SD_SHARE_PKG_RESOURCES		\
+				| arch_sd_share_power_line()		\
 				| 0*SD_SERIALIZE			\
 				| 1*SD_PREFER_SIBLING			\
 				,					\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d50fbac..dab7908 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6407,6 +6407,11 @@ int __weak arch_sd_sibling_asym_packing(void)
        return 0*SD_ASYM_PACKING;
 }
 
+int __weak arch_sd_share_power_line(void)
+{
+	return 1*SD_SHARE_POWERLINE;
+}
+
 /*
  * Initializers for schedule domains
  * Non-inlined to reduce accumulated stack pressure in build_sched_domains()
-- 
1.7.9.5
