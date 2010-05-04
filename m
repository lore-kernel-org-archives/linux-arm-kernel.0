From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 4 May 2010 14:27:28 +0530
Subject: [PATCH 1/2] nomadik: define clocks statically
Message-ID: <1272963449-17657-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a table for clocks to be defined statically, so that new clocks can
be added without having to call nmdk_clk_create() for each of them.
Remove the now unused nmdk_clk_create() function.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-nomadik/board-nhk8815.c |   10 +---------
 arch/arm/mach-nomadik/clock.c         |   28 ++++++++++++++++++++--------
 arch/arm/mach-nomadik/clock.h         |    1 -
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index ab3712c..841d459 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -32,7 +32,6 @@
 #include <mach/setup.h>
 #include <mach/nand.h>
 #include <mach/fsmc.h>
-#include "clock.h"
 
 /* Initial value for SRC control register: all timers use MXTAL/8 source */
 #define SRC_CR_INIT_MASK	0x00007fff
@@ -202,11 +201,6 @@ static struct amba_device *amba_devs[] __initdata = {
 	&uart1_device,
 };
 
-/* We have a fixed clock alone, by now */
-static struct clk nhk8815_clk_48 = {
-	.rate = 48*1000*1000,
-};
-
 static struct resource nhk8815_eth_resources[] = {
 	{
 		.name = "smc91x-regs",
@@ -276,10 +270,8 @@ static void __init nhk8815_platform_init(void)
 	platform_add_devices(nhk8815_platform_devices,
 			     ARRAY_SIZE(nhk8815_platform_devices));
 
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
-		nmdk_clk_create(&nhk8815_clk_48, amba_devs[i]->dev.init_name);
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
-	}
 }
 
 MACHINE_START(NOMADIK, "NHK8815")
diff --git a/arch/arm/mach-nomadik/clock.c b/arch/arm/mach-nomadik/clock.c
index 9f92502..7af7850 100644
--- a/arch/arm/mach-nomadik/clock.c
+++ b/arch/arm/mach-nomadik/clock.c
@@ -32,14 +32,26 @@ void clk_disable(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_disable);
 
-/* Create a clock structure with the given name */
-int nmdk_clk_create(struct clk *clk, const char *dev_id)
-{
-	struct clk_lookup *clkdev;
+/* We have a fixed clock alone, for now */
+static struct clk clk_48 = {
+	.rate = 48 * 1000 * 1000,
+};
+
+#define CLK(_clk, dev)				\
+	{					\
+		.clk		= _clk,		\
+		.dev_id		= dev,		\
+	}
+
+static struct clk_lookup lookups[] = {
+	CLK(&clk_48, "uart0"),
+	CLK(&clk_48, "uart1"),
+};
 
-	clkdev = clkdev_alloc(clk, NULL, dev_id);
-	if (!clkdev)
-		return -ENOMEM;
-	clkdev_add(clkdev);
+static int __init clk_init(void)
+{
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 	return 0;
 }
+
+arch_initcall(clk_init);
diff --git a/arch/arm/mach-nomadik/clock.h b/arch/arm/mach-nomadik/clock.h
index 235faec..5563985 100644
--- a/arch/arm/mach-nomadik/clock.h
+++ b/arch/arm/mach-nomadik/clock.h
@@ -11,4 +11,3 @@
 struct clk {
 	unsigned long		rate;
 };
-extern int nmdk_clk_create(struct clk *clk, const char *dev_id);
-- 
1.7.0
