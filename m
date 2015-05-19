From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 19 May 2015 17:12:56 +0100
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
Message-ID: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All ARMv5 and older CPUs invalidate their caches in the early assembly
setup function, prior to enabling the MMU.  This is because the L1
cache should not contain any data relevant to the execution of the
kernel at this point; all data should have been flushed out to memory.

This requirement should also be true for ARMv6 and ARMv7 CPUs - indeed,
these typically do not search their caches when caching is disabled (as
it needs to be when the MMU is disabled) so this change should be safe.

ARMv7 allows there to be CPUs which search their caches while caching is
disabled, and it's permitted that the cache is uninitialised at boot;
for these, the architecture reference manual requires that an
implementation specific code sequence is used immediately after reset
to ensure that the cache is placed into a sane state.  Such
functionality is definitely outside the remit of the Linux kernel, and
must be done by the SoC's firmware before _any_ CPU gets to the Linux
kernel.

Changing the data cache clean+invalidate to a mere invalidate allows us
to get rid of a lot of platform specific hacks around this issue for
their secondary CPU bringup paths - some of which were buggy.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-bcm/Makefile            |  2 +-
 arch/arm/mach-bcm/brcmstb.h           | 19 -------------------
 arch/arm/mach-bcm/headsmp-brcmstb.S   | 33 ---------------------------------
 arch/arm/mach-bcm/platsmp-brcmstb.c   |  4 +---
 arch/arm/mach-berlin/headsmp.S        |  6 ------
 arch/arm/mach-berlin/platsmp.c        |  3 +--
 arch/arm/mach-hisi/Makefile           |  2 +-
 arch/arm/mach-hisi/core.h             |  1 -
 arch/arm/mach-hisi/headsmp.S          | 16 ----------------
 arch/arm/mach-hisi/platsmp.c          |  4 ++--
 arch/arm/mach-imx/headsmp.S           |  1 -
 arch/arm/mach-mvebu/headsmp-a9.S      |  1 -
 arch/arm/mach-prima2/headsmp.S        |  1 -
 arch/arm/mach-rockchip/core.h         |  1 -
 arch/arm/mach-rockchip/headsmp.S      |  8 --------
 arch/arm/mach-rockchip/platsmp.c      |  5 ++---
 arch/arm/mach-shmobile/common.h       |  1 -
 arch/arm/mach-shmobile/headsmp-scu.S  |  4 ++--
 arch/arm/mach-shmobile/headsmp.S      |  7 -------
 arch/arm/mach-shmobile/platsmp-apmu.c |  2 +-
 arch/arm/mach-socfpga/core.h          |  1 -
 arch/arm/mach-socfpga/headsmp.S       |  5 -----
 arch/arm/mach-socfpga/platsmp.c       |  2 +-
 arch/arm/mach-tegra/Makefile          |  2 +-
 arch/arm/mach-tegra/headsmp.S         | 12 ------------
 arch/arm/mach-tegra/reset.c           |  2 +-
 arch/arm/mach-tegra/reset.h           |  1 -
 arch/arm/mach-zynq/common.h           |  2 --
 arch/arm/mach-zynq/headsmp.S          |  5 -----
 arch/arm/mach-zynq/platsmp.c          |  5 ++---
 arch/arm/mm/proc-v7.S                 |  2 +-
 31 files changed, 17 insertions(+), 143 deletions(-)
 delete mode 100644 arch/arm/mach-bcm/brcmstb.h
 delete mode 100644 arch/arm/mach-bcm/headsmp-brcmstb.S
 delete mode 100644 arch/arm/mach-hisi/headsmp.S
 delete mode 100644 arch/arm/mach-tegra/headsmp.S

diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 4c38674c73ec..54d274da7ccb 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -43,5 +43,5 @@ obj-$(CONFIG_ARCH_BCM_63XX)	:= bcm63xx.o
 ifeq ($(CONFIG_ARCH_BRCMSTB),y)
 CFLAGS_platsmp-brcmstb.o	+= -march=armv7-a
 obj-y				+= brcmstb.o
