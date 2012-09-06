From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  5 Sep 2012 23:07:18 -0600
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
Message-ID: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM2708 is an ARM SoC from Broadcom. It is the primary SoC in a
series which contains the BCM2835 amongst other variants. This patch
adds very basic support for this series of SoCs, under the BCM2708 name.

http://www.broadcom.com/products/BCM2835
http://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pd

Note that the documentation in the latter .pdf assumes the MMU setup that's
used on the "VideoCore" companion processor, and does not document physical
peripheral addresses. Subtract 0x5e000000 to obtain the physical addresses.

The BCM2835 SoC is used in the Raspberry Pi. This patch also adds a
minimal device tree for this board; enough to see some very early kernel
boot messages through earlyprintk.

http://www.raspberrypi.org/.

This series was extracted from git://github.com/lp0/linux.git branch
rpi-next or rpi-linear from 3-4 months ago, and significantly stripped
down and modified since. The work in that branch was signed-off-by:

    Chris Boot <bootc@bootc.net>
    Simon Arlott <sa.me.uk> [sic]

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
To do:
* Interrupt controller and timer aren't implemented, so the kernel only
  boots as far as "Calibrating delay loop...". However, this patch is
  intended solely to provide the very basic infra-structure so people
  can start filling in the gaps in mainline rather than downstream.
* No device drivers are implemented yet.

Questions:
* It is asserted (I believe by Broadcom) that the BCM2835 is the only SoC
  in the series likely to see Linux support. Irrespective, those working
  on BCM2835 support downstream (see git URL above) have chosen to name
  the kernel support after the primary SoC (BCM2708) rather than the
  particular instance in use on the Raspberry Pi (BCM2835). I've followed
  that here, although I wonder if it's really the correct thing to do?
* Should bcm2708_map_io() map the entire peripheral address range, or
  only the debug UART iff DEBUG_LL is enabled? Presumably anything other
  than the UART should be using of_iomap(), so doesn't need to be
  statically mapped; are the IRQ controller/timer set up before
  of_iomap() will work with non-static mappings?
* Does the (currently somewhat arbitrary) value for BCM2708_PERIPH_VIRT
  matter; should it be picked to align nicely with any particular part
  of the kernel's virtual address layout?
---
 arch/arm/Kconfig                                 |   19 ++++
 arch/arm/Makefile                                |    1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts              |   12 +++
 arch/arm/boot/dts/bcm2835.dtsi                   |   10 +++
 arch/arm/configs/bcm2708_defconfig               |  102 ++++++++++++++++++++++
 arch/arm/mach-bcm2708/Makefile                   |    1 +
 arch/arm/mach-bcm2708/Makefile.boot              |    5 ++
 arch/arm/mach-bcm2708/common.c                   |   80 +++++++++++++++++
 arch/arm/mach-bcm2708/include/mach/bcm2708_soc.h |   29 ++++++
 arch/arm/mach-bcm2708/include/mach/debug-macro.S |   24 +++++
 arch/arm/mach-bcm2708/include/mach/hardware.h    |   18 ++++
 arch/arm/mach-bcm2708/include/mach/timex.h       |   26 ++++++
 arch/arm/mach-bcm2708/include/mach/uncompress.h  |   49 +++++++++++
 13 files changed, 376 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-b.dts
 create mode 100644 arch/arm/boot/dts/bcm2835.dtsi
 create mode 100644 arch/arm/configs/bcm2708_defconfig
 create mode 100644 arch/arm/mach-bcm2708/Makefile
 create mode 100644 arch/arm/mach-bcm2708/Makefile.boot
 create mode 100644 arch/arm/mach-bcm2708/common.c
 create mode 100644 arch/arm/mach-bcm2708/include/mach/bcm2708_soc.h
 create mode 100644 arch/arm/mach-bcm2708/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-bcm2708/include/mach/hardware.h
 create mode 100644 arch/arm/mach-bcm2708/include/mach/timex.h
 create mode 100644 arch/arm/mach-bcm2708/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 88ff698..3c11dce 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -349,6 +349,25 @@ config ARCH_AT91
 	  This enables support for systems based on Atmel
 	  AT91RM9200 and AT91SAM9* processors.
 
