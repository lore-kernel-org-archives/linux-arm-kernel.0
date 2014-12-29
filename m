From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:46:43 +0900
Subject: [PATCH 1/6] ARM: shmobile: lager-reference: DTS-only board support
In-Reply-To: <cover.1419809774.git.horms+renesas@verge.net.au>
References: <cover.1419809774.git.horms+renesas@verge.net.au>
Message-ID: <be2902416cc6f26d05a9b7308b78d093ad69062c.1419809774.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove redundant C board code for Lager Multiplatform,
everything is supported via DT these days anyway so it
is fine to rely on the MACHINE_START in setup-r8a7790.c.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
[Remove CONFIG_MACH_LAGER from shmobile_defconfig]
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig            |  1 -
 arch/arm/mach-shmobile/Kconfig                 |  5 ----
 arch/arm/mach-shmobile/Makefile                |  1 -
 arch/arm/mach-shmobile/board-lager-reference.c | 39 --------------------------
 4 files changed, 46 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-lager-reference.c

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3df6ca0..e4a6c5e 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -17,7 +17,6 @@ CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7794=y
-CONFIG_MACH_LAGER=y
 CONFIG_MACH_MARZEN=y
 # CONFIG_SWP_EMULATE is not set
 CONFIG_CPU_BPREDICT_DISABLE=y
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 1b4fafe..859f391 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -74,11 +74,6 @@ config ARCH_R8A7794
 
 comment "Renesas ARM SoCs Board Type"
 
-config MACH_LAGER
-	bool "Lager board"
-	depends on ARCH_R8A7790
-	select MICREL_PHY if SH_ETH
-
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index b55cac0..85692c9a 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -57,7 +57,6 @@ obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o sleep-sh7372.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
-obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
deleted file mode 100644
index fa06bdb..0000000
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Lager board support - Reference DT implementation
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Simon Horman
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/init.h>
-#include <linux/of_platform.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "r8a7790.h"
-#include "rcar-gen2.h"
-
-static const char *lager_boards_compat_dt[] __initdata = {
-	"renesas,lager",
-	"renesas,lager-reference",
-	NULL,
-};
-
-DT_MACHINE_START(LAGER_DT, "lager")
-	.smp		= smp_ops(r8a7790_smp_ops),
-	.init_early	= shmobile_init_delay,
-	.init_time	= rcar_gen2_timer_init,
-	.init_late	= shmobile_init_late,
-	.reserve	= rcar_gen2_reserve,
-	.dt_compat	= lager_boards_compat_dt,
-MACHINE_END
-- 
2.1.3
