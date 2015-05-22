From: atull@opensource.altera.com (Alan Tull)
Date: Fri, 22 May 2015 13:02:14 -0500
Subject: [PATCH v4 1/2] ARM: socfpga: support suspend to ram
In-Reply-To: <1432317735-29413-1-git-send-email-atull@opensource.altera.com>
References: <1432317735-29413-1-git-send-email-atull@opensource.altera.com>
Message-ID: <1432317735-29413-2-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code that requests that the sdr controller go into
self-refresh mode.  This code is run from ocram.

This patch assumes that u-boot has already configured sdr:
  sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
  sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
  sdr.ctrlcfg.dramtiming4.selfrfshexit = 512

Suspend-to-RAM and EDAC support are mutually exclusive on SOCFPGA
platforms.  CONFIG_SOCFPGA_SUSPEND enables suspend-to-RAM and
prevents selecting CONFIG_EDAC_ALTERA_MC.

How to suspend to ram:
 $ echo enabled > \
/sys/devices/soc/ffc02000.serial0/tty/ttyS0/power/wakeup

 $ echo -n mem > /sys/power/state

Signed-off-by: Alan Tull <atull@opensource.altera.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
v2: use Generic on-chip SRAM driver to allocate ocram
    rm fncpy_align since generic allocator handles alignment
    check __arm_ioremap_exec return code
    check for NULL pointers
    add a comment regarding sdram controller configuration
v3: fix renamed #define
    propagate socfpga_setup_ocram_self_refresh error code
v4: Kconfig: don't need to select GENERIC_ALLOCATER
    add CONFIG_SOCFPGA_SUSPEND
    make s2r and EDAC support mutually exclusive
    socfpga.c: add sdr_ctl_base_addr
    return error if ocram not available in device tree
    update copyright years
---
 arch/arm/mach-socfpga/Kconfig        |   10 ++-
 arch/arm/mach-socfpga/Makefile       |    1 +
 arch/arm/mach-socfpga/core.h         |    6 +-
 arch/arm/mach-socfpga/pm.c           |  150 ++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/self-refresh.S |  157 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c      |    6 +-
 drivers/edac/Kconfig                 |    2 +-
 7 files changed, 328 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/pm.c
 create mode 100644 arch/arm/mach-socfpga/self-refresh.S

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index b5f8d75..b26a684 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_SOCFPGA
+menuconfig ARCH_SOCFPGA
 	bool "Altera SOCFPGA family" if ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
@@ -8,3 +8,11 @@ config ARCH_SOCFPGA
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
 	select MFD_SYSCON
+
+if ARCH_SOCFPGA
+config SOCFPGA_SUSPEND
+	bool "Suspend to RAM on SOCFPGA"
+	help
+	  Select this if you want to enable Suspend-to-RAM on SOCFPGA
+	  platforms.
+endif
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 6dd7a93..b8f9e23 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -4,3 +4,4 @@
 
 obj-y					:= socfpga.o
 obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
