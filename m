From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon, 11 Jul 2016 14:18:48 +0200
Subject: [PATCH] ARM: mxs: remove obsolete startup code for TX28
Message-ID: <1468239528-10501-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power and reset handling of the FEC ethernet driver is sufficient
to get the ethernet PHY on the TX28 into a usable state.
Remove the code that does the PHY initialization on startup.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/mach-mxs/mach-mxs.c | 77 --------------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 0b7fe74..e4f2108 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -268,80 +268,6 @@ static void __init apx4devkit_init(void)
 					   apx4devkit_phy_fixup);
 }
 
-#define ENET0_MDC__GPIO_4_0	MXS_GPIO_NR(4, 0)
-#define ENET0_MDIO__GPIO_4_1	MXS_GPIO_NR(4, 1)
-#define ENET0_RX_EN__GPIO_4_2	MXS_GPIO_NR(4, 2)
-#define ENET0_RXD0__GPIO_4_3	MXS_GPIO_NR(4, 3)
-#define ENET0_RXD1__GPIO_4_4	MXS_GPIO_NR(4, 4)
-#define ENET0_TX_EN__GPIO_4_6	MXS_GPIO_NR(4, 6)
-#define ENET0_TXD0__GPIO_4_7	MXS_GPIO_NR(4, 7)
-#define ENET0_TXD1__GPIO_4_8	MXS_GPIO_NR(4, 8)
-#define ENET_CLK__GPIO_4_16	MXS_GPIO_NR(4, 16)
-
-#define TX28_FEC_PHY_POWER	MXS_GPIO_NR(3, 29)
-#define TX28_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
-#define TX28_FEC_nINT		MXS_GPIO_NR(4, 5)
-
-static const struct gpio const tx28_gpios[] __initconst = {
-	{ ENET0_MDC__GPIO_4_0, GPIOF_OUT_INIT_LOW, "GPIO_4_0" },
-	{ ENET0_MDIO__GPIO_4_1, GPIOF_OUT_INIT_LOW, "GPIO_4_1" },
-	{ ENET0_RX_EN__GPIO_4_2, GPIOF_OUT_INIT_LOW, "GPIO_4_2" },
-	{ ENET0_RXD0__GPIO_4_3, GPIOF_OUT_INIT_LOW, "GPIO_4_3" },
-	{ ENET0_RXD1__GPIO_4_4, GPIOF_OUT_INIT_LOW, "GPIO_4_4" },
-	{ ENET0_TX_EN__GPIO_4_6, GPIOF_OUT_INIT_LOW, "GPIO_4_6" },
-	{ ENET0_TXD0__GPIO_4_7, GPIOF_OUT_INIT_LOW, "GPIO_4_7" },
-	{ ENET0_TXD1__GPIO_4_8, GPIOF_OUT_INIT_LOW, "GPIO_4_8" },
-	{ ENET_CLK__GPIO_4_16, GPIOF_OUT_INIT_LOW, "GPIO_4_16" },
-	{ TX28_FEC_PHY_POWER, GPIOF_OUT_INIT_LOW, "fec-phy-power" },
-	{ TX28_FEC_PHY_RESET, GPIOF_OUT_INIT_LOW, "fec-phy-reset" },
-	{ TX28_FEC_nINT, GPIOF_DIR_IN, "fec-int" },
-};
-
-static void __init tx28_post_init(void)
-{
-	struct device_node *np;
-	struct platform_device *pdev;
-	struct pinctrl *pctl;
-	int ret;
-
-	enable_clk_enet_out();
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-fec");
-	pdev = of_find_device_by_node(np);
-	if (!pdev) {
-		pr_err("%s: failed to find fec device\n", __func__);
-		return;
-	}
-
-	pctl = pinctrl_get_select(&pdev->dev, "gpio_mode");
-	if (IS_ERR(pctl)) {
-		pr_err("%s: failed to get pinctrl state\n", __func__);
-		return;
-	}
-
-	ret = gpio_request_array(tx28_gpios, ARRAY_SIZE(tx28_gpios));
-	if (ret) {
-		pr_err("%s: failed to request gpios: %d\n", __func__, ret);
-		return;
-	}
-
-	/* Power up fec phy */
-	gpio_set_value(TX28_FEC_PHY_POWER, 1);
-	msleep(26); /* 25ms according to data sheet */
-
-	/* Mode strap pins */
-	gpio_set_value(ENET0_RX_EN__GPIO_4_2, 1);
-	gpio_set_value(ENET0_RXD0__GPIO_4_3, 1);
-	gpio_set_value(ENET0_RXD1__GPIO_4_4, 1);
-
-	udelay(100); /* minimum assertion time for nRST */
-
-	/* Deasserting FEC PHY RESET */
-	gpio_set_value(TX28_FEC_PHY_RESET, 1);
-
-	pinctrl_put(pctl);
-}
-
 static void __init crystalfontz_init(void)
 {
 	update_fec_mac_prop(OUI_CRYSTALFONTZ);
@@ -501,9 +427,6 @@ static void __init mxs_machine_init(void)
 	of_platform_default_populate(NULL, NULL, parent);
 
 	mxs_restart_init();
-
-	if (of_machine_is_compatible("karo,tx28"))
-		tx28_post_init();
 }
 
 #define MXS_CLKCTRL_RESET_CHIP		(1 << 1)
-- 
2.1.4
