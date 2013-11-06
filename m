From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 07 Nov 2013 08:31:16 +0900
Subject: [PATCH 02/03] ARM: shmobile: r7s72100 Genmai DT reference C bits
In-Reply-To: <20131106233032.8117.71968.sendpatchset@w520>
References: <20131106233032.8117.71968.sendpatchset@w520>
Message-ID: <20131106233116.8117.76183.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add C code support for r7s72100 Genmai DT reference.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig                  |   11 +++++
 arch/arm/mach-shmobile/Makefile                 |    1 
 arch/arm/mach-shmobile/Makefile.boot            |    3 +
 arch/arm/mach-shmobile/board-genmai-reference.c |   44 +++++++++++++++++++++++
 4 files changed, 58 insertions(+), 1 deletion(-)

--- 0013/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-11-06 19:14:25.000000000 +0900
@@ -201,6 +201,17 @@ config MACH_GENMAI
 	depends on ARCH_R7S72100
 	select USE_OF
 
+config MACH_GENMAI_REFERENCE
+	bool "Genmai board - Reference Device Tree Implementation"
+	depends on ARCH_R7S72100
+	select USE_OF
+	---help---
+	   Use reference implementation of Genmai board support
+	   which makes use of device tree at the expense
+	   of not supporting a number of devices.
+
+	   This is intended to aid developers
+
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
--- 0013/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-11-06 19:14:25.000000000 +0900
@@ -65,6 +65,7 @@ obj-$(CONFIG_MACH_MACKEREL)	+= board-mac
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai.o
+obj-$(CONFIG_MACH_GENMAI_REFERENCE)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
--- 0004/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-11-06 19:14:25.000000000 +0900
@@ -6,7 +6,8 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA)
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
-loadaddr-$(CONFIG_MACH_GENMAI) += 0x8008000
+loadaddr-$(CONFIG_MACH_GENMAI) += 0x08008000
+loadaddr-$(CONFIG_MACH_GENMAI_REFERENCE) += 0x08008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
 loadaddr-$(CONFIG_MACH_KOELSCH_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-genmai-reference.c	2013-11-06 19:14:26.000000000 +0900
@@ -0,0 +1,44 @@
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
+#include <linux/of_platform.h>
+#include <mach/common.h>
+#include <mach/r7s72100.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static void __init genmai_add_standard_devices(void)
+{
+	r7s72100_clock_init();
+	r7s72100_add_dt_devices();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const genmai_boards_compat_dt[] __initconst = {
+	"renesas,genmai-reference",
+	NULL,
+};
+
+DT_MACHINE_START(GENMAI_DT, "genmai")
+	.init_early	= r7s72100_init_early,
+	.init_machine	= genmai_add_standard_devices,
+	.dt_compat	= genmai_boards_compat_dt,
+MACHINE_END
