From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 29 Mar 2013 18:19:49 -0600
Subject: [PATCH 1/2] ARM: tegra: move <mach/powergate.h> to
 <linux/tegra-powergate.h>
Message-ID: <1364602790-10759-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This is required so that code such as Tegra's PCIe and clock drivers
can still access this header file once Tegra is converted to
multiplatform, and <mach/> no longer exists.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board.h                                       |    1 +
 arch/arm/mach-tegra/common.c                                      |    2 --
 arch/arm/mach-tegra/pcie.c                                        |    3 +--
 arch/arm/mach-tegra/powergate.c                                   |    3 +--
 drivers/clk/tegra/clk-tegra30.c                                   |    3 +--
 .../include/mach/powergate.h => include/linux/tegra-powergate.h   |    5 -----
 6 files changed, 4 insertions(+), 13 deletions(-)
 rename arch/arm/mach-tegra/include/mach/powergate.h => include/linux/tegra-powergate.h (92%)

diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index 60431de..1787327 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -40,6 +40,7 @@ int tegra_clk_debugfs_init(void);
 static inline int tegra_clk_debugfs_init(void) { return 0; }
 #endif
 
+int __init tegra_powergate_init(void);
 #if defined(CONFIG_ARCH_TEGRA_2x_SOC) && defined(CONFIG_DEBUG_FS)
 int __init tegra_powergate_debugfs_init(void);
 #else
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index f0315c9..7cc75636 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -27,8 +27,6 @@
 
 #include <asm/hardware/cache-l2x0.h>
 
-#include <mach/powergate.h>
-
 #include "board.h"
 #include "common.h"
 #include "fuse.h"
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index b60165f..46144a1 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -34,12 +34,11 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/clk/tegra.h>
+#include <linux/tegra-powergate.h>
 
 #include <asm/sizes.h>
 #include <asm/mach/pci.h>
 
-#include <mach/powergate.h>
-
 #include "board.h"
 #include "iomap.h"
 
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index c6bc8f8..585d297 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -27,8 +27,7 @@
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/clk/tegra.h>
-
-#include <mach/powergate.h>
+#include <linux/tegra-powergate.h>
 
 #include "fuse.h"
 #include "iomap.h"
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 32c61cb..84584e5 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -22,8 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk/tegra.h>
-
-#include <mach/powergate.h>
+#include <linux/tegra-powergate.h>
 
 #include "clk.h"
 
diff --git a/arch/arm/mach-tegra/include/mach/powergate.h b/include/linux/tegra-powergate.h
similarity index 92%
rename from arch/arm/mach-tegra/include/mach/powergate.h
rename to include/linux/tegra-powergate.h
index 06763fe..55c29a8 100644
--- a/arch/arm/mach-tegra/include/mach/powergate.h
+++ b/include/linux/tegra-powergate.h
@@ -1,6 +1,4 @@
 /*
- * drivers/regulator/tegra-regulator.c
- *
  * Copyright (c) 2010 Google, Inc
  *
  * Author:
@@ -40,9 +38,6 @@ struct clk;
 #define TEGRA_POWERGATE_CPU0	TEGRA_POWERGATE_CPU
 #define TEGRA_POWERGATE_3D0	TEGRA_POWERGATE_3D
 
-int  __init tegra_powergate_init(void);
-
-int tegra_cpu_powergate_id(int cpuid);
 int tegra_powergate_is_powered(int id);
 int tegra_powergate_power_on(int id);
 int tegra_powergate_power_off(int id);
-- 
1.7.10.4
