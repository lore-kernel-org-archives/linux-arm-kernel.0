From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri, 19 Aug 2016 16:47:36 +0000
Subject: [PATCH v2] ARM: davinci: da8xx-dt: Add ti-aemif lookup for clock
 matching
In-Reply-To: <20160819164736.10199-1-kbeldan@baylibre.com>
References: <20160819164736.10199-1-kbeldan@baylibre.com>
Message-ID: <20160819164736.10199-2-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci boards don't have their clocks in DT yet and getting a clock
with a null con_id will fail, unless registering them as clk_lookups.
This registers the aemif clock for the ti-aemif memory driver.

The current aemif lookup entry resolving to the same clock:
    'CLK(NULL,               "aemif",        &aemif_clk)'
is currently used by davinci_nand and remains for non-DT and backward
compatibility.

Currently the davinci boards only configure the AEMIF in case of non-DT
boot, via some code in mach-davinci.
This change will allow DT-based davinci platforms to do the same, via
the ti-aemif memory driver code.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 This patch was originally patch 1/4 of the series
 "Add DT support for NAND to LCDK via ti-aemif" from which two other
 patches have already applied in Sekhar's tree.
 Sekhar, please note that commit 31e3a881 ("ARM: dts: da850,da850-evm:
 Add an aemif node and use it for the NAND") of your tree depends on
 this change.

 Thanks, 
 Karl

v2:
 - Reword the commit message more accurately after Sekhar's feedback


 arch/arm/mach-davinci/da850.c    | 1 +
 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 0d046ac..ed3d0e9 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -501,6 +501,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
 	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
+	CLK("ti-aemif",		NULL,		&aemif_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"usb11",	&usb11_clk),
 	CLK(NULL,		"usb20",	&usb20_clk),
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index ca99711..c9f7e92 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -37,6 +37,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-dm6467-emac", 0x01e20000, "davinci_emac.1",
 		       NULL),
 	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
+	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", NULL),
 	{}
 };
 
-- 
2.9.2
