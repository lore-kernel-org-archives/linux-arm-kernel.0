From: olof@lixom.net (Olof Johansson)
Date: Fri,  4 Jun 2010 02:10:33 -0500
Subject: [PATCH 01/10] [ARM] tegra: initial tegra support
In-Reply-To: <1275635441-17378-1-git-send-email-olof@lixom.net>
References: <3478yvr76gerav> <1275635441-17378-1-git-send-email-olof@lixom.net>
Message-ID: <1275635441-17378-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Erik Gilling <konkers@android.com>

v2: Fixes from Mike Rapoport
	- remove unused header files (mach/dma.h and mach/nand.h)
	- remove tegra 1 references from Makefile.boot

v2: fixes from Russell King
	- remove mach/io.h include from mach/iomap.h
	- fix whitespace in Kconfig

v2: from Colin Cross
	- fix invalid immediate in debug-macro.S

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Erik Gilling <konkers@android.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/Kconfig                               |   13 ++
 arch/arm/Makefile                              |    1 +
 arch/arm/mach-tegra/Kconfig                    |   53 ++++++
 arch/arm/mach-tegra/Makefile                   |    2 +
 arch/arm/mach-tegra/Makefile.boot              |    3 +
 arch/arm/mach-tegra/board.h                    |   32 ++++
 arch/arm/mach-tegra/common.c                   |   44 +++++
 arch/arm/mach-tegra/include/mach/barriers.h    |   30 ++++
 arch/arm/mach-tegra/include/mach/debug-macro.S |   46 ++++++
 arch/arm/mach-tegra/include/mach/entry-macro.S |  118 ++++++++++++++
 arch/arm/mach-tegra/include/mach/hardware.h    |   24 +++
 arch/arm/mach-tegra/include/mach/io.h          |   79 +++++++++
 arch/arm/mach-tegra/include/mach/iomap.h       |  203 ++++++++++++++++++++++++
 arch/arm/mach-tegra/include/mach/memory.h      |   28 ++++
 arch/arm/mach-tegra/include/mach/system.h      |   39 +++++
 arch/arm/mach-tegra/include/mach/timex.h       |   26 +++
 arch/arm/mach-tegra/include/mach/uncompress.h  |   78 +++++++++
 arch/arm/mach-tegra/include/mach/vmalloc.h     |   28 ++++
 arch/arm/mach-tegra/io.c                       |   78 +++++++++
 arch/arm/mm/Kconfig                            |    2 +-
 20 files changed, 926 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tegra/Kconfig
 create mode 100644 arch/arm/mach-tegra/Makefile
 create mode 100644 arch/arm/mach-tegra/Makefile.boot
 create mode 100644 arch/arm/mach-tegra/board.h
 create mode 100644 arch/arm/mach-tegra/common.c
 create mode 100644 arch/arm/mach-tegra/include/mach/barriers.h
 create mode 100644 arch/arm/mach-tegra/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-tegra/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-tegra/include/mach/hardware.h
 create mode 100644 arch/arm/mach-tegra/include/mach/io.h
 create mode 100644 arch/arm/mach-tegra/include/mach/iomap.h
 create mode 100644 arch/arm/mach-tegra/include/mach/memory.h
 create mode 100644 arch/arm/mach-tegra/include/mach/system.h
 create mode 100644 arch/arm/mach-tegra/include/mach/timex.h
 create mode 100644 arch/arm/mach-tegra/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-tegra/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-tegra/io.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92622eb..388f371 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -575,6 +575,17 @@ config ARCH_NUC93X
 	  Support for Nuvoton (Winbond logic dept.) NUC93X MCU,The NUC93X is a
 	  low-power and high performance MPEG-4/JPEG multimedia controller chip.
 
+config ARCH_TEGRA
+	bool "NVIDIA Tegra"
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
+	select HAVE_CLK
+	select ARCH_HAS_BARRIERS if CACHE_L2X0
+	help
+	  This enables support for NVIDIA Tegra based systems (Tegra APX,
+	  Tegra 6xx and Tegra 2 series).
+
 config ARCH_PNX4008
 	bool "Philips Nexperia PNX4008 Mobile"
 	select CPU_ARM926T