-obj-$(CONFIG_SMP)		+= headsmp-brcmstb.o platsmp-brcmstb.o
+obj-$(CONFIG_SMP)		+= platsmp-brcmstb.o
 endif
diff --git a/arch/arm/mach-bcm/brcmstb.h b/arch/arm/mach-bcm/brcmstb.h
deleted file mode 100644
index ec0c3d112b36..000000000000
--- a/arch/arm/mach-bcm/brcmstb.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Copyright (C) 2013-2014 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __BRCMSTB_H__
-#define __BRCMSTB_H__
-
-void brcmstb_secondary_startup(void);
-
-#endif /* __BRCMSTB_H__ */
diff --git a/arch/arm/mach-bcm/headsmp-brcmstb.S b/arch/arm/mach-bcm/headsmp-brcmstb.S
deleted file mode 100644
index 199c1ea58248..000000000000
--- a/arch/arm/mach-bcm/headsmp-brcmstb.S
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * SMP boot code for secondary CPUs
- * Based on arch/arm/mach-tegra/headsmp.S
- *
- * Copyright (C) 2010 NVIDIA, Inc.
- * Copyright (C) 2013-2014 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <asm/assembler.h>
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-        .section ".text.head", "ax"
-
-ENTRY(brcmstb_secondary_startup)
-        /*
-         * Ensure CPU is in a sane state by disabling all IRQs and switching
-         * into SVC mode.
-         */
-        setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r0
-
-        bl      v7_invalidate_l1
-        b       secondary_startup
-ENDPROC(brcmstb_secondary_startup)
diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
index e209e6fc7caf..44d6bddf7a4e 100644
--- a/arch/arm/mach-bcm/platsmp-brcmstb.c
+++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
@@ -30,8 +30,6 @@
 #include <asm/mach-types.h>
 #include <asm/smp_plat.h>
 
