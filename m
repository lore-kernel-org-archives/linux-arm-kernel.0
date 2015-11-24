From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 24 Nov 2015 12:17:58 +0100
Subject: [PATCH v2 resend] clk: imx25: Remove osc clock from driver
Message-ID: <1448363878-14551-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'osc' clock is already initialized by the fixed clock defined in
imx25.dtsi. The imx25 clock driver tries to add this clock for a second
time and fails with -EEXIST:
	i.MX clk 1: register failed with -17

As the clock is already properly setup in DT with a different driver, we
can completely remove the handling in the imx25 clock driver.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---

This is not a critical bugfix. It will just remove a warning for trying to add
this clock twice.

Best Regards,

Markus

 drivers/clk/imx/clk-imx25.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index c4c141cab444..23686f756b5e 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -96,13 +96,11 @@ static struct clk ** const uart_clks[] __initconst = {
 	NULL
 };
 
-static int __init __mx25_clocks_init(unsigned long osc_rate,
-				     void __iomem *ccm_base)
+static int __init __mx25_clocks_init(void __iomem *ccm_base)
 {
 	BUG_ON(!ccm_base);
 
 	clk[dummy] = imx_clk_fixed("dummy", 0);
-	clk[osc] = imx_clk_fixed("osc", osc_rate);
 	clk[mpll] = imx_clk_pllv1(IMX_PLLV1_IMX25, "mpll", "osc", ccm(CCM_MPCTL));
 	clk[upll] = imx_clk_pllv1(IMX_PLLV1_IMX25, "upll", "osc", ccm(CCM_UPCTL));
 	clk[mpll_cpu_3_4] = imx_clk_fixed_factor("mpll_cpu_3_4", "mpll", 3, 4);
@@ -250,22 +248,10 @@ static int __init __mx25_clocks_init(unsigned long osc_rate,
 
 static void __init mx25_clocks_init_dt(struct device_node *np)
 {
-	struct device_node *refnp;
-	unsigned long osc_rate = 24000000;
 	void __iomem *ccm;
 
-	/* retrieve the freqency of fixed clocks from device tree */
-	for_each_compatible_node(refnp, NULL, "fixed-clock") {
-		u32 rate;
-		if (of_property_read_u32(refnp, "clock-frequency", &rate))
-			continue;
-
-		if (of_device_is_compatible(refnp, "fsl,imx-osc"))
-			osc_rate = rate;
-	}
-
 	ccm = of_iomap(np, 0);
-	__mx25_clocks_init(osc_rate, ccm);
+	__mx25_clocks_init(ccm);
 
 	clk_data.clks = clk;
 	clk_data.clk_num = ARRAY_SIZE(clk);
-- 
2.6.2
