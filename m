From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed,  5 Apr 2017 19:17:50 +0200
Subject: [PATCH v2] ARM: davinci: Add the clock for the CPPI 4.1 DMA engine
Message-ID: <20170405171750.16821-1-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPPI 4.1 DMA is sharing its clock with the USB OTG,
and most of the time, the clock will be enabled by USB.
But during the init of the DMA, USB is not enabled (waiting for DMA),
and then we must enable the clock before doing anything.
Add the clock for the CPPI 4.1 DMA engine.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/mach-davinci/da830.c | 6 ++++++
 arch/arm/mach-davinci/da850.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 073c458..bd88470 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -304,6 +304,11 @@ static struct clk usb20_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk cppi41_clk = {
+	.name		= "cppi41",
+	.parent		= &usb20_clk,
+};
+
 static struct clk aemif_clk = {
 	.name		= "aemif",
 	.parent		= &pll0_sysclk3,
@@ -413,6 +418,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
 	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
 	CLK(NULL,		"secu_mgr",	&secu_mgr_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index ccad2f9..07d6f0e 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -401,6 +401,11 @@ static struct clk usb20_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk cppi41_clk = {
+	.name		= "cppi41",
+	.parent		= &usb20_clk,
+};
+
 static struct clk spi0_clk = {
 	.name		= "spi0",
 	.parent		= &pll0_sysclk2,
@@ -560,6 +565,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("davinci-nand.0",	"aemif",	&aemif_nand_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
-- 
2.10.2
