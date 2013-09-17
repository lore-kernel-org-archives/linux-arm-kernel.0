From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 17 Sep 2013 21:58:04 +0200
Subject: [PATCH v2] ARM: new platform for Energy Micro's EFM32 Cortex-M3 SoCs
Message-ID: <1379447884-14025-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1 sent with Message-id:
1376552964-16296-1-git-send-email-u.kleine-koenig at pengutronix.de:

 - drop adding device trees as this depends on a patch not yet mainline
   (clk: new driver for efm32 SoC)
 - drop adding code for timekeeping. Sent as a separate patch which adds code
   to drivers/clocksource. (No compile time dependencies)

 arch/arm/Kconfig                               |  16 +++-
 arch/arm/Kconfig.debug                         |  16 ++++
 arch/arm/Makefile                              |   1 +
 arch/arm/configs/efm32_defconfig               | 104 +++++++++++++++++++++++++
 arch/arm/mach-efm32/Makefile                   |   1 +
 arch/arm/mach-efm32/Makefile.boot              |   2 +
 arch/arm/mach-efm32/cmu.h                      |  15 ++++
 arch/arm/mach-efm32/common.c                   |  19 +++++
 arch/arm/mach-efm32/common.h                   |   1 +
 arch/arm/mach-efm32/dtmachine.c                |  31 ++++++++
 arch/arm/mach-efm32/include/mach/debug-macro.S |  48 ++++++++++++
 arch/arm/mach-efm32/include/mach/entry-macro.S |   5 ++
 arch/arm/mach-efm32/include/mach/io.h          |   6 ++
 arch/arm/mach-efm32/include/mach/irqs.h        |   6 ++
 arch/arm/mach-efm32/include/mach/timex.h       |   7 ++
 15 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/configs/efm32_defconfig
 create mode 100644 arch/arm/mach-efm32/Makefile
 create mode 100644 arch/arm/mach-efm32/Makefile.boot
 create mode 100644 arch/arm/mach-efm32/cmu.h
 create mode 100644 arch/arm/mach-efm32/common.c
 create mode 100644 arch/arm/mach-efm32/common.h
 create mode 100644 arch/arm/mach-efm32/dtmachine.c
 create mode 100644 arch/arm/mach-efm32/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-efm32/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-efm32/include/mach/io.h
 create mode 100644 arch/arm/mach-efm32/include/mach/irqs.h
 create mode 100644 arch/arm/mach-efm32/include/mach/timex.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3f7714d..88198e4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -406,6 +406,20 @@ config ARCH_EBSA110
 	  Ethernet interface, two PCMCIA sockets, two serial ports and a
 	  parallel port.
 
+config ARCH_EFM32
+	bool "Energy Micro Cortex M3 Platform"
+	depends on !MMU
+	select ARM_NVIC
+	select CLKSRC_MMIO
+	select CLKSRC_OF
+	select COMMON_CLK
+	select CPU_V7M
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+	select NO_DMA
+	select NO_IOPORT
+	select USE_OF
+
 config ARCH_EP93XX
 	bool "EP93xx-based"
 	select ARCH_HAS_HOLES_MEMORYMODEL
@@ -1803,7 +1817,7 @@ config FORCE_MAX_ZONEORDER
 	int "Maximum zone order" if ARCH_SHMOBILE
 	range 11 64 if ARCH_SHMOBILE
 	default "12" if SOC_AM33XX
-	default "9" if SA1111
+	default "9" if SA1111 || ARCH_EFM32
 	default "11"
 	help
 	  The kernel memory allocator divides physically contiguous memory
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9762c84..27f37e8 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -173,6 +173,22 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the serial port in the DC21285 (Footbridge).
 
+	config DEBUG_EFM32_UART1
+		bool "Kernel low-level debugging messages via UART1 (ttyefm4)"
+		depends on ARCH_EFM32
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the second UART port on efm32 based
+		  machines.
+
+	config DEBUG_EFM32_USART1
+		bool "Kernel low-level debugging messages via USART1 (ttyefm1)"
+		depends on ARCH_EFM32
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the second USART port on efm32 based
+		  machines.
+
 	config DEBUG_FOOTBRIDGE_COM1
 		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
 		depends on FOOTBRIDGE
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a37a50f..bee8be4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -152,6 +152,7 @@ machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
 machine-$(CONFIG_ARCH_DOVE)		+= dove
 machine-$(CONFIG_ARCH_EBSA110)		+= ebsa110
