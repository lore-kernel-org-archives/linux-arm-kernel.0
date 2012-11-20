From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:01:03 +0100
Subject: [PATCH 12/16] ARM: spear3xx: use common irqchip_init
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-13-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a common irqchip infrastructure, use it on the
spear3xx platform:

 * Use irqchip_init() as the ->irq_init() machine function. The
   irqchip infrastructure already knows about the compatible strings
   for the VIC IRQ controller driver.

 * No longer needed to set ->handle_irq() in the machine structure, as
   it will be set by the VIC IRQ controller driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    1 -
 arch/arm/mach-spear3xx/spear300.c             |    5 ++---
 arch/arm/mach-spear3xx/spear310.c             |    5 ++---
 arch/arm/mach-spear3xx/spear320.c             |    5 ++---
 arch/arm/mach-spear3xx/spear3xx.c             |   10 ----------
 5 files changed, 6 insertions(+), 20 deletions(-)

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
index 6ec3005..a56922e 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -15,7 +15,7 @@
 
 #include <linux/amba/pl08x.h>
 #include <linux/of_platform.h>
-#include <asm/hardware/vic.h>
+#include <linux/irqchip.h>
 #include <asm/mach/arch.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
@@ -315,8 +315,7 @@ static void __init spear300_map_io(void)
 
 DT_MACHINE_START(SPEAR300_DT, "ST SPEAr300 SoC with Flattened Device Tree")
 	.map_io		=	spear300_map_io,
-	.init_irq	=	spear3xx_dt_init_irq,
-	.handle_irq	=	vic_handle_irq,
+	.init_irq	=	irqchip_init,
 	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear300_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 1d0e435..3e9cb6c 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -15,8 +15,8 @@
 
 #include <linux/amba/pl08x.h>
 #include <linux/amba/serial.h>
+#include <linux/irqchip.h>
 #include <linux/of_platform.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
@@ -456,8 +456,7 @@ static void __init spear310_map_io(void)
 
 DT_MACHINE_START(SPEAR310_DT, "ST SPEAr310 SoC with Flattened Device Tree")
 	.map_io		=	spear310_map_io,
-	.init_irq	=	spear3xx_dt_init_irq,
-	.handle_irq	=	vic_handle_irq,
+	.init_irq	=	irqchip_init,
 	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear310_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index fd823c6..675aa9c 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -13,11 +13,11 @@
 
 #define pr_fmt(fmt) "SPEAr320: " fmt
 
+#include <linux/irqchip.h>
 #include <linux/amba/pl022.h>
 #include <linux/amba/pl08x.h>
 #include <linux/amba/serial.h>
 #include <linux/of_platform.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
@@ -471,8 +471,7 @@ static void __init spear320_map_io(void)
 
 DT_MACHINE_START(SPEAR320_DT, "ST SPEAr320 SoC with Flattened Device Tree")
 	.map_io		=	spear320_map_io,
-	.init_irq	=	spear3xx_dt_init_irq,
-	.handle_irq	=	vic_handle_irq,
+	.init_irq	=	irqchip_init,
 	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear320_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 98144ba..4daecef 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -118,13 +118,3 @@ static void __init spear3xx_timer_init(void)
 struct sys_timer spear3xx_timer = {
 	.init = spear3xx_timer_init,
 };
-
-static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
-	{ /* Sentinel */ }
-};
-
-void __init spear3xx_dt_init_irq(void)
-{
-	of_irq_init(vic_of_match);
-}
-- 
1.7.9.5
