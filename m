From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:06:27 +0100
Subject: [PATCH 3/9] ARM: pxa: mark unused eseries code as __maybe_unused
In-Reply-To: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
Message-ID: <1454076396-3563101-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two variables in eseries.c are used on multiple platforms,
but are not referenced when those are all disabled:

eseries.c:60:31: warning: 'e7xx_gpio_vbus' defined but not used [-Wunused-variable]
eseries.c:129:20: warning: 'eseries_register_clks' defined but not used [-Wunused-function]

Marking them __maybe_unused is the nicest way to ensure
that we never get the warning or end up with missing symbols
if we get it wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/eseries.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 0b00b226f54b..e838b11fb8c7 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -57,7 +57,7 @@ struct gpio_vbus_mach_info e7xx_udc_info = {
 	.gpio_pullup_inverted = 1
 };
 
-static struct platform_device e7xx_gpio_vbus = {
+static struct platform_device e7xx_gpio_vbus __maybe_unused = {
 	.name	= "gpio-vbus",
 	.id	= -1,
 	.dev	= {
@@ -126,7 +126,7 @@ struct resource eseries_tmio_resources[] = {
 };
 
 /* Some e-series hardware cannot control the 32K clock */
-static void __init eseries_register_clks(void)
+static void __init __maybe_unused eseries_register_clks(void)
 {
 	clk_register_fixed_rate(NULL, "CLK_CK32K", NULL, CLK_IS_ROOT, 32768);
 }
-- 
2.7.0
