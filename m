From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 12 Jul 2012 12:26:15 -0500
Subject: [RFC PATCHv2 1/2] ARM: socfpga: initial support for Altera's SOCFPGA
 platform.
In-Reply-To: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
Message-ID: <1342113976-27140-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Adding core definitions for Altera's SOCFPGA ARM platform.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
---
 MAINTAINERS                                      |    5 +++
 arch/arm/Kconfig                                 |   20 ++++++++++
 arch/arm/Makefile                                |    1 +
 arch/arm/mach-socfpga/clock.c                    |   45 ++++++++++++++++++++++
 arch/arm/mach-socfpga/common.h                   |   23 +++++++++++
 arch/arm/mach-socfpga/include/mach/debug-macro.S |   16 ++++++++
 arch/arm/mach-socfpga/include/mach/iomap.h       |   33 ++++++++++++++++
 arch/arm/mach-socfpga/include/mach/irqs.h        |   24 ++++++++++++
 arch/arm/mach-socfpga/include/mach/timex.h       |   19 +++++++++
 arch/arm/mach-socfpga/include/mach/uncompress.h  |    9 +++++
 10 files changed, 195 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/clock.c
 create mode 100644 arch/arm/mach-socfpga/common.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-socfpga/include/mach/iomap.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/irqs.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/timex.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/uncompress.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 03df1d1..af6cc9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1103,6 +1103,11 @@ S:	Supported
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
 
+ARM/SOCFPGA ARCHITECTURE
+M:	Dinh Nguyen <dinguyen@altera.com>
+S:	Supported
+F:	arch/arm/mach-socfpga/
+
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 57eb6ef..01116e5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -250,6 +250,24 @@ choice
 	prompt "ARM system type"
 	default ARCH_VERSATILE
 
+config ARCH_SOCFPGA
+	bool "Altera SOCFPGA family"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
+	select ARM_GIC
+	select CACHE_L2X0
+	select CLKDEV_LOOKUP
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
@@ -1057,6 +1075,8 @@ source "arch/arm/mach-sa1100/Kconfig"
 source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
 
+source "arch/arm/mach-socfpga/Kconfig"
+
 source "arch/arm/plat-spear/Kconfig"
 
 source "arch/arm/mach-s3c24xx/Kconfig"
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
diff --git a/arch/arm/mach-socfpga/clock.c b/arch/arm/mach-socfpga/clock.c
new file mode 100644
index 0000000..79f3890
--- /dev/null
+++ b/arch/arm/mach-socfpga/clock.c
@@ -0,0 +1,45 @@
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
+#include <linux/clkdev.h>
+
+#define SOCFPGA_MPU_PERIHCLK_FREQ_HZ			(800000000 / 4)
+#define SOCFPGA_L4_MAIN_CLK					(400000000)
+
+struct clk {
+	unsigned long		rate;
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
diff --git a/arch/arm/mach-socfpga/common.h b/arch/arm/mach-socfpga/common.h
new file mode 100644
index 0000000..e66587f
--- /dev/null
+++ b/arch/arm/mach-socfpga/common.h
@@ -0,0 +1,23 @@
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
+extern struct sys_timer socfpga_timer;
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
diff --git a/arch/arm/mach-socfpga/include/mach/iomap.h b/arch/arm/mach-socfpga/include/mach/iomap.h
new file mode 100644
index 0000000..d5f8493
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/iomap.h
@@ -0,0 +1,33 @@
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
+#ifndef __MACH_SOCFPGA_IOMAP_H
+#define __MACH_SOCFPGA_IOMAP_H
+
+#include <asm/sizes.h>
+
+/* macro to get at IO space when running virtually */
+/*
+ * Statically mapped addresses:
+ *
+ * 10xx xxxx -> fbxx xxxx
+ * 1exx xxxx -> fdxx xxxx
+ * 1fxx xxxx -> fexx xxxx
+ */
+#define IO_ADDRESS(x)		(((x) & 0x03ffffff) + 0xfb000000)
+#define __io_address(n)		IOMEM(IO_ADDRESS(n))
+
+#endif
diff --git a/arch/arm/mach-socfpga/include/mach/irqs.h b/arch/arm/mach-socfpga/include/mach/irqs.h
new file mode 100644
index 0000000..5e344db
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/irqs.h
@@ -0,0 +1,24 @@
+/*
+ *  Copyright (C) 2012 Altera Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+
+#ifndef __MACH_IRQS_H
+#define __MACH_IRQS_H
+
+#define IRQ_SOCFPGA_GIC_START	32
+#define IRQ_LOCALWDOG		30
+#define MAX_GIC_NR		1
+
+#endif	/* __MACH_IRQS_H */
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
-- 
1.7.9.5
