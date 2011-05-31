From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 31 May 2011 15:14:07 -0600
Subject: [PATCH 1/2] ARM: Tegra: Harmony: Fix conflicting GPIO numbering
In-Reply-To: <1306876448-28147-1-git-send-email-swarren@nvidia.com>
References: <1306876448-28147-1-git-send-email-swarren@nvidia.com>
Message-ID: <1306876448-28147-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, both the WM8903 and TPS6586x chips attempt to register with
gpiolib using the same GPIO numbers. This causes the audio driver to
fail to initialize.

To solve this, add a define to board-harmony.h for the TPS6586x, and make
board-harmony-power.c use this define, instead of directly referencing
TEGRA_NR_GPIOS.

This fixes a regression introduced by commit
6f168f2fa60f87e85e0df25e87e2372f22f5eb7c.
ARM: tegra: harmony: initialize the TPS65862 PMIC

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony-power.c |    4 +++-
 arch/arm/mach-tegra/board-harmony.h       |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
index c84442c..5ad8b2f 100644
--- a/arch/arm/mach-tegra/board-harmony-power.c
+++ b/arch/arm/mach-tegra/board-harmony-power.c
@@ -24,6 +24,8 @@
 
 #include <mach/irqs.h>
 
+#include "board-harmony.h"
+
 #define PMC_CTRL		0x0
 #define PMC_CTRL_INTR_LOW	(1 << 17)
 
@@ -98,7 +100,7 @@ static struct tps6586x_platform_data tps_platform = {
 	.irq_base	= TEGRA_NR_IRQS,
 	.num_subdevs	= ARRAY_SIZE(tps_devs),
 	.subdevs	= tps_devs,
-	.gpio_base	= TEGRA_NR_GPIOS,
+	.gpio_base	= HARMONY_GPIO_TPS6586X(0),
 };
 
 static struct i2c_board_info __initdata harmony_regulators[] = {
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index 1e57b07..d85142e 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -17,7 +17,8 @@
 #ifndef _MACH_TEGRA_BOARD_HARMONY_H
 #define _MACH_TEGRA_BOARD_HARMONY_H
 
-#define HARMONY_GPIO_WM8903(_x_)	(TEGRA_NR_GPIOS + (_x_))
+#define HARMONY_GPIO_TPS6586X(_x_)	(TEGRA_NR_GPIOS + (_x_))
+#define HARMONY_GPIO_WM8903(_x_)	(HARMONY_GPIO_TPS6586X(4) + (_x_))
 
 #define TEGRA_GPIO_SD2_CD		TEGRA_GPIO_PI5
 #define TEGRA_GPIO_SD2_WP		TEGRA_GPIO_PH1
-- 
1.7.0.4
