From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 8 Feb 2013 09:29:32 +0200
Subject: [PATCH 2/4] ARM: tegra: Unify board-dt-tegra{30,114}.c
In-Reply-To: <1360308574-19658-1-git-send-email-hdoyu@nvidia.com>
References: <1360308574-19658-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1360308574-19658-3-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactored that Tegra114 uses board-dt-tegra30.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mach-tegra/Makefile            |    2 +-
 arch/arm/mach-tegra/board-dt-tegra114.c |   46 -------------------------------
 arch/arm/mach-tegra/board-dt-tegra30.c  |    3 +-
 3 files changed, 3 insertions(+), 48 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-dt-tegra114.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index f6b46ae..1a08ecd 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-dt-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= board-dt-tegra114.o
+obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= board-dt-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
 endif
diff --git a/arch/arm/mach-tegra/board-dt-tegra114.c b/arch/arm/mach-tegra/board-dt-tegra114.c
deleted file mode 100644
index 08e8294..0000000
--- a/arch/arm/mach-tegra/board-dt-tegra114.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * NVIDIA Tegra114 device tree board support
- *
- * Copyright (C) 2013 NVIDIA Corporation
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/clocksource.h>
-
-#include <asm/mach/arch.h>
-
-#include "board.h"
-#include "common.h"
-
-static void __init tegra114_dt_init(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-static const char * const tegra114_dt_board_compat[] = {
-	"nvidia,tegra114",
-	NULL,
-};
-
-DT_MACHINE_START(TEGRA114_DT, "NVIDIA Tegra114 (Flattened Device Tree)")
-	.smp		= smp_ops(tegra_smp_ops),
-	.map_io		= tegra_map_common_io,
-	.init_early	= tegra_init_early,
-	.init_irq	= tegra_dt_init_irq,
-	.init_time	= clocksource_of_init,
-	.init_machine	= tegra114_dt_init,
-	.init_late	= tegra_init_late,
-	.restart	= tegra_assert_system_reset,
-	.dt_compat	= tegra114_dt_board_compat,
-MACHINE_END
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 63f8139..82cd85c 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -44,10 +44,11 @@ static void __init tegra30_dt_init(void)
 
 static const char *tegra30_dt_board_compat[] = {
 	"nvidia,tegra30",
+	"nvidia,tegra114",
 	NULL
 };
 
-DT_MACHINE_START(TEGRA30_DT, "NVIDIA Tegra30 (Flattened Device Tree)")
+DT_MACHINE_START(TEGRA30_DT, "NVIDIA Tegra30/114 (Flattened Device Tree)")
 	.smp		= smp_ops(tegra_smp_ops),
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra_init_early,
-- 
1.7.9.5
