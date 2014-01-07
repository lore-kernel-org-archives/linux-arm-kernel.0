From: b20788@freescale.com (Anson Huang)
Date: Tue, 7 Jan 2014 12:46:04 -0500
Subject: [PATCH] ARM: imx: AHB rate must be set to 132MHz on i.mx6sl
Message-ID: <1389116764-27951-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset value of AHB divider is 3, so current AHB rate
is 99MHz which is not correct for kernel, need to ensure
AHB rate is 132MHz in clk driver, as ipg is sourcing from
AHB, and it should be 66MHz by default.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/clk-imx6sl.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index a747a7d..e6900e9 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2013 Freescale Semiconductor, Inc.
+ * Copyright 2013-2014 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -72,6 +72,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	void __iomem *base;
 	int irq;
 	int i;
+	int ret;
 
 	clks[IMX6SL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
 	clks[IMX6SL_CLK_CKIL] = imx_obtain_fixed_clock("ckil", 0);
@@ -256,6 +257,11 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clk_register_clkdev(clks[IMX6SL_CLK_GPT], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clks[IMX6SL_CLK_GPT_SERIAL], "per", "imx-gpt.0");
 
+	/* Ensure the AHB clk is at 132MHz. */
+	ret = clk_set_rate(clks[IMX6SL_CLK_AHB], 132000000);
+	if (ret)
+		pr_warn("%s: failed to set AHB clock rate %d!\n", __func__, ret);
+
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
 		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY1_GATE]);
 		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY2_GATE]);
-- 
1.7.9.5