+config ARCH_BCM2708
+	bool "Broadcom BCM2708 family"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
+	select ARM_ERRATA_411920
+	select ARM_TIMER_SP804
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select CPU_V6
+	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
+	select USE_OF
+	select WATCHDOG
+	help
+	  This enables support for the Broadcom BCM2708 SoC series. The
+	  BCM2835 is one such SoC in this series. The Raspberry Pi uses
+	  the BCM2835.
+
 config ARCH_BCMRING
 	bool "Broadcom BCMRING"
 	depends on MMU
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30eae87..853c761 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -136,6 +136,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_AT91)		:= at91
+machine-$(CONFIG_ARCH_BCM2708)		:= bcm2708
 machine-$(CONFIG_ARCH_BCMRING)		:= bcmring
 machine-$(CONFIG_ARCH_CLPS711X)		:= clps711x
 machine-$(CONFIG_ARCH_CNS3XXX)		:= cns3xxx
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
new file mode 100644
index 0000000..7e43197
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -0,0 +1,12 @@
+/dts-v1/;
+/memreserve/ 0x0c000000 0x04000000;
+/include/ "bcm2835.dtsi"
+
+/ {
+	model = "Raspberry Pi Model B";
+	compatible = "raspberrypi,model-b", "broadcom,bcm2835", "broadcom,bcm2708";
+
+	memory {
+		reg = <0 0x10000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
new file mode 100644
index 0000000..221a49a
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -0,0 +1,10 @@
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "broadcom,bcm2835", "broadcom,bcm2708";
+	model = "BCM2835";
+
+	chosen {
+		bootargs = "earlyprintk";			/* Set by VideoCore */
+	};
+};
diff --git a/arch/arm/configs/bcm2708_defconfig b/arch/arm/configs/bcm2708_defconfig
new file mode 100644
index 0000000..55cd103
--- /dev/null
+++ b/arch/arm/configs/bcm2708_defconfig
@@ -0,0 +1,102 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_FHANDLE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_RESOURCE_COUNTERS=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_NAMESPACES=y
+CONFIG_SCHED_AUTOGROUP=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_RD_BZIP2=y
+CONFIG_RD_LZMA=y
+CONFIG_RD_XZ=y
+CONFIG_RD_LZO=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
+CONFIG_JUMP_LABEL=y
+# CONFIG_BLOCK is not set
+CONFIG_ARCH_BCM2708=y
+CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_COMPACTION=y
+CONFIG_KSM=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
+CONFIG_CLEANCACHE=y
+CONFIG_SECCOMP=y
+CONFIG_CC_STACKPROTECTOR=y
+CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SUSPEND is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=48
+CONFIG_SERIAL_8250_RUNTIME_UARTS=32
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_AMBA_PL010=y
+CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_TTY_PRINTK=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_PROC_FS is not set
+# CONFIG_SYSFS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_PRINTK_TIME=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_UNUSED_SYMBOLS=y
+CONFIG_LOCKUP_DETECTOR=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_BOOT_PRINTK_DELAY=y
+CONFIG_SCHED_TRACER=y
+CONFIG_STACK_TRACER=y
+CONFIG_FUNCTION_PROFILER=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_KGDB=y
+CONFIG_KGDB_KDB=y
+CONFIG_TEST_KSTRTOX=y
+CONFIG_STRICT_DEVMEM=y
+CONFIG_DEBUG_LL=y
+CONFIG_EARLY_PRINTK=y
+# CONFIG_XZ_DEC_X86 is not set
+# CONFIG_XZ_DEC_POWERPC is not set
+# CONFIG_XZ_DEC_IA64 is not set
+# CONFIG_XZ_DEC_ARM is not set
+# CONFIG_XZ_DEC_ARMTHUMB is not set
+# CONFIG_XZ_DEC_SPARC is not set
diff --git a/arch/arm/mach-bcm2708/Makefile b/arch/arm/mach-bcm2708/Makefile
new file mode 100644
index 0000000..f95691b
--- /dev/null
+++ b/arch/arm/mach-bcm2708/Makefile
@@ -0,0 +1 @@
+obj-y += common.o
diff --git a/arch/arm/mach-bcm2708/Makefile.boot b/arch/arm/mach-bcm2708/Makefile.boot
new file mode 100644
index 0000000..0831fd1
--- /dev/null
+++ b/arch/arm/mach-bcm2708/Makefile.boot
@@ -0,0 +1,5 @@
+   zreladdr-y := 0x00008000
+params_phys-y := 0x00000100
+initrd_phys-y := 0x00800000
+
+dtb-y += bcm2835-rpi-b.dtb
diff --git a/arch/arm/mach-bcm2708/common.c b/arch/arm/mach-bcm2708/common.c
new file mode 100644
index 0000000..85f19aa3
--- /dev/null
+++ b/arch/arm/mach-bcm2708/common.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2012 Stephen Warren
+ *
+ * Derived from code:
+ * Copyright (C) 2010 Broadcom
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
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <asm/exception.h>
+
+#include <mach/bcm2708_soc.h>
+
+static struct map_desc io_map __initdata = {
+	.virtual = BCM2708_PERIPH_VIRT,
+	.pfn = __phys_to_pfn(BCM2708_PERIPH_BASE),
+	.length = BCM2708_PERIPH_SIZE,
+	.type = MT_DEVICE
+};
+
+void __init bcm2708_map_io(void)
+{
+	iotable_init(&io_map, 1);
+}
+
+void __init bcm2708_init_irq(void)
+{
+}
+
+asmlinkage void __exception_irq_entry bcm2708_handle_irq(struct pt_regs *regs)
+{
+}
+
+void __init bcm2708_init(void)
+{
+	int ret;
+
+	ret = of_platform_populate(NULL, of_default_bus_match_table, NULL,
+				   NULL);
+	if (ret) {
+		pr_err("of_platform_populate failed: %d\n", ret);
+		BUG();
+	}
+}
+
+static void __init bcm2708_timer_init(void)
+{
+}
+
+struct sys_timer bcm2708_timer = {
+	.init = bcm2708_timer_init
+};
+
+static const char * const bcm2708_compat[] = {
+	"broadcom,bcm2708",
+	NULL
+};
+
+DT_MACHINE_START(BCM2708, "BCM2708")
+	.map_io = bcm2708_map_io,
+	.init_irq = bcm2708_init_irq,
+	.handle_irq = bcm2708_handle_irq,
+	.init_machine = bcm2708_init,
+	.timer = &bcm2708_timer,
+	.dt_compat = bcm2708_compat
+MACHINE_END
diff --git a/arch/arm/mach-bcm2708/include/mach/bcm2708_soc.h b/arch/arm/mach-bcm2708/include/mach/bcm2708_soc.h
new file mode 100644
index 0000000..4ddeb4e
--- /dev/null
+++ b/arch/arm/mach-bcm2708/include/mach/bcm2708_soc.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2012 Stephen Warren
+ *
+ * Derived from code:
+ * Copyright (C) 2010 Broadcom
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
+
+#ifndef __MACH_BCM2708_BCM2708_SOC_H__
+#define __MACH_BCM2708_BCM2708_SOC_H__
+
+#include <asm/sizes.h>
+
+#define BCM2708_PERIPH_BASE	0x20000000
+#define BCM2708_PERIPH_VIRT	0xf0000000
+#define BCM2708_PERIPH_SIZE	SZ_16M
+#define BCM2708_DEBUG_BASE	0x20201000
+#define BCM2708_DEBUG_VIRT	0xf0201000
+
+#endif
diff --git a/arch/arm/mach-bcm2708/include/mach/debug-macro.S b/arch/arm/mach-bcm2708/include/mach/debug-macro.S
new file mode 100644
index 0000000..ef71e41
--- /dev/null
+++ b/arch/arm/mach-bcm2708/include/mach/debug-macro.S
@@ -0,0 +1,24 @@
+/*
+ * Debugging macro include header
+ *
+ * Copyright (C) 2012 Stephen Warren
+ *
+ * Derived from code:
+ *  Copyright (C) 2010 Broadcom
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <mach/bcm2708_soc.h>
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =BCM2708_DEBUG_BASE
+	ldr	\rv, =BCM2708_DEBUG_VIRT
+	.endm
+
+#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-bcm2708/include/mach/hardware.h b/arch/arm/mach-bcm2708/include/mach/hardware.h
new file mode 100644
index 0000000..2b15d0b
--- /dev/null
+++ b/arch/arm/mach-bcm2708/include/mach/hardware.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2012 Stephen Warren
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
+
+#ifndef __MACH_BCM2708_HARDWARE_H__
+#define __MACH_BCM2708_HARDWARE_H__
+
+#endif
diff --git a/arch/arm/mach-bcm2708/include/mach/timex.h b/arch/arm/mach-bcm2708/include/mach/timex.h
new file mode 100644
index 0000000..ca67219
--- /dev/null
+++ b/arch/arm/mach-bcm2708/include/mach/timex.h
@@ -0,0 +1,26 @@
+/*
+ *  BCM2708 system clock frequency
+ *
+ *  Copyright (C) 2010 Broadcom
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
+#ifndef __ASM_ARCH_TIMEX_H
+#define __ASM_ARCH_TIMEX_H
+
+#define CLOCK_TICK_RATE		(1000000)
+
+#endif
diff --git a/arch/arm/mach-bcm2708/include/mach/uncompress.h b/arch/arm/mach-bcm2708/include/mach/uncompress.h
new file mode 100644
index 0000000..0c8fe04
--- /dev/null
+++ b/arch/arm/mach-bcm2708/include/mach/uncompress.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2012 Stephen Warren
+ *
+ * Derived from code:
+ * Copyright (C) 2010 Broadcom
+ * Copyright (C) 2003 ARM Limited
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
+
+#include <linux/io.h>
+#include <linux/amba/serial.h>
+#include <mach/bcm2708_soc.h>
+
+#define UART_BAUD 115200
+#define UART0_BASE BCM2708_DEBUG_BASE
+
+#define BCM2708_UART_DR IOMEM(UART0_BASE + UART01x_DR)
+#define BCM2708_UART_FR IOMEM(UART0_BASE + UART01x_FR)
+#define BCM2708_UART_CR IOMEM(UART0_BASE + UART011_CR)
+
+static inline void putc(int c)
+{
+	while (__raw_readl(BCM2708_UART_FR) & UART01x_FR_TXFF)
+		barrier();
+
+	__raw_writel(c, BCM2708_UART_DR);
+}
+
+static inline void flush(void)
+{
+	int fr;
+
+	do {
+		fr = __raw_readl(BCM2708_UART_FR);
+		barrier();
+	} while ((fr & (UART011_FR_TXFE | UART01x_FR_BUSY)) != UART011_FR_TXFE);
+}
+
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
-- 
1.7.9.5