-#include "brcmstb.h"
-
 enum {
 	ZONE_MAN_CLKEN_MASK		= BIT(0),
 	ZONE_MAN_RESET_CNTL_MASK	= BIT(1),
@@ -153,7 +151,7 @@ static void brcmstb_cpu_boot(u32 cpu)
 	 * Set the reset vector to point to the secondary_startup
 	 * routine
 	 */
-	cpu_set_boot_addr(cpu, virt_to_phys(brcmstb_secondary_startup));
+	cpu_set_boot_addr(cpu, virt_to_phys(secondary_startup));
 
 	/* Unhalt the cpu */
 	cpu_rst_cfg_set(cpu, 0);
diff --git a/arch/arm/mach-berlin/headsmp.S b/arch/arm/mach-berlin/headsmp.S
index 4a4c56a58ad3..dc82a3486b05 100644
--- a/arch/arm/mach-berlin/headsmp.S
+++ b/arch/arm/mach-berlin/headsmp.S
@@ -12,12 +12,6 @@
 #include <linux/init.h>
 #include <asm/assembler.h>
 
-ENTRY(berlin_secondary_startup)
- ARM_BE8(setend be)
-	bl	v7_invalidate_l1
-	b       secondary_startup
-ENDPROC(berlin_secondary_startup)
-
 /*
  * If the following instruction is set in the reset exception vector, CPUs
  * will fetch the value of the software reset address vector when being
diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index 702e7982015a..34a3753e7356 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -22,7 +22,6 @@
 #define RESET_VECT		0x00
 #define SW_RESET_ADDR		0x94
 
-extern void berlin_secondary_startup(void);
 extern u32 boot_inst;
 
 static void __iomem *cpu_ctrl;
@@ -85,7 +84,7 @@ static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
 	 * Write the secondary startup address into the SW reset address
 	 * vector. This is used by boot_inst.
 	 */
-	writel(virt_to_phys(berlin_secondary_startup), vectors_base + SW_RESET_ADDR);
+	writel(virt_to_phys(secondary_startup), vectors_base + SW_RESET_ADDR);
 
 	iounmap(vectors_base);
 unmap_scu:
diff --git a/arch/arm/mach-hisi/Makefile b/arch/arm/mach-hisi/Makefile
index 6b7b3033de0b..659db1933ed3 100644
--- a/arch/arm/mach-hisi/Makefile
+++ b/arch/arm/mach-hisi/Makefile
@@ -6,4 +6,4 @@ CFLAGS_platmcpm.o	:= -march=armv7-a
 
 obj-y	+= hisilicon.o
 obj-$(CONFIG_MCPM)		+= platmcpm.o
-obj-$(CONFIG_SMP)		+= platsmp.o hotplug.o headsmp.o
+obj-$(CONFIG_SMP)		+= platsmp.o hotplug.o
diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
index 92a682d8e939..c7648ef1825c 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -12,7 +12,6 @@ extern void hi3xxx_cpu_die(unsigned int cpu);
 extern int hi3xxx_cpu_kill(unsigned int cpu);
 extern void hi3xxx_set_cpu(int cpu, bool enable);
 
-extern void hisi_secondary_startup(void);
 extern struct smp_operations hix5hd2_smp_ops;
 extern void hix5hd2_set_cpu(int cpu, bool enable);
 extern void hix5hd2_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-hisi/headsmp.S b/arch/arm/mach-hisi/headsmp.S
deleted file mode 100644
index 81e35b159e75..000000000000
--- a/arch/arm/mach-hisi/headsmp.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- *  Copyright (c) 2014 Hisilicon Limited.
- *  Copyright (c) 2014 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-	__CPUINIT
-
-ENTRY(hisi_secondary_startup)
-	bl	v7_invalidate_l1
-	b	secondary_startup
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index 8880c8e8b296..51744127db66 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -118,7 +118,7 @@ static int hix5hd2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	phys_addr_t jumpaddr;
 
-	jumpaddr = virt_to_phys(hisi_secondary_startup);
+	jumpaddr = virt_to_phys(secondary_startup);
 	hix5hd2_set_scu_boot_addr(HIX5HD2_BOOT_ADDRESS, jumpaddr);
 	hix5hd2_set_cpu(cpu, true);
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
@@ -156,7 +156,7 @@ static int hip01_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	struct device_node *node;
 
 
-	jumpaddr = virt_to_phys(hisi_secondary_startup);
+	jumpaddr = virt_to_phys(secondary_startup);
 	hip01_set_boot_addr(HIP01_BOOT_ADDRESS, jumpaddr);
 
 	node = of_find_compatible_node(NULL, NULL, "hisilicon,hip01-sysctrl");
diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index de5047c8a6c8..b5e976816b63 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -25,7 +25,6 @@ diag_reg_offset:
 	.endm
 
 ENTRY(v7_secondary_startup)
-	bl	v7_invalidate_l1
 	set_diag_reg
 	b	secondary_startup
 ENDPROC(v7_secondary_startup)
diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
index 08d5ed46b996..48e4c4b3cd1c 100644
--- a/arch/arm/mach-mvebu/headsmp-a9.S
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@ -21,7 +21,6 @@
 
 ENTRY(mvebu_cortex_a9_secondary_startup)
 ARM_BE8(setend	be)
-	bl      v7_invalidate_l1
 	bl	armada_38x_scu_power_up
 	b	secondary_startup
 ENDPROC(mvebu_cortex_a9_secondary_startup)
diff --git a/arch/arm/mach-prima2/headsmp.S b/arch/arm/mach-prima2/headsmp.S
index d86fe33c5f53..209d9fc5c16c 100644
--- a/arch/arm/mach-prima2/headsmp.S
+++ b/arch/arm/mach-prima2/headsmp.S
@@ -15,7 +15,6 @@
  * ready for them to initialise.
  */
 ENTRY(sirfsoc_secondary_startup)
-	bl v7_invalidate_l1
         mrc     p15, 0, r0, c0, c0, 5
         and     r0, r0, #15
         adr     r4, 1f
diff --git a/arch/arm/mach-rockchip/core.h b/arch/arm/mach-rockchip/core.h
index 39bca96b555a..492c048813da 100644
--- a/arch/arm/mach-rockchip/core.h
+++ b/arch/arm/mach-rockchip/core.h
@@ -17,4 +17,3 @@ extern char rockchip_secondary_trampoline;
 extern char rockchip_secondary_trampoline_end;
 
 extern unsigned long rockchip_boot_fn;
-extern void rockchip_secondary_startup(void);
diff --git a/arch/arm/mach-rockchip/headsmp.S b/arch/arm/mach-rockchip/headsmp.S
index 46c22dedf632..d69708b07282 100644
--- a/arch/arm/mach-rockchip/headsmp.S
+++ b/arch/arm/mach-rockchip/headsmp.S
@@ -15,14 +15,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-ENTRY(rockchip_secondary_startup)
-	mrc	p15, 0, r0, c0, c0, 0	@ read main ID register
-	ldr	r1, =0x00000c09		@ Cortex-A9 primary part number
-	teq	r0, r1
-	beq	v7_invalidate_l1
-	b	secondary_startup
-ENDPROC(rockchip_secondary_startup)
-
 ENTRY(rockchip_secondary_trampoline)
 	ldr	pc, 1f
 ENDPROC(rockchip_secondary_trampoline)
diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 5b4ca3c3c879..2e6ab67e2284 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -149,8 +149,7 @@ static int __cpuinit rockchip_boot_secondary(unsigned int cpu,
 		 * sram_base_addr + 8: start address for pc
 		 * */
 		udelay(10);
-		writel(virt_to_phys(rockchip_secondary_startup),
-			sram_base_addr + 8);
+		writel(virt_to_phys(secondary_startup), sram_base_addr + 8);
 		writel(0xDEADBEAF, sram_base_addr + 4);
 		dsb_sev();
 	}
@@ -189,7 +188,7 @@ static int __init rockchip_smp_prepare_sram(struct device_node *node)
 	}
 
 	/* set the boot function for the sram code */
