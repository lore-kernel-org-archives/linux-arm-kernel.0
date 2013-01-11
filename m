From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 11 Jan 2013 16:17:38 +0000
Subject: [PATCH] ARM: kernel: DT cpu map validity check helper function
Message-ID: <1357921058-11322-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the introduction of /cpu nodes bindings for ARM and the
corresponding parse function arm_dt_init_cpu_maps(), the cpu_logical_map
and the number of possible CPUs are set according to the DT /cpu
nodes entries. Currently most of the existing ARM SMP platforms detect the
number of cores through HW probing in their .smp_init_cpus functions and set
the possible CPU mask accordingly.
This method should be upgraded so that the CPU counting mechanism will be
based on DT, keeping legacy HW probing mechanism as a fall back solution.

In order to implement this fall back solution mechanism, the ARM DT code
should provide a helper function to platforms to check if the cpu map
has been properly initialized through DT. If the check fails the
platform will resort to legacy HW based cores counting mechanism.

This patch implements a helper function that platforms can call to check
whether DT based cpu map initialization and cores count were completed
successfully.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/prom.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
index a219227..a913989 100644
--- a/arch/arm/include/asm/prom.h
+++ b/arch/arm/include/asm/prom.h
@@ -13,11 +13,21 @@
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
+#include <linux/cpumask.h>
+
 #ifdef CONFIG_OF
 
 extern struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
 extern void arm_dt_memblock_reserve(void);
 extern void __init arm_dt_init_cpu_maps(void);
+/*
+ * Return true if cpu map initialization has been
+ * carried out correctly from DT
+ */
+static inline bool __init arm_dt_cpu_map_valid(void)
+{
+	return !!(num_possible_cpus());
+}
 
 #else /* CONFIG_OF */
 
@@ -28,6 +38,7 @@ static inline struct machine_desc *setup_machine_fdt(unsigned int dt_phys)
 
 static inline void arm_dt_memblock_reserve(void) { }
 static inline void arm_dt_init_cpu_maps(void) { }
+static inline bool __init arm_dt_cpu_map_valid(void) { return false; }
 
 #endif /* CONFIG_OF */
 #endif /* ASMARM_PROM_H */
-- 
1.7.12
