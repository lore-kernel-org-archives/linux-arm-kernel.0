From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 19 Aug 2012 14:05:59 -0300
Subject: [PATCH v2 2/2] ARM: clk-imx25: Fix SSI clock registration
Message-ID: <1345395959-26978-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SSI block has two types of clock:

ipg: bus clock, the clock needed for accessing registers.
per: peripheral clock, the clock needed for generating the bit rate.

Currently SSI driver only supports slave mode and only need to handle
the ipg clock, because the peripheral clock comes from the master codec.

Only register the ipg clock and do not register the peripheral clock for ssi.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Use imx-ssi.1 for ssi2_ipg

 arch/arm/mach-imx/clk-imx25.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index fdd8cc8..5ff9534 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -222,10 +222,8 @@ int __init mx25_clocks_init(void)
 	clk_register_clkdev(clk[lcdc_ipg], "ipg", "imx-fb.0");
 	clk_register_clkdev(clk[lcdc_ahb], "ahb", "imx-fb.0");
 	clk_register_clkdev(clk[wdt_ipg], NULL, "imx2-wdt.0");
-	clk_register_clkdev(clk[ssi1_ipg_per], "per", "imx-ssi.0");
-	clk_register_clkdev(clk[ssi1_ipg], "ipg", "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_ipg_per], "per", "imx-ssi.1");
-	clk_register_clkdev(clk[ssi2_ipg], "ipg", "imx-ssi.1");
+	clk_register_clkdev(clk[ssi1_ipg], NULL, "imx-ssi.0");
+	clk_register_clkdev(clk[ssi2_ipg], NULL, "imx-ssi.1");
 	clk_register_clkdev(clk[esdhc1_ipg_per], "per", "sdhci-esdhc-imx25.0");
 	clk_register_clkdev(clk[esdhc1_ipg], "ipg", "sdhci-esdhc-imx25.0");
 	clk_register_clkdev(clk[esdhc1_ahb], "ahb", "sdhci-esdhc-imx25.0");
-- 
1.7.9.5
