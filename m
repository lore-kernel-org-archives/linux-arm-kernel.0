From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 24 Aug 2011 15:41:44 +0100
Subject: [PATCHv2 1/3] picoxcell: support for Picochip picoxcell devices
In-Reply-To: <1314196906-20709-1-git-send-email-jamie@jamieiles.com>
References: <1314196906-20709-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1314196906-20709-2-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

picoXcell is a family of femtocell devices with an ARM application
processor and picoArray DSP processor array.

This patch adds support for picoXcell boards to be booted using the
device tree registering the VIC's, UART's and timers.

v2:	- cleanup empty mach headers
	- convert to of_platform_populate()
	- simplify uncompress.h
	- split vic node into 2 devices
	- add missing __initconst attributes

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 .../devicetree/bindings/arm/picoxcell.txt          |   23 ++++
 arch/arm/Kconfig                                   |   18 +++
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-picoxcell/Makefile                   |    3 +
 arch/arm/mach-picoxcell/Makefile.boot              |    1 +
 arch/arm/mach-picoxcell/common.c                   |   55 ++++++++
 arch/arm/mach-picoxcell/common.h                   |   18 +++
 arch/arm/mach-picoxcell/include/mach/debug-macro.S |   35 +++++
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 +++
 arch/arm/mach-picoxcell/include/mach/gpio.h        |    1 +
 arch/arm/mach-picoxcell/include/mach/hardware.h    |   21 +++
 arch/arm/mach-picoxcell/include/mach/io.h          |   29 +++++
 arch/arm/mach-picoxcell/include/mach/irqs.h        |   25 ++++
 arch/arm/mach-picoxcell/include/mach/map.h         |   25 ++++
 arch/arm/mach-picoxcell/include/mach/memory.h      |    1 +
 .../mach-picoxcell/include/mach/picoxcell_soc.h    |   25 ++++
 arch/arm/mach-picoxcell/include/mach/system.h      |   31 +++++
 arch/arm/mach-picoxcell/include/mach/timex.h       |   25 ++++
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   21 +++
 arch/arm/mach-picoxcell/include/mach/vmalloc.h     |   18 +++
 arch/arm/mach-picoxcell/io.c                       |   56 ++++++++
 arch/arm/mach-picoxcell/time.c                     |  132 ++++++++++++++++++++
 22 files changed, 583 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/picoxcell.txt
 create mode 100644 arch/arm/mach-picoxcell/Makefile
 create mode 100644 arch/arm/mach-picoxcell/Makefile.boot
 create mode 100644 arch/arm/mach-picoxcell/common.c
 create mode 100644 arch/arm/mach-picoxcell/common.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-picoxcell/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-picoxcell/include/mach/gpio.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/hardware.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/io.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/irqs.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/map.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/memory.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/system.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/timex.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-picoxcell/io.c
 create mode 100644 arch/arm/mach-picoxcell/time.c

diff --git a/Documentation/devicetree/bindings/arm/picoxcell.txt b/Documentation/devicetree/bindings/arm/picoxcell.txt
new file mode 100644
index 0000000..fe40500
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/picoxcell.txt
@@ -0,0 +1,23 @@
+Picochip picoXcell device tree bindings.
+========================================
+
+Required root node properties:
+    - compatible:
+	- "picochip,pc7302-pc3x3" : PC7302 development board with PC3X3 device.
+	- "picochip,pc3x3" : picoXcell PC3X3 device based board.
+	- "picochip,pc3x2" : picoXcell PC3X2 device based board.
+
+Timers required properties:
+    - compatible = "picochip,pc3x2-timer"
+    - interrupts : The single IRQ line for the timer.
+    - clock-freq : The frequency in HZ of the timer.
+    - reg : The register bank for the timer.
+
+Note: two timers are required - one for the scheduler clock and one for the
+event tick/NOHZ.
+
+VIC required properties:
+    - compatible = "arm,pl192-vic".
+    - interrupt-controller.
+    - reg : The register bank for the device.
+    - #interrupt-cells : Must be 1.
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5ebc5d9..15fab78 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -608,6 +608,24 @@ config ARCH_TEGRA
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
 	  Tegra 6xx and Tegra 2 series).
 
