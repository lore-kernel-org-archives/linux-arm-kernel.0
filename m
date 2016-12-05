From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon,  5 Dec 2016 11:09:07 +0100
Subject: [PATCH v3 1/3] ARM: da850: fix infinite loop in clk_set_rate()
In-Reply-To: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1480932549-30811-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aemif clock is added twice to the lookup table in da850.c. This
breaks the children list of pll0_sysclk3 as we're using the same list
links in struct clk. When calling clk_set_rate(), we get stuck in
propagate_rate().

Create a separate clock for nand, inheriting the rate of the aemif
clock and retrieve it in the davinci_nand module.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e770c97..c008e5e 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -367,6 +367,11 @@ static struct clk aemif_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
+static struct clk aemif_nand_clk = {
+	.name		= "nand",
+	.parent		= &aemif_clk,
+};
+
 static struct clk usb11_clk = {
 	.name		= "usb11",
 	.parent		= &pll0_sysclk4,
@@ -537,7 +542,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
 	CLK("ti-aemif",		NULL,		&aemif_clk),
-	CLK(NULL,		"aemif",	&aemif_clk),
+	CLK(NULL,		"aemif",	&aemif_nand_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
-- 
2.9.3
