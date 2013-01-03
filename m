From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:26 -0600
Subject: [PATCH v4 17/19] ARM: spear: use common irqchip_init function
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-18-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert spear DT irq initialization over to use common irqchip_init
function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    1 -
 arch/arm/mach-spear3xx/spear300.c             |    3 ++-
 arch/arm/mach-spear3xx/spear310.c             |    3 ++-
 arch/arm/mach-spear3xx/spear320.c             |    3 ++-
 arch/arm/mach-spear3xx/spear3xx.c             |   16 ----------------
 arch/arm/mach-spear6xx/spear6xx.c             |   15 ++-------------
 drivers/irqchip/spear-shirq.c                 |    3 +++
 7 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index ce19113..c26b7a4 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -30,7 +30,6 @@ extern struct pl08x_platform_data pl080_plat_data;
 void __init spear_setup_of_timer(void);
 void __init spear3xx_clk_init(void);
 void __init spear3xx_map_io(void);
-void __init spear3xx_dt_init_irq(void);
 
 void spear_restart(char, const char *);
 
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 7a11d85..499479b 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) "SPEAr300: " fmt
 
 #include <linux/amba/pl08x.h>
+#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <mach/generic.h>
@@ -211,7 +212,7 @@ static void __init spear300_map_io(void)
 
 DT_MACHINE_START(SPEAR300_DT, "ST SPEAr300 SoC with Flattened Device Tree")
 	.map_io		=	spear300_map_io,
-	.init_irq	=	spear3xx_dt_init_irq,
+	.init_irq	=	irqchip_init,
 	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear300_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 9719f83..367d9be 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -15,6 +15,7 @@
 
 #include <linux/amba/pl08x.h>
 #include <linux/amba/serial.h>
+#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <mach/generic.h>
@@ -253,7 +254,7 @@ static void __init spear310_map_io(void)
 
 DT_MACHINE_START(SPEAR310_DT, "ST SPEAr310 SoC with Flattened Device Tree")
 	.map_io		=	spear310_map_io,
-	.init_irq	=	spear3xx_dt_init_irq,
+	.init_irq	=	irqchip_init,
 	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear310_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 3a22d842..34c212e 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -16,6 +16,7 @@
 #include <linux/amba/pl022.h>
 #include <linux/amba/pl08x.h>
 #include <linux/amba/serial.h>
+#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <mach/generic.h>
@@ -267,7 +268,7 @@ static void __init spear320_map_io(void)
 
 DT_MACHINE_START(SPEAR320_DT, "ST SPEAr320 SoC with Flattened Device Tree")
 	.map_io		=	spear320_map_io,
-	.init_irq	=	spear3xx_dt_init_irq,
+	.init_irq	=	irqchip_init,
 	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear320_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 38fe95d..c6003ef 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -15,11 +15,8 @@
 
 #include <linux/amba/pl022.h>
 #include <linux/amba/pl08x.h>
-#include <linux/irqchip/spear-shirq.h>
-#include <linux/of_irq.h>
 #include <linux/io.h>
 #include <asm/hardware/pl080.h>
-#include <asm/hardware/vic.h>
 #include <plat/pl080.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
@@ -119,16 +116,3 @@ static void __init spear3xx_timer_init(void)
 struct sys_timer spear3xx_timer = {
 	.init = spear3xx_timer_init,
 };
-
-static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
-	{ .compatible = "st,spear300-shirq", .data = spear300_shirq_of_init, },
-	{ .compatible = "st,spear310-shirq", .data = spear310_shirq_of_init, },
-	{ .compatible = "st,spear320-shirq", .data = spear320_shirq_of_init, },
-	{ /* Sentinel */ }
-};
-
-void __init spear3xx_dt_init_irq(void)
-{
-	of_irq_init(vic_of_match);
-}
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 9d81068..3f6fac0 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -16,12 +16,11 @@
 #include <linux/amba/pl08x.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <asm/hardware/pl080.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
@@ -425,19 +424,9 @@ static const char *spear600_dt_board_compat[] = {
 	NULL
 };
 
-static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
-	{ /* Sentinel */ }
-};
-
-static void __init spear6xx_dt_init_irq(void)
-{
-	of_irq_init(vic_of_match);
-}
-
 DT_MACHINE_START(SPEAR600_DT, "ST SPEAr600 (Flattened Device Tree)")
 	.map_io		=	spear6xx_map_io,
-	.init_irq	=	spear6xx_dt_init_irq,
+	.init_irq	=	irqchip_init,
 	.timer		=	&spear6xx_timer,
 	.init_machine	=	spear600_dt_init,
 	.restart	=	spear_restart,
diff --git a/drivers/irqchip/spear-shirq.c b/drivers/irqchip/spear-shirq.c
index 80e1d2f..9011b2e 100644
--- a/drivers/irqchip/spear-shirq.c
+++ b/drivers/irqchip/spear-shirq.c
@@ -300,6 +300,7 @@ int __init spear300_shirq_of_init(struct device_node *np,
 	return shirq_init(spear300_shirq_blocks,
 			ARRAY_SIZE(spear300_shirq_blocks), np);
 }
+IRQCHIP_DECLARE(spear300_shirq, "st,spear300-shirq", spear300_shirq_of_init);
 
 int __init spear310_shirq_of_init(struct device_node *np,
 		struct device_node *parent)
@@ -307,6 +308,7 @@ int __init spear310_shirq_of_init(struct device_node *np,
 	return shirq_init(spear310_shirq_blocks,
 			ARRAY_SIZE(spear310_shirq_blocks), np);
 }
+IRQCHIP_DECLARE(spear310_shirq, "st,spear310-shirq", spear310_shirq_of_init);
 
 int __init spear320_shirq_of_init(struct device_node *np,
 		struct device_node *parent)
@@ -314,3 +316,4 @@ int __init spear320_shirq_of_init(struct device_node *np,
 	return shirq_init(spear320_shirq_blocks,
 			ARRAY_SIZE(spear320_shirq_blocks), np);
 }
+IRQCHIP_DECLARE(spear320_shirq, "st,spear320-shirq", spear320_shirq_of_init);
-- 
1.7.10.4
