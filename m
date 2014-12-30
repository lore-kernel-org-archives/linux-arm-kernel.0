From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Dec 2014 13:28:37 -0600
Subject: [PATCH 8/9] ARM: versatile: convert to multi-platform
In-Reply-To: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
Message-ID: <1419967718-26909-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Now that all the prerequisites are in place, we can enable Versatile
boards for multi-platform kernels.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                  | 21 +----------
 arch/arm/mach-versatile/Kconfig                   | 14 +++++++
 arch/arm/mach-versatile/Makefile.boot             |  4 --
 arch/arm/mach-versatile/include/mach/uncompress.h | 45 -----------------------
 4 files changed, 16 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm/mach-versatile/Kconfig
 delete mode 100644 arch/arm/mach-versatile/Makefile.boot
 delete mode 100644 arch/arm/mach-versatile/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7816b54..4d9858f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -337,25 +337,6 @@ config ARCH_REALVIEW
 	help
 	  This enables support for ARM Ltd RealView boards.
 
-config ARCH_VERSATILE
-	bool "ARM Ltd. Versatile family"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_AMBA
-	select ARM_TIMER_SP804
-	select ARM_VIC
-	select CLKSRC_VERSATILE
-	select COMMON_CLK
-	select COMMON_CLK_VERSATILE
-	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
-	select ICST
-	select MIGHT_HAVE_PCI
-	select SPARSE_IRQ
-	select USE_OF
-	select VERSATILE_FPGA_IRQ
-	help
-	  This enables support for ARM Ltd Versatile board.
-
 config ARCH_AT91
 	bool "Atmel AT91"
 	select ARCH_REQUIRE_GPIOLIB
@@ -956,6 +937,8 @@ source "arch/arm/mach-u300/Kconfig"
 
 source "arch/arm/mach-ux500/Kconfig"
 
+source "arch/arm/mach-versatile/Kconfig"
+
 source "arch/arm/mach-vexpress/Kconfig"
 source "arch/arm/plat-versatile/Kconfig"
 
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
new file mode 100644
index 0000000..1d6a8b2
--- /dev/null
+++ b/arch/arm/mach-versatile/Kconfig
@@ -0,0 +1,14 @@
+config ARCH_VERSATILE
+	bool "ARM Ltd. Versatile family" if ARCH_MULTI_V5
+	select ARM_AMBA
+	select ARM_TIMER_SP804
+	select ARM_VIC
+	select CLKSRC_VERSATILE
+	select COMMON_CLK_VERSATILE
+	select CPU_ARM926T
+	select ICST
+	select MIGHT_HAVE_PCI
+	select VERSATILE_FPGA_IRQ
+	help
+	  This enables support for ARM Ltd Versatile board.
+
diff --git a/arch/arm/mach-versatile/Makefile.boot b/arch/arm/mach-versatile/Makefile.boot
deleted file mode 100644
index ff0a4b5..0000000
--- a/arch/arm/mach-versatile/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
-
diff --git a/arch/arm/mach-versatile/include/mach/uncompress.h b/arch/arm/mach-versatile/include/mach/uncompress.h
deleted file mode 100644
index 986e3d3..0000000
--- a/arch/arm/mach-versatile/include/mach/uncompress.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- *  arch/arm/mach-versatile/include/mach/uncompress.h
- *
- *  Copyright (C) 2003 ARM Limited
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
-#define AMBA_UART_DR	(*(volatile unsigned char *)0x101F1000)
-#define AMBA_UART_LCRH	(*(volatile unsigned char *)0x101F102C)
-#define AMBA_UART_CR	(*(volatile unsigned char *)0x101F1030)
-#define AMBA_UART_FR	(*(volatile unsigned char *)0x101F1018)
-
-/*
- * This does not append a newline
- */
-static inline void putc(int c)
-{
-	while (AMBA_UART_FR & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR = c;
-}
-
-static inline void flush(void)
-{
-	while (AMBA_UART_FR & (1 << 3))
-		barrier();
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-- 
2.1.0
