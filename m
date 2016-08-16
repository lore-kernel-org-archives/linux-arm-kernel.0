From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue, 16 Aug 2016 22:33:35 +0000
Subject: [PATCH v3 1/4] ARM: davinci: da8xx-dt: Add ti-aemif lookup for clock
 matching
In-Reply-To: <20160816223338.20776-1-kbeldan@baylibre.com>
References: <20160816223338.20776-1-kbeldan@baylibre.com>
Message-ID: <20160816223338.20776-2-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many davinci boards (da830 and da850 families) don't have their clocks
in DT yet and won't be successful in getting an unnamed aemif clock
without explicitly registering them via clk_lookups, failing the
ti-aemif memory driver probe.

The current aemif lookup entry resolving to the same clock:
    'CLK(NULL,               "aemif",        &aemif_clk)'
remains, as it is currently used (davinci_nand is getting a named clock
"aemif").

This change will allow to switch from the mach-davinci aemif code to
the ti-aemif memory driver.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
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
