From: david@lechnology.com (David Lechner)
Date: Fri,  1 Dec 2017 20:34:10 -0600
Subject: [PATCH v1 2/6] ARM: davinci: move davinci_clk_init() to init_time
In-Reply-To: <1512182054-17410-1-git-send-email-david@lechnology.com>
References: <1512182054-17410-1-git-send-email-david@lechnology.com>
Message-ID: <1512182054-17410-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the call of davinci_clk_init() from map_io to init_time for all
boards.

This is the proper place to init clocks. This is also done in preparation
for moving to the common clock framework.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da830.c  | 2 --
 arch/arm/mach-davinci/da850.c  | 2 --
 arch/arm/mach-davinci/dm355.c  | 1 -
 arch/arm/mach-davinci/dm365.c  | 1 -
 arch/arm/mach-davinci/dm644x.c | 1 -
 arch/arm/mach-davinci/dm646x.c | 7 -------
 arch/arm/mach-davinci/time.c   | 7 +++++++
 7 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 2e249f0..f28eda1 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1220,6 +1220,4 @@ void __init da830_map_io(void)
 
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
-
-	davinci_clk_init(davinci_soc_info_da830.cpu_clks);
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 056b148..28d8ec2 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1392,6 +1392,4 @@ void __init da850_map_io(void)
 	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 	v &= ~CFGCHIP3_PLL1_MASTER_LOCK;
 	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
-
-	davinci_clk_init(davinci_soc_info_da850.cpu_clks);
 }
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 88c3c80..164ff27 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -1043,7 +1043,6 @@ void __init dm355_map_io(void)
 {
 	davinci_common_init(&davinci_soc_info_dm355);
 	davinci_map_sysmod();
-	davinci_clk_init(davinci_soc_info_dm355.cpu_clks);
 }
 
 int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index f979180..6076085 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1166,7 +1166,6 @@ void __init dm365_map_io(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
 	davinci_map_sysmod();
-	davinci_clk_init(davinci_soc_info_dm365.cpu_clks);
 }
 
 static struct resource dm365_vpss_resources[] = {
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 80048c0..c5b1cf3 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -931,7 +931,6 @@ void __init dm644x_map_io(void)
 {
 	davinci_common_init(&davinci_soc_info_dm644x);
 	davinci_map_sysmod();
-	davinci_clk_init(davinci_soc_info_dm644x.cpu_clks);
 }
 
 int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index b3be5c8..a844f7b 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -17,7 +17,6 @@
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 
-#include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
 #include <mach/cputype.h>
@@ -953,16 +952,10 @@ int __init dm646x_init_edma(struct edma_rsv_info *rsv)
 	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
 
-#define DM6467T_EVM_REF_FREQ		33000000
-
 void __init dm646x_map_io(void)
 {
 	davinci_common_init(&davinci_soc_info_dm646x);
 	davinci_map_sysmod();
-	davinci_clk_init(davinci_soc_info_dm646x.cpu_clks);
-
-	if (machine_is_davinci_dm6467tevm())
-		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 034f865..6ba156e 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 
+#include <asm/mach-types.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
@@ -341,6 +342,7 @@ static struct clock_event_device clockevent_davinci = {
 	.set_state_oneshot	= davinci_set_oneshot,
 };
 
+#define DM6467T_EVM_REF_FREQ		33000000
 
 void __init davinci_timer_init(void)
 {
@@ -350,6 +352,11 @@ void __init davinci_timer_init(void)
 	unsigned int clocksource_id;
 	int i;
 
+	davinci_clk_init(soc_info->cpu_clks);
+
+	if (machine_is_davinci_dm6467tevm())
+		davinci_set_refclk_rate(DM6467T_EVM_REF_FREQ);
+
 	clockevent_id = soc_info->timer_info->clockevent_id;
 	clocksource_id = soc_info->timer_info->clocksource_id;
 
-- 
2.7.4
