From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Jul 2017 19:02:12 +0200
Subject: [PATCH 1/2] ARM: shmobile: Add CA7 arch_timer initialization for
 secondary CPUs
In-Reply-To: <1499187733-1430-1-git-send-email-geert+renesas@glider.be>
References: <1499187733-1430-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499187733-1430-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Cortex-A7, the arch timer CNTVOFF register is uninitialized.
Hence when enabling SMP on r8a7794, the kernel log is spammed with:

    WARNING: Underflow in clocksource 'arch_sys_counter' observed, time update ignored.
	     Please report this, consider using a different clocksource, if possible.
	     Your kernel is probably still fine.

To fix this, wrap the standard secondary_startup routine inside a
routine which initializes CNTVOFF when running on a Cortex-A7.
As the only possibilities are Cortex-A7 or Cortex-A15, checking the low
nibble of the Primary Part Number is sufficient.

The initialization is identical to what is already done for the boot CPU
since commit 9ce3fa6816c2fb59 ("ARM: shmobile: rcar-gen2: Add CA7
arch_timer initialization for r8a7794").

Based on patches by Hisashi Nakamura in the BSP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Makefile       |  1 +
 arch/arm/mach-shmobile/common.h       |  1 +
 arch/arm/mach-shmobile/headsmp-apmu.S | 38 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c |  2 +-
 4 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-shmobile/headsmp-apmu.S

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 64611a1b4276517b..de735444e9f715fd 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_ARCH_R8A7793)	+= regulator-quirk-rcar-gen2.o
 
 # SMP objects
 smp-y				:= $(cpu-y)
+smp-$(CONFIG_ARCH_RCAR_GEN2)	+= headsmp-apmu.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 1a8f7b3ab449db56..6792a07bce761aab 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -11,6 +11,7 @@ extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
 extern bool shmobile_smp_init_fallback_ops(void);
+extern void shmobile_boot_apmu(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
 					  unsigned int max_cpus);
diff --git a/arch/arm/mach-shmobile/headsmp-apmu.S b/arch/arm/mach-shmobile/headsmp-apmu.S
new file mode 100644
index 0000000000000000..52516d81ce98384c
--- /dev/null
+++ b/arch/arm/mach-shmobile/headsmp-apmu.S
@@ -0,0 +1,38 @@
+/*
+ * SMP support for APMU based systems
+ *
+ * Copyright (C) 2014  Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+ENTRY(shmobile_boot_apmu)
+	mrc	p15, 0, r0, c0, c0, 0		/* Get Main ID */
+	ubfx	r1, r0, #4, #4			/* r1=Lo 4bit of Primary Part */
+	cmp	r1, #0x7			/* 0x7 = CA7, 0xf = CA15 */
+	bne	1f
+	/*
+	 * CA7 setup
+	 * CNTVOFF has to be initialized either from non-secure Hypervisor
+	 * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
+	 * then it should be handled by the secure code
+	 */
+	cps	0x16
+	mrc	p15, 0, r1, c1, c1, 0		/* get Secure Config */
+	orr	r0, r1, #1
+	mcr	p15, 0, r0, c1, c1, 0		/* Set Non Secure bit */
+	isb
+	mov	r0, #0
+	mcrr	p15, 4, r0, r0, c14		/* CNTVOFF = 0 */
+	isb
+	mcr	p15, 0, r1, c1, c1, 0		/* Set Secure bit */
+	isb
+	cps	0x13
+1:
+
+	b	secondary_startup
+ENDPROC(shmobile_boot_apmu)
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 3ca2c13346f0cbc3..4422b615a6ee6045 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -204,7 +204,7 @@ void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/* For this particular CPU register boot vector */
-	shmobile_smp_hook(cpu, __pa_symbol(secondary_startup), 0);
+	shmobile_smp_hook(cpu, __pa_symbol(shmobile_boot_apmu), 0);
 
 	return apmu_wrap(cpu, apmu_power_on);
 }
-- 
2.7.4
