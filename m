From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 25 Jan 2012 14:43:29 -0700
Subject: [PATCH 3/3] ARM: tegra: Remove duplicate PMU interrupt inversion code
In-Reply-To: <1327527809-10179-1-git-send-email-swarren@nvidia.com>
References: <1327527809-10179-1-git-send-email-swarren@nvidia.com>
Message-ID: <1327527809-10179-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new PMC driver now configures the PMU interrupt inversion, so board
files don't need to poke the PMC registers directly to achieve this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony-power.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
index 21d1285..976edfb 100644
--- a/arch/arm/mach-tegra/board-harmony-power.c
+++ b/arch/arm/mach-tegra/board-harmony-power.c
@@ -18,18 +18,13 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/io.h>
 #include <linux/regulator/machine.h>
 #include <linux/mfd/tps6586x.h>
 
-#include <mach/iomap.h>
 #include <mach/irqs.h>
 
 #include "board-harmony.h"
 
-#define PMC_CTRL		0x0
-#define PMC_CTRL_INTR_LOW	(1 << 17)
-
 static struct regulator_consumer_supply tps658621_ldo0_supply[] = {
 	REGULATOR_SUPPLY("pex_clk", NULL),
 };
@@ -114,16 +109,6 @@ static struct i2c_board_info __initdata harmony_regulators[] = {
 
 int __init harmony_regulator_init(void)
 {
-	void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
-	u32 pmc_ctrl;
-
-	/*
-	 * Configure the power management controller to trigger PMU
-	 * interrupts when low
-	 */
-	pmc_ctrl = readl(pmc + PMC_CTRL);
-	writel(pmc_ctrl | PMC_CTRL_INTR_LOW, pmc + PMC_CTRL);
-
 	i2c_register_board_info(3, harmony_regulators, 1);
 
 	return 0;
-- 
1.7.0.4
