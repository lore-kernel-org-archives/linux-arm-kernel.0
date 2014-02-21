From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:26 +0900
Subject: [PATCH 14/16] ARM: shmobile: Remove KZM9D board code
In-Reply-To: <cover.1392960310.git.horms+renesas@verge.net.au>
References: <cover.1392960310.git.horms+renesas@verge.net.au>
Message-ID: <1ee101d9c416823f960a4841ef81044d461034b5.1392960310.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Get rid of KZM9D board code written in C. This version of the
C board code was used in the case of multiplatform, but these
days DT can be used instead, so because of that simply get rid
of the C code to simplify and save space.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                 |  6 ----
 arch/arm/mach-shmobile/Makefile                |  1 -
 arch/arm/mach-shmobile/board-kzm9d-reference.c | 47 --------------------------
 3 files changed, 54 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9d-reference.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index c431114..cc2a182 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -47,12 +47,6 @@ config MACH_KOELSCH
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
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fe7d4ff..1402d60 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -58,7 +58,6 @@ obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
-obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
deleted file mode 100644
index 853003c..0000000
--- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ /dev/null
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
-- 
1.8.5.2
