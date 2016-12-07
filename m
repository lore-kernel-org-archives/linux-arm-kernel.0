From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed,  7 Dec 2016 16:22:15 +0100
Subject: [PATCH v4 1/4] ARM: da850: fix infinite loop in clk_set_rate()
In-Reply-To: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
References: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1481124138-27337-2-git-send-email-bgolaszewski@baylibre.com>
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
 arch/arm/mach-davinci/da850.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e770c97..e9d019c 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -367,6 +367,16 @@ static struct clk aemif_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
+/*
+ * In order to avoid adding the aemif_clk to the clock lookup table twice (and
+ * screwing up the linked list in the process) create a separate clock for
+ * nand inheriting the rate from aemif_clk.
+ */
+static struct clk aemif_nand_clk = {
+	.name		= "nand",
+	.parent		= &aemif_clk,
+};
+
 static struct clk usb11_clk = {
 	.name		= "usb11",
 	.parent		= &pll0_sysclk4,
@@ -537,7 +547,15 @@ static struct clk_lookup da850_clks[] = {
 	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
 	CLK("ti-aemif",		NULL,		&aemif_clk),
-	CLK(NULL,		"aemif",	&aemif_clk),
+	/*
+	 * The only user of this clock is davinci_nand and it get's it through
+	 * con_id. The nand node itself is created from within the aemif
+	 * driver to guarantee that it's probed after the aemif timing
+	 * parameters are configured. of_dev_auxdata is not accessible from
+	 * the aemif driver and can't be passed to of_platform_populate(). For
+	 * that reason we're leaving the dev_id here as NULL.
+	 */
+	CLK(NULL,		"aemif",	&aemif_nand_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
-- 
2.9.3
