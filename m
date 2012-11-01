From: felix.yang@huawei.com (Yangfei (Felix))
Date: Thu, 1 Nov 2012 01:24:38 +0000
Subject: [PATCH] ARM: Fix the "WFI" instruction opcode definition.
Message-ID: <DA41BE1DDCA941489001C7FBD7A8820E3CB5512E@szxeml549-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current "WFI" opcode definiton causes CPU hot-plug feature fails to work
if the kernel is built with CONFIG_THUMB2_KERNEL/CONFIG_CPU_ENDIAN_BE8 being
defined. An invalid instruction exception will be generated.

Signed-off-by: yangfei.kernel at gmail.com
---
 arch/arm/mach-exynos/hotplug.c   |    8 +++++++-
 arch/arm/mach-realview/hotplug.c |    8 +++++++-
 arch/arm/mach-shmobile/hotplug.c |    8 +++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index f4d7dd2..823a0e4 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -18,11 +18,17 @@
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
+#include <asm/opcodes.h>
 
 #include <mach/regs-pmu.h>
 
 #include "common.h"
 
+/*
+ * Define opcode of the WFI instruction.
+ */
+#define __WFI __inst_arm_thumb16(0xe320f003, 0xbf30)
+
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
@@ -72,7 +78,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		/*
 		 * here's the WFI
 		 */
-		asm(".word	0xe320f003\n"
+		asm(__WFI
 		    :
 		    :
 		    : "memory", "cc");
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index 53818e5..5271a1a 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -15,6 +15,12 @@
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
+#include <asm/opcodes.h>
+
+/*
+ * Define opcode of the WFI instruction.
+ */
+#define __WFI __inst_arm_thumb16(0xe320f003, 0xbf30)
 
 static inline void cpu_enter_lowpower(void)
 {
@@ -64,7 +70,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		/*
 		 * here's the WFI
 		 */
-		asm(".word	0xe320f003\n"
+		asm(__WFI
 		    :
 		    :
 		    : "memory", "cc");
diff --git a/arch/arm/mach-shmobile/hotplug.c b/arch/arm/mach-shmobile/hotplug.c
index b09a0bd..0d7b7d1 100644
--- a/arch/arm/mach-shmobile/hotplug.c
+++ b/arch/arm/mach-shmobile/hotplug.c
@@ -20,6 +20,12 @@
 #include <mach/emev2.h>
 #include <asm/cacheflush.h>
 #include <asm/mach-types.h>
+#include <asm/opcodes.h>
+
+/*
+ * Define opcode of the WFI instruction.
+ */
++#define __WFI __inst_arm_thumb16(0xe320f003, 0xbf30)
 
 static cpumask_t dead_cpus;
 
@@ -39,7 +45,7 @@ void shmobile_cpu_die(unsigned int cpu)
 		/*
 		 * here's the WFI
 		 */
-		asm(".word	0xe320f003\n"
+		asm(__WFI
 		    :
 		    :
 		    : "memory", "cc");
--
