From: david@lechnology.com (David Lechner)
Date: Mon, 31 Oct 2016 15:04:24 -0500
Subject: [PATCH v2] ARM: davinci: da850: Fix pwm name matching
Message-ID: <1477944264-18637-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes pwm name matching for DA850 familiy devices. When using device
tree, the da850_auxdata_lookup[] table caused pwm devices to have the exact
same name, which caused errors when trying to register the devices.

We cannot have multiple entries for the same clock in in da850_clks[], so
we have added child clocks to the EHRPWM and ECAP LPSC clocks so that each
PWM device will have its own clock for proper name matching.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes:
* Added child clocks so that each PWM has its own clock.


 arch/arm/mach-davinci/da850.c    | 48 +++++++++++++++++++++++++++++++++++++---
 arch/arm/mach-davinci/da8xx-dt.c | 10 ++++-----
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 196e262..a9db413 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -424,6 +424,16 @@ static struct clk ehrpwm_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk ehrpwm0_clk = {
+	.name		= "ehrpwm0",
+	.parent		= &ehrpwm_clk,
+};
+
+static struct clk ehrpwm1_clk = {
+	.name		= "ehrpwm1",
+	.parent		= &ehrpwm_clk,
+};
+
 #define DA8XX_EHRPWM_TBCLKSYNC	BIT(12)
 
 static void ehrpwm_tblck_enable(struct clk *clk)
@@ -451,6 +461,16 @@ static struct clk ehrpwm_tbclk = {
 	.clk_disable	= ehrpwm_tblck_disable,
 };
 
+static struct clk ehrpwm0_tbclk = {
+	.name		= "ehrpwm0_tbclk",
+	.parent		= &ehrpwm_tbclk,
+};
+
+static struct clk ehrpwm1_tbclk = {
+	.name		= "ehrpwm1_tbclk",
+	.parent		= &ehrpwm_tbclk,
+};
+
 static struct clk ecap_clk = {
 	.name		= "ecap",
 	.parent		= &async3_clk,
@@ -458,6 +478,21 @@ static struct clk ecap_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk ecap0_clk = {
+	.name		= "ecap0_clk",
+	.parent		= &ecap_clk,
+};
+
+static struct clk ecap1_clk = {
+	.name		= "ecap1_clk",
+	.parent		= &ecap_clk,
+};
+
+static struct clk ecap2_clk = {
+	.name		= "ecap2_clk",
+	.parent		= &ecap_clk,
+};
+
 static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
@@ -510,9 +545,16 @@ static struct clk_lookup da850_clks[] = {
 	CLK("vpif",		NULL,		&vpif_clk),
 	CLK("ahci_da850",		NULL,		&sata_clk),
 	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
-	CLK("ehrpwm",		"fck",		&ehrpwm_clk),
-	CLK("ehrpwm",		"tbclk",	&ehrpwm_tbclk),
-	CLK("ecap",		"fck",		&ecap_clk),
+	CLK(NULL,		NULL,		&ehrpwm_clk),
+	CLK("ehrpwm.0",		"fck",		&ehrpwm0_clk),
+	CLK("ehrpwm.1",		"fck",		&ehrpwm1_clk),
+	CLK(NULL,		NULL,		&ehrpwm_tbclk),
+	CLK("ehrpwm.0",		"tbclk",	&ehrpwm0_tbclk),
+	CLK("ehrpwm.1",		"tbclk",	&ehrpwm1_tbclk),
+	CLK(NULL,		NULL,		&ecap_clk),
+	CLK("ecap.0",		"fck",		&ecap0_clk),
+	CLK("ecap.1",		"fck",		&ecap1_clk),
+	CLK("ecap.2",		"fck",		&ecap2_clk),
 	CLK(NULL,		NULL,		NULL),
 };
 
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 0e45cbd..aec569f9 100644
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