+obj-$(CONFIG_SOCFPGA_SUSPEND)	+= pm.o self-refresh.o
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index a0f3b1c..498b271 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -1,6 +1,6 @@
 /*
  * Copyright 2012 Pavel Machek <pavel@denx.de>
- * Copyright (C) 2012 Altera Corporation
+ * Copyright (C) 2012-2015 Altera Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -39,6 +39,10 @@ extern void socfpga_sysmgr_init(void);
 
 extern void __iomem *sys_manager_base_addr;
 extern void __iomem *rst_manager_base_addr;
+extern void __iomem *sdr_ctl_base_addr;
+
+u32 socfpga_sdram_self_refresh(u32 sdr_base, u32 scu_base);
+extern unsigned int socfpga_sdram_self_refresh_sz;
 
 extern struct smp_operations socfpga_smp_ops;
 extern char secondary_trampoline, secondary_trampoline_end;
diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
new file mode 100644
index 0000000..166ac32
--- /dev/null
+++ b/arch/arm/mach-socfpga/pm.c
@@ -0,0 +1,150 @@
+/*
+ *  arch/arm/mach-socfpga/pm.c
+ *
+ * Copyright (C) 2014-2015 Altera Corporation. All rights reserved.
+ *
+ * with code from pm-imx6.c
+ * Copyright 2011-2014 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/bitops.h>
+#include <linux/genalloc.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/suspend.h>
+#include <asm/suspend.h>
+#include <asm/fncpy.h>
+#include "core.h"
+
+/* Pointer to function copied to ocram */
+static u32 (*socfpga_sdram_self_refresh_in_ocram)(u32 sdr_base, u32 scu_base);
+
+static int socfpga_setup_ocram_self_refresh(void)
+{
+	struct platform_device *pdev;
+	phys_addr_t ocram_pbase;
+	struct device_node *np;
+	struct gen_pool *ocram_pool;
+	unsigned long ocram_base;
+	void __iomem *suspend_ocram_base;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL, "mmio-sram");
+	if (!np) {
+		pr_err("%s: Unable to find mmio-sram in dtb\n", __func__);
+		return -ENODEV;
+	}
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		pr_warn("%s: failed to find ocram device!\n", __func__);
+		ret = -ENODEV;
+		goto put_node;
+	}
+
+	ocram_pool = dev_get_gen_pool(&pdev->dev);
+	if (!ocram_pool) {
+		pr_warn("%s: ocram pool unavailable!\n", __func__);
+		ret = -ENODEV;
+		goto put_node;
+	}
+
+	ocram_base = gen_pool_alloc(ocram_pool, socfpga_sdram_self_refresh_sz);
+	if (!ocram_base) {
+		pr_warn("%s: unable to alloc ocram!\n", __func__);
+		ret = -ENOMEM;
+		goto put_node;
+	}
+
+	ocram_pbase = gen_pool_virt_to_phys(ocram_pool, ocram_base);
+
+	suspend_ocram_base = __arm_ioremap_exec(ocram_pbase,
+						socfpga_sdram_self_refresh_sz,
+						false);
+	if (!suspend_ocram_base) {
+		pr_warn("%s: __arm_ioremap_exec failed!\n", __func__);
+		ret = -ENOMEM;
+		goto put_node;
+	}
+
+	/* Copy the code that puts DDR in self refresh to ocram */
+	socfpga_sdram_self_refresh_in_ocram =
+		(void *)fncpy(suspend_ocram_base,
+			      &socfpga_sdram_self_refresh,
+			      socfpga_sdram_self_refresh_sz);
+
+	WARN(!socfpga_sdram_self_refresh_in_ocram,
+	     "could not copy function to ocram");
+	if (!socfpga_sdram_self_refresh_in_ocram)
+		ret = -EFAULT;
+
+put_node:
+	of_node_put(np);
+
+	return ret;
+}
+
+static int socfpga_pm_suspend(unsigned long arg)
+{
+	u32 ret;
+
+	if (!sdr_ctl_base_addr || !socfpga_scu_base_addr)
+		return -EFAULT;
+
+	ret = socfpga_sdram_self_refresh_in_ocram(
+		(u32)sdr_ctl_base_addr, (u32)socfpga_scu_base_addr);
+
+	pr_debug("%s self-refresh loops request=%d exit=%d\n", __func__,
+		 ret & 0xffff, (ret >> 16) & 0xffff);
+
+	return 0;
+}
+
+static int socfpga_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		outer_disable();
+		cpu_suspend(0, socfpga_pm_suspend);
+		outer_resume();
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct platform_suspend_ops socfpga_pm_ops = {
+	.valid	= suspend_valid_only_mem,
+	.enter	= socfpga_pm_enter,
+};
+
+static int __init socfpga_pm_init(void)
+{
+	int ret;
+
+	ret = socfpga_setup_ocram_self_refresh();
+	if (ret)
+		return ret;
+
+	suspend_set_ops(&socfpga_pm_ops);
+	pr_info("SoCFPGA initialized for DDR self-refresh during suspend.\n");
+
+	return 0;
+}
+arch_initcall(socfpga_pm_init);
diff --git a/arch/arm/mach-socfpga/self-refresh.S b/arch/arm/mach-socfpga/self-refresh.S
new file mode 100644
index 0000000..b9f95bc
--- /dev/null
+++ b/arch/arm/mach-socfpga/self-refresh.S
@@ -0,0 +1,157 @@
+/*
+ * Copyright (C) 2014-2015 Altera Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+#define SOCFPGA_SCU_CTRL_OFFS	0
+#define SCU_STANDBY_ENA		0x20
+#define MAX_LOOP_COUNT		1000
+
+/* Register offset */
+#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x54
+#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x58
+
+/* Bitfield positions */
+#define SELFRSHREQ_POS                  3
+#define SELFRSHREQ_MASK                 0x8
+
+#define SELFRFSHACK_POS                 1
+#define SELFRFSHACK_MASK                0x2
+
+	/*
+	 * This code assumes that the bootloader has already
+	 * properly configured the sdram controller:
+	 *
+	 * sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
+	 * sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
+	 * sdr.ctrlcfg.dramtiming4.selfrfshexit = 512
+	 */
+
+	.arch   armv7-a
+	.text
+	.align 3
+
+	/*
+	 * socfpga_sdram_self_refresh
+	 *
+	 *  r0 : sdr_ctl_base_addr
+	 *  r1 : socfpga_scu_base_addr
+	 *  r2 : temp storage of register values
+	 *  r3 : loop counter
+	 *  r4 : temp storage of return value
+	 *
+	 *  return value: lower 16 bits: loop count going into self refresh
+	 *                upper 16 bits: loop count exiting self refresh
+	 */
+ENTRY(socfpga_sdram_self_refresh)
+	stmfd	sp!, {r4}
+
+	/*
+	 * Enable SCU (snoop) standby mode.
+	 *
+	 * From the ARM Cortex-A9 MPCore Technical Reference Manual:
+	 * "When set, SCU CLK is turned off when all processors are in WFI
+	 *  mode, there is no pending request on the ACP (if implemented), and
+	 *  there is no remaining activity in the SCU."
+	 */
+	ldr	r2, [r1, #SOCFPGA_SCU_CTRL_OFFS]
+	orr	r2, r2, #SCU_STANDBY_ENA
+	str	r2, [r1, #SOCFPGA_SCU_CTRL_OFFS]
+
+	/* Enable dynamic clock gating in the Power Control Register. */
+	mrc	p15, 0, r2, c15, c0, 0
+	orr	r2, r2, #1
+	mcr	p15, 0, r2, c15, c0, 0
+
+	/* Enable self refresh: set sdr.ctrlgrp.lowpwreq.selfrshreq = 1 */
+	ldr	r2, [r0, #SDR_CTRLGRP_LOWPWREQ_ADDR]
+	orr	r2, r2, #SELFRSHREQ_MASK
+	str	r2, [r0, #SDR_CTRLGRP_LOWPWREQ_ADDR]
+
+	/* Poll until sdr.ctrlgrp.lowpwrack.selfrfshack == 1 or hit max loops */
+	mov	r3, #0
+while_ack_0:
+	ldr	r2, [r0, #SDR_CTRLGRP_LOWPWRACK_ADDR]
+	and	r2, r2, #SELFRFSHACK_MASK
+	cmp	r2, #SELFRFSHACK_MASK
+	beq	ack_1
+
+	add	r3, #1
+	cmp	r3, #MAX_LOOP_COUNT
+	bne	while_ack_0
+
+ack_1:
+	mov	r4, r3
+
+	/*
+	 * Execute an ISB instruction to ensure that all of the
+	 * CP15 register changes have been committed.
+	 */
+	isb
+
+	/*
+	 * Execute a barrier instruction to ensure that all cache,
+	 * TLB and branch predictor maintenance operations issued
+	 * by any CPU in the cluster have completed.
+	 */
+	dsb
+	dmb
+
+	wfi
+
+	/* Disable self-refresh: set sdr.ctrlgrp.lowpwreq.selfrshreq = 0 */
+	ldr	r2, [r0, #SDR_CTRLGRP_LOWPWREQ_ADDR]
+	bic	r2, r2, #SELFRSHREQ_MASK
+	str	r2, [r0, #SDR_CTRLGRP_LOWPWREQ_ADDR]
+
+	/* Poll until sdr.ctrlgrp.lowpwrack.selfrfshack == 0 or hit max loops */
+	mov	r3, #0
+while_ack_1:
+	ldr	r2, [r0, #SDR_CTRLGRP_LOWPWRACK_ADDR]
+	and	r2, r2, #SELFRFSHACK_MASK
+	cmp	r2, #SELFRFSHACK_MASK
+	bne	ack_0
+
+	add	r3, #1
+	cmp	r3, #MAX_LOOP_COUNT
+	bne	while_ack_1
+
+ack_0:
+	/*
+	 * Prepare return value:
+	 * Shift loop count for exiting self refresh into upper 16 bits.
+	 * Leave loop count for requesting self refresh in lower 16 bits.
+	 */
+	mov	r3, r3, lsl #16
+	add	r4, r4, r3
+
+	/* Disable dynamic clock gating in the Power Control Register. */
+	mrc	p15, 0, r2, c15, c0, 0
+	bic	r2, r2, #1
+	mcr	p15, 0, r2, c15, c0, 0
+
+	/* Disable SCU standby mode */
+	ldr	r2, [r1, #SOCFPGA_SCU_CTRL_OFFS]
+	bic	r2, r2, #SCU_STANDBY_ENA
+	str	r2, [r1, #SOCFPGA_SCU_CTRL_OFFS]
+
+	mov     r0, r4                  @ return value
+	ldmfd	sp!, {r4}
+	bx	lr			@ return
+
+ENDPROC(socfpga_sdram_self_refresh)
+ENTRY(socfpga_sdram_self_refresh_sz)
+	.word	. - socfpga_sdram_self_refresh
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index f5e597c..a807aa0 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2012 Altera Corporation
+ *  Copyright (C) 2012-2015 Altera Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -30,6 +30,7 @@
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
+void __iomem *sdr_ctl_base_addr;
 unsigned long socfpga_cpu1start_addr;
 
 static struct map_desc scu_io_desc __initdata = {
@@ -82,6 +83,9 @@ void __init socfpga_sysmgr_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
 	rst_manager_base_addr = of_iomap(np, 0);
+
+	np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
+	sdr_ctl_base_addr = of_iomap(np, 0);
 }
 
 static void __init socfpga_init_irq(void)
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index cb59619..9b69b97 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -378,7 +378,7 @@ config EDAC_OCTEON_PCI
 
 config EDAC_ALTERA_MC
 	tristate "Altera SDRAM Memory Controller EDAC"
-	depends on EDAC_MM_EDAC && ARCH_SOCFPGA
+	depends on EDAC_MM_EDAC && ARCH_SOCFPGA && !SOCFPGA_SUSPEND
 	help
 	  Support for error detection and correction on the
 	  Altera SDRAM memory controller. Note that the
-- 
1.7.9.5