-	rockchip_boot_fn = virt_to_phys(rockchip_secondary_startup);
+	rockchip_boot_fn = virt_to_phys(secondary_startup);
 
 	/* copy the trampoline to sram, that runs during startup of the core */
 	memcpy(sram_base_addr, &rockchip_secondary_trampoline, trampoline_sz);
diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index afc60bad6fd6..476092b86c6e 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -14,7 +14,6 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern int shmobile_smp_cpu_disable(unsigned int cpu);
-extern void shmobile_invalidate_start(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index 69df8bfac167..fa5248c52399 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -22,7 +22,7 @@
  * Boot code for secondary CPUs.
  *
  * First we turn on L1 cache coherency for our CPU. Then we jump to
- * shmobile_invalidate_start that invalidates the cache and hands over control
+ * secondary_startup that invalidates the cache and hands over control
  * to the common ARM startup code.
  */
 ENTRY(shmobile_boot_scu)
@@ -36,7 +36,7 @@ ENTRY(shmobile_boot_scu)
 	bic	r2, r2, r3		@ Clear bits of our CPU (Run Mode)
 	str	r2, [r0, #8]		@ write back
 
-	b	shmobile_invalidate_start
+	b	secondary_startup
 ENDPROC(shmobile_boot_scu)
 
 	.text
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 50c491567e11..330c1fc63197 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -16,13 +16,6 @@
 #include <asm/assembler.h>
 #include <asm/memory.h>
 
-#ifdef CONFIG_SMP
-ENTRY(shmobile_invalidate_start)
-	bl	v7_invalidate_l1
-	b	secondary_startup
-ENDPROC(shmobile_invalidate_start)
-#endif
-
 /*
  * Reset vector for secondary CPUs.
  * This will be mapped at address 0 by SBAR register.
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index f483b560b066..b0790fc32282 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -133,7 +133,7 @@ void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/* For this particular CPU register boot vector */
-	shmobile_smp_hook(cpu, virt_to_phys(shmobile_invalidate_start), 0);
+	shmobile_smp_hook(cpu, virt_to_phys(secondary_startup), 0);
 
 	return apmu_wrap(cpu, apmu_power_on);
 }
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index a0f3b1cd497c..767c09e954a0 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -31,7 +31,6 @@
 
 #define RSTMGR_MPUMODRST_CPU1		0x2     /* CPU1 Reset */
 
-extern void socfpga_secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
 
 extern void socfpga_init_clocks(void);
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index f65ea0af4af3..5bb016427107 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -30,8 +30,3 @@ ENTRY(secondary_trampoline)
 1:	.long	.
 	.long	socfpga_cpu1start_addr
 ENTRY(secondary_trampoline_end)
-
-ENTRY(socfpga_secondary_startup)
-       bl      v7_invalidate_l1
-       b       secondary_startup
-ENDPROC(socfpga_secondary_startup)
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index c64d89b7c0ca..79c5336c569f 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -40,7 +40,7 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
-		writel(virt_to_phys(socfpga_secondary_startup),
+		writel(virt_to_phys(secondary_startup),
 		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x000000ff));
 
 		flush_cache_all();
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index e48a74458c25..fffad2426ee4 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
 endif
-obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
deleted file mode 100644
index 2072e7322c39..000000000000
--- a/arch/arm/mach-tegra/headsmp.S
+++ /dev/null
@@ -1,12 +0,0 @@
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-#include "sleep.h"
-
-        .section ".text.head", "ax"
-
-ENTRY(tegra_secondary_startup)
-        check_cpu_part_num 0xc09, r8, r9
-        bleq    v7_invalidate_l1
-        b       secondary_startup
-ENDPROC(tegra_secondary_startup)
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index 894c5c472184..6fd9db54887e 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -94,7 +94,7 @@ void __init tegra_cpu_reset_handler_init(void)
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
 		*((u32 *)cpu_possible_mask);
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_SECONDARY] =
-		virt_to_phys((void *)tegra_secondary_startup);
+		virt_to_phys((void *)secondary_startup);
 #endif
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index 76a93434c6ee..0aee0129f8d7 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -36,7 +36,6 @@ extern unsigned long __tegra_cpu_reset_handler_data[TEGRA_RESET_DATA_SIZE];
 void __tegra_cpu_reset_handler_start(void);
 void __tegra_cpu_reset_handler(void);
 void __tegra_cpu_reset_handler_end(void);
