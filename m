From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 26 Sep 2013 08:21:58 +0900
Subject: [PATCH] ARM: shmobile: Add r8a7791 Koelsch DT reference support
Message-ID: <20130925232158.16508.13781.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add DT reference support for the r8a7791 Koelsch board.

This board support file will be used together with common
clocks in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-20130925

 arch/arm/boot/dts/Makefile                       |    1 
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts  |   32 ++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                   |   11 +++++
 arch/arm/mach-shmobile/Makefile                  |    1 
 arch/arm/mach-shmobile/Makefile.boot             |    1 
 arch/arm/mach-shmobile/board-koelsch-reference.c |   43 ++++++++++++++++++++++
 6 files changed, 89 insertions(+)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-09-26 07:45:16.000000000 +0900
@@ -203,6 +203,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm
 	r8a7779-marzen.dtb \
 	r8a7779-marzen-reference.dtb \
 	r8a7791-koelsch.dtb \
+	r8a7791-koelsch-reference.dtb \
 	r8a7790-lager.dtb \
 	r8a7790-lager-reference.dtb \
 	sh73a0-kzm9g.dtb \
--- /dev/null
+++ work/arch/arm/boot/dts/r8a7791-koelsch-reference.dts	2013-09-26 07:40:52.000000000 +0900
@@ -0,0 +1,32 @@
+/*
+ * Device Tree Source for the Koelsch board
+ *
+ * Copyright (C) 2013 Renesas Electronics Corporation
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a7791.dtsi"
+
+/ {
+	model = "Koelsch";
+	compatible = "renesas,koelsch-reference", "renesas,r8a7791";
+
+	chosen {
+		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	lbsc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-09-26 07:38:59.000000000 +0900
@@ -226,6 +226,17 @@ config MACH_KOELSCH
 	depends on ARCH_R8A7791
 	select USE_OF
 
+config MACH_KOELSCH_REFERENCE
+	bool "Koelsch board - Reference Device Tree Implementation"
+	depends on ARCH_R8A7791
+	select USE_OF
+	---help---
+	   Use reference implementation of Koelsch board support
+	   which makes use of device tree at the expense
+	   of not supporting a number of devices.
+
+	   This is intended to aid developers
+
 config MACH_KZM9D
 	bool "KZM9D board"
 	depends on ARCH_EMEV2
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-09-26 07:38:15.000000000 +0900
@@ -64,6 +64,7 @@ obj-$(CONFIG_MACH_LAGER_REFERENCE)	+= bo
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
+obj-$(CONFIG_MACH_KOELSCH_REFERENCE)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
 obj-$(CONFIG_MACH_KZM9D_REFERENCE)	+= board-kzm9d-reference.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
--- 0001/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-09-26 07:39:10.000000000 +0900
@@ -7,6 +7,7 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_R
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
+loadaddr-$(CONFIG_MACH_KOELSCH_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2013-09-26 07:41:56.000000000 +0900
@@ -0,0 +1,43 @@
+/*
+ * Koelsch board support - Reference DT implementation
+ *
+ * Copyright (C) 2013  Renesas Electronics Corporation
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
+#include <linux/of_platform.h>
+#include <mach/r8a7791.h>
+#include <asm/mach/arch.h>
+
+static void __init koelsch_add_standard_devices(void)
+{
+	r8a7791_clock_init();
+	r8a7791_add_dt_devices();
+        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const koelsch_boards_compat_dt[] __initconst = {
+	"renesas,koelsch-reference",
+	NULL,
+};
+
+DT_MACHINE_START(KOELSCH_DT, "koelsch")
+	.init_early	= r8a7791_init_early,
+	.init_machine	= koelsch_add_standard_devices,
+	.dt_compat	= koelsch_boards_compat_dt,
+MACHINE_END
