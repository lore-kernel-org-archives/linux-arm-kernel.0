From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  7 Feb 2015 22:54:02 +0100
Subject: [PATCH 1/2] ARM: pxa: convert eseries to clock framework
In-Reply-To: <1423346043-7391-1-git-send-email-robert.jarzmik@free.fr>
References: <1423346043-7391-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1423346043-7391-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As pxa architecture transitions to clock framework, the previously
available INIT_CLKREG is no more. Use the fixed clock rate initializer
to declare the "fake" CLK_CK32K in eseries.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/eseries.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index d8fc9a3..9522265 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/clk-provider.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
@@ -125,27 +126,9 @@ struct resource eseries_tmio_resources[] = {
 };
 
 /* Some e-series hardware cannot control the 32K clock */
-static void clk_32k_dummy(struct clk *clk)
-{
-}
-
-static const struct clkops clk_32k_dummy_ops = {
-	.enable         = clk_32k_dummy,
-	.disable        = clk_32k_dummy,
-};
-
-static struct clk tmio_dummy_clk = {
-	.ops	= &clk_32k_dummy_ops,
-	.rate	= 32768,
-};
-
-static struct clk_lookup eseries_clkregs[] = {
-	INIT_CLKREG(&tmio_dummy_clk, NULL, "CLK_CK32K"),
-};
-
 static void __init eseries_register_clks(void)
 {
-	clkdev_add_table(eseries_clkregs, ARRAY_SIZE(eseries_clkregs));
+	clk_register_fixed_rate(NULL, "CLK_CK32K", NULL, CLK_IS_ROOT, 32768);
 }
 
 #ifdef CONFIG_MACH_E330
-- 
2.1.0
