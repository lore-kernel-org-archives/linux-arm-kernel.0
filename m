From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 26 Nov 2010 11:08:46 +0000
Subject: [PATCH] picoxcell: add support for picoXcell
In-Reply-To: <1290506774-17895-2-git-send-email-jamie@jamieiles.com>
References: <1290506774-17895-2-git-send-email-jamie@jamieiles.com>
Message-ID: <1290769726-26247-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

picoXcell is a family of femtocell SoC devices from Picochip [1] with an
ARM subsystem.  The devices have an ARM1176JZ-S core and a DSP processor
array.  Currently there are two sub families - PC3X2 and PC3X3. The
latter includes extra power and performance control along with extra
peripherals.

This initial patch adds the hardware definitions and a framework for
adding device variants.

v2:
	- Define VMALLOC_END as a fixed address rather than relative to
	  PAGE_OFFSET
	- Reduce the number of static IO mappings
	- Put the picoXcell entry in the correct place in
	  arch/arm/Kconfig

1. http://www.picochip.com

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                                   |   17 ++
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-picoxcell/Kconfig                    |    4 +
 arch/arm/mach-picoxcell/Makefile                   |    1 +
 arch/arm/mach-picoxcell/Makefile.boot              |    3 +
 arch/arm/mach-picoxcell/axi2cfg.c                  |  168 ++++++++++++++++++
 arch/arm/mach-picoxcell/include/mach/debug-macro.S |   18 ++
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 ++
 arch/arm/mach-picoxcell/include/mach/hardware.h    |   29 +++
 arch/arm/mach-picoxcell/include/mach/io.h          |   32 ++++
 arch/arm/mach-picoxcell/include/mach/irqs.h        |   89 +++++++++
 arch/arm/mach-picoxcell/include/mach/memory.h      |   27 +++
 .../include/mach/picoxcell/axi2cfg.h               |  171 ++++++++++++++++++
 .../mach-picoxcell/include/mach/picoxcell/gpio.h   |   48 +++++
 .../include/mach/picoxcell/picoxcell.h             |   61 +++++++
 .../mach-picoxcell/include/mach/picoxcell/timer.h  |   36 ++++
 .../mach-picoxcell/include/mach/picoxcell/wdog.h   |   43 +++++
 arch/arm/mach-picoxcell/include/mach/platform.h    |   32 ++++
 arch/arm/mach-picoxcell/include/mach/system.h      |   51 ++++++
 arch/arm/mach-picoxcell/include/mach/timex.h       |   26 +++
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   56 ++++++
 arch/arm/mach-picoxcell/include/mach/vmalloc.h     |   18 ++
 arch/arm/mach-picoxcell/picoxcell_core.c           |  187 ++++++++++++++++++++
 arch/arm/mach-picoxcell/picoxcell_core.h           |   21 +++
 arch/arm/mach-picoxcell/soc.h                      |   59 ++++++
 25 files changed, 1217 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/Kconfig
 create mode 100644 arch/arm/mach-picoxcell/Makefile
 create mode 100644 arch/arm/mach-picoxcell/Makefile.boot
 create mode 100644 arch/arm/mach-picoxcell/axi2cfg.c
 create mode 100644 arch/arm/mach-picoxcell/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-picoxcell/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-picoxcell/include/mach/hardware.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/io.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/irqs.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/memory.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/axi2cfg.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/gpio.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/picoxcell.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/timer.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/wdog.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/platform.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/system.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/timex.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-picoxcell/picoxcell_core.c
 create mode 100644 arch/arm/mach-picoxcell/picoxcell_core.h
 create mode 100644 arch/arm/mach-picoxcell/soc.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 81c71da..3806af0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -579,6 +579,21 @@ config ARCH_PNX4008
 	help
 	  This enables support for Philips PNX4008 mobile platform.
 
+config ARCH_PICOXCELL
+	bool "Picochip picoXcell"
+	select ARM_VIC
+	select HAS_TLS_REG
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select COMMON_CLKDEV
+	select TICK_ONESHOT
+	select CPU_V6
+	help
+	  This enables support for systems based on the Picochip picoXcell
+	  family of Femtocell devices.
+
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
 	depends on MMU
@@ -924,6 +939,8 @@ source "arch/arm/mach-omap2/Kconfig"
 
 source "arch/arm/mach-orion5x/Kconfig"
 
+source "arch/arm/mach-picoxcell/Kconfig"
+
 source "arch/arm/mach-pxa/Kconfig"
 source "arch/arm/plat-pxa/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index b87aed0..b47baa8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -166,6 +166,7 @@ machine-$(CONFIG_ARCH_OMAP2)		:= omap2
 machine-$(CONFIG_ARCH_OMAP3)		:= omap2
 machine-$(CONFIG_ARCH_OMAP4)		:= omap2
 machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
+machine-$(CONFIG_ARCH_PICOXCELL)	:= picoxcell
 machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
 machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
