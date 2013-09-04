From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 04 Sep 2013 12:46:49 +0900
Subject: [PATCH 04/04] ARM: shmobile: Koelsch support
In-Reply-To: <20130904034525.12546.24775.sendpatchset@w520>
References: <20130904034525.12546.24775.sendpatchset@w520>
Message-ID: <20130904034649.12546.87340.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Koelsch base board support making use of 2 GiB of memory,
the r8a7791 SoC with the SCIF0 serial port and CA15 with
CMT timer.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
[damm at opensource.se: Forward ported to upstream, dropped not-yet-ready SMP/PFC]
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/Makefile             |    1 
 arch/arm/boot/dts/r8a7791-koelsch.dts  |   32 +++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig         |    5 +++
 arch/arm/mach-shmobile/Makefile        |    1 
 arch/arm/mach-shmobile/Makefile.boot   |    1 
 arch/arm/mach-shmobile/board-koelsch.c |   44 ++++++++++++++++++++++++++++++++
 6 files changed, 84 insertions(+)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-09-03 21:18:57.000000000 +0900
@@ -190,6 +190,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm
 	r8a7740-armadillo800eva-reference.dtb \
 	r8a7779-marzen.dtb \
 	r8a7779-marzen-reference.dtb \
+	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb \
 	r8a7790-lager-reference.dtb \
 	sh73a0-kzm9g.dtb \
--- /dev/null
+++ work/arch/arm/boot/dts/r8a7791-koelsch.dts	2013-09-03 21:18:58.000000000 +0900
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
+	compatible = "renesas,koelsch", "renesas,r8a7791";
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
--- 0003/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-09-03 21:18:57.000000000 +0900
@@ -219,6 +219,11 @@ config MACH_LAGER_REFERENCE
 
 	   This is intended to aid developers
 
+config MACH_KOELSCH
+	bool "Koelsch board"
+	depends on ARCH_R8A7791
+	select USE_OF
+
 config MACH_KZM9D
 	bool "KZM9D board"
 	depends on ARCH_EMEV2
--- 0003/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-09-03 21:18:57.000000000 +0900
@@ -61,6 +61,7 @@ obj-$(CONFIG_MACH_LAGER)	+= board-lager.
 obj-$(CONFIG_MACH_LAGER_REFERENCE)	+= board-lager-reference.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
+obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
 obj-$(CONFIG_MACH_KZM9D_REFERENCE)	+= board-kzm9d-reference.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
--- 0001/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-09-03 21:22:48.000000000 +0900
@@ -6,6 +6,7 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA)
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
+loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-09-03 21:18:58.000000000 +0900
@@ -0,0 +1,44 @@
+/*
+ * Koelsch board support
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
+#include <linux/platform_device.h>
+#include <mach/common.h>
+#include <mach/r8a7791.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static void __init koelsch_add_standard_devices(void)
+{
+	r8a7791_clock_init();
+	r8a7791_add_dt_devices();
+}
+
+static const char * const koelsch_boards_compat_dt[] __initconst = {
+	"renesas,koelsch",
+	NULL,
+};
+
+DT_MACHINE_START(KOELSCH_DT, "koelsch")
+	.init_early	= r8a7791_init_early,
+	.init_machine	= koelsch_add_standard_devices,
+	.dt_compat	= koelsch_boards_compat_dt,
+MACHINE_END