@@ -914,6 +925,8 @@ source "arch/arm/mach-shmobile/Kconfig"
 
 source "arch/arm/plat-stmp3xxx/Kconfig"
 
+source "arch/arm/mach-tegra/Kconfig"
+
 source "arch/arm/mach-u300/Kconfig"
 
 source "arch/arm/mach-ux500/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ed820e7..ddc6cb6 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -172,6 +172,7 @@ machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
 machine-$(CONFIG_ARCH_STMP37XX)		:= stmp37xx
+machine-$(CONFIG_ARCH_TEGRA)		:= tegra
 machine-$(CONFIG_ARCH_U300)		:= u300
 machine-$(CONFIG_ARCH_U8500)		:= ux500
 machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
new file mode 100644
index 0000000..64ab14f
--- /dev/null
+++ b/arch/arm/mach-tegra/Kconfig
@@ -0,0 +1,53 @@
+if ARCH_TEGRA
+
+comment "NVIDIA Tegra options"
+
+choice
+	prompt "Select Tegra processor family for target system"
+
+config ARCH_TEGRA_2x_SOC
+	bool "Tegra 2 family"
+	select CPU_V7
+	select ARM_GIC
+	help
+	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
+	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
+
+endchoice
+
+
+choice
+	prompt "Select Tegra-based product"
+
+config MACH_HARMONY
+       bool "Harmony board"
+       help
+         Support for nVidia Harmony development platform
+
+endchoice
+
+choice
+        prompt "Low-level debug console UART"
+        default TEGRA_DEBUG_UART_NONE
+
+config TEGRA_DEBUG_UART_NONE
+        bool "None"
+
+config TEGRA_DEBUG_UARTA
+        bool "UART-A"
+
+config TEGRA_DEBUG_UARTB
+        bool "UART-B"
+
+config TEGRA_DEBUG_UARTC
+        bool "UART-C"
+
+config TEGRA_DEBUG_UARTD
+        bool "UART-D"
+
+config TEGRA_DEBUG_UARTE
+        bool "UART-E"
+
+endchoice
+
+endif
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
new file mode 100644
index 0000000..81f003d
--- /dev/null
+++ b/arch/arm/mach-tegra/Makefile
@@ -0,0 +1,2 @@
+obj-y                                   += common.o
+obj-y                                   += io.o
diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
new file mode 100644
index 0000000..db52d61
--- /dev/null
+++ b/arch/arm/mach-tegra/Makefile.boot
@@ -0,0 +1,3 @@
+zreladdr-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00008000
+params_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00000100
+initrd_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00800000
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
new file mode 100644
index 0000000..3d06354
--- /dev/null
+++ b/arch/arm/mach-tegra/board.h
@@ -0,0 +1,32 @@
+/*
+ * arch/arm/mach-tegra/board.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_BOARD_H
+#define __MACH_TEGRA_BOARD_H
+
+#include <linux/types.h>
+
+void __init tegra_common_init(void);
+void __init tegra_map_common_io(void);
+void __init tegra_init_irq(void);
+void __init tegra_init_clock(void);
+
+extern struct sys_timer tegra_timer;
+#endif
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
new file mode 100644
index 0000000..20875ee
--- /dev/null
+++ b/arch/arm/mach-tegra/common.c
@@ -0,0 +1,44 @@
+/*
+ * arch/arm/mach-tegra/board-harmony.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/hardware/cache-l2x0.h>
+
+#include <mach/iomap.h>
+
+#include "board.h"
+
+void __init tegra_init_cache(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	void __iomem *p = IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x3000;
+
+	writel(0x331, p + L2X0_TAG_LATENCY_CTRL);
+	writel(0x441, p + L2X0_DATA_LATENCY_CTRL);
+
+	l2x0_init(p, 0x6C080001, 0x8200c3fe);
+#endif
+}
+
+void __init tegra_common_init(void)
+{
+	tegra_init_cache();
+}
diff --git a/arch/arm/mach-tegra/include/mach/barriers.h b/arch/arm/mach-tegra/include/mach/barriers.h
new file mode 100644
index 0000000..cc11517
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/barriers.h
@@ -0,0 +1,30 @@
+/*
+ * arch/arm/mach-realview/include/mach/barriers.h
+ *
+ * Copyright (C) 2010 ARM Ltd.
+ * Written by Catalin Marinas <catalin.marinas@arm.com>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __MACH_BARRIERS_H
+#define __MACH_BARRIERS_H
+
+#include <asm/outercache.h>
+
+#define rmb()		dmb()
+#define wmb()		do { dsb(); outer_sync(); } while (0)
+#define mb()		wmb()
+
+#endif	/* __MACH_BARRIERS_H */
diff --git a/arch/arm/mach-tegra/include/mach/debug-macro.S b/arch/arm/mach-tegra/include/mach/debug-macro.S
new file mode 100644
index 0000000..55a3956
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/debug-macro.S
@@ -0,0 +1,46 @@
+/*
+ * arch/arm/mach-tegra/include/mach/debug-macro.S
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <mach/io.h>
+
+	.macro  addruart,rx, tmp
+        mrc     p15, 0, \rx, c1, c0
+        tst     \rx, #1                 @ MMU enabled?
+        ldreq   \rx, =IO_APB_PHYS       @ physical
+        ldrne   \rx, =IO_APB_VIRT        @ virtual
+#if defined(CONFIG_TEGRA_DEBUG_UART_NONE)
+#error "A debug UART must be selected in the kernel config to use DEBUG_LL"
+#elif defined(CONFIG_TEGRA_DEBUG_UARTA)
+        orr     \rx, \rx, #0x6000
+#elif defined(CONFIG_TEGRA_DEBUG_UARTB)
+	ldr	\tmp, =0x6040
+        orr     \rx, \rx, \tmp
+#elif defined(CONFIG_TEGRA_DEBUG_UARTC)
+        orr     \rx, \rx, #0x6200
+#elif defined(CONFIG_TEGRA_DEBUG_UARTD)
+        orr     \rx, \rx, #0x6300
+#elif defined(CONFIG_TEGRA_DEBUG_UARTE)
+        orr     \rx, \rx, #0x6400
+#endif
+	.endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
+
diff --git a/arch/arm/mach-tegra/include/mach/entry-macro.S b/arch/arm/mach-tegra/include/mach/entry-macro.S
new file mode 100644
index 0000000..2ba9e5c
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/entry-macro.S
@@ -0,0 +1,118 @@
+/* arch/arm/mach-tegra/include/mach/entry-macro.S
+ *
+ * Copyright (C) 2009 Palm, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <mach/iomap.h>
+#include <mach/io.h>
+
+#if defined(CONFIG_ARM_GIC)
+
+#include <asm/hardware/gic.h>
+
+	/* Uses the GIC interrupt controller built into the cpu */
+#define ICTRL_BASE (IO_CPU_VIRT + 0x100)
+
+	.macro	disable_fiq
+	.endm
+
+	.macro	get_irqnr_preamble, base, tmp
+	movw \base, #(ICTRL_BASE & 0x0000ffff)
+	movt \base, #((ICTRL_BASE & 0xffff0000) >> 16)
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	/*
+	 * The interrupt numbering scheme is defined in the
+	 * interrupt controller spec.  To wit:
+	 *
+	 * Interrupts 0-15 are IPI
+	 * 16-28 are reserved
+	 * 29-31 are local.  We allow 30 to be used for the watchdog.
+	 * 32-1020 are global
+	 * 1021-1022 are reserved
+	 * 1023 is "spurious" (no interrupt)
+	 *
+	 * For now, we ignore all local interrupts so only return an interrupt
+	 * if it's between 30 and 1020.  The test_for_ipi routine below will
+	 * pick up on IPIs.
+	 *
+	 * A simple read from the controller will tell us the number of the
+	 * highest priority enabled interrupt.  We then just need to check
+	 * whether it is in the valid range for an IRQ (30-1020 inclusive).
+	 */
+
+	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+
+	/* bits 12-10 = src CPU, 9-0 = int # */
+	ldr     \irqstat, [\base, #GIC_CPU_INTACK]
+
+	ldr		\tmp, =1021
+
+	bic     \irqnr, \irqstat, #0x1c00
+
+	cmp     \irqnr, #29
+	cmpcc	\irqnr, \irqnr
+	cmpne	\irqnr, \tmp
+	cmpcs	\irqnr, \irqnr
+
+	.endm
+
+	/* We assume that irqstat (the raw value of the IRQ acknowledge
+	 * register) is preserved from the macro above.
+	 * If there is an IPI, we immediately signal end of interrupt on the
+	 * controller, since this requires the original irqstat value which
+	 * we won't easily be able to recreate later.
+	 */
+
+	.macro test_for_ipi, irqnr, irqstat, base, tmp
+	bic	\irqnr, \irqstat, #0x1c00
+	cmp	\irqnr, #16
+	strcc	\irqstat, [\base, #GIC_CPU_EOI]
+	cmpcs	\irqnr, \irqnr
+	.endm
+
+	/* As above, this assumes that irqstat and base are preserved.. */
+
+	.macro test_for_ltirq, irqnr, irqstat, base, tmp
+	bic	\irqnr, \irqstat, #0x1c00
+	mov 	\tmp, #0
+	cmp	\irqnr, #29
+	moveq	\tmp, #1
+	streq	\irqstat, [\base, #GIC_CPU_EOI]
+	cmp	\tmp, #0
+	.endm
+
+#else
+	/* legacy interrupt controller for AP16 */
+	.macro	disable_fiq
+	.endm
+
+	.macro	get_irqnr_preamble, base, tmp
+	@ enable imprecise aborts
+	cpsie	a
+	@ EVP base at 0xf010f000
+	mov \base, #0xf0000000
+	orr \base, #0x00100000
+	orr \base, #0x0000f000
+	.endm
+
+	.macro	arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+	ldr \irqnr, [\base, #0x20]	@ EVT_IRQ_STS
+	cmp \irqnr, #0x80
+	.endm
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/hardware.h b/arch/arm/mach-tegra/include/mach/hardware.h
new file mode 100644
index 0000000..6014edf
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/hardware.h
@@ -0,0 +1,24 @@
+/*
+ * arch/arm/mach-tegra/include/mach/hardware.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_HARDWARE_H
+#define __MACH_TEGRA_HARDWARE_H
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
new file mode 100644
index 0000000..35edfc3
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/io.h
@@ -0,0 +1,79 @@
+/*
+ * arch/arm/mach-tegra/include/mach/io.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_IO_H
+#define __MACH_TEGRA_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/* On TEGRA, many peripherals are very closely packed in
+ * two 256MB io windows (that actually only use about 64KB
+ * at the start of each).
+ *
+ * We will just map the first 1MB of each window (to minimize
+ * pt entries needed) and provide a macro to transform physical
+ * io addresses to an appropriate void __iomem *.
+ *
+ */
+
+#define IO_CPU_PHYS     0x50040000
+#define IO_CPU_VIRT     0xFE000000
+#define IO_CPU_SIZE	SZ_16K
+
+#define IO_PPSB_PHYS	0x60000000
+#define IO_PPSB_VIRT	0xFE200000
+#define IO_PPSB_SIZE	SZ_1M
+
+#define IO_APB_PHYS	0x70000000
+#define IO_APB_VIRT	0xFE300000
+#define IO_APB_SIZE	SZ_1M
+
+#define IO_TO_VIRT_BETWEEN(p, st, sz)	((p) >= (st) && (p) < ((st) + (sz)))
+#define IO_TO_VIRT_XLATE(p, pst, vst)	(((p) - (pst) + (vst)))
+
+#define IO_TO_VIRT(n) ( \
+	IO_TO_VIRT_BETWEEN((n), IO_PPSB_PHYS, IO_PPSB_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_PPSB_PHYS, IO_PPSB_VIRT) :	\
+	IO_TO_VIRT_BETWEEN((n), IO_APB_PHYS, IO_APB_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_APB_PHYS, IO_APB_VIRT) :	\
+	IO_TO_VIRT_BETWEEN((n), IO_CPU_PHYS, IO_CPU_SIZE) ?		\
+		IO_TO_VIRT_XLATE((n), IO_CPU_PHYS, IO_CPU_VIRT) :	\
+	0)
+
+#ifndef __ASSEMBLER__
+
+#define __arch_ioremap(p, s, t)	tegra_ioremap(p, s, t)
+#define __arch_iounmap(v)	tegra_iounmap(v)
+
+void __iomem *tegra_ioremap(unsigned long phys, size_t size, unsigned int type);
+void tegra_iounmap(volatile void __iomem *addr);
+
+#define IO_ADDRESS(n) ((void __iomem *) IO_TO_VIRT(n))
+
+static inline void __iomem *__io(unsigned long addr)
+{
+	return (void __iomem *)addr;
+}
+#define __io(a)         __io(a)
+#define __mem_pci(a)    (a)
+
+#endif
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
new file mode 100644
index 0000000..1741f7d
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -0,0 +1,203 @@
+/*
+ * arch/arm/mach-tegra/include/mach/iomap.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_IOMAP_H
+#define __MACH_TEGRA_IOMAP_H
+
+#include <asm/sizes.h>
+
+#define TEGRA_ARM_PERIF_BASE		0x50040000
+#define TEGRA_ARM_PERIF_SIZE		SZ_8K
+
+#define TEGRA_ARM_INT_DIST_BASE		0x50041000
+#define TEGRA_ARM_INT_DIST_SIZE		SZ_4K
+
+#define TEGRA_DISPLAY_BASE		0x54200000
+#define TEGRA_DISPLAY_SIZE		SZ_256K
+
+#define TEGRA_DISPLAY2_BASE		0x54240000
+#define TEGRA_DISPLAY2_SIZE		SZ_256K
+
+#define TEGRA_PRIMARY_ICTLR_BASE	0x60004000
+#define TEGRA_PRIMARY_ICTLR_SIZE	SZ_64
+
+#define TEGRA_SECONDARY_ICTLR_BASE	0x60004100
+#define TEGRA_SECONDARY_ICTLR_SIZE	SZ_64
+
+#define TEGRA_TERTIARY_ICTLR_BASE	0x60004200
+#define TEGRA_TERTIARY_ICTLR_SIZE	SZ_64
+
+#define TEGRA_QUATERNARY_ICTLR_BASE	0x60004300
+#define TEGRA_QUATERNARY_ICTLR_SIZE	SZ_64
+
+#define TEGRA_TMR1_BASE			0x60005000
+#define TEGRA_TMR1_SIZE			SZ_8
+
+#define TEGRA_TMR2_BASE			0x60005008
+#define TEGRA_TMR2_SIZE			SZ_8
+
+#define TEGRA_TMRUS_BASE		0x60005010
+#define TEGRA_TMRUS_SIZE		SZ_64
+
+#define TEGRA_TMR3_BASE			0x60005050
+#define TEGRA_TMR3_SIZE			SZ_8
+
+#define TEGRA_TMR4_BASE			0x60005058
+#define TEGRA_TMR4_SIZE			SZ_8
+
+#define TEGRA_CLK_RESET_BASE		0x60006000
+#define TEGRA_CLK_RESET_SIZE		SZ_4K
+
+#define TEGRA_FLOW_CTRL_BASE		0x60007000
+#define TEGRA_FLOW_CTRL_SIZE		20
+
+#define TEGRA_STATMON_BASE		0x6000C4000
+#define TEGRA_STATMON_SIZE		SZ_1K
+
+#define TEGRA_GPIO_BASE			0x6000D000
+#define TEGRA_GPIO_SIZE			SZ_4K
+
+#define TEGRA_EXCEPTION_VECTORS_BASE    0x6000F000
+#define TEGRA_EXCEPTION_VECTORS_SIZE    SZ_4K
+
+#define TEGRA_APB_MISC_BASE		0x70000000
+#define TEGRA_APB_MISC_SIZE		SZ_4K
+
+#define TEGRA_AC97_BASE			0x70002000
+#define TEGRA_AC97_SIZE			SZ_512
+
+#define TEGRA_SPDIF_BASE		0x70002400
+#define TEGRA_SPDIF_SIZE		SZ_512
+
+#define TEGRA_I2S1_BASE			0x70002800
+#define TEGRA_I2S1_SIZE			SZ_256
+
+#define TEGRA_I2S2_BASE			0x70002A00
+#define TEGRA_I2S2_SIZE			SZ_256
+
+#define TEGRA_UARTA_BASE		0x70006000
+#define TEGRA_UARTA_SIZE		SZ_64
+
+#define TEGRA_UARTB_BASE		0x70006040
+#define TEGRA_UARTB_SIZE		SZ_64
+
+#define TEGRA_UARTC_BASE		0x70006200
+#define TEGRA_UARTC_SIZE		SZ_256
+
+#define TEGRA_UARTD_BASE		0x70006300
+#define TEGRA_UARTD_SIZE		SZ_256
+
+#define TEGRA_UARTE_BASE		0x70006400
+#define TEGRA_UARTE_SIZE		SZ_256
+
+#define TEGRA_NAND_BASE			0x70008000
+#define TEGRA_NAND_SIZE			SZ_256
+
+#define TEGRA_HSMMC_BASE		0x70008500
+#define TEGRA_HSMMC_SIZE		SZ_256
+
+#define TEGRA_SNOR_BASE			0x70009000
+#define TEGRA_SNOR_SIZE			SZ_4K
+
+#define TEGRA_PWFM_BASE			0x7000A000
+#define TEGRA_PWFM_SIZE			SZ_256
+
+#define TEGRA_MIPI_BASE			0x7000B000
+#define TEGRA_MIPI_SIZE			SZ_256
+
+#define TEGRA_I2C_BASE			0x7000C000
+#define TEGRA_I2C_SIZE			SZ_256
+
+#define TEGRA_TWC_BASE			0x7000C100
+#define TEGRA_TWC_SIZE			SZ_256
+
+#define TEGRA_SPI_BASE			0x7000C380
+#define TEGRA_SPI_SIZE			48
+
+#define TEGRA_I2C2_BASE			0x7000C400
+#define TEGRA_I2C2_SIZE			SZ_256
+
+#define TEGRA_I2C3_BASE			0x7000C500
+#define TEGRA_I2C3_SIZE			SZ_256
+
+#define TEGRA_OWR_BASE			0x7000D000
+#define TEGRA_OWR_SIZE			80
+
+#define TEGRA_DVC_BASE			0x7000D000
+#define TEGRA_DVC_SIZE			SZ_512
+
+#define TEGRA_SPI1_BASE			0x7000D400
+#define TEGRA_SPI1_SIZE			SZ_512
+
+#define TEGRA_SPI2_BASE			0x7000D600
+#define TEGRA_SPI2_SIZE			SZ_512
+
+#define TEGRA_SPI3_BASE			0x7000D800
+#define TEGRA_SPI3_SIZE			SZ_512
+
+#define TEGRA_SPI4_BASE			0x7000DA00
+#define TEGRA_SPI4_SIZE			SZ_512
+
+#define TEGRA_RTC_BASE			0x7000E000
+#define TEGRA_RTC_SIZE			SZ_256
+
+#define TEGRA_KBC_BASE			0x7000E200
+#define TEGRA_KBC_SIZE			SZ_256
+
+#define TEGRA_PMC_BASE			0x7000E400
+#define TEGRA_PMC_SIZE			SZ_256
+
+#define TEGRA_MC_BASE			0x7000F000
+#define TEGRA_MC_SIZE			SZ_1K
+
+#define TEGRA_EMC_BASE			0x7000F400
+#define TEGRA_EMC_SIZE			SZ_1K
+
+#define TEGRA_FUSE_BASE			0x7000F800
+#define TEGRA_FUSE_SIZE			SZ_1K
+
+#define TEGRA_KFUSE_BASE		0x7000FC00
+#define TEGRA_KFUSE_SIZE		SZ_1K
+
+#define TEGRA_CSITE_BASE		0x70040000
+#define TEGRA_CSITE_SIZE		SZ_256K
+
+#define TEGRA_USB_BASE			0xC5000000
+#define TEGRA_USB_SIZE			SZ_16K
+
+#define TEGRA_USB1_BASE			0xC5004000
+#define TEGRA_USB1_SIZE			SZ_16K
+
+#define TEGRA_USB2_BASE			0xC5008000
+#define TEGRA_USB2_SIZE			SZ_16K
+
+#define TEGRA_SDMMC1_BASE		0xC8000000
+#define TEGRA_SDMMC1_SIZE		SZ_512
+
+#define TEGRA_SDMMC2_BASE		0xC8000200
+#define TEGRA_SDMMC2_SIZE		SZ_512
+
+#define TEGRA_SDMMC3_BASE		0xC8000400
+#define TEGRA_SDMMC3_SIZE		SZ_512
+
+#define TEGRA_SDMMC4_BASE		0xC8000600
+#define TEGRA_SDMMC4_SIZE		SZ_512
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/memory.h b/arch/arm/mach-tegra/include/mach/memory.h
new file mode 100644
index 0000000..6151bab
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/memory.h
@@ -0,0 +1,28 @@
+/*
+ * arch/arm/mach-tegra/include/mach/memory.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_MEMORY_H
+#define __MACH_TEGRA_MEMORY_H
+
+/* physical offset of RAM */
+#define PHYS_OFFSET		UL(0)
+
+#endif
+
diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
new file mode 100644
index 0000000..84d5d46
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/system.h
@@ -0,0 +1,39 @@
+/*
+ * arch/arm/mach-tegra/include/mach/system.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_SYSTEM_H
+#define __MACH_TEGRA_SYSTEM_H
+
+#include <mach/hardware.h>
+#include <mach/iomap.h>
+
+static inline void arch_idle(void)
+{
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
+	u32 reg = readl(reset);
+	reg |= 0x04;
+	writel(reg, reset);
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/timex.h b/arch/arm/mach-tegra/include/mach/timex.h
new file mode 100644
index 0000000..a44ccbd
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/timex.h
@@ -0,0 +1,26 @@
+/*
+ * arch/arm/mach-tegra/include/mach/timex.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_TIMEX_H
+#define __MACH_TEGRA_TIMEX_H
+
+#define CLOCK_TICK_RATE		1000000
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
new file mode 100644
index 0000000..6c4dd81
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -0,0 +1,78 @@
+/*
+ * arch/arm/mach-tegra/include/mach/uncompress.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_UNCOMPRESS_H
+#define __MACH_TEGRA_UNCOMPRESS_H
+
+#include <linux/types.h>
+#include <linux/serial_reg.h>
+
+#include <mach/iomap.h>
+
+#if defined(CONFIG_TEGRA_DEBUG_UARTA)
+#define DEBUG_UART_BASE TEGRA_UARTA_BASE
+#elif defined(CONFIG_TEGRA_DEBUG_UARTB)
+#define DEBUG_UART_BASE TEGRA_UARTB_BASE
+#elif defined(CONFIG_TEGRA_DEBUG_UARTC)
+#define DEBUG_UART_BASE TEGRA_UARTC_BASE
+#elif defined(CONFIG_TEGRA_DEBUG_UARTD)
+#define DEBUG_UART_BASE TEGRA_UARTD_BASE
+#elif defined(CONFIG_TEGRA_DEBUG_UARTE)
+#define DEBUG_UART_BASE TEGRA_UARTE_BASE
+#else
+#define DEBUG_UART_BASE NULL
+#endif
+
+static void putc(int c)
+{
+	volatile u8 *uart = (volatile u8 *)DEBUG_UART_BASE;
+	int shift = 2;
+
+	if (uart == NULL)
+		return;
+
+	while (!(uart[UART_LSR << shift] & UART_LSR_THRE))
+		barrier();
+	uart[UART_TX << shift] = c;
+}
+
+static inline void flush(void)
+{
+}
+
+static inline void arch_decomp_setup(void)
+{
+	volatile u8 *uart = (volatile u8 *)DEBUG_UART_BASE;
+	int shift = 2;
+
+	if (uart == NULL)
+		return;
+
+	uart[UART_LCR << shift] |= UART_LCR_DLAB;
+	uart[UART_DLL << shift] = 0x75;
+	uart[UART_DLM << shift] = 0x0;
+	uart[UART_LCR << shift] = 3;
+}
+
+static inline void arch_decomp_wdog(void)
+{
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/vmalloc.h b/arch/arm/mach-tegra/include/mach/vmalloc.h
new file mode 100644
index 0000000..267a141
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/vmalloc.h
@@ -0,0 +1,28 @@
+/*
+ * arch/arm/mach-tegra/include/mach/vmalloc.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_VMALLOC_H
+#define __MACH_TEGRA_VMALLOC_H
+
+#include <asm/sizes.h>
+
+#define VMALLOC_END        0xFE000000
+
+#endif
diff --git a/arch/arm/mach-tegra/io.c b/arch/arm/mach-tegra/io.c
new file mode 100644
index 0000000..9fe2c5c
--- /dev/null
+++ b/arch/arm/mach-tegra/io.c
@@ -0,0 +1,78 @@
+/*
+ * arch/arm/mach-tegra/io.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *	Erik Gilling <konkers@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <asm/page.h>
+#include <asm/mach/map.h>
+
+#include "board.h"
+
+static struct map_desc tegra_io_desc[] __initdata = {
+	{
+		.virtual = IO_PPSB_VIRT,
+		.pfn = __phys_to_pfn(IO_PPSB_PHYS),
+		.length = IO_PPSB_SIZE,
+		.type = MT_DEVICE,
+	},
+	{
+		.virtual = IO_APB_VIRT,
+		.pfn = __phys_to_pfn(IO_APB_PHYS),
+		.length = IO_APB_SIZE,
+		.type = MT_DEVICE,
+	},
+	{
+		.virtual = IO_CPU_VIRT,
+		.pfn = __phys_to_pfn(IO_CPU_PHYS),
+		.length = IO_CPU_SIZE,
+		.type = MT_DEVICE,
+	},
+};
+
+void __init tegra_map_common_io(void)
+{
+	iotable_init(tegra_io_desc, ARRAY_SIZE(tegra_io_desc));
+}
+
+/*
+ * Intercept ioremap() requests for addresses in our fixed mapping regions.
+ */
+void __iomem *tegra_ioremap(unsigned long p, size_t size, unsigned int type)
+{
+	void __iomem *v = IO_ADDRESS(p);
+	if (v == NULL)
+		v = __arm_ioremap(p, size, type);
+	return v;
+}
+EXPORT_SYMBOL(tegra_ioremap);
+
+void tegra_iounmap(volatile void __iomem *addr)
+{
+	unsigned long virt = (unsigned long)addr;
+
+	if (virt >= VMALLOC_START && virt < VMALLOC_END)
+		__iounmap(addr);
+}
+EXPORT_SYMBOL(tegra_iounmap);
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5bd7c89..b4f6c5e 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -760,7 +760,7 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
 config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
-		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK || ARCH_OMAP4
+		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK || ARCH_OMAP4 || ARCH_TEGRA
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
-- 
1.5.6.5
