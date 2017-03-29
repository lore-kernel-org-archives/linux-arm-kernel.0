From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 29 Mar 2017 18:09:32 +0200
Subject: [PATCH] ARM: davinci: Add the clock for the CPPI 4.1 DMA engine
Message-ID: <20170329160932.27157-1-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPPI 4.1 DMA is sharing its clock with the USB OTG,
and most of the time, the clock will be enabled by USB.
But during the init of the DMA, USB is not enabled (waiting for DMA),
and then we must enable the clock before to do anything.
Add the clock for the CPPI 4.1 DMA engine.

Note:
This patch is to apply instead of:
"ARM: davinci: Make the usb20 clock available to PM runtime"

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/mach-davinci/da830.c    | 1 +
 arch/arm/mach-davinci/da850.c    | 1 +
 arch/arm/mach-davinci/da8xx-dt.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 073c458..ae4a8a5 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -413,6 +413,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
 	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("cppi41-dmaengine",	NULL,		&usb20_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
 	CLK(NULL,		"secu_mgr",	&secu_mgr_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index ccad2f9..9739aaa 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -560,6 +560,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("davinci-nand.0",	"aemif",	&aemif_nand_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("cppi41-dmaengine",	NULL,		&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index e3cef50..5bf08ba 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -53,6 +53,8 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
 	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
 	OF_DEV_AUXDATA("ti,da850-ahci", 0x01e18000, "ahci_da850", NULL),
+	OF_DEV_AUXDATA("ti,da830-cppi41", 0x01e01000, "cppi41-dma-engine",
+		       NULL),
 	{}
 };
 
-- 
2.10.2
