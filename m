From: viresh.linux@gmail.com (Viresh Kumar)
Date: Sat, 21 Apr 2012 17:53:25 +0530
Subject: [PATCH V2 03/10] SPEAr13xx: Add source files
In-Reply-To: <cover.1335010373.git.viresh.kumar@st.com>
References: <cover.1335010373.git.viresh.kumar@st.com>
Message-ID: <4a3362a884d1dfa8cdef65a10c97c43be4c17ff6.1335010373.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds source files for SPEAr13xx Machines.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/Kconfig       |   18 +++
 arch/arm/mach-spear13xx/Makefile      |   10 ++
 arch/arm/mach-spear13xx/Makefile.boot |    6 +
 arch/arm/mach-spear13xx/headsmp.S     |   47 ++++++++
 arch/arm/mach-spear13xx/hotplug.c     |  119 ++++++++++++++++++++
 arch/arm/mach-spear13xx/platsmp.c     |  127 +++++++++++++++++++++
 arch/arm/mach-spear13xx/spear1310.c   |   88 +++++++++++++++
 arch/arm/mach-spear13xx/spear1340.c   |  192 ++++++++++++++++++++++++++++++++
 arch/arm/mach-spear13xx/spear13xx.c   |  197 +++++++++++++++++++++++++++++++++
 arch/arm/plat-spear/restart.c         |    5 +
 10 files changed, 809 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/Kconfig
 create mode 100644 arch/arm/mach-spear13xx/Makefile
 create mode 100644 arch/arm/mach-spear13xx/Makefile.boot
 create mode 100644 arch/arm/mach-spear13xx/headsmp.S
 create mode 100644 arch/arm/mach-spear13xx/hotplug.c
 create mode 100644 arch/arm/mach-spear13xx/platsmp.c
 create mode 100644 arch/arm/mach-spear13xx/spear1310.c
 create mode 100644 arch/arm/mach-spear13xx/spear1340.c
 create mode 100644 arch/arm/mach-spear13xx/spear13xx.c

