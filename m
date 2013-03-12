From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 12 Mar 2013 13:56:37 +0900
Subject: [PATCH 04/04] ARM: shmobile: APE6EVM support
In-Reply-To: <20130312045559.19701.77841.sendpatchset@w520>
References: <20130312045559.19701.77841.sendpatchset@w520>
Message-ID: <20130312045637.19701.62477.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add APE6EVM board support making use of 1 GiB of memory,
the SCIFA0 serial port and the Architecture timer.

More devices will be added on top of this patch after
PICNTRL and clock framework are in better shape.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/Makefile             |    1 
 arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   26 ++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig         |    8 +++++-
 arch/arm/mach-shmobile/Makefile        |    1 
 arch/arm/mach-shmobile/board-ape6evm.c |   40 ++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-03-11 23:05:33.000000000 +0900
@@ -125,6 +125,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm
 	r8a7779-marzen-reference.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb \
+	r8a73a4-ape6evm.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
 	spear1340-evb.dtb
--- /dev/null
+++ work/arch/arm/boot/dts/r8a73a4-ape6evm.dts	2013-03-11 23:06:38.000000000 +0900
@@ -0,0 +1,26 @@
+/*
+ * Device Tree Source for the APE6EVM board
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a73a4.dtsi"
+
+/ {
+	model = "APE6EVM";
+	compatible = "renesas,ape6evm", "renesas,r8a73a4";
+
+	chosen {
+		bootargs = "console=ttySC0,115200 ignore_loglevel";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x40000000>;
+	};
+};
--- 0002/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-03-11 23:07:50.000000000 +0900
@@ -76,6 +76,11 @@ config MACH_AG5EVM
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SH_LCD_MIPI_DSI
 
+config MACH_APE6EVM
+	bool "APE6EVM board"
+	depends on ARCH_R8A73A4
+	select USE_OF
+
 config MACH_MACKEREL
 	bool "mackerel board"
 	depends on ARCH_SH7372
@@ -163,7 +168,7 @@ config MEMORY_START
 	hex "Physical memory start address"
 	default "0x40000000" if MACH_AP4EVB || MACH_AG5EVM || \
 				MACH_MACKEREL || MACH_BONITO || \
-				MACH_ARMADILLO800EVA
+				MACH_ARMADILLO800EVA || MACH_APE6EVM
 	default "0x41000000" if MACH_KOTA2
 	default "0x00000000"
 	---help---
@@ -173,6 +178,7 @@ config MEMORY_START
 
 config MEMORY_SIZE
 	hex "Physical memory size"
+	default "0x40000000" if MACH_APE6EVM
 	default "0x20000000" if MACH_AG5EVM || MACH_BONITO || \
 				MACH_ARMADILLO800EVA
 	default "0x1e000000" if MACH_KOTA2
--- 0002/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-03-11 23:05:33.000000000 +0900
@@ -35,6 +35,7 @@ obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 # Board objects
 obj-$(CONFIG_MACH_AP4EVB)	+= board-ap4evb.o
 obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
+obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2013-03-11 23:05:34.000000000 +0900
@@ -0,0 +1,40 @@
+/*
+ * APE6EVM board support
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
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/irqchip.h>
+#include <mach/common.h>
+#include <mach/r8a73a4.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static const char *ape6evm_boards_compat_dt[] __initdata = {
+	"renesas,ape6evm",
+	NULL,
+};
+
+DT_MACHINE_START(APE6EVM_DT, "ape6evm")
+	.init_irq	= irqchip_init,
+	.init_time	= shmobile_timer_init,
+	.init_machine	= r8a73a4_add_standard_devices,
+	.dt_compat	= ape6evm_boards_compat_dt,
+MACHINE_END
