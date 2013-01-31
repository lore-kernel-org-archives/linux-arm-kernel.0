From: robherring2@gmail.com (Rob Herring)
Date: Thu, 31 Jan 2013 14:01:14 -0600
Subject: [PATCH 3/3] ARM: highbank: mask cluster id from cpu_logical_map
In-Reply-To: <1359662474-1883-1-git-send-email-robherring2@gmail.com>
References: <1359662474-1883-1-git-send-email-robherring2@gmail.com>
Message-ID: <1359662474-1883-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With commit a0ae0240 (ARM: kernel: add device tree init map function),
the cpu id value may include the cluster id and is no longer 0-3, so we
need to mask it now to get the right hard cpu index.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/highbank.c |    3 ++-
 arch/arm/mach-highbank/sysregs.h  |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 981dc1e..e6c0612 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -28,6 +28,7 @@
 
 #include <asm/arch_timer.h>
 #include <asm/cacheflush.h>
+#include <asm/cputype.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/arm_timer.h>
@@ -59,7 +60,7 @@ static void __init highbank_scu_map_io(void)
 
 void highbank_set_cpu_jump(int cpu, void *jump_addr)
 {
-	cpu = cpu_logical_map(cpu);
+	cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(cpu), 0);
 	writel(virt_to_phys(jump_addr), HB_JUMP_TABLE_VIRT(cpu));
 	__cpuc_flush_dcache_area(HB_JUMP_TABLE_VIRT(cpu), 16);
 	outer_clean_range(HB_JUMP_TABLE_PHYS(cpu),
diff --git a/arch/arm/mach-highbank/sysregs.h b/arch/arm/mach-highbank/sysregs.h
index 70af9d1..5995df7 100644
--- a/arch/arm/mach-highbank/sysregs.h
+++ b/arch/arm/mach-highbank/sysregs.h
@@ -37,7 +37,7 @@ extern void __iomem *sregs_base;
 
 static inline void highbank_set_core_pwr(void)
 {
-	int cpu = cpu_logical_map(smp_processor_id());
+	int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(smp_processor_id()), 0);
 	if (scu_base_addr)
 		scu_power_mode(scu_base_addr, SCU_PM_POWEROFF);
 	else
@@ -46,7 +46,7 @@ static inline void highbank_set_core_pwr(void)
 
 static inline void highbank_clear_core_pwr(void)
 {
-	int cpu = cpu_logical_map(smp_processor_id());
+	int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(smp_processor_id()), 0);
 	if (scu_base_addr)
 		scu_power_mode(scu_base_addr, SCU_PM_NORMAL);
 	else
-- 
1.7.10.4
