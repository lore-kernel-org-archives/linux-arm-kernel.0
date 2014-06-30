From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 30 Jun 2014 14:09:25 +0200
Subject: [PATCHv2] ARM: mvebu: fix cpuidle implementation to work on
 big-endian systems
Message-ID: <1404130165-3593-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell Armada XP, when a CPU comes back from deep idle state of
cpuidle, it restarts its execution at armada_370_xp_cpu_resume(),
which puts back the CPU into the coherency, and then calls the generic
cpu_resume() function.

While this works on little-endian configurations, it doesn't work on
big-endian configurations because the CPU restarts in little-endian,
and therefore must be switched back to big-endian to operate
properly. To achieve this, a 'setend be' instruction must be executed
in big-endian configurations. However, the ARM_BE8() macro that is
used to implement nice compile-time conditional for ARM LE vs. ARM BE8
is not easily usable in inline assembly.

Therefore, this patch moves the armada_370_xp_cpu_resume() C function,
which was anyway just a block of inline assembly, into a proper
pmsu_ll.S file, and adds the appropriate ARM_BE8(setend be)
instruction.

Without this patch, an Armada XP big endian configuration with cpuidle
enabled fails to boot, as it hangs as soon as one of the CPU hits the
deep idle state.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Jason, as requested, this version has been rebased on top of
3.16-rc3. It should be pushed into the 3.16-rc cycle to fix a big in
the cpuidle implementation affecting big endian configurations. Tested
on little endian and big endian configuration on Armada XP GP.

 arch/arm/mach-mvebu/Makefile  |  2 +-
 arch/arm/mach-mvebu/pmsu.c    |  9 ++-------
 arch/arm/mach-mvebu/pmsu_ll.S | 25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/pmsu_ll.S

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 2ecb828..1636cdb 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -7,7 +7,7 @@ CFLAGS_pmsu.o			:= -march=armv7-a
 obj-y				 += system-controller.o mvebu-soc-id.o
 
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
-obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o
+obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o
 obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
 obj-$(CONFIG_HOTPLUG_CPU)	 += hotplug.o
 endif
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 53a55c8..a1d407c 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -66,6 +66,8 @@ static void __iomem *pmsu_mp_base;
 extern void ll_disable_coherency(void);
 extern void ll_enable_coherency(void);
 
+extern void armada_370_xp_cpu_resume(void);
+
 static struct platform_device armada_xp_cpuidle_device = {
 	.name = "cpuidle-armada-370-xp",
 };
@@ -140,13 +142,6 @@ static void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
 	writel(reg, pmsu_mp_base + L2C_NFABRIC_PM_CTL);
 }
 
-static void armada_370_xp_cpu_resume(void)
-{
-	asm volatile("bl    ll_add_cpu_to_smp_group\n\t"
-		     "bl    ll_enable_coherency\n\t"
-		     "b	    cpu_resume\n\t");
-}
-
 /* No locking is needed because we only access per-CPU registers */
 void armada_370_xp_pmsu_idle_prepare(bool deepidle)
 {
diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
new file mode 100644
index 0000000..fc3de68
--- /dev/null
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2014 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ * Gregory Clement <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/*
+ * This is the entry point through which CPUs exiting cpuidle deep
+ * idle state are going.
+ */
+ENTRY(armada_370_xp_cpu_resume)
+ARM_BE8(setend	be )			@ go BE8 if entered LE
+	bl	ll_add_cpu_to_smp_group
+	bl	ll_enable_coherency
+	b	cpu_resume
+ENDPROC(armada_370_xp_cpu_resume)
+
-- 
2.0.0