diff --git a/arch/arm/mach-spear13xx/Kconfig b/arch/arm/mach-spear13xx/Kconfig
new file mode 100644
index 0000000..138e891
--- /dev/null
+++ b/arch/arm/mach-spear13xx/Kconfig
@@ -0,0 +1,18 @@
+#
+# SPEAr13XX Machine configuration file
+#
+
+if ARCH_SPEAR13XX
+
+menu "SPEAr13xx Implementations"
+config MACH_SPEAR1310
+	bool "SPEAr1310 Machine support with Device Tree"
+	help
+	  Supports ST SPEAr1310 machine configured via the device-tree
+
+config MACH_SPEAR1340
+	bool "SPEAr1340 Machine support with Device Tree"
+	help
+	  Supports ST SPEAr1340 machine configured via the device-tree
+endmenu
+endif #ARCH_SPEAR13XX
diff --git a/arch/arm/mach-spear13xx/Makefile b/arch/arm/mach-spear13xx/Makefile
new file mode 100644
index 0000000..3435ea7
--- /dev/null
+++ b/arch/arm/mach-spear13xx/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for SPEAr13XX machine series
+#
+
+obj-$(CONFIG_SMP)		+= headsmp.o platsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+
+obj-$(CONFIG_ARCH_SPEAR13XX)	+= spear13xx.o
+obj-$(CONFIG_MACH_SPEAR1310)	+= spear1310.o
+obj-$(CONFIG_MACH_SPEAR1340)	+= spear1340.o
diff --git a/arch/arm/mach-spear13xx/Makefile.boot b/arch/arm/mach-spear13xx/Makefile.boot
new file mode 100644
index 0000000..403efd7
--- /dev/null
+++ b/arch/arm/mach-spear13xx/Makefile.boot
@@ -0,0 +1,6 @@
+zreladdr-y	+= 0x00008000
+params_phys-y	:= 0x00000100
+initrd_phys-y	:= 0x00800000
+
+dtb-$(CONFIG_MACH_SPEAR1310)	+= spear1310-evb.dtb
+dtb-$(CONFIG_MACH_SPEAR1340)	+= spear1340-evb.dtb
diff --git a/arch/arm/mach-spear13xx/headsmp.S b/arch/arm/mach-spear13xx/headsmp.S
new file mode 100644
index 0000000..ed85473
--- /dev/null
+++ b/arch/arm/mach-spear13xx/headsmp.S
@@ -0,0 +1,47 @@
+/*
+ * arch/arm/mach-spear13XX/headsmp.S
+ *
+ * Picked from realview
+ * Copyright (c) 2012 ST Microelectronics Limited
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+
+/*
+ * spear13xx specific entry point for secondary CPUs. This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(spear13xx_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+pen:	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/* re-enable coherency */
+	mrc	p15, 0, r0, c1, c0, 1
+	orr	r0, r0, #(1 << 6) | (1 << 0)
+	mcr	p15, 0, r0, c1, c0, 1
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+
+	.align
+1:	.long	.
+	.long	pen_release
+ENDPROC(spear13xx_secondary_startup)
diff --git a/arch/arm/mach-spear13xx/hotplug.c b/arch/arm/mach-spear13xx/hotplug.c
new file mode 100644
index 0000000..5c6867b
--- /dev/null
+++ b/arch/arm/mach-spear13xx/hotplug.c
@@ -0,0 +1,119 @@
+/*
+ * linux/arch/arm/mach-spear13xx/hotplug.c
+ *
+ * Copyright (C) 2012 ST Microelectronics Ltd.
+ * Deepak Sikri <deepak.sikri@st.com>
+ *
+ * based upon linux/arch/arm/mach-realview/hotplug.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/smp_plat.h>
+
+extern volatile int pen_release;
+
+static inline void cpu_enter_lowpower(void)
+{
+	unsigned int v;
+
+	flush_cache_all();
+	asm volatile(
+	"	mcr	p15, 0, %1, c7, c5, 0\n"
+	"	dsb\n"
+	/*
+	 * Turn off coherency
+	 */
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, #0x20\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, %2\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	: "=&r" (v)
+	: "r" (0), "Ir" (CR_C)
+	: "cc", "memory");
+}
+
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile("mrc	p15, 0, %0, c1, c0, 0\n"
+	"	orr	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	orr	%0, %0, #0x20\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	: "=&r" (v)
+	: "Ir" (CR_C)
+	: "cc");
+}
+
+static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+{
+	for (;;) {
+		wfi();
+
+		if (pen_release == cpu) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+
+		/*
+		 * Getting here, means that we have come out of WFI without
+		 * having been woken up - this shouldn't happen
+		 *
+		 * Just note it happening - when we're woken, we can report
+		 * its occurrence.
+		 */
+		(*spurious)++;
+	}
+}
+
+int platform_cpu_kill(unsigned int cpu)
+{
+	return 1;
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void __cpuinit platform_cpu_die(unsigned int cpu)
+{
+	int spurious = 0;
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+	platform_do_lowpower(cpu, &spurious);
+
+	/*
+	 * bring this CPU back into the world of cache
+	 * coherency, and then restore interrupts
+	 */
+	cpu_leave_lowpower();
+
+	if (spurious)
+		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
+}
+
+int platform_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * we don't allow CPU 0 to be shutdown (it is still too special
+	 * e.g. clock tick interrupts)
+	 */
+	return cpu == 0 ? -EPERM : 0;
+}
diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear13xx/platsmp.c
new file mode 100644
index 0000000..f5d07f2
--- /dev/null
+++ b/arch/arm/mach-spear13xx/platsmp.c
@@ -0,0 +1,127 @@
+/*
+ * arch/arm/mach-spear13xx/platsmp.c
+ *
+ * based upon linux/arch/arm/mach-realview/platsmp.c
+ *
+ * Copyright (C) 2012 ST Microelectronics Ltd.
+ * Shiraz Hashim <shiraz.hashim@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/io.h>
+#include <linux/smp.h>
+#include <asm/cacheflush.h>
+#include <asm/hardware/gic.h>
+#include <asm/smp_scu.h>
+#include <mach/spear.h>
+
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen"
+ */
+volatile int __cpuinitdata pen_release = -1;
+static DEFINE_SPINLOCK(boot_lock);
+
+static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
+extern void spear13xx_secondary_startup(void);
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_secondary_init(0);
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	pen_release = -1;
+	smp_wmb();
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
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
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	pen_release = cpu;
+	flush_cache_all();
+	outer_flush_all();
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
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
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init smp_init_cpus(void)
+{
+	unsigned int i, ncores = scu_get_core_count(scu_base);
+
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+{
+
+	scu_enable(scu_base);
+
+	/*
+	 * Write the address of secondary startup into the system-wide location
+	 * (presently it is in SRAM). The BootMonitor waits until it receives a
+	 * soft interrupt, and then the secondary CPU branches to this address.
+	 */
+	__raw_writel(virt_to_phys(spear13xx_secondary_startup), SYS_LOCATION);
+}
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
new file mode 100644
index 0000000..fefd15b
--- /dev/null
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -0,0 +1,88 @@
+/*
+ * arch/arm/mach-spear13xx/spear1310.c
+ *
+ * SPEAr1310 machine source file
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define pr_fmt(fmt) "SPEAr1310: " fmt
+
+#include <linux/amba/pl022.h>
+#include <linux/of_platform.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+/* Base addresses */
+#define SPEAR1310_SSP1_BASE			UL(0x5D400000)
+#define SPEAR1310_SATA0_BASE			UL(0xB1000000)
+#define SPEAR1310_SATA1_BASE			UL(0xB1800000)
+#define SPEAR1310_SATA2_BASE			UL(0xB4000000)
+
+/* ssp device registration */
+static struct pl022_ssp_controller ssp1_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	.num_chipselect = 3,
+};
+
+/* Add SPEAr1310 auxdata to pass platform data */
+static struct of_dev_auxdata spear1310_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_dma_priv),
+	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC0_BASE, NULL, &dmac_plat_data),
+	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC1_BASE, NULL, &dmac_plat_data),
+	OF_DEV_AUXDATA("arm,pl022", SSP_BASE, NULL, &pl022_plat_data),
+
+	OF_DEV_AUXDATA("arm,pl022", SPEAR1310_SSP1_BASE, NULL, &ssp1_plat_data),
+	{}
+};
+
+static void __init spear1310_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+			spear1310_auxdata_lookup, NULL);
+}
+
+static const char * const spear1310_dt_board_compat[] = {
+	"st,spear1310",
+	"st,spear1310-evb",
+	NULL,
+};
+
+/*
+ * Following will create 16MB static virtual/physical mappings
+ * PHYSICAL		VIRTUAL
+ * 0xD8000000		0xFA000000
+ */
+struct map_desc spear1310_io_desc[] __initdata = {
+	{
+		.virtual	= VA_SPEAR1310_RAS_GRP1_BASE,
+		.pfn		= __phys_to_pfn(SPEAR1310_RAS_GRP1_BASE),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE
+	},
+};
+
+static void __init spear1310_map_io(void)
+{
+	iotable_init(spear1310_io_desc, ARRAY_SIZE(spear1310_io_desc));
+	spear13xx_map_io();
+}
+
+DT_MACHINE_START(SPEAR1310_DT, "ST SPEAr1310 SoC with Flattened Device Tree")
+	.map_io		=	spear1310_map_io,
+	.init_irq	=	spear13xx_dt_init_irq,
+	.handle_irq	=	gic_handle_irq,
+	.timer		=	&spear13xx_timer,
+	.init_machine	=	spear1310_dt_init,
+	.restart	=	spear_restart,
+	.dt_compat	=	spear1310_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear13xx/spear1340.c
new file mode 100644
index 0000000..ee38cbc
--- /dev/null
+++ b/arch/arm/mach-spear13xx/spear1340.c
@@ -0,0 +1,192 @@
+/*
+ * arch/arm/mach-spear13xx/spear1340.c
+ *
+ * SPEAr1340 machine source file
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define pr_fmt(fmt) "SPEAr1340: " fmt
+
+#include <linux/ahci_platform.h>
+#include <linux/amba/serial.h>
+#include <linux/delay.h>
+#include <linux/dw_dmac.h>
+#include <linux/of_platform.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/arch.h>
+#include <mach/dma.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+/* Base addresses */
+#define SPEAR1340_SATA_BASE			UL(0xB1000000)
+#define SPEAR1340_UART1_BASE			UL(0xB4100000)
+
+/* Power Management Registers */
+#define SPEAR1340_PCM_CFG			(VA_MISC_BASE + 0x100)
+#define SPEAR1340_PCM_WKUP_CFG			(VA_MISC_BASE + 0x104)
+#define SPEAR1340_SWITCH_CTR			(VA_MISC_BASE + 0x108)
+
+#define SPEAR1340_PERIP1_SW_RST			(VA_MISC_BASE + 0x318)
+#define SPEAR1340_PERIP2_SW_RST			(VA_MISC_BASE + 0x31C)
+#define SPEAR1340_PERIP3_SW_RST			(VA_MISC_BASE + 0x320)
+
+/* PCIE - SATA configuration registers */
+#define SPEAR1340_PCIE_SATA_CFG			(VA_MISC_BASE + 0x424)
+	/* PCIE CFG MASks */
+	#define SPEAR1340_PCIE_CFG_DEVICE_PRESENT	(1 << 11)
+	#define SPEAR1340_PCIE_CFG_POWERUP_RESET	(1 << 10)
+	#define SPEAR1340_PCIE_CFG_CORE_CLK_EN		(1 << 9)
+	#define SPEAR1340_PCIE_CFG_AUX_CLK_EN		(1 << 8)
+	#define SPEAR1340_SATA_CFG_TX_CLK_EN		(1 << 4)
+	#define SPEAR1340_SATA_CFG_RX_CLK_EN		(1 << 3)
+	#define SPEAR1340_SATA_CFG_POWERUP_RESET	(1 << 2)
+	#define SPEAR1340_SATA_CFG_PM_CLK_EN		(1 << 1)
+	#define SPEAR1340_PCIE_SATA_SEL_PCIE		(0)
+	#define SPEAR1340_PCIE_SATA_SEL_SATA		(1)
+	#define SPEAR1340_SATA_PCIE_CFG_MASK		0xF1F
+	#define SPEAR1340_PCIE_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_PCIE | \
+			SPEAR1340_PCIE_CFG_AUX_CLK_EN | \
+			SPEAR1340_PCIE_CFG_CORE_CLK_EN | \
+			SPEAR1340_PCIE_CFG_POWERUP_RESET | \
+			SPEAR1340_PCIE_CFG_DEVICE_PRESENT)
+	#define SPEAR1340_SATA_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_SATA | \
+			SPEAR1340_SATA_CFG_PM_CLK_EN | \
+			SPEAR1340_SATA_CFG_POWERUP_RESET | \
+			SPEAR1340_SATA_CFG_RX_CLK_EN | \
+			SPEAR1340_SATA_CFG_TX_CLK_EN)
+
+#define SPEAR1340_PCIE_MIPHY_CFG		(VA_MISC_BASE + 0x428)
+	#define SPEAR1340_MIPHY_OSC_BYPASS_EXT		(1 << 31)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV2		(1 << 27)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV4		(2 << 27)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV8		(3 << 27)
+	#define SPEAR1340_MIPHY_PLL_RATIO_TOP(x)	(x << 0)
+	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA \
+			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
+			SPEAR1340_MIPHY_CLK_REF_DIV2 | \
+			SPEAR1340_MIPHY_PLL_RATIO_TOP(60))
+	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK \
+			(SPEAR1340_MIPHY_PLL_RATIO_TOP(120))
+	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE \
+			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
+			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
+
+static struct dw_dma_slave uart1_dma_param[] = {
+	{
+		/* Tx */
+		.cfg_hi = DWC_CFGH_DST_PER(SPEAR1340_DMA_REQ_UART1_TX),
+		.cfg_lo = 0,
+		.src_master = DMA_MASTER_MEMORY,
+		.dst_master = SPEAR1340_DMA_MASTER_UART1,
+	}, {
+		/* Rx */
+		.cfg_hi = DWC_CFGH_SRC_PER(SPEAR1340_DMA_REQ_UART1_RX),
+		.cfg_lo = 0,
+		.src_master = SPEAR1340_DMA_MASTER_UART1,
+		.dst_master = DMA_MASTER_MEMORY,
+	}
+};
+
+static struct amba_pl011_data uart1_data = {
+	.dma_filter = dw_dma_filter,
+	.dma_tx_param = &uart1_dma_param[0],
+	.dma_rx_param = &uart1_dma_param[1],
+};
+
+/* SATA device registration */
+static int sata_miphy_init(struct device *dev, void __iomem *addr)
+{
+	writel(SPEAR1340_SATA_CFG_VAL, SPEAR1340_PCIE_SATA_CFG);
+	writel(SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK,
+			SPEAR1340_PCIE_MIPHY_CFG);
+	/* Switch on sata power domain */
+	writel((readl(SPEAR1340_PCM_CFG) | (0x800)), SPEAR1340_PCM_CFG);
+	msleep(20);
+	/* Disable PCIE SATA Controller reset */
+	writel((readl(SPEAR1340_PERIP1_SW_RST) & (~0x1000)),
+			SPEAR1340_PERIP1_SW_RST);
+	msleep(20);
+
+	return 0;
+}
+
+void sata_miphy_exit(struct device *dev)
+{
+	writel(0, SPEAR1340_PCIE_SATA_CFG);
+	writel(0, SPEAR1340_PCIE_MIPHY_CFG);
+
+	/* Enable PCIE SATA Controller reset */
+	writel((readl(SPEAR1340_PERIP1_SW_RST) | (0x1000)),
+			SPEAR1340_PERIP1_SW_RST);
+	msleep(20);
+	/* Switch off sata power domain */
+	writel((readl(SPEAR1340_PCM_CFG) & (~0x800)), SPEAR1340_PCM_CFG);
+	msleep(20);
+}
+
+int sata_suspend(struct device *dev)
+{
+	if (dev->power.power_state.event == PM_EVENT_FREEZE)
+		return 0;
+
+	sata_miphy_exit(dev);
+
+	return 0;
+}
+
+int sata_resume(struct device *dev)
+{
+	if (dev->power.power_state.event == PM_EVENT_THAW)
+		return 0;
+
+	return sata_miphy_init(dev, NULL);
+}
+
+static struct ahci_platform_data sata_pdata = {
+	.init = sata_miphy_init,
+	.exit = sata_miphy_exit,
+	.suspend = sata_suspend,
+	.resume = sata_resume,
+};
+
+/* Add SPEAr1340 auxdata to pass platform data */
+static struct of_dev_auxdata spear1340_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_dma_priv),
+	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC0_BASE, NULL, &dmac_plat_data),
+	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC1_BASE, NULL, &dmac_plat_data),
+	OF_DEV_AUXDATA("arm,pl022", SSP_BASE, NULL, &pl022_plat_data),
+
+	OF_DEV_AUXDATA("snps,spear-ahci", SPEAR1340_SATA_BASE, NULL,
+			&sata_pdata),
+	OF_DEV_AUXDATA("arm,pl011", SPEAR1340_UART1_BASE, NULL, &uart1_data),
+	{}
+};
+
+static void __init spear1340_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+			spear1340_auxdata_lookup, NULL);
+}
+
+static const char * const spear1340_dt_board_compat[] = {
+	"st,spear1340",
+	"st,spear1340-evb",
+	NULL,
+};
+
+DT_MACHINE_START(SPEAR1340_DT, "ST SPEAr1340 SoC with Flattened Device Tree")
+	.map_io		=	spear13xx_map_io,
+	.init_irq	=	spear13xx_dt_init_irq,
+	.handle_irq	=	gic_handle_irq,
+	.timer		=	&spear13xx_timer,
+	.init_machine	=	spear1340_dt_init,
+	.restart	=	spear_restart,
+	.dt_compat	=	spear1340_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
new file mode 100644
index 0000000..50b349a
--- /dev/null
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -0,0 +1,197 @@
+/*
+ * arch/arm/mach-spear13xx/spear13xx.c
+ *
+ * SPEAr13XX machines common source file
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define pr_fmt(fmt) "SPEAr13xx: " fmt
+
+#include <linux/amba/pl022.h>
+#include <linux/clk.h>
+#include <linux/dw_dmac.h>
+#include <linux/err.h>
+#include <linux/of_irq.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/map.h>
+#include <asm/smp_twd.h>
+#include <mach/dma.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+/* common dw_dma filter routine to be used by peripherals */
+bool dw_dma_filter(struct dma_chan *chan, void *slave)
+{
+	struct dw_dma_slave *dws = (struct dw_dma_slave *)slave;
+
+	if (chan->device->dev == dws->dma_dev) {
+		chan->private = slave;
+		return true;
+	} else {
+		return false;
+	}
+}
+
+/* ssp device registration */
+static struct dw_dma_slave ssp_dma_param[] = {
+	{
+		/* Tx */
+		.cfg_hi = DWC_CFGH_DST_PER(DMA_REQ_SSP0_TX),
+		.cfg_lo = 0,
+		.src_master = DMA_MASTER_MEMORY,
+		.dst_master = DMA_MASTER_SSP0,
+	}, {
+		/* Rx */
+		.cfg_hi = DWC_CFGH_SRC_PER(DMA_REQ_SSP0_RX),
+		.cfg_lo = 0,
+		.src_master = DMA_MASTER_SSP0,
+		.dst_master = DMA_MASTER_MEMORY,
+	}
+};
+
+struct pl022_ssp_controller pl022_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 1,
+	.dma_filter = dw_dma_filter,
+	.dma_rx_param = &ssp_dma_param[1],
+	.dma_tx_param = &ssp_dma_param[0],
+	.num_chipselect = 3,
+};
+
+/* CF device registration */
+struct dw_dma_slave cf_dma_priv = {
+	.cfg_hi = 0,
+	.cfg_lo = 0,
+	.src_master = 0,
+	.dst_master = 0,
+};
+
+/* dmac device registeration */
+struct dw_dma_platform_data dmac_plat_data = {
+	.nr_channels = 8,
+	.chan_allocation_order = CHAN_ALLOCATION_DESCENDING,
+	.chan_priority = CHAN_PRIORITY_DESCENDING,
+};
+
+void __init spear13xx_l2x0_init(void)
+{
+	/*
+	 * 512KB (64KB/way), 8-way associativity, parity supported
+	 *
+	 * FIXME: 9th bit, of Auxillary Controller register must be set
+	 * for some spear13xx devices for stable L2 operation.
+	 *
+	 * Enable Early BRESP, L2 prefetch for Instruction and Data,
+	 * write alloc and 'Full line of zero' options
+	 *
+	 */
+
+	writel_relaxed(0x06, VA_L2CC_BASE + L2X0_PREFETCH_CTRL);
+
+	/*
+	 * Program following latencies in order to make
+	 * SPEAr1340 work at 600 MHz
+	 */
+	writel_relaxed(0x221, VA_L2CC_BASE + L2X0_TAG_LATENCY_CTRL);
+	writel_relaxed(0x441, VA_L2CC_BASE + L2X0_DATA_LATENCY_CTRL);
+	l2x0_init(VA_L2CC_BASE, 0x70A60001, 0xfe00ffff);
+}
+
+/*
+ * Following will create 16MB static virtual/physical mappings
+ * PHYSICAL		VIRTUAL
+ * 0xB3000000		0xFE000000
+ * 0xE0000000		0xFD000000
+ * 0xEC000000		0xFC000000
+ * 0xED000000		0xFB000000
+ */
+struct map_desc spear13xx_io_desc[] __initdata = {
+	{
+		.virtual	= VA_PERIP_GRP2_BASE,
+		.pfn		= __phys_to_pfn(PERIP_GRP2_BASE),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= VA_PERIP_GRP1_BASE,
+		.pfn		= __phys_to_pfn(PERIP_GRP1_BASE),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= VA_A9SM_AND_MPMC_BASE,
+		.pfn		= __phys_to_pfn(A9SM_AND_MPMC_BASE),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= (unsigned long)VA_L2CC_BASE,
+		.pfn		= __phys_to_pfn(L2CC_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE
+	},
+};
+
+/* This will create static memory mapping for selected devices */
+void __init spear13xx_map_io(void)
+{
+	iotable_init(spear13xx_io_desc, ARRAY_SIZE(spear13xx_io_desc));
+}
+
+static void __init spear13xx_clk_init(void)
+{
+	if (of_machine_is_compatible("st,spear1310"))
+		spear1310_clk_init();
+	else if (of_machine_is_compatible("st,spear1340"))
+		spear1340_clk_init();
+	else
+		pr_err("%s: Unknown machine\n", __func__);
+}
+
+static void __init spear13xx_timer_init(void)
+{
+	char pclk_name[] = "osc_24m_clk";
+	struct clk *gpt_clk, *pclk;
+
+	spear13xx_clk_init();
+
+	/* get the system timer clock */
+	gpt_clk = clk_get_sys("gpt0", NULL);
+	if (IS_ERR(gpt_clk)) {
+		pr_err("%s:couldn't get clk for gpt\n", __func__);
+		BUG();
+	}
+
+	/* get the suitable parent clock for timer*/
+	pclk = clk_get(NULL, pclk_name);
+	if (IS_ERR(pclk)) {
+		pr_err("%s:couldn't get %s as parent for gpt\n", __func__,
+				pclk_name);
+		BUG();
+	}
+
+	clk_set_parent(gpt_clk, pclk);
+	clk_put(gpt_clk);
+	clk_put(pclk);
+
+	spear_setup_of_timer();
+	twd_local_timer_of_register();
+}
+
+struct sys_timer spear13xx_timer = {
+	.init = spear13xx_timer_init,
+};
+
+static const struct of_device_id gic_of_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init },
+	{ /* Sentinel */ }
+};
+
+void __init spear13xx_dt_init_irq(void)
+{
+	of_irq_init(gic_of_match);
+}
diff --git a/arch/arm/plat-spear/restart.c b/arch/arm/plat-spear/restart.c
index 4471a23..ea0a613 100644
--- a/arch/arm/plat-spear/restart.c
+++ b/arch/arm/plat-spear/restart.c
@@ -16,6 +16,7 @@
 #include <mach/spear.h>
 #include <mach/generic.h>
 
+#define SPEAR13XX_SYS_SW_RES			(VA_MISC_BASE + 0x204)
 void spear_restart(char mode, const char *cmd)
 {
 	if (mode == 's') {
@@ -23,6 +24,10 @@ void spear_restart(char mode, const char *cmd)
 		soft_restart(0);
 	} else {
 		/* hardware reset, Use on-chip reset capability */
+#ifdef CONFIG_ARCH_SPEAR13XX
+		writel_relaxed(0x01, SPEAR13XX_SYS_SW_RES);
+#else
 		sysctl_soft_reset((void __iomem *)VA_SPEAR_SYS_CTRL_BASE);
+#endif
 	}
 }
-- 
1.7.9