+config ARCH_PICOXCELL
+	bool "Picochip picoXcell"
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_PATCH_PHYS_VIRT
+	select ARM_VIC
+	select CPU_V6K
+	select DW_APB_TIMER
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
+	select HAVE_SCHED_CLOCK
+	select HAVE_TCM
+	select NO_IOPORT
+	select USE_OF
+	help
+	  This enables support for systems based on the Picochip picoXcell
+	  family of Femtocell devices.  The picoxcell support requires device tree
+	  for all boards.
+
 config ARCH_PNX4008
 	bool "Philips Nexperia PNX4008 Mobile"
 	select CPU_ARM926T
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 70c424e..c941399 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -167,6 +167,7 @@ machine-$(CONFIG_ARCH_OMAP2)		:= omap2
 machine-$(CONFIG_ARCH_OMAP3)		:= omap2
 machine-$(CONFIG_ARCH_OMAP4)		:= omap2
 machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
+machine-$(CONFIG_ARCH_PICOXCELL)	:= picoxcell
 machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
 machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
 machine-$(CONFIG_ARCH_PXA)		:= pxa
diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
new file mode 100644
index 0000000..c550b63
--- /dev/null
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -0,0 +1,3 @@
+obj-y	:= common.o
+obj-y	+= time.o
+obj-y	+= io.o
diff --git a/arch/arm/mach-picoxcell/Makefile.boot b/arch/arm/mach-picoxcell/Makefile.boot
new file mode 100644
index 0000000..b327175
--- /dev/null
+++ b/arch/arm/mach-picoxcell/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y := 0x00008000
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
new file mode 100644
index 0000000..34d0834
--- /dev/null
+++ b/arch/arm/mach-picoxcell/common.c
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+#include <asm/hardware/vic.h>
+
+#include <mach/map.h>
+#include <mach/picoxcell_soc.h>
+
+#include "common.h"
+
+static void __init picoxcell_init_machine(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *picoxcell_dt_match[] = {
+	"picochip,pc3x2",
+	"picochip,pc3x3",
+	NULL
+};
+
+static const struct of_device_id vic_of_match[] __initconst = {
+	{ .compatible = "arm,pl192-vic" },
+	{ /* Sentinel */ }
+};
+
+static void __init picoxcell_init_irq(void)
+{
+	vic_init(IO_ADDRESS(PICOXCELL_VIC0_BASE), 0, ~0, 0);
+	vic_init(IO_ADDRESS(PICOXCELL_VIC1_BASE), 32, ~0, 0);
+	irq_domain_generate_simple(vic_of_match, PICOXCELL_VIC0_BASE, 0);
+	irq_domain_generate_simple(vic_of_match, PICOXCELL_VIC1_BASE, 32);
+}
+
+DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
+	.map_io		= picoxcell_map_io,
+	.nr_irqs	= ARCH_NR_IRQS,
+	.init_irq	= picoxcell_init_irq,
+	.timer		= &picoxcell_timer,
+	.init_machine	= picoxcell_init_machine,
+	.dt_compat	= picoxcell_dt_match,
+MACHINE_END
diff --git a/arch/arm/mach-picoxcell/common.h b/arch/arm/mach-picoxcell/common.h
new file mode 100644
index 0000000..5263f0f
--- /dev/null
+++ b/arch/arm/mach-picoxcell/common.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#ifndef __PICOXCELL_COMMON_H__
+#define __PICOXCELL_COMMON_H__
+
+#include <asm/mach/time.h>
+
+extern struct sys_timer picoxcell_timer;
+extern void picoxcell_map_io(void);
+
+#endif /* __PICOXCELL_COMMON_H__ */
diff --git a/arch/arm/mach-picoxcell/include/mach/debug-macro.S b/arch/arm/mach-picoxcell/include/mach/debug-macro.S
new file mode 100644
index 0000000..8f2c234
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/debug-macro.S
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Derived from arch/arm/mach-davinci/include/mach/debug-macro.S to use 32-bit
+ * accesses to the 8250.
+ */
+#include <linux/serial_reg.h>
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#define UART_SHIFT 2
+
+		.macro	addruart, rp, rv
+		ldr	\rv, =PHYS_TO_IO(PICOXCELL_UART1_BASE)
+		ldr	\rp, =PICOXCELL_UART1_BASE
+		.endm
+
+		.macro	senduart,rd,rx
+		str	\rd, [\rx, #UART_TX << UART_SHIFT]
+		.endm
+
+		.macro	busyuart,rd,rx
+1002:		ldr	\rd, [\rx, #UART_LSR << UART_SHIFT]
+		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
+		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
+		bne	1002b
+		.endm
+
+		/* The UART's don't have any flow control IO's wired up. */
+		.macro	waituart,rd,rx
+		.endm
diff --git a/arch/arm/mach-picoxcell/include/mach/entry-macro.S b/arch/arm/mach-picoxcell/include/mach/entry-macro.S
new file mode 100644
index 0000000..a6b09f7
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/entry-macro.S
@@ -0,0 +1,19 @@
+/*
+ * entry-macro.S
+ *
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * Low-level IRQ helper macros for picoXcell platforms
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#define VA_VIC0		IO_ADDRESS(PICOXCELL_VIC0_BASE)
+#define VA_VIC1		IO_ADDRESS(PICOXCELL_VIC1_BASE)
+
+#include <asm/entry-macro-vic2.S>
diff --git a/arch/arm/mach-picoxcell/include/mach/gpio.h b/arch/arm/mach-picoxcell/include/mach/gpio.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-picoxcell/include/mach/hardware.h b/arch/arm/mach-picoxcell/include/mach/hardware.h
new file mode 100644
index 0000000..70ff581
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/hardware.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This file contains the hardware definitions of the picoXcell SoC devices.
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
+ */
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H
+
+#include <mach/picoxcell_soc.h>
+
+#endif
diff --git a/arch/arm/mach-picoxcell/include/mach/io.h b/arch/arm/mach-picoxcell/include/mach/io.h
new file mode 100644
index 0000000..a863b0f
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/io.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
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
+ */
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+/* No ioports, but needed for driver compatibility. */
+#define __io(a)			__typesafe_io(a)
+/* No PCI possible on picoxcell. */
+#define __mem_pci(a)		(a)
+
+#define __arch_ioremap	picoxcell_ioremap
+#define __arch_iounmap	picoxcell_iounmap
+
+extern void __iomem *picoxcell_ioremap(unsigned long phys, size_t size,
+				       unsigned int type);
+extern void picoxcell_iounmap(volatile void __iomem *addr);
+
+#endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/irqs.h b/arch/arm/mach-picoxcell/include/mach/irqs.h
new file mode 100644
index 0000000..4d13ed9
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/irqs.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This file contains the hardware definitions of the picoXcell SoC devices.
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
+ */
+#ifndef __MACH_IRQS_H
+#define __MACH_IRQS_H
+
+#define ARCH_NR_IRQS			64
+#define NR_IRQS				(128 + ARCH_NR_IRQS)
+
+#define IRQ_VIC0_BASE			0
+#define IRQ_VIC1_BASE			32
+
+#endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/map.h b/arch/arm/mach-picoxcell/include/mach/map.h
new file mode 100644
index 0000000..c06afad
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/map.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
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
+ */
+#ifndef __PICOXCELL_MAP_H__
+#define __PICOXCELL_MAP_H__
+
+#define PHYS_TO_IO(x)		(((x) & 0x00ffffff) | 0xfe000000)
+
+#ifdef __ASSEMBLY__
+#define IO_ADDRESS(x)		PHYS_TO_IO((x))
+#else
+#define IO_ADDRESS(x)		(void __iomem __force *)(PHYS_TO_IO((x)))
+#endif
+
+#endif /* __PICOXCELL_MAP_H__ */
diff --git a/arch/arm/mach-picoxcell/include/mach/memory.h b/arch/arm/mach-picoxcell/include/mach/memory.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/memory.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h b/arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h
new file mode 100644
index 0000000..5566fc8
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This file contains the hardware definitions of the picoXcell SoC devices.
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
+ */
+#ifndef __PICOXCELL_SOC_H__
+#define __PICOXCELL_SOC_H__
+
+#define PICOXCELL_UART1_BASE		0x80230000
+#define PICOXCELL_PERIPH_BASE		0x80000000
+#define PICOXCELL_PERIPH_LENGTH		SZ_4M
+#define PICOXCELL_VIC0_BASE		0x80060000
+#define PICOXCELL_VIC1_BASE		0x80064000
+
+#endif /* __PICOXCELL_SOC_H__ */
diff --git a/arch/arm/mach-picoxcell/include/mach/system.h b/arch/arm/mach-picoxcell/include/mach/system.h
new file mode 100644
index 0000000..67c589b
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/system.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
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
+ */
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H
+
+static inline void arch_idle(void)
+{
+	/*
+	 * This should do all the clock switching and wait for interrupt
+	 * tricks.
+	 */
+	cpu_do_idle();
+}
+
+static inline void arch_reset(int mode, const char *cmd)
+{
+	/* Watchdog reset to go here. */
+}
+
+#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/timex.h b/arch/arm/mach-picoxcell/include/mach/timex.h
new file mode 100644
index 0000000..6c540a6
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/timex.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
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
+#ifndef __TIMEX_H__
+#define __TIMEX_H__
+
+/* Bogus value to allow the kernel to compile. */
+#define CLOCK_TICK_RATE		1000000
+
+#endif /* __TIMEX_H__ */
+
diff --git a/arch/arm/mach-picoxcell/include/mach/uncompress.h b/arch/arm/mach-picoxcell/include/mach/uncompress.h
new file mode 100644
index 0000000..b60b19d
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/uncompress.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
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
+#define putc(c)
+#define flush()
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
diff --git a/arch/arm/mach-picoxcell/include/mach/vmalloc.h b/arch/arm/mach-picoxcell/include/mach/vmalloc.h
new file mode 100644
index 0000000..62559e3
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/vmalloc.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
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
+#define VMALLOC_END		0xFE000000UL
diff --git a/arch/arm/mach-picoxcell/io.c b/arch/arm/mach-picoxcell/io.c
new file mode 100644
index 0000000..935a2fa
--- /dev/null
+++ b/arch/arm/mach-picoxcell/io.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/map.h>
+#include <mach/picoxcell_soc.h>
+
+#include "common.h"
+
+void __init picoxcell_map_io(void)
+{
+	struct map_desc io_map = {
+		.virtual	= PHYS_TO_IO(PICOXCELL_PERIPH_BASE),
+		.pfn		= __phys_to_pfn(PICOXCELL_PERIPH_BASE),
+		.length		= PICOXCELL_PERIPH_LENGTH,
+		.type		= MT_DEVICE,
+	};
+
+	iotable_init(&io_map, 1);
+}
+
+void __iomem *picoxcell_ioremap(unsigned long p, size_t size,
+				unsigned int type)
+{
+	if (unlikely(size == 0))
+		return NULL;
+
+	if (p >= PICOXCELL_PERIPH_BASE &&
+	    p < PICOXCELL_PERIPH_BASE + PICOXCELL_PERIPH_LENGTH)
+		return IO_ADDRESS(p);
+
+	return __arm_ioremap_caller(p, size, type,
+				    __builtin_return_address(0));
+}
+EXPORT_SYMBOL_GPL(picoxcell_ioremap);
+
+void picoxcell_iounmap(volatile void __iomem *addr)
+{
+	unsigned long virt = (unsigned long)addr;
+
+	if (virt >= VMALLOC_START && virt < VMALLOC_END)
+		__iounmap(addr);
+}
+EXPORT_SYMBOL_GPL(picoxcell_iounmap);
diff --git a/arch/arm/mach-picoxcell/time.c b/arch/arm/mach-picoxcell/time.c
new file mode 100644
index 0000000..8b0f5c4
--- /dev/null
+++ b/arch/arm/mach-picoxcell/time.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support@picochip.com
+ */
+#include <linux/dw_apb_timer.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched.h>
+
+#include <asm/mach/time.h>
+#include <asm/sched_clock.h>
+
+#include "common.h"
+
+static void timer_get_base_and_rate(struct device_node *np,
+				    void __iomem **base, u32 *rate)
+{
+	*base = of_iomap(np, 0);
+
+	if (!*base)
+		panic("Unable to map regs for %s", np->name);
+
+	if (of_property_read_u32(np, "clock-freq", rate))
+		panic("No clock-freq property for %s", np->name);
+}
+
+static void picoxcell_add_clockevent(struct device_node *event_timer)
+{
+	void __iomem *iobase;
+	struct dw_apb_clock_event_device *ced;
+	u32 irq, rate;
+
+	irq = irq_of_parse_and_map(event_timer, 0);
+	if (irq == NO_IRQ)
+		panic("No IRQ for clock event timer");
+
+	timer_get_base_and_rate(event_timer, &iobase, &rate);
+
+	ced = dw_apb_clockevent_init(0, event_timer->name, 300, iobase, irq,
+				     rate);
+	if (!ced)
+		panic("Unable to initialise clockevent device");
+
+	dw_apb_clockevent_register(ced);
+}
+
+static void picoxcell_add_clocksource(struct device_node *source_timer)
+{
+	void __iomem *iobase;
+	struct dw_apb_clocksource *cs;
+	u32 rate;
+
+	timer_get_base_and_rate(source_timer, &iobase, &rate);
+
+	cs = dw_apb_clocksource_init(300, source_timer->name, iobase, rate);
+	if (!cs)
+		panic("Unable to initialise clocksource device");
+
+	dw_apb_clocksource_start(cs);
+	dw_apb_clocksource_register(cs);
+}
+
+static DEFINE_CLOCK_DATA(cd);
+static void __iomem *sched_io_base;
+
+unsigned long long notrace sched_clock(void)
+{
+	cycle_t cyc = sched_io_base ? __raw_readl(sched_io_base) : 0;
+
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
+
+static void notrace picoxcell_update_sched_clock(void)
+{
+	cycle_t cyc = sched_io_base ? __raw_readl(sched_io_base) : 0;
+
+	update_sched_clock(&cd, cyc, (u32)~0);
+}
+
+static const struct of_device_id picoxcell_rtc_ids[] __initconst = {
+	{ .compatible = "picochip,pc3x2-rtc" },
+	{ /* Sentinel */ },
+};
+
+static void picoxcell_init_sched_clock(void)
+{
+	struct device_node *sched_timer;
+	u32 rate;
+
+	sched_timer = of_find_matching_node(NULL, picoxcell_rtc_ids);
+	if (!sched_timer)
+		panic("No RTC for sched clock to use");
+
+	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
+	of_node_put(sched_timer);
+
+	init_sched_clock(&cd, picoxcell_update_sched_clock, 32, rate);
+}
+
+static const struct of_device_id picoxcell_timer_ids[] __initconst = {
+	{ .compatible = "picochip,pc3x2-timer" },
+	{ /* Sentinel */ },
+};
+
+static void __init picoxcell_timer_init(void)
+{
+	struct device_node *event_timer, *source_timer;
+
+	event_timer = of_find_matching_node(NULL, picoxcell_timer_ids);
+	if (!event_timer)
+		panic("No timer for clockevent");
+	picoxcell_add_clockevent(event_timer);
+
+	source_timer = of_find_matching_node(event_timer, picoxcell_timer_ids);
+	if (!source_timer)
+		panic("No timer for clocksource");
+	picoxcell_add_clocksource(source_timer);
+
+	of_node_put(source_timer);
+
+	picoxcell_init_sched_clock();
+}
+
+struct sys_timer picoxcell_timer = {
+	.init = picoxcell_timer_init,
+};
-- 
1.7.4.1
