From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 08 Oct 2013 15:30:18 +0900
Subject: [PATCH 02/02] ARM: shmobile: r8a7791 Koelsch DT reference C bits
In-Reply-To: <20131008063000.24789.7845.sendpatchset@w520>
References: <20131008063000.24789.7845.sendpatchset@w520>
Message-ID: <20131008063018.24789.2944.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add DT reference support for the r8a7791 Koelsch board.

This board support file will be used together with common
clocks and multiplatform in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig                   |   11 +++++
 arch/arm/mach-shmobile/Makefile                  |    1 
 arch/arm/mach-shmobile/Makefile.boot             |    1 
 arch/arm/mach-shmobile/board-koelsch-reference.c |   46 ++++++++++++++++++++++
 4 files changed, 59 insertions(+)

--- 0004/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-10-08 15:14:08.000000000 +0900
@@ -232,6 +232,17 @@ config MACH_KOELSCH
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
+++ work/arch/arm/mach-shmobile/Makefile	2013-10-08 15:14:08.000000000 +0900
@@ -71,6 +71,7 @@ obj-$(CONFIG_MACH_LAGER_REFERENCE)	+= bo
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
+obj-$(CONFIG_MACH_KOELSCH_REFERENCE)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
--- 0001/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-10-08 15:14:08.000000000 +0900
@@ -8,6 +8,7 @@ loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_GENMAI) += 0x8008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
+loadaddr-$(CONFIG_MACH_KOELSCH_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2013-10-08 15:17:04.000000000 +0900
@@ -0,0 +1,46 @@
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
+#include <mach/rcar-gen2.h>
+#include <mach/r8a7791.h>
+#include <asm/mach/arch.h>
+
+static void __init koelsch_add_standard_devices(void)
+{
+	r8a7791_clock_init();
+	r8a7791_add_dt_devices();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const koelsch_boards_compat_dt[] __initconst = {
+	"renesas,koelsch-reference",
+	NULL,
+};
+
+DT_MACHINE_START(KOELSCH_DT, "koelsch")
+	.smp		= smp_ops(r8a7791_smp_ops),
+	.init_early	= r8a7791_init_early,
+	.init_time	= rcar_gen2_timer_init,
+	.init_machine	= koelsch_add_standard_devices,
+	.dt_compat	= koelsch_boards_compat_dt,
+MACHINE_END
