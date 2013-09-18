From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 19 Sep 2013 05:11:29 +0900
Subject: [PATCH 03/03] ARM: shmobile: Genmai support
In-Reply-To: <20130918201101.6319.97667.sendpatchset@w520>
References: <20130918201101.6319.97667.sendpatchset@w520>
Message-ID: <20130918201129.6319.80740.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Genmai base board support making use of 128 MiB of memory,
the r7s7211 SoC with the SCIF2 serial port and CA9 core.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/Makefile            |    1 
 arch/arm/boot/dts/r7s72100-genmai.dts |   31 +++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig        |    5 +++
 arch/arm/mach-shmobile/Makefile       |    1 
 arch/arm/mach-shmobile/Makefile.boot  |    1 
 arch/arm/mach-shmobile/board-genmai.c |   43 +++++++++++++++++++++++++++++++++
 6 files changed, 82 insertions(+)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-09-19 03:47:59.000000000 +0900
@@ -184,6 +184,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	emev2-kzm9d-reference.dtb \
+	r7s72100-genmai.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
--- /dev/null
+++ work/arch/arm/boot/dts/r7s72100-genmai.dts	2013-09-19 03:47:59.000000000 +0900
@@ -0,0 +1,31 @@
+/*
+ * Device Tree Source for the Genmai board
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r7s72100.dtsi"
+
+/ {
+	model = "Genmai";
+	compatible = "renesas,genmai", "renesas,r7s72100";
+
+	chosen {
+		bootargs = "console=ttySC2,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x08000000 0x08000000>;
+	};
+
+	lbsc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
--- 0002/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-09-19 03:47:59.000000000 +0900
@@ -189,6 +189,11 @@ config MACH_BOCKW_REFERENCE
 
 	   This is intended to aid developers
 
+config MACH_GENMAI
+	bool "Genmai board"
+	depends on ARCH_R7S72100
+	select USE_OF
+
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
--- 0002/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-09-19 03:47:59.000000000 +0900
@@ -58,6 +58,7 @@ obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+=
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
+obj-$(CONFIG_MACH_GENMAI)	+= board-genmai.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
--- 0001/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-09-19 03:47:59.000000000 +0900
@@ -6,6 +6,7 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA)
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
+loadaddr-$(CONFIG_MACH_GENMAI) += 0x8008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D_REFERENCE) += 0x40008000
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-genmai.c	2013-09-19 03:47:59.000000000 +0900
@@ -0,0 +1,43 @@
+/*
+ * Genmai board support
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
+#include <linux/platform_device.h>
+#include <mach/common.h>
+#include <mach/r7s72100.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static void __init genmai_add_standard_devices(void)
+{
+	r7s72100_clock_init();
+	r7s72100_add_dt_devices();
+}
+
+static const char * const genmai_boards_compat_dt[] __initconst = {
+	"renesas,genmai",
+	NULL,
+};
+
+DT_MACHINE_START(GENMAI_DT, "genmai")
+	.init_early	= r7s72100_init_early,
+	.init_machine	= genmai_add_standard_devices,
+	.dt_compat	= genmai_boards_compat_dt,
+MACHINE_END
