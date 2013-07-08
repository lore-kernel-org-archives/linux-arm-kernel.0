From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 08 Jul 2013 15:00:30 +0900
Subject: [PATCH] ARM: shmobile: KZM9D DT reference implementation
Message-ID: <20130708060030.13607.45725.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a DT reference implementation for the KZM9D board.

Only DT devices are used in this case. UART, STI, GPIO
and SMP / GIC are all provided by emev2.dtsi.

There is still a board specific C file used for enabling
legacy SH clocks. This file will be removed after we have
moved over to common clocks.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against "renesas-next-20130704v2". Boot tested on KZM9D.

 arch/arm/boot/dts/Makefile                     |    1 
 arch/arm/boot/dts/emev2-kzm9d-reference.dts    |   26 +++++++++++++
 arch/arm/mach-shmobile/Kconfig                 |   12 ++++++
 arch/arm/mach-shmobile/Makefile                |    1 
 arch/arm/mach-shmobile/Makefile.boot           |    1 
 arch/arm/mach-shmobile/board-kzm9d-reference.c |   47 ++++++++++++++++++++++++
 6 files changed, 88 insertions(+)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-07-08 14:24:15.000000000 +0900
@@ -160,6 +160,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
 	hrefv60plus.dtb \
 	ccu9540.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
+	emev2-kzm9d-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7740-armadillo800eva-reference.dtb \
--- /dev/null
+++ work/arch/arm/boot/dts/emev2-kzm9d-reference.dts	2013-07-08 14:48:50.000000000 +0900
@@ -0,0 +1,26 @@
+/*
+ * Device Tree Source for the KZM9D board
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+/dts-v1/;
+
+/include/ "emev2.dtsi"
+
+/ {
+	model = "EMEV2 KZM9D Board";
+	compatible = "renesas,kzm9d-reference", "renesas,emev2";
+
+	memory {
+		device_type = "memory";
+		reg = <0x40000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096";
+	};
+};
--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-07-08 14:24:15.000000000 +0900
@@ -167,6 +167,18 @@ config MACH_KZM9D
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select USE_OF
 
+config MACH_KZM9D_REFERENCE
+	bool "KZM9D board - Reference Device Tree Implementation"
+	depends on ARCH_EMEV2
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select USE_OF
+	---help---
+	   Use reference implementation of KZM9D board support
+	   which makes a greater use of device tree at the expense
+	   of not supporting a number of devices.
+
+	   This is intended to aid developers
+
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
 	depends on ARCH_SH73A0
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-07-08 14:24:15.000000000 +0900
@@ -47,6 +47,7 @@ obj-$(CONFIG_MACH_LAGER_REFERENCE)	+= bo
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
+obj-$(CONFIG_MACH_KZM9D_REFERENCE)	+= board-kzm9d-reference.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 
--- 0001/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-07-08 14:24:15.000000000 +0900
@@ -7,6 +7,7 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_R
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_KOTA2) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
+loadaddr-$(CONFIG_MACH_KZM9D_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-kzm9d-reference.c	2013-07-08 14:49:41.000000000 +0900
@@ -0,0 +1,47 @@
+/*
+ * kzm9d board support - Reference DT implementation
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
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <mach/emev2.h>
+#include <mach/common.h>
+#include <asm/mach/arch.h>
+
+static void __init kzm9d_add_standard_devices(void)
+{
+	emev2_clock_init();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *kzm9d_boards_compat_dt[] __initdata = {
+	"renesas,kzm9d-reference",
+	NULL,
+};
+
+DT_MACHINE_START(KZM9D_DT, "kzm9d")
+	.smp		= smp_ops(emev2_smp_ops),
+	.map_io		= emev2_map_io,
+	.init_early	= emev2_init_delay,
+	.init_machine	= kzm9d_add_standard_devices,
+	.init_late	= shmobile_init_late,
+	.dt_compat	= kzm9d_boards_compat_dt,
+MACHINE_END
+