new file mode 100644
index 0000000..3daba53
--- /dev/null
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -0,0 +1,4 @@
+menu "PICOXCELL platform type"
+	depends on ARCH_PICOXCELL
+
+endmenu
diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
new file mode 100644
index 0000000..7246a6a
--- /dev/null
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -0,0 +1 @@
+obj-y				:= picoxcell_core.o axi2cfg.o
diff --git a/arch/arm/mach-picoxcell/Makefile.boot b/arch/arm/mach-picoxcell/Makefile.boot
new file mode 100644
index 0000000..67039c3
--- /dev/null
+++ b/arch/arm/mach-picoxcell/Makefile.boot
@@ -0,0 +1,3 @@
+   zreladdr-y	:= 0x00008000
+params_phys-y	:= 0x00000100
+initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-picoxcell/axi2cfg.c b/arch/arm/mach-picoxcell/axi2cfg.c
new file mode 100644
index 0000000..5974743
--- /dev/null
+++ b/arch/arm/mach-picoxcell/axi2cfg.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ *
+ * This file implements functions for using the axi2cfg to configure and debug
+ * picoArray systems providing configuration bus access over the axi2cfg.
+ */
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+
+#include <mach/hardware.h>
+
+/* Configuration port write bit positions. */
+#define CAEID_BIT_MASK	    (1 << 19)	/* AE ID signal. */
+#define CADDR_BIT_MASK	    (1 << 18)	/* AE ADDR signal. */
+#define CREAD_BIT_MASK	    (1 << 17)	/* READ data signal. */
+#define CWRITE_BIT_MASK     (1 << 16)	/* WRITE data signal. */
+
+#define RB_FAIL_MASK	    (1 << 17)	/* Readback failed. */
+#define RB_VALID_MASK	    (1 << 16)	/* Readback valid. */
+
+#define NR_RETRIES	    16		/* The number of retries for an
+					 * AXI2Cfg config read. */
+
+static DEFINE_SPINLOCK(axi2cfg_lock);
+
+static void __iomem *axi2cfg;
+
+#define CFG_WRITE_PORT	    0x100	/* Write port offset. */
+#define CFG_READ_PORT	    0x200	/* Read port offset. */
+
+int
+axi2cfg_config_read(u16 aeid, u16 ae_addr, u16 *buf, u16 count)
+{
+	u32 val;
+	void __iomem *write_p = axi2cfg + CFG_WRITE_PORT;
+	void __iomem *read_p = axi2cfg + CFG_READ_PORT;
+	u16 rc, to_read = count;
+	unsigned i, retries;
+	unsigned long flags;
+
+	spin_lock_irqsave(&axi2cfg_lock, flags);
+
+	val = aeid | CAEID_BIT_MASK;
+	writel(val, write_p);
+
+	while (to_read) {
+		/* Output the address to read from. */
+		val = (ae_addr + (count - to_read)) | CADDR_BIT_MASK;
+		writel(val, write_p);
+
+		/* Dispatch the read requests. We have a 64 entry FIFO. */
+		rc = min_t(u16, to_read, 64);
+		val = CREAD_BIT_MASK | rc;
+		writel(val, write_p);
+		wmb();
+
+		/* Now read the values. */
+		for (i = 0; i < rc; ++i) {
+			retries = NR_RETRIES;
+			while (retries) {
+				val = readl(read_p);
+				if (val & (RB_VALID_MASK | RB_FAIL_MASK))
+					break;
+				--retries;
+				rmb();
+			}
+
+			if (!retries || (val & RB_FAIL_MASK)) {
+				pr_warning("config read %04x@%04x failed\n",
+					   aeid,
+					   (ae_addr + (count - to_read) + i));
+				break;
+			} else
+				buf[(count - to_read) + i] = val & 0xFFFF;
+		}
+
+		if (val & RB_FAIL_MASK)
+			break;
+
+		to_read -= rc;
+	}
+
+	spin_unlock_irqrestore(&axi2cfg_lock, flags);
+
+	return !(val & RB_FAIL_MASK) ? count : -EIO;
+}
+EXPORT_SYMBOL_GPL(axi2cfg_config_read);
+
+void
+axi2cfg_config_write(u16 aeid, u16 ae_addr, const u16 *buf, u16 count)
+{
+	u32 val;
+	void __iomem *write_p = axi2cfg + CFG_WRITE_PORT;
+	unsigned i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&axi2cfg_lock, flags);
+
+	val = aeid | CAEID_BIT_MASK;
+	writel(val, write_p);
+
+	/* Output the address to read from. */
+	val = ae_addr | CADDR_BIT_MASK;
+	writel(val, write_p);
+
+	/* Now read the values. */
+	for (i = 0; i < count; ++i) {
+		val = buf[i] | CWRITE_BIT_MASK;
+		writel(val, write_p);
+	}
+
+	spin_unlock_irqrestore(&axi2cfg_lock, flags);
+}
+EXPORT_SYMBOL_GPL(axi2cfg_config_write);
+
+void
+axi2cfg_write_buf(const u32 *buf, unsigned nr_words)
+{
+	void __iomem *write_p = axi2cfg + CFG_WRITE_PORT;
+	unsigned i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&axi2cfg_lock, flags);
+
+	/* Now read the values. */
+	for (i = 0; i < nr_words; ++i)
+		writel(*buf++, write_p);
+
+	spin_unlock_irqrestore(&axi2cfg_lock, flags);
+}
+EXPORT_SYMBOL_GPL(axi2cfg_write_buf);
+
+unsigned long axi2cfg_readl(unsigned long offs)
+{
+	return readl(axi2cfg + offs);
+}
+
+void axi2cfg_writel(unsigned long val, unsigned long offs)
+{
+	writel(val, axi2cfg + offs);
+}
+
+u32 syscfg_read(void)
+{
+	return axi2cfg_readl(AXI2CFG_SYSCFG_REG_OFFSET);
+}
+
+void syscfg_update(u32 mask, u32 val)
+{
+	u32 tmp = syscfg_read();
+	tmp &= ~mask;
+	tmp |= (val & mask);
+	axi2cfg_writel(tmp, AXI2CFG_SYSCFG_REG_OFFSET);
+}
+
+void __init axi2cfg_init(void)
+{
+	axi2cfg = ioremap(PICOXCELL_AXI2CFG_BASE, 0x300);
+	BUG_ON(!axi2cfg);
+}
diff --git a/arch/arm/mach-picoxcell/include/mach/debug-macro.S b/arch/arm/mach-picoxcell/include/mach/debug-macro.S
new file mode 100644
index 0000000..5cbab63
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/debug-macro.S
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+		.macro	addruart, rp, rv
+		mov	\rv, #0x00230000
+		orr	\rp, \rv, #0x80000000
+		orr	\rv, \rv, #0xFE000000
+		.endm
+
+#define UART_SHIFT 2
+#define DEBUG_8250_ACCESS_32
+#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-picoxcell/include/mach/entry-macro.S b/arch/arm/mach-picoxcell/include/mach/entry-macro.S
new file mode 100644
index 0000000..4dcda96
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/entry-macro.S
@@ -0,0 +1,19 @@
+/*
+ * entry-macro.S
+ *
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * Low-level IRQ helper macros for picoXcell platforms
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <mach/hardware.h>
+#include <mach/io.h>
+#include <mach/irqs.h>
+
+#define VA_VIC0		IO_ADDRESS(PICOXCELL_VIC0_BASE)
+#define VA_VIC1		IO_ADDRESS(PICOXCELL_VIC1_BASE)
+
+#include <asm/entry-macro-vic2.S>
diff --git a/arch/arm/mach-picoxcell/include/mach/hardware.h b/arch/arm/mach-picoxcell/include/mach/hardware.h
new file mode 100644
index 0000000..7c203d3
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/hardware.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H
+
+#include <mach/picoxcell/axi2cfg.h>
+#include <mach/picoxcell/gpio.h>
+#include <mach/picoxcell/picoxcell.h>
+#include <mach/picoxcell/timer.h>
+#include <mach/picoxcell/wdog.h>
+
+#endif
diff --git a/arch/arm/mach-picoxcell/include/mach/io.h b/arch/arm/mach-picoxcell/include/mach/io.h
new file mode 100644
index 0000000..3d61379
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/io.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define PHYS_TO_IO(x)		(((x) & 0x00ffffff) | 0xfe000000)
+#ifdef __ASSEMBLY__
+# define IO_ADDRESS(x)		PHYS_TO_IO((x))
+#else /* __ASSEMBLY__ */
+# define IO_ADDRESS(x)		__typesafe_io(PHYS_TO_IO((x)))
+# define IO_SPACE_LIMIT		0xffffffff
+# define __io(a)		__typesafe_io(a)
+# define __mem_pci(a)		(a)
+# define iomem_ptr(a)		(void __iomem __force *)(PHYS_TO_IO((a)))
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/irqs.h b/arch/arm/mach-picoxcell/include/mach/irqs.h
new file mode 100644
index 0000000..0fe84ff
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/irqs.h
@@ -0,0 +1,89 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#ifndef __IRQS_H__
+#define __IRQS_H__
+
+/* VIC0 IRQ Indexes */
+#define IRQ_VIC0_BASE	    32
+#define IRQ_EMAC	    (31 + IRQ_VIC0_BASE)
+#define IRQ_NPMUIRQ	    (30 + IRQ_VIC0_BASE)
+#define IRQ_NDMAEXTERRIRQ   (29 + IRQ_VIC0_BASE)
+#define IRQ_NDMASIRQ	    (28 + IRQ_VIC0_BASE)
+#define IRQ_NDMAIRQ	    (27 + IRQ_VIC0_BASE)
+#define IRQ_DMAC2	    (26 + IRQ_VIC0_BASE)
+#define IRQ_DMAC1	    (25 + IRQ_VIC0_BASE)
+#define IRQ_IPSEC	    (24 + IRQ_VIC0_BASE)
+#define IRQ_SRTP	    (23 + IRQ_VIC0_BASE)
+#define IRQ_AES		    (22 + IRQ_VIC0_BASE)
+#define IRQ_AXI2PICO8	    (21 + IRQ_VIC0_BASE)
+#define IRQ_AXI2PICO7	    (20 + IRQ_VIC0_BASE)
+#define IRQ_AXI2PICO6	    (19 + IRQ_VIC0_BASE)
+#define IRQ_AXI2PICO5	    (18 + IRQ_VIC0_BASE)
+#define IRQ_AXI2PICO4	    (17 + IRQ_VIC0_BASE)
+#define IRQ_AXI2PICO3	    (16 + IRQ_VIC0_BASE)
+#define IRQ_AXI2PICO2	    (15 + IRQ_VIC0_BASE)
+#define IRQ_AXI2PICO1	    (14 + IRQ_VIC0_BASE)
+#define IRQ_AXI2PICO0	    (13 + IRQ_VIC0_BASE)
+#define IRQ_AXI2CFG	    (12 + IRQ_VIC0_BASE)
+#define IRQ_WDG		    (11 + IRQ_VIC0_BASE)
+#define IRQ_SSI		    (10 + IRQ_VIC0_BASE)
+#define IRQ_AXI_RD_ERR	    (9	+ IRQ_VIC0_BASE)
+#define IRQ_AXI_WR_ERR	    (8	+ IRQ_VIC0_BASE)
+#define IRQ_TIMER3	    (7	+ IRQ_VIC0_BASE)
+#define IRQ_TIMER2	    (6	+ IRQ_VIC0_BASE)
+#define IRQ_TIMER1	    (5	+ IRQ_VIC0_BASE)
+#define IRQ_TIMER0	    (4	+ IRQ_VIC0_BASE)
+#define IRQ_COMMTX	    (3	+ IRQ_VIC0_BASE)
+#define IRQ_COMMRX	    (2	+ IRQ_VIC0_BASE)
+#define IRQ_SWI		    (1	+ IRQ_VIC0_BASE)
+
+/* VIC1 IRQ Indexes */
+#define IRQ_VIC1_BASE	    0
+#define IRQ_UART1	    (10 + IRQ_VIC1_BASE)
+#define IRQ_UART2	    (9 + IRQ_VIC1_BASE)
+#define IRQ_RTC		    (8 + IRQ_VIC1_BASE)
+#define __IRQ_GPIO7	    (7 + IRQ_VIC1_BASE)
+#define __IRQ_GPIO6	    (6 + IRQ_VIC1_BASE)
+#define __IRQ_GPIO5	    (5 + IRQ_VIC1_BASE)
+#define __IRQ_GPIO4	    (4 + IRQ_VIC1_BASE)
+#define __IRQ_GPIO3	    (3 + IRQ_VIC1_BASE)
+#define __IRQ_GPIO2	    (2 + IRQ_VIC1_BASE)
+#define __IRQ_GPIO1	    (1 + IRQ_VIC1_BASE)
+#define __IRQ_GPIO0	    (0 + IRQ_VIC1_BASE)
+
+/*
+ * Virtual GPIO interrupts.
+ *
+ * We want to enable/disable interrupts for the GPIO pins through the GPIO
+ * block itself. To do this we install a chained handler. If a user requests
+ * one of the __IRQ_GPIOn interrupts then the GPIO block won't get configured.
+ * We provide these interrupts below as virtual ones that will configure the
+ * GPIO block and enable the source in the VIC.
+ */
+#define IRQ_GPIO7	    71
+#define IRQ_GPIO6	    70
+#define IRQ_GPIO5	    69
+#define IRQ_GPIO4	    68
+#define IRQ_GPIO3	    67
+#define IRQ_GPIO2	    66
+#define IRQ_GPIO1	    65
+#define IRQ_GPIO0	    64
+
+#define NR_IRQS		    72
+
+#endif /* __IRQS_H__ */
diff --git a/arch/arm/mach-picoxcell/include/mach/memory.h b/arch/arm/mach-picoxcell/include/mach/memory.h
new file mode 100644
index 0000000..47b8ba1
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/memory.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+/*
+ * Physical DRAM offset.
+ */
+#define PHYS_OFFSET	UL(0x00000000)
+
+#endif
+
diff --git a/arch/arm/mach-picoxcell/include/mach/picoxcell/axi2cfg.h b/arch/arm/mach-picoxcell/include/mach/picoxcell/axi2cfg.h
new file mode 100644
index 0000000..18a4ac8
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/picoxcell/axi2cfg.h
@@ -0,0 +1,171 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#ifndef PICOXCELL_AXI2CFG_H
+#define PICOXCELL_AXI2CFG_H
+
+#define AXI2CFG_SYSCFG_REG_OFFSET		0x0000
+#define AXI2CFG_JTAG_ISC_REG_OFFSET		0x0004
+#define AXI2CFG_IRQ_REG_OFFSET			0x0008
+#define AXI2CFG_PURGE_CFG_PORT_REG_OFFSET	0x000C
+#define AXI2CFG_DMA_CFG_REG_OFFSET		0x0010
+#define AXI2CFG_DEVICE_ID_REG_OFFSET		0x0014
+#define AXI2CFG_REVISION_ID_REG_OFFSET		0x0018
+#define AXI2CFG_AXI_ERR_ENABLE_REG_OFFSET	0x001C
+#define AXI2CFG_AXI_ERR_CLEAR_REG_OFFSET	0x0020
+#define AXI2CFG_AXI_ERR_MASK_REG_OFFSET		0x0024
+#define AXI2CFG_AXI_ERR_TEST_REG_OFFSET		0x0028
+#define AXI2CFG_AXI_ERR_RAW_REG_OFFSET		0x002C
+#define AXI2CFG_AXI_ERR_STATE_REG_OFFSET	0x0030
+#define AXI2CFG_CLOCK_GATING_REG_OFFSET		0x0048
+#define AXI2CFG_CONFIG_WRITE_REG_OFFSET		0x0100
+#define AXI2CFG_CONFIG_READ_REG_OFFSET		0x0200
+#define AXI2CFG_DMAC1_CONFIG_REG_OFFSET		0x0300
+
+#define AXI2CFG_SYSCFG_PA_RST_IDX		30
+#define AXI2CFG_SYSCFG_SD_ARM_GPIO_SEL_SZ	8
+#define AXI2CFG_SYSCFG_SD_ARM_GPIO_SEL_HI	23
+#define AXI2CFG_SYSCFG_SD_ARM_GPIO_SEL_LO	16
+#define AXI2CFG_SYSCFG_RW_EBI_CLK_DISABLE_IDX	15
+#define AXI2CFG_SYSCFG_RW_EXCVEC_EN_IDX		14
+#define AXI2CFG_SYSCFG_RW_RMII_EN_IDX		13
+#define AXI2CFG_SYSCFG_RW_REVMII_EN_IDX		12
+#define AXI2CFG_SYSCFG_SSI_EBI_SEL_SZ		4
+#define AXI2CFG_SYSCFG_SSI_EBI_SEL_HI		11
+#define AXI2CFG_SYSCFG_SSI_EBI_SEL_LO		8
+#define AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_IDX	7
+#define AXI2CFG_SYSCFG_MASK_AXI_ERR_IDX		6
+#define AXI2CFG_SYSCFG_RW_REMAP_IDX		5
+#define AXI2CFG_SYSCFG_WDG_PAUSE_IDX		4
+#define AXI2CFG_SYSCFG_CP15DISABLE_IDX		3
+#define AXI2CFG_SYSCFG_DMAC1_CH7_IDX		2
+#define AXI2CFG_SYSCFG_BOOT_MODE_SZ		2
+#define AXI2CFG_SYSCFG_BOOT_MODE_HI		1
+#define AXI2CFG_SYSCFG_BOOT_MODE_LO		0
+
+#define AXI2CFG_SYSCFG_PA_RST_MASK \
+	(1 << AXI2CFG_SYSCFG_PA_RST_IDX)
+#define AXI2CFG_SYSCFG_SD_ARM_GPIO_MASK	\
+	(((1 << AXI2CFG_SYSCFG_SD_ARM_GPIO_SEL_SZ) - 1) << \
+	 AXI2CFG_SYSCFG_SD_ARM_GPIO_SEL_LO)
+#define AXI2CFG_SYSCFG_RW_EXCVEC_EN_MASK \
+	(1 << AXI2CFG_SYSCFG_RW_EXCVEC_EN_IDX)
+#define AXI2CFG_SYSCFG_RW_RMII_EN_MASK \
+	(1 << AXI2CFG_SYSCFG_RW_RMII_EN_IDX)
+#define AXI2CFG_SYSCFG_RW_REVMII_EN_MASK \
+	(1 << AXI2CFG_SYSCFG_RW_REVMII_EN_IDX)
+#define AXI2CFG_SYSCFG_SSI_EBI_SEL_MASK	\
+	(((1 << AXI2CFG_SYSCFG_SSI_EBI_SEL_SZ) - 1) << \
+	 AXI2CFG_SYSCFG_SSI_EBI_SEL_LO)
+#define AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_MASK \
+	(1 << AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_IDX)
+#define AXI2CFG_SYSCFG_MASK_AXI_ERR_MASK \
+	(1 << AXI2CFG_SYSCFG_MASK_AXI_ERR_IDX)
+#define AXI2CFG_SYSCFG_RW_REMAP_MASK \
+	(1 << AXI2CFG_SYSCFG_RW_REMAP_IDX)
+#define AXI2CFG_SYSCFG_WDG_PAUSE_MASK \
+	(1 << AXI2CFG_SYSCFG_WDG_PAUSE_IDX)
+#define AXI2CFG_SYSCFG_CP15DISABLE_MASK	\
+	(1 << AXI2CFG_SYSCFG_CP15DISABLE_IDX)
+#define AXI2CFG_SYSCFG_DMAC1_CH7_MASK \
+	(1 << AXI2CFG_SYSCFG_DMAC1_CH7_IDX)
+#define AXI2CFG_SYSCFG_BOOT_MODE_MASK \
+	(((1 << AXI2CFG_SYSCFG_BOOT_MODE_SZ) - 1) << \
+	 AXI2CFG_SYSCFG_BOOT_MODE_LO)
+
+#define AXI2CFG_AXI_RD_ERR_MASK			   0x00000FFF
+#define AXI2CFG_AXI_WR_ERR_MASK			   0x00FFF000
+#define AXI2CFG_AXI_ERR_MASK_NONE		   0
+#define AXI2CFG_AXI_ERR_ENABLE_ALL		   0x00FFFFFF
+
+#ifndef __ASSEMBLY__
+
+#include <linux/init.h>
+
+/*
+ * axi2cfg_config_read - Read a number of 16 bit words from a picoArray axi2cfg.
+ *
+ * Returns the number of words read on success, negative errno on failure.
+ *
+ * @axi2cfg_base: The base address of the upper axi2cfg.
+ * @aeid: The CAEID of the AE to read from.
+ * @ae_addr: The address to begin reading from within the AE.
+ * @buf: The buffer to store the results in.
+ * @count: The number of 16 bit words to read.
+ */
+extern int axi2cfg_config_read(u16 aeid, u16 ae_addr, u16 *buf, u16 count);
+
+/*
+ * axi2cfg_config_write - Write a number of 16 bit words to a picoArray axi2cfg.
+ *
+ * @axi2cfg_base: The base address of the upper axi2cfg.
+ * @aeid: The CAEID of the AE to write to.
+ * @ae_addr: The address to begin writing to within the AE.
+ * @buf: The buffer to read the words from.
+ * @count: The number of 16 bit words to write.
+ */
+extern void axi2cfg_config_write(u16 aeid, u16 ae_addr, const u16 *buf,
+				 u16 count);
+
+/*
+ * ax2cfg_write_buf - Write a series of configuration words to the AXI2CFG
+ *	config write port.
+ *
+ * @buf: The buffer to write.
+ * @nr_words: The number of 32 bit words to write.
+ */
+extern void axi2cfg_write_buf(const u32 *buf, unsigned nr_words);
+
+/*
+ * axi2cfg_init - initialize the AXI2CFG hardware.
+ */
+extern void __init axi2cfg_init(void);
+
+/*
+ * axi2cfg_readl - read a register in the axi2cfg.
+ *
+ * Returns the value of the register.
+ *
+ * @offs: the byte offset to read from.
+ */
+extern unsigned long axi2cfg_readl(unsigned long offs);
+
+/*
+ * axi2cfg_writel - write an axi2cfg AXI domain register.
+ *
+ * @val: the value to write.
+ * @offs: the byte offset to write to.
+ */
+extern void axi2cfg_writel(unsigned long val, unsigned long offs);
+
+/*
+ * syscfg_read - read the system configuration register.
+ */
+u32 syscfg_read(void);
+
+/*
+ * syscfg_update - update specific bits in the syscfg register
+ *
+ * @mask: the bitmask for bits to update
+ * @val: the value to write to the register.
+ */
+void syscfg_update(u32 mask, u32 val);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* PICOXCELL_AXI2CFG_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/picoxcell/gpio.h b/arch/arm/mach-picoxcell/include/mach/picoxcell/gpio.h
new file mode 100644
index 0000000..f526271
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/picoxcell/gpio.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#ifndef PICOXCELL_GPIO_H
+#define PICOXCELL_GPIO_H
+
+#define GPIO_SW_PORT_A_DR_REG_OFFSET	    0x00
+#define GPIO_SW_PORT_A_DDR_REG_OFFSET	    0x04
+#define GPIO_SW_PORT_A_CTL_REG_OFFSET	    0x08
+#define GPIO_SW_PORT_B_DR_REG_OFFSET	    0x0C
+#define GPIO_SW_PORT_B_DDR_REG_OFFSET	    0x10
+#define GPIO_SW_PORT_B_CTL_REG_OFFSET	    0x14
+#define GPIO_SW_PORT_C_DR_REG_OFFSET	    0x18
+#define GPIO_SW_PORT_C_DDR_REG_OFFSET	    0x1C
+#define GPIO_SW_PORT_C_CTL_REG_OFFSET	    0x20
+#define GPIO_SW_PORT_D_DR_REG_OFFSET	    0x24
+#define GPIO_SW_PORT_D_DDR_REG_OFFSET	    0x28
+#define GPIO_SW_PORT_D_CTL_REG_OFFSET	    0x2C
+
+#define GPIO_INT_EN_REG_OFFSET		    0x30
+#define GPIO_INT_MASK_REG_OFFSET	    0x34
+#define GPIO_INT_TYPE_LEVEL_REG_OFFSET	    0x38
+#define GPIO_INT_POLARITY_REG_OFFSET	    0x3c
+
+#define GPIO_INT_STATUS_REG_OFFSET	    0x40
+
+#define GPIO_PORT_A_EOI_REG_OFFSET	    0x4c
+#define GPIO_EXT_PORT_A_REG_OFFSET	    0x50
+#define GPIO_EXT_PORT_B_REG_OFFSET	    0x54
+#define GPIO_EXT_PORT_C_REG_OFFSET	    0x58
+#define GPIO_EXT_PORT_D_REG_OFFSET	    0x5C
+
+#endif /* PICOXCELL_GPIO_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/picoxcell/picoxcell.h b/arch/arm/mach-picoxcell/include/mach/picoxcell/picoxcell.h
new file mode 100644
index 0000000..7f1917a
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/picoxcell/picoxcell.h
@@ -0,0 +1,61 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#ifndef __PICOXCELL_H__
+#define __PICOXCELL_H__
+
+#define BOOT_ROM_BASE			0xFFFF0000
+#define BOOT_ROM_SIZE			0x400
+#define AXI2PICO_BUFFERS_BASE		0xC0000000
+#define AXI2PICO_BUFFERS_SIZE		0x00010000
+#define PICOXCELL_PERIPH_BASE		0x80000000
+#define PICOXCELL_PERIPH_LENGTH		0x00400000
+#define PICOXCELL_MEMIF_BASE		0x80000000
+#define PICOXCELL_EBI_BASE		0x80010000
+#define PICOXCELL_EMAC_BASE		0x80030000
+#define PICOXCELL_DMAC1_BASE		0x80040000
+#define PICOXCELL_DMAC2_BASE		0x80050000
+#define PICOXCELL_VIC0_BASE		0x80060000
+#define PICOXCELL_VIC1_BASE		0x80064000
+#define PICOXCELL_TZIC_BASE		0x80068000
+#define PICOXCELL_TZPC_BASE		0x80070000
+#define PICOXCELL_FUSE_BASE		0x80080000
+#define PICOXCELL_SSI_BASE		0x80090000
+#define PICOXCELL_AXI2CFG_BASE		0x800A0000
+#define PICOXCELL_IPSEC_BASE		0x80100000
+#define PICOXCELL_SRTP_BASE		0x80140000
+#define PICOXCELL_CIPHER_BASE		0x80180000
+#define PICOXCELL_RTCLK_BASE		0x80200000
+#define PICOXCELL_TIMER_BASE		0x80210000
+#define PICOXCELL_GPIO_BASE		0x80220000
+#define PICOXCELL_UART1_BASE		0x80230000
+#define PICOXCELL_UART2_BASE		0x80240000
+#define PICOXCELL_WDOG_BASE		0x80250000
+#define PC3X3_RNG_BASE			0x800B0000
+#define PC3X3_TIMER2_BASE		0x80260000
+#define PC3X3_OTP_BASE			0xFFFF8000
+
+#define EBI_CS0_BASE			0x40000000
+#define EBI_CS1_BASE			0x48000000
+#define EBI_CS2_BASE			0x50000000
+#define EBI_CS3_BASE			0x58000000
+
+#define SRAM_BASE			0x20000000
+#define SRAM_START			0x20000000
+#define SRAM_SIZE			0x00020000
+
+#endif /* __PICOXCELL_H__ */
diff --git a/arch/arm/mach-picoxcell/include/mach/picoxcell/timer.h b/arch/arm/mach-picoxcell/include/mach/picoxcell/timer.h
new file mode 100644
index 0000000..3daf6b2
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/picoxcell/timer.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#ifndef PICOXCELL_TIMER_H
+#define PICOXCELL_TIMER_H
+
+/* The spacing between individual timers. */
+#define TIMER_SPACING			    0x14
+
+#define TIMER_LOAD_COUNT_REG_OFFSET	    0x00
+#define TIMER_CONTROL_REG_OFFSET	    0x08
+#define TIMER_EOI_REG_OFFSET		    0x0c
+
+#define TIMERS_EOI_REG_OFFSET		    0xa4
+
+#define TIMER_ENABLE			    0x00000001
+#define TIMER_MODE			    0x00000002
+#define TIMER_INTERRUPT_MASK		    0x00000004
+
+#define RTCLK_CCV_REG_OFFSET		    0x00
+
+#endif /* PICOXCELL_TIMER_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/picoxcell/wdog.h b/arch/arm/mach-picoxcell/include/mach/picoxcell/wdog.h
new file mode 100644
index 0000000..727780c
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/picoxcell/wdog.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#ifndef PICOXCELL_WDOG_H
+#define PICOXCELL_WDOG_H
+
+#define WDOG_CONTROL_REG_OFFSET		    0x00
+#define WDOG_TIMEOUT_RANGE_REG_OFFSET	    0x04
+#define WDOG_CURRENT_COUNT_REG_OFFSET	    0x08
+#define WDOG_COUNTER_RESTART_REG_OFFSET     0x0c
+#define WDOG_INT_STATUS_REG_OFFSET	    0x10
+#define WDOG_CLEAR_REG_OFFSET		    0x14
+
+#define WDOG_CONTROL_REG_RESET		    0x00000016
+#define WDOG_TIMEOUT_RANGE_REG_RESET	    0x0000000c
+#define WDOG_CURRENT_COUNT_REG_RESET	    0x0fffffff
+#define WDOG_COUNTER_RESTART_REG_RESET	    0x00000000
+#define WDOG_INT_STATUS_REG_RESET	    0x00000000
+#define WDOG_CLEAR_REG_RESET		    0x00000000
+
+#define WDOGCONTROLREGWDT_ENIDX		    0
+#define WDOGCONTROLREGRMODIDX		    1
+#define WDOGCONTROLREGRPLIDX		    2
+
+#define WDOG_CONTROL_REG_WDT_EN_MASK	    (1 << WDOGCONTROLREGWDT_ENIDX)
+#define WDOG_CONTROL_REG_RMOD_MASK	    (1 << WDOGCONTROLREGRMODIDX)
+#define WDOG_CONTROL_REG_RPL_MASK	    (0x7 << WDOGCONTROLREGRPLIDX)
+
+#endif /* PICOXCELL_WDOG_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/platform.h b/arch/arm/mach-picoxcell/include/mach/platform.h
new file mode 100644
index 0000000..ef7900f
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/platform.h
@@ -0,0 +1,32 @@
+/*
+ * platform.h
+ *
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#ifndef __ARCH_PICOXCELL_PLATFORM_H
+#define __ARCH_PICOXCELL_PLATFORM_H
+
+/* Physical address of the Flash in the ARM sub-system memory map */
+#define PICOXCELL_FLASH_BASE	    0x40000000
+
+/* The clock frequency for the UARTs */
+#define PICOXCELL_BASE_BAUD	    3686400	/* 3.6864 MHz */
+
+/* The clock frequency for the timers on the various boards */
+#define PICOXCELL_TIMER_FREQ	    200000000	/* 200 MHz */
+
+#endif /* __ARCH_PICOXCELL_PLATFORM_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/system.h b/arch/arm/mach-picoxcell/include/mach/system.h
new file mode 100644
index 0000000..73d889d
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/system.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H
+
+#include <mach/io.h>
+#include <mach/picoxcell/picoxcell.h>
+#include <mach/picoxcell/wdog.h>
+
+static inline void arch_idle(void)
+{
+	/*
+	 * This should do all the clock switching
+	 * and wait for interrupt tricks
+	 */
+	cpu_do_idle();
+}
+
+static inline void arch_reset(int mode, const char *cmd)
+{
+	/*
+	 * Set the watchdog to expire as soon as possible and reset the
+	 * system.
+	 */
+	writel(WDOG_CONTROL_REG_WDT_EN_MASK,
+	       IO_ADDRESS(PICOXCELL_WDOG_BASE + WDOG_CONTROL_REG_OFFSET));
+	writel(0, IO_ADDRESS(PICOXCELL_WDOG_BASE +
+			     WDOG_TIMEOUT_RANGE_REG_OFFSET));
+
+	/* Give it chance to reset. */
+	mdelay(500);
+
+	pr_crit("watchdog reset failed - entering infinite loop\n");
+}
+
+#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/timex.h b/arch/arm/mach-picoxcell/include/mach/timex.h
new file mode 100644
index 0000000..57740c5
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/timex.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#include <mach/platform.h>
+
+#define CLOCK_TICK_RATE		PICOXCELL_TIMER_FREQ
+
+#endif /* __TIMEX_H__ */
+
diff --git a/arch/arm/mach-picoxcell/include/mach/uncompress.h b/arch/arm/mach-picoxcell/include/mach/uncompress.h
new file mode 100644
index 0000000..ccaf3d5
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/uncompress.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
+#include <asm/processor.h>
+#include <linux/io.h>
+#include <linux/serial_reg.h>
+#include <mach/hardware.h>
+
+#define UART_SHIFT  2
+
+static inline void putc(int c)
+{
+	void __iomem *uart = (void __iomem *)(PICOXCELL_UART1_BASE);
+
+	while (!(readl(uart + (UART_LSR << UART_SHIFT)) & UART_LSR_THRE))
+		barrier();
+	writel(c & 0xFF, uart + (UART_TX << UART_SHIFT));
+}
+
+static inline void flush(void)
+{
+}
+
+static inline void arch_decomp_setup(void)
+{
+	void __iomem *uart = (void __iomem *)(PICOXCELL_UART1_BASE);
+
+	/* Reset and enable the FIFO's. */
+	writel(UART_FCR_ENABLE_FIFO, uart + (UART_FCR << UART_SHIFT));
+
+	/* Wait for the FIFO's to be enabled. */
+	while (!(readl(uart + (UART_FCR << UART_SHIFT)) & UART_FCR_TRIGGER_14))
+		cpu_relax();
+	/* Enable divisor access, set length to 8 bits. */
+	writel(UART_LCR_DLAB | UART_LCR_WLEN8, uart + (UART_LCR << UART_SHIFT));
+	/* Set for 115200 baud. */
+	writel(0x2, uart + (UART_DLL << UART_SHIFT));
+	writel(0x0, uart + (UART_DLM << UART_SHIFT));
+	writel(UART_LCR_WLEN8, uart + (UART_LCR << UART_SHIFT));
+}
+
+#define arch_decomp_wdog()
diff --git a/arch/arm/mach-picoxcell/include/mach/vmalloc.h b/arch/arm/mach-picoxcell/include/mach/vmalloc.h
new file mode 100644
index 0000000..09a7f75
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/vmalloc.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
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
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
new file mode 100644
index 0000000..f97919d
--- /dev/null
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -0,0 +1,187 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support@picochip.com
+ */
+#include <linux/debugfs.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/sysdev.h>
+
+#include <asm/hardware/vic.h>
+#include <asm/mach/map.h>
+#include <asm/mach-types.h>
+
+#include <mach/hardware.h>
+
+#include "mux.h"
+#include "picoxcell_core.h"
+#include "soc.h"
+
+struct picoxcell_soc *picoxcell_get_soc(void)
+{
+	unsigned long device_id = readl(IO_ADDRESS(PICOXCELL_AXI2CFG_BASE +
+					AXI2CFG_DEVICE_ID_REG_OFFSET));
+	switch (device_id) {
+	default:
+		panic("unsupported device type %lx", device_id);
+	}
+}
+
+void __init picoxcell_init_irq(void)
+{
+	u32 vic0_resume_sources =
+		(1 << (IRQ_AXI2PICO8 & 31)) |
+		(1 << (IRQ_EMAC & 31)) |
+		(1 << (IRQ_WDG & 31));
+
+	vic_init(IO_ADDRESS(PICOXCELL_VIC0_BASE), 32, 0xFFFFFFFE,
+		 vic0_resume_sources);
+	vic_init(IO_ADDRESS(PICOXCELL_VIC1_BASE), 0, 0x7FF, 0);
+}
+
+static const char *picoxcell_get_partname(void)
+{
+	unsigned long dev_id = axi2cfg_readl(AXI2CFG_DEVICE_ID_REG_OFFSET);
+	const char *part = "<unknown>";
+
+	return part;
+}
+
+static inline unsigned long picoxcell_get_revision(void)
+{
+	return axi2cfg_readl(AXI2CFG_REVISION_ID_REG_OFFSET);
+}
+
+static struct sysdev_class soc_sysdev_class = {
+	.name		= "soc",
+};
+
+static struct sys_device soc_sysdev_device = {
+	.id		= 0,
+	.cls		= &soc_sysdev_class,
+};
+
+static ssize_t part_show(struct sys_device *sysdev,
+			 struct sysdev_attribute *attr, char *buf)
+{
+	const char *part = picoxcell_get_partname();
+	return snprintf(buf, PAGE_SIZE, "%s\n", part);
+}
+static SYSDEV_ATTR(part, 0444, part_show, NULL);
+
+static ssize_t boot_mode_show(struct sys_device *sysdev,
+			      struct sysdev_attribute *attr, char *buf)
+{
+	struct picoxcell_soc *soc = picoxcell_get_soc();
+
+	return soc->get_boot_mode(buf);
+}
+static SYSDEV_ATTR(boot_mode, 0444, boot_mode_show, NULL);
+
+static ssize_t revision_show(struct sys_device *sysdev,
+			     struct sysdev_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%lu\n", picoxcell_get_revision());
+}
+static SYSDEV_ATTR(revision, 0444, revision_show, NULL);
+
+static ssize_t die_ident_show(struct sys_device *sysdev,
+			      struct sysdev_attribute *attr, char *buf)
+{
+	int i;
+
+	for (i = 0; i < 16; ++i)
+		snprintf(buf + (i * 2), PAGE_SIZE, "%02x",
+			 readb(IO_ADDRESS(PICOXCELL_FUSE_BASE + 0x60 + i)));
+	snprintf(buf + (i * 2), PAGE_SIZE, "\n");
+
+	return 33;
+}
+static SYSDEV_ATTR(die_ident, 0444, die_ident_show, NULL);
+
+static struct __init sysdev_attribute *sysdev_attrs[] = {
+	&attr_die_ident,
+	&attr_revision,
+	&attr_boot_mode,
+	&attr_part,
+	NULL,
+};
+
+static void __init socinfo_init(void)
+{
+	if (sysdev_class_register(&soc_sysdev_class)) {
+		pr_err("unable to register sysdev class\n");
+		return;
+	}
+
+	if (sysdev_register(&soc_sysdev_device)) {
+		pr_err("unable to register sysdev device\n");
+		return;
+	}
+
+	if (sysdev_create_files(&soc_sysdev_device, sysdev_attrs))
+		pr_err("unable to add sysdev attrs\n");
+}
+
+static void __init report_chipinfo(void)
+{
+	const char *part = picoxcell_get_partname();
+	unsigned long revision = picoxcell_get_revision();
+
+	pr_info("Picochip picoXcell device: %s revision %lu\n", part, revision);
+}
+
+struct dentry *arch_debugfs_dir;
+
+static void __init picoxcell_debugfs_init(void)
+{
+	arch_debugfs_dir = debugfs_create_dir("picoxcell", NULL);
+	if (IS_ERR(arch_debugfs_dir)) {
+		/* debugfs is enabled but we failed. */
+		if (-ENODEV != PTR_ERR(arch_debugfs_dir))
+			pr_err("failed to create picoxcell debugfs entry (%ld)\n",
+			       PTR_ERR(arch_debugfs_dir));
+		arch_debugfs_dir = NULL;
+		return;
+	}
+}
+
+static struct map_desc __initdata picoxcell_io_desc[] = {
+	{
+		.virtual    = PHYS_TO_IO(PICOXCELL_PERIPH_BASE),
+		.pfn	    = __phys_to_pfn(PICOXCELL_PERIPH_BASE),
+		.length     = PICOXCELL_PERIPH_LENGTH,
+		.type	    = MT_DEVICE,
+	},
+};
+
+void __init picoxcell_map_io(void)
+{
+	iotable_init(picoxcell_io_desc, ARRAY_SIZE(picoxcell_io_desc));
+}
+
+void __init picoxcell_core_init(void)
+{
+	struct picoxcell_soc *soc = picoxcell_get_soc();
+
+	BUG_ON(!soc);
+
+	axi2cfg_init();
+	report_chipinfo();
+	soc->init();
+
+	/*
+	 * Add the soc/soc0 entries to /sys/devices/system to report the
+	 * device type, boot mode etc.
+	 */
+	socinfo_init();
+
+	/* Add the arch debugfs entry. */
+	picoxcell_debugfs_init();
+}
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.h b/arch/arm/mach-picoxcell/picoxcell_core.h
new file mode 100644
index 0000000..5b27e52
--- /dev/null
+++ b/arch/arm/mach-picoxcell/picoxcell_core.h
@@ -0,0 +1,21 @@
+/*
+ * linux/arch/arm/mach-picoxcell/picoxcell_core.h
+ *
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#ifndef __ASM_ARCH_PICOXCELL_CORE_H__
+#define __ASM_ARCH_PICOXCELL_CORE_H__
+
+struct picoxcell_soc;
+
+extern void __init picoxcell_core_init(void);
+extern void __init picoxcell_init_irq(void);
+extern void __init picoxcell_map_io(void);
+
+#endif /* __ASM_ARCH_PICOXCELL_CORE_H__ */
diff --git a/arch/arm/mach-picoxcell/soc.h b/arch/arm/mach-picoxcell/soc.h
new file mode 100644
index 0000000..d24a0ce
--- /dev/null
+++ b/arch/arm/mach-picoxcell/soc.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#ifndef __PICOXCELL_SOC_H__
+#define __PICOXCELL_SOC_H__
+
+enum timer_type {
+	TIMER_TYPE_RTC,
+	TIMER_TYPE_TIMER,
+};
+
+struct picoxcell_timer {
+	const char			*name;
+	enum timer_type			type;
+	unsigned long			base;
+	int				irq;
+};
+
+enum picoxcell_features {
+	PICOXCELL_FEATURE_EBI,
+	PICOXCELL_FEATURE_SW_NAND,
+	PICOXCELL_FEATURE_PM,
+	PICOXCELL_FEATURE_CPUFREQ,
+	NR_FEAT_BITS
+};
+
+struct picoxcell_soc {
+	void				(*init)(void);
+	void				(*init_clocks)(void);
+	void				(*init_timers)(void);
+	void				(*init_muxing)(void);
+	ssize_t				(*get_boot_mode)(char *buf);
+	const char * const		*armgpio_pins;
+	int				nr_armgpio;
+	int				armgpio_base;
+	const char * const		*sdgpio_pins;
+	int				nr_sdgpio;
+	int				sdgpio_base;
+	const struct picoxcell_timer	*timers;
+	int				nr_timers;
+	unsigned long			features[BITS_TO_LONGS(NR_FEAT_BITS)];
+};
+
+extern struct picoxcell_soc *picoxcell_get_soc(void);
+
+static inline int picoxcell_has_feature(enum picoxcell_features feat)
+{
+	struct picoxcell_soc *soc = picoxcell_get_soc();
+
+	return test_bit(feat, soc->features);
+}
+
+#endif /* __PICOXCELL_SOC_H__ */
-- 
1.7.2.3
