From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu,  3 Nov 2016 17:03:06 +0100
Subject: [PATCH v2 1/3] ARM: davinci: da8xx: Fix ohci device name
In-Reply-To: <20161103160308.29588-1-ahaslam@baylibre.com>
References: <20161103160308.29588-1-ahaslam@baylibre.com>
Message-ID: <20161103160308.29588-2-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the clk lookup table is making reference to "ohci"
other subsystems (such as phy) are trying to match "ohci.0"

Since there is a single ohci instance, instead of changing
the clk name, change the dev id to -1, and add the "-da8xx"
postfix to match the driver name that will also be changed
in a subsequent patch.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/da830.c     | 2 +-
 arch/arm/mach-davinci/da850.c     | 2 +-
 arch/arm/mach-davinci/da8xx-dt.c  | 2 +-
 arch/arm/mach-davinci/usb-da8xx.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 41459bd..073c458 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -420,7 +420,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci_mdio.0",   "fck",          &emac_clk),
 	CLK(NULL,		"gpio",		&gpio_clk),
 	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
-	CLK("ohci",		"usb11",	&usb11_clk),
+	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
 	CLK(NULL,		"emif3",	&emif3_clk),
 	CLK(NULL,		"arm",		&arm_clk),
 	CLK(NULL,		"rmii",		&rmii_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 196e262..3961556 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -503,7 +503,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
 	CLK("ti-aemif",		NULL,		&aemif_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
-	CLK("ohci",		"usb11",	&usb11_clk),
+	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 92ae093..2afb067 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -39,7 +39,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
 	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", NULL),
 	OF_DEV_AUXDATA("ti,da850-tilcdc", 0x01e13000, "da8xx_lcdc.0", NULL),
-	OF_DEV_AUXDATA("ti,da830-ohci", 0x01e25000, "ohci", NULL),
+	OF_DEV_AUXDATA("ti,da830-ohci", 0x01e25000, "ohci-da8xx", NULL),
 	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
 	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
 	{}
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index b010e5f..c6feecf 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -109,8 +109,8 @@ static struct resource da8xx_usb11_resources[] = {
 static u64 da8xx_usb11_dma_mask = DMA_BIT_MASK(32);
 
 static struct platform_device da8xx_usb11_device = {
-	.name		= "ohci",
-	.id		= 0,
+	.name		= "ohci-da8xx",
+	.id		= -1,
 	.dev = {
 		.dma_mask		= &da8xx_usb11_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
-- 
2.10.1
