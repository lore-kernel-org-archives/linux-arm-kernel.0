From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 18 Mar 2013 16:09:58 +0800
Subject: [PATCH V2 2/3] ARM: tegra: get PMC clock source from DT
In-Reply-To: <1363594199-10974-1-git-send-email-josephl@nvidia.com>
References: <1363594199-10974-1-git-send-email-josephl@nvidia.com>
Message-ID: <1363594199-10974-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock source of PMC should be PCLK and gotten from DT.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* new in this change
---
 arch/arm/mach-tegra/common.c | 2 +-
 arch/arm/mach-tegra/pmc.c    | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index f0315c9..b02ebe7 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -61,6 +61,7 @@ u32 tegra_uart_config[4] = {
 void __init tegra_dt_init_irq(void)
 {
 	tegra_clocks_init();
+	tegra_pmc_init();
 	tegra_init_irq();
 	irqchip_init();
 }
@@ -100,7 +101,6 @@ void __init tegra_init_early(void)
 	tegra_apb_io_init();
 	tegra_init_fuse();
 	tegra_init_cache();
-	tegra_pmc_init();
 	tegra_powergate_init();
 	tegra_hotplug_init();
 }
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index b30e921..05259fd 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/clk.h>
 
 #define PMC_CTRL			0x0
 #define PMC_CTRL_INTR_LOW		(1 << 17)
@@ -43,6 +44,7 @@ static DEFINE_SPINLOCK(tegra_powergate_lock);
 
 static void __iomem *tegra_pmc_base;
 static bool tegra_pmc_invert_interrupt;
+static struct clk *tegra_pclk;
 
 static inline u32 tegra_pmc_readl(u32 reg)
 {
@@ -151,6 +153,8 @@ static void tegra_pmc_parse_dt(void)
 
 	tegra_pmc_invert_interrupt = of_property_read_bool(np,
 				     "nvidia,invert-interrupt");
+	tegra_pclk = of_clk_get(np, 0);
+	WARN_ON_ONCE(IS_ERR(tegra_pclk));
 }
 
 void __init tegra_pmc_init(void)
-- 
1.8.1.5
