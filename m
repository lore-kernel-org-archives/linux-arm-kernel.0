From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 28 Mar 2014 14:07:04 +0100
Subject: [PATCH 08/10] ARM: mvebu: add workaround for SMP support for Armada
 375 stepping Z1
In-Reply-To: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396012026-5997-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Due to internal bootrom issue, CPU[1] initial jump code (four
instructions) should be placed in SRAM memory of the SoC. In order to
achieve this, we have to unmap the BootROM and at some specific
location where the BootROM was place, create a specific MBus window
for the SRAM. This SRAM is initialized with a few instructions of code
that allows to jump into the real secondary CPU boot address.

This workaround will most likely be disabled when newer steppings of
the Armada 375 will be made available, in which case a dynamic test
based on mvebu-soc-id will be added.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/headsmp-a9.S | 12 ++++++++++++
 arch/arm/mach-mvebu/platsmp-a9.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
index 78e66c9..5925366 100644
--- a/arch/arm/mach-mvebu/headsmp-a9.S
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@ -16,6 +16,18 @@
 #include <linux/init.h>
 
 	__CPUINIT
+#define CPU_RESUME_ADDR_REG 0xf10182d4
+
+.global armada_375_smp_cpu1_enable_code_start
+.global armada_375_smp_cpu1_enable_code_end
+
+armada_375_smp_cpu1_enable_code_start:
+	ldr     r0, [pc, #4]
+	ldr     r1, [r0]
+	mov     pc, r1
+	.word   CPU_RESUME_ADDR_REG
+armada_375_smp_cpu1_enable_code_end:
+
 ENTRY(mvebu_cortex_a9_secondary_startup)
 	bl      v7_invalidate_l1
 	b	secondary_startup
diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
index f29eb95..6c311de 100644
--- a/arch/arm/mach-mvebu/platsmp-a9.c
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -16,11 +16,36 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/mbus.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 #include "common.h"
 #include "pmsu.h"
 
+#define CRYPT0_ENG_ID   41
+#define CRYPT0_ENG_ATTR 0x1
+#define SRAM_PHYS_BASE  0xFFFF0000
+
+#define BOOTROM_BASE    0xFFF00000
+#define BOOTROM_SIZE    0x100000
+
+extern unsigned char armada_375_smp_cpu1_enable_code_end;
+extern unsigned char armada_375_smp_cpu1_enable_code_start;
+
+void armada_375_smp_cpu1_enable_wa(void)
+{
+	void __iomem *sram_virt_base;
+
+	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
+	mvebu_mbus_add_window_by_id(CRYPT0_ENG_ID, CRYPT0_ENG_ATTR,
+				SRAM_PHYS_BASE, SZ_64K);
+	sram_virt_base = ioremap(SRAM_PHYS_BASE, SZ_64K);
+
+	memcpy(sram_virt_base, &armada_375_smp_cpu1_enable_code_start,
+	       &armada_375_smp_cpu1_enable_code_end
+	       - &armada_375_smp_cpu1_enable_code_start);
+}
+
 extern void mvebu_cortex_a9_secondary_startup(void);
 
 static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
@@ -55,7 +80,14 @@ static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
 	return 0;
 }
 
+static void __init mvebu_cortex_a9_smp_prepare_cpus(unsigned int max_cpus)
+{
+	if (of_machine_is_compatible("marvell,armada375"))
+		armada_375_smp_cpu1_enable_wa();
+}
+
 struct smp_operations mvebu_cortex_a9_smp_ops __initdata = {
+	.smp_prepare_cpus	= mvebu_cortex_a9_smp_prepare_cpus,
 	.smp_boot_secondary	= mvebu_cortex_a9_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= armada_xp_cpu_die,
-- 
1.8.3.2
