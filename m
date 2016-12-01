From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu,  1 Dec 2016 18:15:14 +0100
Subject: [PATCH 1/3] ARM: da850: fix infinite loop in clk_set_rate()
In-Reply-To: <1480612516-18853-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480612516-18853-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1480612516-18853-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aemif clock is added twice to the lookup table in da850.c. This
breaks the children list of pll0_sysclk3 as we're using the same list
links in struct clk. When calling clk_set_rate(), we get stuck in
propagate_rate().

Simply add the clock once, but specify both the con_id and dev_id in
the lookup entry.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e770c97..1e11ce8 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -536,8 +536,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
 	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
-	CLK("ti-aemif",		NULL,		&aemif_clk),
-	CLK(NULL,		"aemif",	&aemif_clk),
+	CLK("ti-aemif",		"aemif",	&aemif_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
-- 
2.9.3
