From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Fri, 20 Jul 2018 14:32:34 +0100
Subject: [PATCH 4/4] arch/arm: Rebuild sched_domain hierarchy when cpu
 capacity changes
In-Reply-To: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
Message-ID: <1532093554-30504-5-git-send-email-morten.rasmussen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Asymmetric cpu capacity can not necessarily be determined accurately at
the time the initial sched_domain hierarchy is built during boot. It is
therefore necessary to be able to force a full rebuild of the hierarchy
later triggered by the arch_topology driver. A full rebuild requires the
arch-code to implement arch_update_cpu_topology() which isn't yet
implemented for arm. This patch points the arm implementation to
arch_topology driver to ensure that full hierarchy rebuild happens when
needed.

cc: Russell King <linux@armlinux.org.uk>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 arch/arm/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 5d88d2f22b2c..2a786f54d8b8 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -33,6 +33,9 @@ const struct cpumask *cpu_coregroup_mask(int cpu);
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity topology_get_cpu_scale
 
+/* Enable topology flag updates */
+#define arch_update_cpu_topology topology_update_cpu_topology
+
 #else
 
 static inline void init_cpu_topology(void) { }
-- 
2.7.4
