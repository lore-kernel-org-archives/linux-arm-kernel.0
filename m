From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 23 Oct 2012 12:28:11 -0600
Subject: [PATCH 2/3] ARM: tegra: enhance timer.c to get IO address from device
 tree
In-Reply-To: <1351016892-21211-1-git-send-email-swarren@wwwdotorg.org>
References: <1351016892-21211-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1351016892-21211-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Modify Tegra's timer code to parse the IO address from device tree,
hence removing the dependency on <mach/iomap.h>. This will allow the
driver to be moved to drivers/clocksource/.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/timer.c |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 026bad4..e4863f3 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -26,6 +26,7 @@
 #include <linux/clocksource.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 
 #include <asm/mach/time.h>
@@ -33,8 +34,6 @@
 #include <asm/sched_clock.h>
 
 #include "board.h"
-#include "clock.h"
-#include "iomap.h"
 
 #define RTC_SECONDS            0x08
 #define RTC_SHADOW_SECONDS     0x0c
@@ -52,8 +51,8 @@
 #define TIMER_PTV 0x0
 #define TIMER_PCR 0x4
 
-static void __iomem *timer_reg_base = IO_ADDRESS(TEGRA_TMR1_BASE);
-static void __iomem *rtc_base = IO_ADDRESS(TEGRA_RTC_BASE);
+static void __iomem *timer_reg_base;
+static void __iomem *rtc_base;
 
 static struct timespec persistent_ts;
 static u64 persistent_ms, last_persistent_ms;
@@ -164,6 +163,11 @@ static const struct of_device_id timer_match[] __initconst = {
 	{}
 };
 
+static const struct of_device_id rtc_match[] __initconst = {
+	{ .compatible = "nvidia,tegra20-rtc" },
+	{}
+};
+
 static void __init tegra_init_timer(void)
 {
 	struct device_node *np;
@@ -177,6 +181,12 @@ static void __init tegra_init_timer(void)
 		BUG();
 	}
 
+	timer_reg_base = of_iomap(np, 0);
+	if (!timer_reg_base) {
+		pr_err("Can't map timer registers");
+		BUG();
+	}
+
 	tegra_timer_irq.irq = irq_of_parse_and_map(np, 2);
 	if (tegra_timer_irq.irq <= 0) {
 		pr_err("Failed to map timer IRQ\n");
@@ -192,6 +202,20 @@ static void __init tegra_init_timer(void)
 		rate = clk_get_rate(clk);
 	}
 
+	of_node_put(np);
+
+	np = of_find_matching_node(NULL, rtc_match);
+	if (!np) {
+		pr_err("Failed to find RTC DT node\n");
+		BUG();
+	}
+
+	rtc_base = of_iomap(np, 0);
+	if (!rtc_base) {
+		pr_err("Can't map RTC registers");
+		BUG();
+	}
+
 	/*
 	 * rtc registers are used by read_persistent_clock, keep the rtc clock
 	 * enabled
-- 
1.7.0.4
