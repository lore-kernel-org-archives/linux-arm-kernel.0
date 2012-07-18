From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 17 Jul 2012 18:50:55 -0600
Subject: [RFC PATCHv3 1/2] ARM: socfpga: initial support for Altera's SOCFPGA
 platform
In-Reply-To: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
References: <1342572656-5205-1-git-send-email-dinguyen@altera.com>
Message-ID: <1342572656-5205-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Adding core definitions for Altera's SOCFPGA ARM platform.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Reviewed-by: Rob Herring <rob.herring@calxeda.com>
---
 MAINTAINERS                                      |   10 ++++
 arch/arm/Kconfig                                 |   19 +++++++
 arch/arm/Makefile                                |    1 +
 arch/arm/mach-socfpga/Makefile                   |    5 ++
 arch/arm/mach-socfpga/Makefile.boot              |    1 +
 arch/arm/mach-socfpga/common.h                   |   24 +++++++++
 arch/arm/mach-socfpga/include/mach/debug-macro.S |   16 ++++++
 arch/arm/mach-socfpga/include/mach/timex.h       |   19 +++++++
 arch/arm/mach-socfpga/include/mach/uncompress.h  |    9 ++++
 arch/arm/mach-socfpga/socfpga.c                  |   62 ++++++++++++++++++++++
 drivers/clk/Makefile                             |    1 +
 drivers/clk/socfpga/Makefile                     |    1 +
 drivers/clk/socfpga/clk.c                        |   47 ++++++++++++++++
 13 files changed, 215 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/Makefile
 create mode 100644 arch/arm/mach-socfpga/Makefile.boot
 create mode 100644 arch/arm/mach-socfpga/common.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-socfpga/include/mach/timex.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-socfpga/socfpga.c
 create mode 100644 drivers/clk/socfpga/Makefile
 create mode 100644 drivers/clk/socfpga/clk.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b71f6c..0239cdb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1103,6 +1103,16 @@ S:	Supported
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
 
+ARM/SOCFPGA ARCHITECTURE
+M:	Dinh Nguyen <dinguyen@altera.com>
+S:	Maintained
+F:	arch/arm/mach-socfpga/
+
+ARM/SOCFPGA CLOCK FRAMEWORK SUPPORT
+M:	Dinh Nguyen <dinguyen@altera.com>
+S:	Maintained
+F:	drivers/clk/socfpga/
+
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 57eb6ef..b9f5fc9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -250,6 +250,25 @@ choice
 	prompt "ARM system type"
 	default ARCH_VERSATILE
 
+config ARCH_SOCFPGA
+	bool "Altera SOCFPGA family"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
+	select ARM_GIC
+	select CACHE_L2X0
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select CPU_V7
+	select DW_APB_TIMER
+	select DW_APB_TIMER_OF
+	select GENERIC_CLOCKEVENTS
+	select GPIO_PL061 if GPIOLIB
+	select HAVE_ARM_SCU
+	select SPARSE_IRQ
+	select USE_OF
+	help
+	  This enables support for Altera SOCFPGA Cyclone V platform
+
 config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
 	select ARM_AMBA
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0298b00..1fe5702 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -193,6 +193,7 @@ machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR600)		:= spear6xx
 machine-$(CONFIG_ARCH_ZYNQ)		:= zynq
