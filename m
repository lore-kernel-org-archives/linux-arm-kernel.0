From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Thu,  8 Jun 2017 08:55:12 +0100
Subject: [PATCH 5/6] arm64: wire frequency-invariant accounting support up to
 the task scheduler
In-Reply-To: <20170608075513.12475-1-dietmar.eggemann@arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
Message-ID: <20170608075513.12475-6-dietmar.eggemann@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit dfbca41f3479 ("sched: Optimize freq invariant accounting")
changed the wiring which now has to be done by associating
arch_scale_freq_capacity with the actual implementation provided
by the architecture.

Define arch_scale_freq_capacity to use the arch_topology "driver"
function topology_get_freq_scale() for the task scheduler's
frequency-invariant accounting instead of the default
arch_scale_freq_capacity() in kernel/sched/sched.h.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm64/include/asm/topology.h | 5 +++++
 arch/arm64/kernel/topology.c      | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 8b57339823e9..44598a86ec4a 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -32,6 +32,11 @@ int pcibus_to_node(struct pci_bus *bus);
 
 #endif /* CONFIG_NUMA */
 
+#include <linux/arch_topology.h>
+
+/* Replace task scheduler's default frequency-invariant accounting */
+#define arch_scale_freq_capacity topology_get_freq_scale
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 79244c75eaec..6cbb6315e493 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -11,7 +11,6 @@
  * for more details.
  */
 
-#include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
-- 
2.11.0
