From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Fri, 20 Jul 2018 14:32:33 +0100
Subject: [PATCH 3/4] arch/arm64: Rebuild sched_domain hierarchy when cpu
 capacity changes
In-Reply-To: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
Message-ID: <1532093554-30504-4-git-send-email-morten.rasmussen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Asymmetric cpu capacity can not necessarily be determined accurately at
the time the initial sched_domain hierarchy is built during boot. It is
therefore necessary to be able to force a full rebuild of the hierarchy
later triggered by the arch_topology driver. A full rebuild requires the
arch-code to implement arch_update_cpu_topology() which isn't yet
implemented for arm64. This patch points the arm64 implementation to
arch_topology driver to ensure that full hierarchy rebuild happens when
needed.

cc: Catalin Marinas <catalin.marinas@arm.com>
cc: Will Deacon <will.deacon@arm.com>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 arch/arm64/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index df48212f767b..61ba09d48237 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -43,6 +43,9 @@ int pcibus_to_node(struct pci_bus *bus);
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity topology_get_cpu_scale
 
+/* Enable topology flag updates */
+#define arch_update_cpu_topology topology_update_cpu_topology
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
-- 
2.7.4
