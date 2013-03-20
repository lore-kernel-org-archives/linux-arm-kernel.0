From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 20 Mar 2013 23:36:42 +0900
Subject: [PATCH 04/04] ARM: shmobile: Lager support
In-Reply-To: <20130320143604.32377.32634.sendpatchset@w520>
References: <20130320143604.32377.32634.sendpatchset@w520>
Message-ID: <20130320143642.32377.35780.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Lager base board support making use of 2 GiB of memory,
the r8a7790 SoC with the SCIF0 serial port and CA15 with
ARM architected timer.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/Makefile           |    1 
 arch/arm/boot/dts/r8a7790-lager.dts  |   26 +++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig       |    9 +++++-
 arch/arm/mach-shmobile/Makefile      |    1 
 arch/arm/mach-shmobile/board-lager.c |   46 ++++++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 1 deletion(-)

--- 0009/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-03-20 21:09:38.000000000 +0900
@@ -137,6 +137,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7779-marzen-reference.dtb \
+	r8a7790-lager.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb \
 	r8a73a4-ape6evm.dtb \
--- /dev/null
+++ work/arch/arm/boot/dts/r8a7790-lager.dts	2013-03-20 21:09:39.000000000 +0900
@@ -0,0 +1,26 @@
+/*
+ * Device Tree Source for the Lager board
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a7790.dtsi"
+
+/ {
+	model = "Lager";
+	compatible = "renesas,lager", "renesas,r8a7790";
+
+	chosen {
+		bootargs = "console=ttySC6,115200 ignore_loglevel";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x80000000>;
+	};
+};
--- 0014/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-03-20 21:09:38.000000000 +0900
@@ -141,6 +141,11 @@ config MACH_MARZEN_REFERENCE
 
 	   This is intended to aid developers
 
+config MACH_LAGER
+	bool "Lager board"
+	depends on ARCH_R8A7790
+	select USE_OF
+
 config MACH_KZM9D
 	bool "KZM9D board"
 	depends on ARCH_EMEV2
@@ -181,7 +186,8 @@ config MEMORY_START
 	hex "Physical memory start address"
 	default "0x40000000" if MACH_AP4EVB || MACH_AG5EVM || \
 				MACH_MACKEREL || MACH_BONITO || \
-				MACH_ARMADILLO800EVA || MACH_APE6EVM
+				MACH_ARMADILLO800EVA || MACH_APE6EVM || \
+				MACH_LAGER
 	default "0x41000000" if MACH_KOTA2
 	default "0x00000000"
 	---help---
@@ -191,6 +197,7 @@ config MEMORY_START
 
 config MEMORY_SIZE
 	hex "Physical memory size"
+	default "0x80000000" if MACH_LAGER
 	default "0x40000000" if MACH_APE6EVM
 	default "0x20000000" if MACH_AG5EVM || MACH_BONITO || \
 				MACH_ARMADILLO800EVA
--- 0012/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-03-20 21:09:38.000000000 +0900
@@ -42,6 +42,7 @@ obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.
 obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
+obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-lager.c	2013-03-20 21:12:05.000000000 +0900
@@ -0,0 +1,46 @@
+/*
+ * Lager board support
+ *
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <mach/common.h>
+#include <mach/r8a7790.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static void __init lager_add_standard_devices(void)
+{
+	r8a7790_clock_init();
+	r8a7790_add_standard_devices();
+}
+
+static const char *lager_boards_compat_dt[] __initdata = {
+	"renesas,lager",
+	NULL,
+};
+
+DT_MACHINE_START(LAGER_DT, "lager")
+	.init_irq	= irqchip_init,
+	.init_time	= shmobile_timer_init,
+	.init_machine	= lager_add_standard_devices,
+	.dt_compat	= lager_boards_compat_dt,
+MACHINE_END