+machine-$(CONFIG_ARCH_SOCFPGA) 	:= socfpga
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
new file mode 100644
index 0000000..4fb9324
--- /dev/null
+++ b/arch/arm/mach-socfpga/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y					:= socfpga.o
diff --git a/arch/arm/mach-socfpga/Makefile.boot b/arch/arm/mach-socfpga/Makefile.boot
new file mode 100644
index 0000000..dae9661
--- /dev/null
+++ b/arch/arm/mach-socfpga/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y	:= 0x00008000
diff --git a/arch/arm/mach-socfpga/common.h b/arch/arm/mach-socfpga/common.h
new file mode 100644
index 0000000..edb7bde
--- /dev/null
+++ b/arch/arm/mach-socfpga/common.h
@@ -0,0 +1,24 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __MACH_SOCFPGA_COMMON_H
+#define __MACH_SOCFPGA_COMMON_H
+
+extern struct sys_timer dw_apb_timer;
+extern void socfpga_init_clocks(void);
+
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/debug-macro.S b/arch/arm/mach-socfpga/include/mach/debug-macro.S
new file mode 100644
index 0000000..d6f26d2
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/debug-macro.S
@@ -0,0 +1,16 @@
+/*
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+		.macro	addruart, rp, rv, tmp
+		mov	\rp, #DEBUG_LL_UART_OFFSET
+		orr	\rp, \rp, #0x00c00000
+		orr	\rv, \rp, #0xfe000000	@ virtual base
+		orr	\rp, \rp, #0xff000000	@ physical base
+		.endm
+
diff --git a/arch/arm/mach-socfpga/include/mach/timex.h b/arch/arm/mach-socfpga/include/mach/timex.h
new file mode 100644
index 0000000..43df435
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/timex.h
@@ -0,0 +1,19 @@
+/*
+ *  Copyright (C) 2003 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#define CLOCK_TICK_RATE		(50000000 / 16)
diff --git a/arch/arm/mach-socfpga/include/mach/uncompress.h b/arch/arm/mach-socfpga/include/mach/uncompress.h
new file mode 100644
index 0000000..bbe20e6
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/uncompress.h
@@ -0,0 +1,9 @@
+#ifndef __MACH_UNCOMPRESS_H
+#define __MACH_UNCOMPRESS_H
+
+#define putc(c)
+#define flush()
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
+
+#endif
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
new file mode 100644
index 0000000..022c233
--- /dev/null
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -0,0 +1,62 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/dw_apb_timer.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/arch.h>
+
+#include "common.h"
+
+const static struct of_device_id irq_match[] = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{}
+};
+
+static void __init gic_init_irq(void)
+{
+	of_irq_init(irq_match);
+}
+
+static void socfpga_cyclone5_restart(char mode, const char *cmd)
+{
+	/* TODO: */
+}
+
+static void __init socfpga_cyclone5_init(void)
+{
+	l2x0_of_init(0, ~0UL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	socfpga_init_clocks();
+}
+
+static const char *altera_dt_match[] = {
+	"altr,socfpga",
+	"altr,socfpga-cyclone5",
+	NULL
+};
+
+DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
+	.init_irq	= gic_init_irq,
+	.handle_irq     = gic_handle_irq,
+	.timer		= &dw_apb_timer,
+	.init_machine	= socfpga_cyclone5_init,
+	.restart	= socfpga_cyclone5_restart,
+	.dt_compat	= altera_dt_match,
+MACHINE_END
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index b9a5158..96014e8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
 				   clk-mux.o clk-divider.o clk-fixed-factor.o
 # SoCs specific
 obj-$(CONFIG_ARCH_MXS)		+= mxs/
+obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
new file mode 100644
index 0000000..0303c0b
--- /dev/null
+++ b/drivers/clk/socfpga/Makefile
@@ -0,0 +1 @@
+obj-y += clk.o
diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
new file mode 100644
index 0000000..fcd71aa
--- /dev/null
+++ b/drivers/clk/socfpga/clk.c
@@ -0,0 +1,47 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation <www.altera.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+
+#define SOCFPGA_MPU_PERIHCLK_FREQ_HZ			(800000000 / 4)
+#define SOCFPGA_L4_MAIN_CLK					(400000000)
+
+struct clk {
+	unsigned long rate;
+};
+
+static struct clk apb_pclk = { .rate = 200000000};
+static struct clk i2c_clk = { .rate = 100000000};
+static struct clk spim_clk = { .rate = 100000000};
+static struct clk mpu_pclk = { .rate = SOCFPGA_MPU_PERIHCLK_FREQ_HZ};
+static struct clk l4_main_clk = { .rate = SOCFPGA_L4_MAIN_CLK};
+
+static struct clk_lookup lookups[] = {
+	{ .clk = &apb_pclk, .con_id = "apb_pclk", },
+	{ .clk = &i2c_clk, .dev_id = "ffc04000.i2c", },
+	{ .clk = &i2c_clk, .dev_id = "ffc05000.i2c", },
+	{ .clk = &spim_clk, .dev_id = "dw-spi-mmio.0", },
+	{ .clk = &spim_clk, .dev_id = "dw-spi-mmio.1", },
+	{ .clk = &mpu_pclk, .dev_id = "smp_twd", },
+	{ .clk = &l4_main_clk, .dev_id = "dma-pl330", },
+};
+
+void __init socfpga_init_clocks(void)
+{
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+}
-- 
1.7.9.5
