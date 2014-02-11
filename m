From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Feb 2014 15:11:58 -0600
Subject: [PATCH 8/9] ARM: virt: make mach-virt just a kconfig option
In-Reply-To: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
Message-ID: <1392153119-23248-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The mach code for mach-virt is no longer needed, so we can remove all of
mach-virt except the kconfig entry.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig            |  8 ++++++--
 arch/arm/Makefile           |  1 -
 arch/arm/mach-virt/Kconfig  |  6 ------
 arch/arm/mach-virt/Makefile |  5 -----
 arch/arm/mach-virt/virt.c   | 41 -----------------------------------------
 5 files changed, 6 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-virt/Kconfig
 delete mode 100644 arch/arm/mach-virt/Makefile
 delete mode 100644 arch/arm/mach-virt/virt.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f350ca5..9790c5d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -929,6 +929,12 @@ config ARCH_MULTI_CPU_AUTO
 
 endmenu
 
+config ARCH_VIRT
+	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
+	select ARM_GIC
+	select HAVE_ARM_ARCH_TIMER
+	select ARM_PSCI
+
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
 # Kconfigs may be included either alphabetically (according to the
@@ -1052,8 +1058,6 @@ source "arch/arm/mach-versatile/Kconfig"
 source "arch/arm/mach-vexpress/Kconfig"
 source "arch/arm/plat-versatile/Kconfig"
 
-source "arch/arm/mach-virt/Kconfig"
-
 source "arch/arm/mach-vt8500/Kconfig"
 
 source "arch/arm/mach-w90x900/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 08a9ef5..a3c06dd 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -199,7 +199,6 @@ machine-$(CONFIG_ARCH_U300)		+= u300
 machine-$(CONFIG_ARCH_U8500)		+= ux500
 machine-$(CONFIG_ARCH_VERSATILE)	+= versatile
 machine-$(CONFIG_ARCH_VEXPRESS)		+= vexpress
-machine-$(CONFIG_ARCH_VIRT)		+= virt
 machine-$(CONFIG_ARCH_VT8500)		+= vt8500
 machine-$(CONFIG_ARCH_W90X900)		+= w90x900
 machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
diff --git a/arch/arm/mach-virt/Kconfig b/arch/arm/mach-virt/Kconfig
deleted file mode 100644
index eaad072..0000000
--- a/arch/arm/mach-virt/Kconfig
+++ /dev/null
@@ -1,6 +0,0 @@
-config ARCH_VIRT
-	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
-	select ARM_GIC
-	select HAVE_ARM_ARCH_TIMER
-	select ARM_PSCI
-	select HAVE_SMP
diff --git a/arch/arm/mach-virt/Makefile b/arch/arm/mach-virt/Makefile
deleted file mode 100644
index 7ddbfa6..0000000
--- a/arch/arm/mach-virt/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-obj-y					:= virt.o
diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
deleted file mode 100644
index b184e57..0000000
--- a/arch/arm/mach-virt/virt.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Dummy Virtual Machine - does what it says on the tin.
- *
- * Copyright (C) 2012 ARM Ltd
- * Authors: Will Deacon <will.deacon@arm.com>,
- *          Marc Zyngier <marc.zyngier@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/smp.h>
-
-#include <asm/mach/arch.h>
-
-static void __init virt_init(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-static const char *virt_dt_match[] = {
-	"linux,dummy-virt",
-	"xen,xenvm",
-	NULL
-};
-
-DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
-	.init_machine	= virt_init,
-	.dt_compat	= virt_dt_match,
-MACHINE_END
-- 
1.8.3.2
