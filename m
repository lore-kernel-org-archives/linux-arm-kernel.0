From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 13 Jan 2017 11:00:26 +0100
Subject: [PATCH RESEND 2/2] ARM: da850: add the nand dev_id to the clock
 lookup table
In-Reply-To: <1484301626-30345-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484301626-30345-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484301626-30345-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aemif driver can now access struct of_dev_auxdata (using platform
data).

Add the device id to the clock lookup table for the nand clock and
create a separate lookup table for aemif subnodes.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c    | 10 +---------
 arch/arm/mach-davinci/da8xx-dt.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 55f6e11..7475f02 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -557,15 +557,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
 	CLK("ti-aemif",		NULL,		&aemif_clk),
-	/*
-	 * The only user of this clock is davinci_nand and it get's it through
-	 * con_id. The nand node itself is created from within the aemif
-	 * driver to guarantee that it's probed after the aemif timing
-	 * parameters are configured. of_dev_auxdata is not accessible from
-	 * the aemif driver and can't be passed to of_platform_populate(). For
-	 * that reason we're leaving the dev_id here as NULL.
-	 */
-	CLK(NULL,		"aemif",	&aemif_nand_clk),
+	CLK("davinci-nand.0",	"aemif",	&aemif_nand_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 9ee44da..06205fe 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -11,6 +11,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
+#include <linux/platform_data/ti-aemif.h>
 
 #include <asm/mach/arch.h>
 
@@ -18,6 +19,15 @@
 #include "cp_intc.h"
 #include <mach/da8xx.h>
 
+static struct of_dev_auxdata da850_aemif_auxdata_lookup[] = {
+	OF_DEV_AUXDATA("ti,davinci-nand", 0x62000000, "davinci-nand.0", NULL),
+	{}
+};
+
+static struct aemif_platform_data aemif_data = {
+	.dev_lookup = da850_aemif_auxdata_lookup,
+};
+
 static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01e28000, "i2c_davinci.2", NULL),
@@ -37,7 +47,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-dm6467-emac", 0x01e20000, "davinci_emac.1",
 		       NULL),
 	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
-	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", NULL),
+	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", &aemif_data),
 	OF_DEV_AUXDATA("ti,da850-tilcdc", 0x01e13000, "da8xx_lcdc.0", NULL),
 	OF_DEV_AUXDATA("ti,da830-ohci", 0x01e25000, "ohci-da8xx", NULL),
 	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
-- 
2.9.3