-void tegra_secondary_startup(void);
 
 #ifdef CONFIG_PM_SLEEP
 #define tegra_cpu_lp1_mask \
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 382c60e9aa16..7038cae95ddc 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -17,8 +17,6 @@
 #ifndef __MACH_ZYNQ_COMMON_H__
 #define __MACH_ZYNQ_COMMON_H__
 
-void zynq_secondary_startup(void);
-
 extern int zynq_slcr_init(void);
 extern int zynq_early_slcr_init(void);
 extern void zynq_slcr_system_reset(void);
diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
index dd8c071941e7..045c72720a4d 100644
--- a/arch/arm/mach-zynq/headsmp.S
+++ b/arch/arm/mach-zynq/headsmp.S
@@ -22,8 +22,3 @@ zynq_secondary_trampoline_jump:
 .globl zynq_secondary_trampoline_end
 zynq_secondary_trampoline_end:
 ENDPROC(zynq_secondary_trampoline)
-
-ENTRY(zynq_secondary_startup)
-	bl	v7_invalidate_l1
-	b	secondary_startup
-ENDPROC(zynq_secondary_startup)
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index 52d768ff7857..f66816c49186 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -87,10 +87,9 @@ int zynq_cpun_start(u32 address, int cpu)
 }
 EXPORT_SYMBOL(zynq_cpun_start);
 
-static int zynq_boot_secondary(unsigned int cpu,
-						struct task_struct *idle)
+static int zynq_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	return zynq_cpun_start(virt_to_phys(zynq_secondary_startup), cpu);
+	return zynq_cpun_start(virt_to_phys(secondary_startup), cpu);
 }
 
 /*
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 003190ae9cd8..0716bbe19872 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -414,7 +414,7 @@ __v7_pj4b_setup:
 __v7_setup:
 	adr	r12, __v7_setup_stack		@ the local stack
 	stmia	r12, {r0-r5, r7, r9, r11, lr}
-	bl      v7_flush_dcache_louis
+	bl      v7_invalidate_l1
 	ldmia	r12, {r0-r5, r7, r9, r11, lr}
 
 	and	r0, r9, #0xff000000		@ ARM?
-- 
2.1.0
