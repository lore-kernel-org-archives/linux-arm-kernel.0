From: david@lechnology.com (David Lechner)
Date: Tue, 25 Oct 2016 12:54:04 -0500
Subject: [PATCH] ARM: davinci: da850: Fix pwm name matching
Message-ID: <1477418044-24603-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes pwm name matching for DA850 familiy devices. When using device
tree, the da850_auxdata_lookup[] table caused pwm devices to have the exact
same name, which caused errors when trying to register the devices.

The names for clock matching in da850_clks[] also have to be updated to
to exactly match in order for the clock lookup to work correctly.

Signed-off-by: David Lechner <david@lechnology.com>
---

Tested working on LEGO MINDSTORMS EV3.


 arch/arm/mach-davinci/da850.c    | 10 +++++++---
 arch/arm/mach-davinci/da8xx-dt.c | 10 +++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index ed3d0e9..6b78a8f 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -510,9 +510,13 @@ static struct clk_lookup da850_clks[] = {
 	CLK("vpif",		NULL,		&vpif_clk),
 	CLK("ahci_da850",		NULL,		&sata_clk),
 	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
-	CLK("ehrpwm",		"fck",		&ehrpwm_clk),
-	CLK("ehrpwm",		"tbclk",	&ehrpwm_tbclk),
-	CLK("ecap",		"fck",		&ecap_clk),
+	CLK("ehrpwm.0",		"fck",		&ehrpwm_clk),
+	CLK("ehrpwm.0",		"tbclk",	&ehrpwm_tbclk),
+	CLK("ehrpwm.1",		"fck",		&ehrpwm_clk),
+	CLK("ehrpwm.1",		"tbclk",	&ehrpwm_tbclk),
+	CLK("ecap.0",		"fck",		&ecap_clk),
+	CLK("ecap.1",		"fck",		&ecap_clk),
+	CLK("ecap.2",		"fck",		&ecap_clk),
 	CLK(NULL,		NULL,		NULL),
 };
 
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 7947267..6ad8ddb 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -23,11 +23,11 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01e28000, "i2c_davinci.2", NULL),
 	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "davinci-wdt", NULL),
 	OF_DEV_AUXDATA("ti,da830-mmc", 0x01c40000, "da830-mmc.0", NULL),
-	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f00000, "ehrpwm", NULL),
-	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f02000, "ehrpwm", NULL),
-	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f06000, "ecap", NULL),
-	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f07000, "ecap", NULL),
-	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f08000, "ecap", NULL),
+	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f00000, "ehrpwm.0", NULL),
+	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f02000, "ehrpwm.1", NULL),
+	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f06000, "ecap.0", NULL),
+	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f07000, "ecap.1", NULL),
+	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f08000, "ecap.2", NULL),
 	OF_DEV_AUXDATA("ti,da830-spi", 0x01c41000, "spi_davinci.0", NULL),
 	OF_DEV_AUXDATA("ti,da830-spi", 0x01f0e000, "spi_davinci.1", NULL),
 	OF_DEV_AUXDATA("ns16550a", 0x01c42000, "serial8250.0", NULL),
-- 
2.7.4
