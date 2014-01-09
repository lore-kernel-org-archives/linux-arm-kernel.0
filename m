From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 9 Jan 2014 17:11:57 +0530
Subject: [GIT PULL] DaVinci watchdog change for v3.14
Message-ID: <52CE8B05.2040800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

Can you please pull the following patch. It has been acked by Wim.
There are some other davinci_wdt.c patches Wim has queued in his
tree, but a test merge of this patch with latest linux-next does
not throw any conflicts.

Thanks,
Sekhar

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.14/watchdog

for you to fetch changes up to 843748123d95ae77a489b41f2f193e8502fc7ea8:

  watchdog: davinci: rename platform driver to davinci-wdt (2014-01-09 16:48:31 +0530)

----------------------------------------------------------------
This patch updates the davinci watchdog
platform device name from generic "watchdog"
to something more specific.

----------------------------------------------------------------
Ivan Khoronzhuk (1):
      watchdog: davinci: rename platform driver to davinci-wdt

 arch/arm/mach-davinci/da830.c         |    2 +-
 arch/arm/mach-davinci/da850.c         |    2 +-
 arch/arm/mach-davinci/da8xx-dt.c      |    2 +-
 arch/arm/mach-davinci/devices-da8xx.c |    4 ++--
 arch/arm/mach-davinci/devices.c       |    2 +-
 arch/arm/mach-davinci/dm355.c         |    2 +-
 arch/arm/mach-davinci/dm365.c         |    2 +-
 arch/arm/mach-davinci/dm644x.c        |    2 +-
 arch/arm/mach-davinci/dm646x.c        |    2 +-
 drivers/watchdog/davinci_wdt.c        |    4 ++--
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 0813b51..82c6013 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -385,7 +385,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK(NULL,		"pll0_sysclk7",	&pll0_sysclk7),
 	CLK("i2c_davinci.1",	NULL,		&i2c0_clk),
 	CLK(NULL,		"timer0",	&timerp64_0_clk),
-	CLK("watchdog",		NULL,		&timerp64_1_clk),
+	CLK("davinci-wdt",	NULL,		&timerp64_1_clk),
 	CLK(NULL,		"arm_rom",	&arm_rom_clk),
 	CLK(NULL,		"scr0_ss",	&scr0_ss_clk),
 	CLK(NULL,		"scr1_ss",	&scr1_ss_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 352984e..ccb2f58 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -443,7 +443,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"pll1_sysclk3",	&pll1_sysclk3),
 	CLK("i2c_davinci.1",	NULL,		&i2c0_clk),
 	CLK(NULL,		"timer0",	&timerp64_0_clk),
-	CLK("watchdog",		NULL,		&timerp64_1_clk),
+	CLK("davinci-wdt",	NULL,		&timerp64_1_clk),
 	CLK(NULL,		"arm_rom",	&arm_rom_clk),
 	CLK(NULL,		"tpcc0",	&tpcc0_clk),
 	CLK(NULL,		"tptc0",	&tptc0_clk),
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index d2bc574..ed19287 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -32,7 +32,7 @@ static void __init da8xx_init_irq(void)
 
 static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
-	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "watchdog", NULL),
+	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "davinci-wdt", NULL),
 	OF_DEV_AUXDATA("ti,da830-mmc", 0x01c40000, "da830-mmc.0", NULL),
 	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f00000, "ehrpwm", NULL),
 	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f02000, "ehrpwm", NULL),
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index c46eccb..f9ba74b 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -389,7 +389,7 @@ static struct resource da8xx_watchdog_resources[] = {
 };
 
 static struct platform_device da8xx_wdt_device = {
-	.name		= "watchdog",
+	.name		= "davinci-wdt",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(da8xx_watchdog_resources),
 	.resource	= da8xx_watchdog_resources,
@@ -399,7 +399,7 @@ void da8xx_restart(enum reboot_mode mode, const char *cmd)
 {
 	struct device *dev;
 
-	dev = bus_find_device_by_name(&platform_bus_type, NULL, "watchdog");
+	dev = bus_find_device_by_name(&platform_bus_type, NULL, "davinci-wdt");
 	if (!dev) {
 		pr_err("%s: failed to find watchdog device\n", __func__);
 		return;
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 3996e98..5cf9a02 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -302,7 +302,7 @@ static struct resource wdt_resources[] = {
 };
 
 struct platform_device davinci_wdt_device = {
-	.name		= "watchdog",
+	.name		= "davinci-wdt",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(wdt_resources),
 	.resource	= wdt_resources,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index ef9ff1f..4bb8132 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -375,7 +375,7 @@ static struct clk_lookup dm355_clks[] = {
 	CLK(NULL, "pwm3", &pwm3_clk),
 	CLK(NULL, "timer0", &timer0_clk),
 	CLK(NULL, "timer1", &timer1_clk),
-	CLK("watchdog", NULL, &timer2_clk),
+	CLK("davinci-wdt", NULL, &timer2_clk),
 	CLK(NULL, "timer3", &timer3_clk),
 	CLK(NULL, "rto", &rto_clk),
 	CLK(NULL, "usb", &usb_clk),
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 1511a06..b0e8df3 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -473,7 +473,7 @@ static struct clk_lookup dm365_clks[] = {
 	CLK(NULL, "pwm3", &pwm3_clk),
 	CLK(NULL, "timer0", &timer0_clk),
 	CLK(NULL, "timer1", &timer1_clk),
-	CLK("watchdog", NULL, &timer2_clk),
+	CLK("davinci-wdt", NULL, &timer2_clk),
 	CLK(NULL, "timer3", &timer3_clk),
 	CLK(NULL, "usb", &usb_clk),
 	CLK("davinci_emac.1", NULL, &emac_clk),
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 143a321..aeaad95 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -322,7 +322,7 @@ static struct clk_lookup dm644x_clks[] = {
 	CLK(NULL, "pwm2", &pwm2_clk),
 	CLK(NULL, "timer0", &timer0_clk),
 	CLK(NULL, "timer1", &timer1_clk),
-	CLK("watchdog", NULL, &timer2_clk),
+	CLK("davinci-wdt", NULL, &timer2_clk),
 	CLK(NULL, NULL, NULL),
 };
 
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 2a73f29..a56779b 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -356,7 +356,7 @@ static struct clk_lookup dm646x_clks[] = {
 	CLK(NULL, "pwm1", &pwm1_clk),
 	CLK(NULL, "timer0", &timer0_clk),
 	CLK(NULL, "timer1", &timer1_clk),
-	CLK("watchdog", NULL, &timer2_clk),
+	CLK("davinci-wdt", NULL, &timer2_clk),
 	CLK("palm_bk3710", NULL, &ide_clk),
 	CLK(NULL, "vpif0", &vpif0_clk),
 	CLK(NULL, "vpif1", &vpif1_clk),
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index dd625cc..12591f6 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -247,7 +247,7 @@ MODULE_DEVICE_TABLE(of, davinci_wdt_of_match);
 
 static struct platform_driver platform_wdt_driver = {
 	.driver = {
-		.name = "watchdog",
+		.name = "davinci-wdt",
 		.owner	= THIS_MODULE,
 		.of_match_table = davinci_wdt_of_match,
 	},
@@ -267,4 +267,4 @@ MODULE_PARM_DESC(heartbeat,
 		 __MODULE_STRING(DEFAULT_HEARTBEAT));
 
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:watchdog");
+MODULE_ALIAS("platform:davinci-wdt");
