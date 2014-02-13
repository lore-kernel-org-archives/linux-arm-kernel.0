From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 13 Feb 2014 17:26:18 +0900
Subject: [PATCH 02/03] ARM: shmobile: Remove KZM9D board code
In-Reply-To: <20140213082558.30630.93034.sendpatchset@w520>
References: <20140213082558.30630.93034.sendpatchset@w520>
Message-ID: <20140213082618.30630.64196.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Get rid of KZM9D board code written in C. This version of the
C board code was used in the case of multiplatform, but these
days DT can be used instead, so because of that simply get rid
of the C code to simplify and save space.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig                 |    6 ---
 arch/arm/mach-shmobile/Makefile                |    1 
 arch/arm/mach-shmobile/board-kzm9d-reference.c |   47 ------------------------
 arch/arm/mach-shmobile/include/mach/emev2.h    |    8 ----
 arch/arm/mach-shmobile/setup-emev2.c           |    3 +
 arch/arm/mach-shmobile/smp-emev2.c             |    1 
 6 files changed, 2 insertions(+), 64 deletions(-)

--- 0010/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-02-05 18:27:53.000000000 +0900
@@ -48,12 +48,6 @@ config MACH_KOELSCH
 	depends on ARCH_R8A7791
 	select MICREL_PHY if SH_ETH
 
-config MACH_KZM9D
-	bool "KZM9D board"
-	depends on ARCH_EMEV2
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select SMSC_PHY if SMSC911X
-
 config MACH_LAGER
 	bool "Lager board"
 	depends on ARCH_R8A7790
--- 0010/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-02-05 18:27:53.000000000 +0900
@@ -57,7 +57,6 @@ obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
-obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
--- 0001/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,47 +0,0 @@
-/*
- * kzm9d board support - Reference DT implementation
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/init.h>
-#include <linux/of_platform.h>
-#include <linux/clk-provider.h>
-#include <mach/emev2.h>
-#include <mach/common.h>
-#include <asm/mach/arch.h>
-
-static void __init kzm9d_add_standard_devices(void)
-{
-	of_clk_init(NULL);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-static const char *kzm9d_boards_compat_dt[] __initdata = {
-	"renesas,kzm9d",
-	"renesas,kzm9d-reference",
-	NULL,
-};
-
-DT_MACHINE_START(KZM9D_DT, "kzm9d")
-	.smp		= smp_ops(emev2_smp_ops),
-	.map_io		= emev2_map_io,
-	.init_early	= emev2_init_delay,
-	.init_machine	= kzm9d_add_standard_devices,
-	.init_late	= shmobile_init_late,
-	.dt_compat	= kzm9d_boards_compat_dt,
-MACHINE_END
--- 0010/arch/arm/mach-shmobile/include/mach/emev2.h
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,8 +0,0 @@
-#ifndef __ASM_EMEV2_H__
-#define __ASM_EMEV2_H__
-
-extern void emev2_map_io(void);
-extern void emev2_init_delay(void);
-extern struct smp_operations emev2_smp_ops;
-
-#endif /* __ASM_EMEV2_H__ */
--- 0010/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2014-02-05 18:27:53.000000000 +0900
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <mach/common.h>
-#include <mach/emev2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -59,6 +58,8 @@ static const char *emev2_boards_compat_d
 	NULL,
 };
 
+extern struct smp_operations emev2_smp_ops;
+
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2014-02-05 18:27:53.000000000 +0900
@@ -24,7 +24,6 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <mach/common.h>
-#include <mach/emev2.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
