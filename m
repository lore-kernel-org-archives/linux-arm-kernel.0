From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 07 Oct 2014 13:23:20 +0530
Subject: [PATCH v3 1/2] clk: samsung: exynos5440: move restart code into clock
 driver
In-Reply-To: <1412668401-21837-1-git-send-email-pankaj.dubey@samsung.com>
References: <1412668401-21837-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1412668401-21837-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's register restart handler for Exynos5440 from it's clock driver
for reboot functionality. So that we can cleanup restart hooks from
machine specific file.

CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
CC: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/exynos.c        |   19 +------------------
 drivers/clk/samsung/clk-exynos5440.c |   29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 6b283eb..e9ddf69 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -139,24 +139,7 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 
 static void exynos_restart(enum reboot_mode mode, const char *cmd)
 {
-	struct device_node *np;
-	u32 val = 0x1;
-	void __iomem *addr = pmu_base_addr + EXYNOS_SWRESET;
-
-	if (of_machine_is_compatible("samsung,exynos5440")) {
-		u32 status;
-		np = of_find_compatible_node(NULL, NULL, "samsung,exynos5440-clock");
-
-		addr = of_iomap(np, 0) + 0xbc;
-		status = __raw_readl(addr);
-
-		addr = of_iomap(np, 0) + 0xcc;
-		val = __raw_readl(addr);
-
-		val = (val & 0xffff0000) | (status & 0xffff);
-	}
-
-	__raw_writel(val, addr);
+	__raw_writel(0x1, pmu_base_addr + EXYNOS_SWRESET);
 }
 
 static struct platform_device exynos_cpuidle = {
diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index 00d1d00..f43b925 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -15,6 +15,8 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 
 #include "clk.h"
 #include "clk-pll.h"
@@ -23,6 +25,8 @@
 #define CPU_CLK_STATUS		0xfc
 #define MISC_DOUT1		0x558
 
+static void __iomem *reg_base;
+
 /* parent clock name list */
 PNAME(mout_armclk_p)	= { "cplla", "cpllb" };
 PNAME(mout_spi_p)	= { "div125", "div200" };
@@ -89,10 +93,30 @@ static const struct of_device_id ext_clk_match[] __initconst = {
 	{},
 };
 
+static int exynos5440_clk_restart_notify(struct notifier_block *this,
+		unsigned long code, void *unused)
+{
+	u32 val, status;
+
+	status = readl_relaxed(reg_base + 0xbc);
+	val = readl_relaxed(reg_base + 0xcc);
+	val = (val & 0xffff0000) | (status & 0xffff);
+	writel_relaxed(val, reg_base + 0xcc);
+
+	return NOTIFY_DONE;
+}
+
+/*
+ * Exynos5440 Clock reboot notifier, handles reboot functionality
+ */
+static struct notifier_block exynos5440_clk_restart_handler = {
+	.notifier_call = exynos5440_clk_restart_notify,
+	.priority = 128,
+};
+
 /* register exynos5440 clocks */
 static void __init exynos5440_clk_init(struct device_node *np)
 {
-	void __iomem *reg_base;
 	struct samsung_clk_provider *ctx;
 
 	reg_base = of_iomap(np, 0);
@@ -125,6 +149,9 @@ static void __init exynos5440_clk_init(struct device_node *np)
 
 	samsung_clk_of_add_provider(np, ctx);
 
+	if (register_restart_handler(&exynos5440_clk_restart_handler))
+		pr_err("exynos5440 clock can't register restart handler\n");
+
 	pr_info("Exynos5440: arm_clk = %ldHz\n", _get_rate("arm_clk"));
 	pr_info("exynos5440 clock initialization complete\n");
 }
-- 
1.7.9.5
