From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 11 Oct 2012 20:59:13 +1300
Subject: [RFC PATCHv2] ARM: vt8500: Convert arch-vt8500 to multiplatform
Message-ID: <1349942353-14972-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch completes the conversion to ARCH_MULTI_V5 for arch-vt8500.
Removed /mach/include/ and remaining unneeded files.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
v2	Added the missing arch/arm/mach-vt8500/Kconfig

 arch/arm/Kconfig                                |   18 ++----------
 arch/arm/mach-vt8500/Kconfig                    |   11 +++++++
 arch/arm/mach-vt8500/include/mach/debug-macro.S |   31 -------------------
 arch/arm/mach-vt8500/include/mach/timex.h       |   26 ----------------
 arch/arm/mach-vt8500/include/mach/uncompress.h  |   36 -----------------------
 5 files changed, 13 insertions(+), 109 deletions(-)
 create mode 100644 arch/arm/mach-vt8500/Kconfig
 delete mode 100644 arch/arm/mach-vt8500/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-vt8500/include/mach/timex.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 32b62ac..e71ad2c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -938,22 +938,6 @@ config PLAT_SPEAR
 	help
 	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
 
-config ARCH_VT8500
-	bool "VIA/WonderMedia 85xx"
-	select CPU_ARM926T
-	select GENERIC_GPIO
-	select ARCH_HAS_CPUFREQ
-	select GENERIC_CLOCKEVENTS
-	select ARCH_REQUIRE_GPIOLIB
-	select USE_OF
-	select COMMON_CLK
-	select HAVE_CLK
-	select CLKDEV_LOOKUP
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-	help
-	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
-
 config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform"
 	select CPU_V7
@@ -1125,6 +1109,8 @@ source "arch/arm/mach-versatile/Kconfig"
 source "arch/arm/mach-vexpress/Kconfig"
 source "arch/arm/plat-versatile/Kconfig"
 
+source "arch/arm/mach-vt8500/Kconfig"
+
 source "arch/arm/mach-w90x900/Kconfig"
 
 # Definitions to make life easier
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
new file mode 100644
index 0000000..fa0c9fa
--- /dev/null
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -0,0 +1,11 @@
+config ARCH_VT8500
+	bool "VIA/WonderMedia 85xx" if ARCH_MULTI_V5
+	select ARCH_HAS_CPUFREQ
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select CPU_ARM926T
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
+	select HAVE_CLK
+	help
+	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
diff --git a/arch/arm/mach-vt8500/include/mach/debug-macro.S b/arch/arm/mach-vt8500/include/mach/debug-macro.S
deleted file mode 100644
index ca292f2..0000000
--- a/arch/arm/mach-vt8500/include/mach/debug-macro.S
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * arch/arm/mach-vt8500/include/mach/debug-macro.S
- *
- *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
- *
- * Debugging macro include header
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-
-	.macro	addruart, rp, rv, tmp
-	mov	\rp,      #0x00200000
-	orr	\rv, \rp, #0xf8000000
-	orr	\rp, \rp, #0xd8000000
-	.endm
-
-	.macro	senduart,rd,rx
-	strb	\rd, [\rx, #0]
-	.endm
-
-	.macro	busyuart,rd,rx
-1001:	ldr	\rd, [\rx, #0x1c]
-	ands	\rd, \rd, #0x2
-	bne	1001b
-	.endm
-
-	.macro	waituart,rd,rx
-	.endm
diff --git a/arch/arm/mach-vt8500/include/mach/timex.h b/arch/arm/mach-vt8500/include/mach/timex.h
deleted file mode 100644
index 8487e4c..0000000
--- a/arch/arm/mach-vt8500/include/mach/timex.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *  arch/arm/mach-vt8500/include/mach/timex.h
- *
- *  Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef MACH_TIMEX_H
-#define MACH_TIMEX_H
-
-#define CLOCK_TICK_RATE		(3000000)
-
-#endif /* MACH_TIMEX_H */
diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
deleted file mode 100644
index a9b6cae..0000000
--- a/arch/arm/mach-vt8500/include/mach/uncompress.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* arch/arm/mach-vt8500/include/mach/uncompress.h
- *
- * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
- *
- * Based on arch/arm/mach-dove/include/mach/uncompress.h
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-#define UART0_PHYS     0xd8200000
-#define UART0_ADDR(x)  *(volatile unsigned char *)(UART0_PHYS + x)
-
-static void putc(const char c)
-{
-	while (UART0_ADDR(0x1c) & 0x2)
-		/* Tx busy, wait and poll */;
-
-	UART0_ADDR(0) = c;
-}
-
-static void flush(void)
-{
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-#define arch_decomp_wdog()
-- 
1.7.9.5
