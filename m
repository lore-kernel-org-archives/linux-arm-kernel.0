From: linux@rempel-privat.de (Oleksij Rempel)
Date: Sun, 14 Sep 2014 00:13:22 +0200
Subject: [PATCH 1/7] ARM: add mach-asm9260
In-Reply-To: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
References: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1410646408-28901-2-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/Kconfig                    | 16 ++++++++
 arch/arm/Makefile                   |  1 +
 arch/arm/mach-asm9260/Kconfig       | 66 +++++++++++++++++++++++++++++++
 arch/arm/mach-asm9260/Makefile      | 11 ++++++
 arch/arm/mach-asm9260/Makefile.boot |  2 +
 arch/arm/mach-asm9260/core.c        | 77 +++++++++++++++++++++++++++++++++++++
 6 files changed, 173 insertions(+)
 create mode 100644 arch/arm/mach-asm9260/Kconfig
 create mode 100644 arch/arm/mach-asm9260/Makefile
 create mode 100644 arch/arm/mach-asm9260/Makefile.boot
 create mode 100644 arch/arm/mach-asm9260/core.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 245058b..fb56189 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -373,6 +373,20 @@ config ARCH_AT91
 	  This enables support for systems based on Atmel
 	  AT91RM9200 and AT91SAM9* processors.
 
+config MACH_ASM9260
+	bool "Alpscale ASM9260"
+	select ARCH_REQUIRE_GPIOLIB
+	select COMMON_CLK
+	select IRQ_DOMAIN
+	select SPARSE_IRQ
+	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_CHIP
+	select GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	select CPU_ARM926T
+	help
+	  Support for Alpscale ASM9260 based platform.
+
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select ARCH_REQUIRE_GPIOLIB
@@ -915,6 +929,8 @@ source "arch/arm/mach-mvebu/Kconfig"
 
 source "arch/arm/mach-at91/Kconfig"
 
+source "arch/arm/mach-asm9260/Kconfig"
+
 source "arch/arm/mach-axxia/Kconfig"
 
 source "arch/arm/mach-bcm/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6721fab..c383d02 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -143,6 +143,7 @@ textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_AT91)		+= at91
+machine-$(CONFIG_MACH_ASM9260)		+= asm9260
 machine-$(CONFIG_ARCH_AXXIA)		+= axxia
 machine-$(CONFIG_ARCH_BCM)		+= bcm
 machine-$(CONFIG_ARCH_BERLIN)		+= berlin
diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
new file mode 100644
index 0000000..f7240d8
--- /dev/null
+++ b/arch/arm/mach-asm9260/Kconfig
@@ -0,0 +1,66 @@
+if MACH_ASM9260
+
+menu "ASM9260T EVK Uart Enable"
+
+config ENABLE_UART0
+	bool "Enable UART0"
+	depends on SERIAL_ASM9260
+	default n
+
+config ENABLE_UART1
+	bool "Enable UART1"
+	depends on SERIAL_ASM9260
+	default n
+
+config ENABLE_UART2
+	bool "Enable UART2"
+	depends on SERIAL_ASM9260
+	default n
+
+
+config ENABLE_UART3
+	bool "Enable UART3"
+	depends on SERIAL_ASM9260
+	default n
+
+
+config ENABLE_UART4
+	bool "Enable UART4"
+	depends on SERIAL_ASM9260
+	default n
+
+
+config ENABLE_UART5
+	bool "Enable UART5"
+	depends on SERIAL_ASM9260
+	default n
+
+
+config ENABLE_UART6
+	bool "Enable UART6"
+	depends on SERIAL_ASM9260
+	default n
+
+
+config ENABLE_UART7
+	bool "Enable UART7"
+	depends on SERIAL_ASM9260
+	default n
+
+
+config ENABLE_UART8
+	bool "Enable UART8"
+	depends on SERIAL_ASM9260
+	default n
+
+
+config ENABLE_UART9
+	bool "Enable UART9"
+	depends on SERIAL_ASM9260
+	default n
+
+endmenu
+
+
+endif
+
diff --git a/arch/arm/mach-asm9260/Makefile b/arch/arm/mach-asm9260/Makefile
new file mode 100644
index 0000000..4bd8ebd
--- /dev/null
+++ b/arch/arm/mach-asm9260/Makefile
@@ -0,0 +1,11 @@
+#
+# Makefile for the linux kernel.
+#
+
+# Object file lists.
+
+obj-y			:= core.o
+obj-m			:=
+obj-n			:=
+obj-			:=
+
diff --git a/arch/arm/mach-asm9260/Makefile.boot b/arch/arm/mach-asm9260/Makefile.boot
new file mode 100644
index 0000000..c57b3b4
--- /dev/null
+++ b/arch/arm/mach-asm9260/Makefile.boot
@@ -0,0 +1,2 @@
+zreladdr-y	:= 0x20008000
+
diff --git a/arch/arm/mach-asm9260/core.c b/arch/arm/mach-asm9260/core.c
new file mode 100644
index 0000000..eee7a9d
--- /dev/null
+++ b/arch/arm/mach-asm9260/core.c
@@ -0,0 +1,77 @@
+/*
+ * Copyright (C) 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *  Co-author: Du Huanpeng <u74147@gmail.com>
+ * map_desc based on:
+ *  linux/arch/arm/mach-asm9260/core.c
+ *  Copyright (C) 2011-2014 Alpscale
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+static struct map_desc asm9260_io_desc[] __initdata = {
+	{	/* IO space */
+		.virtual	= (unsigned long)0xf0000000,
+		.pfn		= __phys_to_pfn(0x80000000),
+		.length		= 0x00800000,
+		.type		= MT_DEVICE
+	},
+	{	/* LCD IO space	*/
+		.virtual	= (unsigned long)0xf0a00000,
+		.pfn		= __phys_to_pfn(0x80800000),
+		.length		= 0x00009000,
+		.type		= MT_DEVICE
+	},
+	{	/* GPIO IO space */
+		.virtual	= (unsigned long)0xf0800000,
+		.pfn		= __phys_to_pfn(0x50000000),
+		.length		= 0x00100000,
+		.type		= MT_DEVICE
+	},
+	{	/* SRAM space Cacheable */
+		.virtual	= (unsigned long)0xd0000000,
+		.pfn		= __phys_to_pfn(0x40000000),
+		.length		= 0x00100000,
+#ifdef CONFIG_SRAM_MEM_CACHED
+		.type		= MT_MEMORY
+#else
+		.type		= MT_DEVICE
+#endif
+	},
+};
+
+static void __init asm9260_map_io(void)
+{
+	iotable_init(asm9260_io_desc, ARRAY_SIZE(asm9260_io_desc));
+}
+
+static void __init asm9260_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const asm9260_dt_board_compat[] __initconst = {
+	"alpscale,asm9260",
+	NULL
+};
+
+DT_MACHINE_START(ASM9260, "Alpscale ASM9260 (Device Tree Support)")
+	.map_io		= asm9260_map_io,
+	.init_machine	= asm9260_init,
+	.dt_compat	= asm9260_dt_board_compat,
+MACHINE_END
-- 
1.9.1
