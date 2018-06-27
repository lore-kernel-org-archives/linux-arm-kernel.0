From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 27 Jun 2018 17:01:49 +0200
Subject: [PATCH v3 1/2] clk: pxa: export 32kHz PLL
Message-ID: <20180627150150.23951-1-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock is especially used by the RTC driver, so export it so that
devicetree users can use it.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v2: fix missing parenthesis in clk-pxa25x.c and clk-pxa3xx.c
---
 drivers/clk/pxa/clk-pxa25x.c          | 6 ++++--
 drivers/clk/pxa/clk-pxa27x.c          | 7 ++++---
 drivers/clk/pxa/clk-pxa3xx.c          | 7 ++++---
 include/dt-bindings/clock/pxa-clock.h | 3 ++-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa25x.c b/drivers/clk/pxa/clk-pxa25x.c
index 6416c1f8e632..e88f8e01fe3a 100644
--- a/drivers/clk/pxa/clk-pxa25x.c
+++ b/drivers/clk/pxa/clk-pxa25x.c
@@ -292,8 +292,10 @@ static void __init pxa25x_register_plls(void)
 {
 	clk_register_fixed_rate(NULL, "osc_3_6864mhz", NULL,
 				CLK_GET_RATE_NOCACHE, 3686400);
-	clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
-				CLK_GET_RATE_NOCACHE, 32768);
+	clkdev_pxa_register(CLK_OSC32k768, "osc_32_768khz", NULL,
+			    clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
+						    CLK_GET_RATE_NOCACHE,
+						    32768));
 	clk_register_fixed_rate(NULL, "clk_dummy", NULL, 0, 0);
 	clk_register_fixed_factor(NULL, "ppll_95_85mhz", "osc_3_6864mhz",
 				  0, 26, 1);
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index 25a30194d27a..d40b63e7bbce 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -314,9 +314,10 @@ static void __init pxa27x_register_plls(void)
 	clk_register_fixed_rate(NULL, "osc_13mhz", NULL,
 				CLK_GET_RATE_NOCACHE,
 				13 * MHz);
-	clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
-				CLK_GET_RATE_NOCACHE,
-				32768 * KHz);
+	clkdev_pxa_register(CLK_OSC32k768, "osc_32_768khz", NULL,
+			    clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
+						    CLK_GET_RATE_NOCACHE,
+						    32768 * KHz));
 	clk_register_fixed_rate(NULL, "clk_dummy", NULL, 0, 0);
 	clk_register_fixed_factor(NULL, "ppll_312mhz", "osc_13mhz", 0, 24, 1);
 }
diff --git a/drivers/clk/pxa/clk-pxa3xx.c b/drivers/clk/pxa/clk-pxa3xx.c
index 2d126df2bccd..7aa120c3bd08 100644
--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -286,9 +286,10 @@ static void __init pxa3xx_register_plls(void)
 	clk_register_fixed_rate(NULL, "osc_13mhz", NULL,
 				CLK_GET_RATE_NOCACHE,
 				13 * MHz);
-	clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
-				CLK_GET_RATE_NOCACHE,
-				32768);
+	clkdev_pxa_register(CLK_OSC32k768, "osc_32_768khz", NULL,
+			    clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
+						    CLK_GET_RATE_NOCACHE,
+						    32768));
 	clk_register_fixed_rate(NULL, "ring_osc_120mhz", NULL,
 				CLK_GET_RATE_NOCACHE,
 				120 * MHz);
diff --git a/include/dt-bindings/clock/pxa-clock.h b/include/dt-bindings/clock/pxa-clock.h
index e65803b1dc7e..0b0fd2b01538 100644
--- a/include/dt-bindings/clock/pxa-clock.h
+++ b/include/dt-bindings/clock/pxa-clock.h
@@ -72,6 +72,7 @@
 #define CLK_USIM 58
 #define CLK_USIM1 59
 #define CLK_USMI0 60
-#define CLK_MAX 61
+#define CLK_OSC32k768 61
+#define CLK_MAX 62
 
 #endif
-- 
2.11.0