+machine-$(CONFIG_ARCH_EFM32)		+= efm32
 machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
diff --git a/arch/arm/configs/efm32_defconfig b/arch/arm/configs/efm32_defconfig
new file mode 100644
index 0000000..b31af07
--- /dev/null
+++ b/arch/arm/configs/efm32_defconfig
@@ -0,0 +1,104 @@
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_LOG_BUF_SHIFT=12
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_UID16 is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_SIGNALFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_AIO is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_SLUB_CPU_PARTIAL is not set
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_MMU is not set
+CONFIG_ARCH_EFM32=y
+# CONFIG_KUSER_HELPERS is not set
+CONFIG_SET_MEM_PARAM=y
+CONFIG_DRAM_BASE=0x88000000
+CONFIG_DRAM_SIZE=0x00400000
+CONFIG_FLASH_MEM_BASE=0x8c000000
+CONFIG_FLASH_SIZE=0x01000000
+CONFIG_PREEMPT=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_XIP_KERNEL=y
+CONFIG_XIP_PHYS_ADDR=0x8c000000
+CONFIG_BINFMT_FLAT=y
+CONFIG_BINFMT_SHARED_FLAT=y
+# CONFIG_COREDUMP is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_FW_LOADER is not set
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK_RO=y
+CONFIG_MTD_ROM=y
+CONFIG_MTD_UCLINUX=y
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_BLK_DEV is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+CONFIG_KS8851=y
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_NONSTANDARD=y
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_EFM32_UART=y
+CONFIG_SERIAL_EFM32_UART_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_SPI_EFM32=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_SPI=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+CONFIG_ROMFS_FS=y
+CONFIG_ROMFS_BACKED_BY_MTD=y
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_LL=y
+CONFIG_EARLY_PRINTK=y
diff --git a/arch/arm/mach-efm32/Makefile b/arch/arm/mach-efm32/Makefile
new file mode 100644
index 0000000..081f45a
--- /dev/null
+++ b/arch/arm/mach-efm32/Makefile
@@ -0,0 +1 @@
+obj-y += common.o dtmachine.o
diff --git a/arch/arm/mach-efm32/Makefile.boot b/arch/arm/mach-efm32/Makefile.boot
new file mode 100644
index 0000000..1d56a92
--- /dev/null
+++ b/arch/arm/mach-efm32/Makefile.boot
@@ -0,0 +1,2 @@
+# This file is still needed because we cannot select ARCH_MULTIPLATFORM (as it
+# depends on MMU) and then this file is sourced in arch/arm/boot/Makefile
diff --git a/arch/arm/mach-efm32/cmu.h b/arch/arm/mach-efm32/cmu.h
new file mode 100644
index 0000000..a7e5741
--- /dev/null
+++ b/arch/arm/mach-efm32/cmu.h
@@ -0,0 +1,15 @@
+/*
+ * Register definition for efm32's CMU component
+ */
+
+#define CMU_OSCENCMD		0x20
+#define CMU_OSCENCMD_HFXOEN		0x00000004
+
+#define CMU_CMD			0x24
+#define CMU_CMD_HFCLKSEL_HFXO		0x00000002
+
+#define CMU_STATUS		0x2c
+#define CMU_STATUS_HFRCOSEL		0x00000400
+#define CMU_STATUS_HFXOSEL		0x00000800
+
+#define CMU_HFPERCLKEN0		0x44
diff --git a/arch/arm/mach-efm32/common.c b/arch/arm/mach-efm32/common.c
new file mode 100644
index 0000000..3a4528d
--- /dev/null
+++ b/arch/arm/mach-efm32/common.c
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2012-2013 Uwe Kleine-Koenig for Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+
+#include "common.h"
+
+void __init efm32_init_time(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
diff --git a/arch/arm/mach-efm32/common.h b/arch/arm/mach-efm32/common.h
new file mode 100644
index 0000000..5ee82f2
--- /dev/null
+++ b/arch/arm/mach-efm32/common.h
@@ -0,0 +1 @@
+void efm32_init_time(void);
diff --git a/arch/arm/mach-efm32/dtmachine.c b/arch/arm/mach-efm32/dtmachine.c
new file mode 100644
index 0000000..d0362e3
--- /dev/null
+++ b/arch/arm/mach-efm32/dtmachine.c
@@ -0,0 +1,31 @@
+#include <linux/kernel.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/irqchip.h>
+
+#include <asm/v7m.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include "common.h"
+
+static void __init efm32_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *const efm32gg_compat[] __initconst = {
+	"efm32,dk3750",
+	NULL
+};
+
+DT_MACHINE_START(EFM32DT, "EFM32 (Device Tree Support)")
+	.init_irq = irqchip_init,
+	.init_time = efm32_init_time,
+	.init_machine = efm32_init,
+	.dt_compat = efm32gg_compat,
+	.restart = armv7m_restart,
+MACHINE_END
diff --git a/arch/arm/mach-efm32/include/mach/debug-macro.S b/arch/arm/mach-efm32/include/mach/debug-macro.S
new file mode 100644
index 0000000..c58915c
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/debug-macro.S
@@ -0,0 +1,48 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define UARTn_CMD		0x000c
+#define UARTn_CMD_TXEN			0x0004
+
+#define	UARTn_STATUS		0x0010
+#define	UARTn_STATUS_TXC		0x0020
+#define	UARTn_STATUS_TXBL		0x0040
+
+#define	UARTn_TXDATA		0x0034
+
+		.macro	addruart, rx, tmp
+#if defined(CONFIG_DEBUG_EFM32_USART1)
+		ldr	\rx, =(0x4000c400)		/* USART1 */
+#elif defined(CONFIG_DEBUG_EFM32_UART1)
+		ldr	\rx, =(0x4000e400)		/* UART1 */
+#else
+#error "No debug port configured"
+#endif
+		/*
+		 * enable TX. The driver might disable that to save energy. We
+		 * don't care about disabling at the end as during debug power
+		 * consumption isn't that important.
+		 */
+		ldr	\tmp, =(UARTn_CMD_TXEN)
+		str	\tmp, [\rx, #UARTn_CMD]
+		.endm
+
+
+		.macro	senduart,rd,rx
+		strb	\rd, [\rx, #UARTn_TXDATA]
+		.endm
+
+		.macro	waituart,rd,rx
+1001:		ldr	\rd, [\rx, #UARTn_STATUS]
+		tst	\rd, #UARTn_STATUS_TXBL
+		beq	1001b
+		.endm
+
+		.macro	busyuart,rd,rx
+1001:		ldr	\rd, [\rx, UARTn_STATUS]
+		tst	\rd, #UARTn_STATUS_TXC
+		bne	1001b
+		.endm
diff --git a/arch/arm/mach-efm32/include/mach/entry-macro.S b/arch/arm/mach-efm32/include/mach/entry-macro.S
new file mode 100644
index 0000000..f0c0f7d
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/entry-macro.S
@@ -0,0 +1,5 @@
+		.macro	get_irqnr_preamble, base, tmp
+		.endm
+
+		.macro	arch_ret_to_user, tmp1, tmp2
+		.endm
diff --git a/arch/arm/mach-efm32/include/mach/io.h b/arch/arm/mach-efm32/include/mach/io.h
new file mode 100644
index 0000000..bc3519b
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/io.h
@@ -0,0 +1,6 @@
+#ifndef __MACH_IO_H__
+#define __MACH_IO_H__
+
+#define __mem_pci(a)		(a)
+
+#endif /* __MACH_IO_H__ */
diff --git a/arch/arm/mach-efm32/include/mach/irqs.h b/arch/arm/mach-efm32/include/mach/irqs.h
new file mode 100644
index 0000000..e33ed12
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/irqs.h
@@ -0,0 +1,6 @@
+#ifndef __MACH_IRQS_H__
+#define __MACH_IRQS_H__
+
+#define NR_IRQS			82
+
+#endif /* __MACH_IRQS_H__ */
diff --git a/arch/arm/mach-efm32/include/mach/timex.h b/arch/arm/mach-efm32/include/mach/timex.h
new file mode 100644
index 0000000..b408dce
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/timex.h
@@ -0,0 +1,7 @@
+#ifndef __MACH_TIMEX_H__
+#define __MACH_TIMEX_H__
+
+/* just a bogus value */
+#define CLOCK_TICK_RATE	12345678
+
+#endif /* __MACH_TIMEX_H__ */
-- 
1.8.4.rc3
