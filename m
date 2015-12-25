From: slash.tmp@free.fr (Mason)
Date: Fri, 25 Dec 2015 22:49:56 +0100
Subject: [PATCH RFC] ARM: tango4: Fix build issues
Message-ID: <567DBA04.4060709@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Move SMP setup to platsmp.c
Specify the CPU type to the assembler, and only for smc.S

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/mach-tango/Makefile  |  3 ++-
 arch/arm/mach-tango/platsmp.c | 16 ++++++++++++++++
 arch/arm/mach-tango/setup.c   | 14 --------------
 3 files changed, 18 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mach-tango/platsmp.c

diff --git a/arch/arm/mach-tango/Makefile b/arch/arm/mach-tango/Makefile
index 0d7e2b5976e3..d33eab2941cb 100644
--- a/arch/arm/mach-tango/Makefile
+++ b/arch/arm/mach-tango/Makefile
@@ -1,2 +1,3 @@
-asflags-y += -mcpu=cortex-a9
 obj-y += setup.o smc.o
+obj-$(CONFIG_SMP) += platsmp.o
+AFLAGS_smc.o := -Wa,-mcpu=cortex-a9
diff --git a/arch/arm/mach-tango/platsmp.c b/arch/arm/mach-tango/platsmp.c
new file mode 100644
index 000000000000..a18d5a34e2f5
--- /dev/null
+++ b/arch/arm/mach-tango/platsmp.c
@@ -0,0 +1,16 @@
+#include <linux/init.h>
+#include <linux/smp.h>
+#include "smc.h"
+
+static int tango_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	tango_set_aux_boot_addr(virt_to_phys(secondary_startup));
+	tango_start_aux_core(cpu);
+	return 0;
+}
+
+static struct smp_operations tango_smp_ops __initdata = {
+	.smp_boot_secondary	= tango_boot_secondary,
+};
+
+CPU_METHOD_OF_DECLARE(tango4_smp, "sigma,tango4-smp", &tango_smp_ops);
diff --git a/arch/arm/mach-tango/setup.c b/arch/arm/mach-tango/setup.c
index d86900550e63..f14b6c7d255b 100644
--- a/arch/arm/mach-tango/setup.c
+++ b/arch/arm/mach-tango/setup.c
@@ -1,21 +1,7 @@
-#include <linux/smp.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "smc.h"
 
-static int tango4_boot_secondary(unsigned int cpu, struct task_struct *idle)
-{
-	tango_set_aux_boot_addr(virt_to_phys(secondary_startup));
-	tango_start_aux_core(cpu);
-	return 0;
-}
-
-static struct smp_operations tango4_smp_ops __initdata = {
-	.smp_boot_secondary	= tango4_boot_secondary,
-};
-
-CPU_METHOD_OF_DECLARE(tango4_smp, "sigma,tango4-smp", &tango4_smp_ops);
-
 static void tango_l2c_write(unsigned long val, unsigned int reg)
 {
 	if (reg == L2X0_CTRL)
-- 
2.4.3
