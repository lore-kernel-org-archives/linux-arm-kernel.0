From: brendanhiggins@google.com (Brendan Higgins)
Date: Mon, 21 Aug 2017 20:35:00 -0700
Subject: [PATCH v1 1/3] arm: npcm: add basic support for Nuvoton BMCs
In-Reply-To: <20170822033502.4100-1-brendanhiggins@google.com>
References: <20170822033502.4100-1-brendanhiggins@google.com>
Message-ID: <20170822033502.4100-2-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds basic support for the Nuvoton NPCM750 BMC.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/arm/Kconfig             |   2 +
 arch/arm/Makefile            |   1 +
 arch/arm/mach-npcm/Kconfig   |  60 +++++++++++++++
 arch/arm/mach-npcm/Makefile  |   3 +
 arch/arm/mach-npcm/headsmp.S | 120 ++++++++++++++++++++++++++++++
 arch/arm/mach-npcm/npcm7xx.c |  34 +++++++++
 arch/arm/mach-npcm/platsmp.c | 170 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 390 insertions(+)
 create mode 100644 arch/arm/mach-npcm/Kconfig
 create mode 100644 arch/arm/mach-npcm/Makefile
 create mode 100644 arch/arm/mach-npcm/headsmp.S
 create mode 100644 arch/arm/mach-npcm/npcm7xx.c
 create mode 100644 arch/arm/mach-npcm/platsmp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 61a0cb15067e..05543f1cfbde 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -782,6 +782,8 @@ source "arch/arm/mach-netx/Kconfig"
 
 source "arch/arm/mach-nomadik/Kconfig"
 
+source "arch/arm/mach-npcm/Kconfig"
+
 source "arch/arm/mach-nspire/Kconfig"
 
 source "arch/arm/plat-omap/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 47d3a1ab08d2..60ca50c7d762 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -191,6 +191,7 @@ machine-$(CONFIG_ARCH_MEDIATEK)		+= mediatek
 machine-$(CONFIG_ARCH_MXS)		+= mxs
 machine-$(CONFIG_ARCH_NETX)		+= netx
 machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
+machine-$(CONFIG_ARCH_NPCM)		+= npcm
 machine-$(CONFIG_ARCH_NSPIRE)		+= nspire
 machine-$(CONFIG_ARCH_OXNAS)		+= oxnas
 machine-$(CONFIG_ARCH_OMAP1)		+= omap1
diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
new file mode 100644
index 000000000000..82714b8a890f
--- /dev/null
+++ b/arch/arm/mach-npcm/Kconfig
@@ -0,0 +1,60 @@
+menuconfig ARCH_NPCM
+	bool "Nuvoton NPCM Architecture"
+	select ARCH_REQUIRE_GPIOLIB
+	select USE_OF
+	select PINCTRL
+	select PINCTRL_NPCM7XX
+
+if ARCH_NPCM
+
+comment "NPCMX50 CPU type"
+
+config CPU_NPCM750
+	depends on ARCH_NPCM
+	bool "Support for NPCM750 BMC CPU (Poleg)"
+	select CACHE_L2X0
+	select CPU_V7
+	select ARM_GIC
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369
+	select USB_EHCI_ROOT_HUB_TT
+	select USB_ARCH_HAS_HCD
+	select USB_ARCH_HAS_EHCI
+	select USB_EHCI_HCD
+	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_HCD
+	select USB
+	select FIQ
+	select CPU_USE_DOMAINS
+	select COMMON_CLK if OF
+	select NPCM750_TIMER
+	select MFD_SYSCON
+	help
+	  Support for single core NPCM750 BMC CPU (Poleg).
+
+	  Single core variant of the Nuvoton NPCM750 BMC based on the Cortex A9.
+
+config CPU_NPCM750_SMP
+	depends on ARCH_NPCM
+	bool "Support for NPCM750 BMC CPU SMP (Poleg)"
+	select HAVE_SMP
+	select HAVE_ARM_SCU
+	select ARM_ERRATA_458693
+	select ARM_ERRATA_742231
+	select ARM_ERRATA_794072
+	select PL310_ERRATA_588369
+	select PL310_ERRATA_727915
+	select ARM_ERRATA_720789
+	select DEBUG_SPINLOCK
+	select GENERIC_CLOCKEVENTS
+	select SMP
+	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_SCU if SMP
+	select CLKDEV_LOOKUP
+	select COMMON_CLK if OF
+	help
+	  Support for dual core NPCM750 BMC CPU (Poleg).
+
+	  Dual core variant of the Nuvoton NPCM750 BMC based on the Cortex A9.
+
+endif
diff --git a/arch/arm/mach-npcm/Makefile b/arch/arm/mach-npcm/Makefile
new file mode 100644
index 000000000000..e7d27340f968
--- /dev/null
+++ b/arch/arm/mach-npcm/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+
+obj-$(CONFIG_ARCH_NPCM)		+= npcm7xx.o
diff --git a/arch/arm/mach-npcm/headsmp.S b/arch/arm/mach-npcm/headsmp.S
new file mode 100644
index 000000000000..d22d2fc1a35c
--- /dev/null
+++ b/arch/arm/mach-npcm/headsmp.S
@@ -0,0 +1,120 @@
+/*
+ * linux/arch/arm/mach-realview/headsmp.S
+ *
+ * Copyright (c) 2003 ARM Limited
+ * Copyright 2017 Google, Inc.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+.equ SVC_MODE, 0x13
+.equ I_BIT, 0x80
+.equ F_BIT, 0x40
+
+ENTRY(npcm7xx_wakeup_z1)
+	stmfd	sp!, {r0-r12, lr}
+	ldr	r0, =0x01
+	ldr	r1, =0x01
+	ldr	r2, =0x01
+
+	and	r3, r0, #0x0F /* Mask off unused bits of ID, and move to r3 */
+	and	r1, r1, #0x0F /* Mask off unused bits of target_filter */
+	and	r2, r2, #0x0F /* Mask off unused bits of filter_list */
+
+	orr	r3, r3, r1, LSL #16 /* Combine ID and target_filter */
+	orr	r3, r3, r2, LSL #24 /* and now the filter list */
+
+	/* Get the address of the GIC */
+	mrc	p15, 4, r0, c15, c0, 0 /* Read periph base address */
+	add	r0, r0, #0x1F00 /* Add offset of the sgi_trigger reg */
+
+	/* Write to the Software Generated Interrupt Register (ICDSGIR) */
+	str	r3, [r0]
+
+	ldmfd	sp!, {r0-r12, pc}
+ENDPROC(npcm7xx_wakeup_z1)
+
+ENTRY(v7_invalidate_l1_npcmX50)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0 /* invalidate I cache */
+	mcr	p15, 2, r0, c0, c0, 0
+	mrc	p15, 1, r0, c0, c0, 0
+
+	ldr	r1, =0x7fff
+	and	r2, r1, r0, lsr #13
+
+	ldr	r1, =0x3ff
+
+	and	r3, r1, r0, lsr #3 /* NumWays - 1 */
+	add	r2, r2, #1         /* NumSets */
+
+	and	r0, r0, #0x7
+	add	r0, r0, #4 /* SetShift */
+
+	clz	r1, r3     /* WayShift */
+	add	r4, r3, #1 /* NumWays */
+1:	sub	r2, r2, #1 /* NumSets-- */
+	mov	r3, r4     /* Temp = NumWays */
+2:	subs	r3, r3, #1 /* Temp-- */
+	mov	r5, r3, lsl r1
+	mov	r6, r2, lsl r0
+	/* Reg = (Temp << WayShift) | (NumSets << SetShift) */
+	orr	r5, r5, r6
+	mcr	p15, 0, r5, c7, c6, 2
+	bgt	2b
+	cmp	r2, #0
+	bgt	1b
+	dsb
+	isb
+	mov	pc, lr
+ENDPROC(v7_invalidate_l1_npcmX50)
+
+/*
+ * MSM specific entry point for secondary CPUs.  This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(npcm7xx_secondary_startup)
+	msr	CPSR_c, #(SVC_MODE)
+
+	bl	v7_invalidate_l1_npcmX50
+	/* disable vector table remapping */
+	mrc	p15, 0,r0, c1, c0, 0
+	and	r0, #0xffffdfff
+	mcr	p15, 0,r0, c1, c0, 0
+
+#ifdef CONFIG_CACHE_L2X0
+	/* Enable L1 & L2 prefetch + Zero line */
+	mrc	p15, 0, r0, c1, c0, 1
+	orr	r0, r0, #(7 << 1)
+	mcr	p15, 0, r0, c1, c0, 1
+#endif /* CONFIG_CACHE_L2X0 */
+
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+	str r3,[r2]
+
+pen:	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+ENDPROC(npcm7xx_secondary_startup)
+
+	.align
+1:	.long	.
+	.long	pen_release
diff --git a/arch/arm/mach-npcm/npcm7xx.c b/arch/arm/mach-npcm/npcm7xx.c
new file mode 100644
index 000000000000..8ff4b269db14
--- /dev/null
+++ b/arch/arm/mach-npcm/npcm7xx.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2014 Nuvoton Technology corporation.
+ * Copyright 2017 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation;version 2 of the License.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <asm/mach/map.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#define NPCM7XX_AUX_VAL (L310_AUX_CTRL_INSTR_PREFETCH |			       \
+			 L310_AUX_CTRL_DATA_PREFETCH |			       \
+			 L310_AUX_CTRL_NS_LOCKDOWN |			       \
+			 L310_AUX_CTRL_CACHE_REPLACE_RR |		       \
+			 L2C_AUX_CTRL_SHARED_OVERRIDE |			       \
+			 L310_AUX_CTRL_FULL_LINE_ZERO)
+
+static const char *const npcm7xx_dt_match[] = {
+	"nuvoton,npcm7xx",
+	NULL
+};
+
+DT_MACHINE_START(NPCM7XX_DT, "NPCMX50 Chip family")
+	.atag_offset	= 0x100,
+	.dt_compat	= npcm7xx_dt_match,
+	.l2c_aux_val	= NPCM7XX_AUX_VAL,
+	.l2c_aux_mask	= ~NPCM7XX_AUX_VAL,
+MACHINE_END
diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
new file mode 100644
index 000000000000..181a71510acb
--- /dev/null
+++ b/arch/arm/mach-npcm/platsmp.c
@@ -0,0 +1,170 @@
+/*
+ * Copyright (C) 2002 ARM Ltd.
+ * Copyright (C) 2008 STMicroelctronics.
+ * Copyright (C) 2009 ST-Ericsson.
+ * Copyright 2017 Google, Inc.
+ *
+ * This file is based on arm realview platform
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <asm/cacheflush.h>
+#include <asm/smp.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+
+#define NPCM7XX_SCRPAD_REG 0x13c
+
+static void __iomem *gcr_base;
+static void __iomem *scu_base;
+
+/* This is called from headsmp.S to wakeup the secondary core */
+extern void npcm7xx_secondary_startup(void);
+extern void npcm7xx_wakeup_z1(void);
+
+/*
+ * Write pen_release in a way that is guaranteed to be visible to all
+ * observers, irrespective of whether they're taking part in coherency
+ * or not.  This is necessary for the hotplug code to work reliably.
+ */
+static void npcm7xx_write_pen_release(int val)
+{
+	pen_release = val;
+	/* write to pen_release must be visible to all observers. */
+	smp_wmb();
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+}
+
+static DEFINE_SPINLOCK(boot_lock);
+
+static void npcm7xx_smp_secondary_init(unsigned int cpu)
+{
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	npcm7xx_write_pen_release(-1);
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+static int npcm7xx_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 */
+	npcm7xx_write_pen_release(cpu_logical_map(cpu));
+	iowrite32(virt_to_phys(npcm7xx_secondary_startup),
+		  gcr_base + NPCM7XX_SCRPAD_REG);
+	/* make npcm7xx_secondary_startup visible to all observers. */
+	smp_rmb();
+
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+	timeout  = jiffies + (HZ * 1);
+	while (time_before(jiffies, timeout)) {
+		/* make sure we see any writes to pen_release. */
+		smp_rmb();
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return pen_release != -1 ? -EIO : 0;
+}
+
+
+static void __init npcm7xx_wakeup_secondary(void)
+{
+	/*
+	 * write the address of secondary startup into the backup ram register
+	 * at offset 0x1FF4, then write the magic number 0xA1FEED01 to the
+	 * backup ram register at offset 0x1FF0, which is what boot rom code
+	 * is waiting for. This would wake up the secondary core from WFE
+	 */
+	iowrite32(virt_to_phys(npcm7xx_secondary_startup), gcr_base +
+		  NPCM7XX_SCRPAD_REG);
+	/* make sure npcm7xx_secondary_startup is seen by all observers. */
+	smp_wmb();
+	dsb_sev();
+
+	/* make sure write buffer is drained */
+	mb();
+}
+
+static void __init npcm7xx_smp_init_cpus(void)
+{
+	struct device_node *gcr_np, *scu_np;
+	unsigned int i, ncores;
+
+	gcr_np = of_find_compatible_node(NULL, NULL, "nuvoton,npcm750-gcr");
+	gcr_base = of_iomap(gcr_np, 0);
+	if (IS_ERR(gcr_base)) {
+		pr_err("no gcr device node: %ld\n", PTR_ERR(gcr_base));
+		return;
+	}
+
+	scu_np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+	scu_base = of_iomap(scu_np, 0);
+	if (IS_ERR(scu_base)) {
+		pr_err("no scu device node: %ld\n", PTR_ERR(scu_base));
+		return;
+	}
+
+	ncores = scu_get_core_count(scu_base);
+
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+static void __init npcm7xx_smp_prepare_cpus(unsigned int max_cpus)
+{
+	scu_enable(scu_base);
+	npcm7xx_wakeup_secondary();
+}
+
+static struct smp_operations npcm7xx_smp_ops __initdata = {
+	.smp_init_cpus    = npcm7xx_smp_init_cpus,
+	.smp_prepare_cpus = npcm7xx_smp_prepare_cpus,
+	.smp_boot_secondary = npcm7xx_smp_boot_secondary,
+	.smp_secondary_init = npcm7xx_smp_secondary_init,
+};
+
+CPU_METHOD_OF_DECLARE(npcm7xx_smp, "nuvoton,npcm7xx-smp", &npcm7xx_smp_ops);
-- 
2.14.1.480.gb18f417b89-goog
