From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Aug 2012 23:42:44 +0800
Subject: [PATCH 1/6] ARM: mxs: tx28: reset fec phy for device tree boot
In-Reply-To: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
References: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344267769-31166-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For non-DT boot, function tx28_add_fec0 configures all ENET0 pins
into gpio mode for resetting fec phy, and then reconfigures those pins
into ENET function after that.

For DT boot, all the pin configuration is done by pinctrl subsystem.
Ideally, when gpio_requst gets called, GPIO subsystem should call
pinctrl to configure pins into gpio mode automatically, and have pins
freed up from pinctrl subsystem when gpio_free is called.  But right
now, this cooperation between gpio and pinctrl hasn't been available.
As the result, we have to explicitly call pinctrl_get_select and
pinctrl_put for device tree boot.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-tx28.dts |   21 +++++++++-
 arch/arm/mach-mxs/mach-mxs.c     |   82 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 62bf767..a56ae05 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -34,6 +34,24 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				mac0_pins_gpio: mac0-gpio-mode at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x4003 /* MX28_PAD_ENET0_MDC__GPIO_4_0 */
+						0x4013 /* MX28_PAD_ENET0_MDIO__GPIO_4_1 */
+						0x4023 /* MX28_PAD_ENET0_RX_EN__GPIO_4_2 */
+						0x4033 /* MX28_PAD_ENET0_RXD0__GPIO_4_3 */
+						0x4043 /* MX28_PAD_ENET0_RXD1__GPIO_4_4 */
+						0x4063 /* MX28_PAD_ENET0_TX_EN__GPIO_4_6 */
+						0x4073 /* MX28_PAD_ENET0_TXD0__GPIO_4_7 */
+						0x4083 /* MX28_PAD_ENET0_TXD1__GPIO_4_8 */
+						0x4103 /* MX28_PAD_ENET_CLK__GPIO_4_16 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
 			};
 		};
 
@@ -72,8 +90,9 @@
 	ahb at 80080000 {
 		mac0: ethernet at 800f0000 {
 			phy-mode = "rmii";
-			pinctrl-names = "default";
+			pinctrl-names = "default", "gpio_mode";
 			pinctrl-0 = <&mac0_pins_a>;
+			pinctrl-1 = <&mac0_pins_gpio>;
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 02d1ab2..6ba37df 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -12,8 +12,9 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/init.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/irqdomain.h>
 #include <linux/micrel_phy.h>
@@ -21,10 +22,12 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
+#include <linux/pinctrl/consumer.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
 #include <mach/digctl.h>
+#include <mach/mxs.h>
 
 static struct fb_videomode mx23evk_video_modes[] = {
 	{
@@ -273,6 +276,80 @@ static void __init apx4devkit_init(void)
 	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
 }
 
+#define ENET0_MDC__GPIO_4_0	MXS_GPIO_NR(4, 0)
+#define ENET0_MDIO__GPIO_4_1	MXS_GPIO_NR(4, 1)
+#define ENET0_RX_EN__GPIO_4_2	MXS_GPIO_NR(4, 2)
+#define ENET0_RXD0__GPIO_4_3	MXS_GPIO_NR(4, 3)
+#define ENET0_RXD1__GPIO_4_4	MXS_GPIO_NR(4, 4)
+#define ENET0_TX_EN__GPIO_4_6	MXS_GPIO_NR(4, 6)
+#define ENET0_TXD0__GPIO_4_7	MXS_GPIO_NR(4, 7)
+#define ENET0_TXD1__GPIO_4_8	MXS_GPIO_NR(4, 8)
+#define ENET_CLK__GPIO_4_16	MXS_GPIO_NR(4, 16)
+
+#define TX28_FEC_PHY_POWER	MXS_GPIO_NR(3, 29)
+#define TX28_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
+#define TX28_FEC_nINT		MXS_GPIO_NR(4, 5)
+
+static const struct gpio tx28_gpios[] __initconst = {
+	{ ENET0_MDC__GPIO_4_0, GPIOF_OUT_INIT_LOW, "GPIO_4_0" },
+	{ ENET0_MDIO__GPIO_4_1, GPIOF_OUT_INIT_LOW, "GPIO_4_1" },
+	{ ENET0_RX_EN__GPIO_4_2, GPIOF_OUT_INIT_LOW, "GPIO_4_2" },
+	{ ENET0_RXD0__GPIO_4_3, GPIOF_OUT_INIT_LOW, "GPIO_4_3" },
+	{ ENET0_RXD1__GPIO_4_4, GPIOF_OUT_INIT_LOW, "GPIO_4_4" },
+	{ ENET0_TX_EN__GPIO_4_6, GPIOF_OUT_INIT_LOW, "GPIO_4_6" },
+	{ ENET0_TXD0__GPIO_4_7, GPIOF_OUT_INIT_LOW, "GPIO_4_7" },
+	{ ENET0_TXD1__GPIO_4_8, GPIOF_OUT_INIT_LOW, "GPIO_4_8" },
+	{ ENET_CLK__GPIO_4_16, GPIOF_OUT_INIT_LOW, "GPIO_4_16" },
+	{ TX28_FEC_PHY_POWER, GPIOF_OUT_INIT_LOW, "fec-phy-power" },
+	{ TX28_FEC_PHY_RESET, GPIOF_OUT_INIT_LOW, "fec-phy-reset" },
+	{ TX28_FEC_nINT, GPIOF_DIR_IN, "fec-int" },
+};
+
+static void __init tx28_post_init(void)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	struct pinctrl *pctl;
+	int ret;
+
+	enable_clk_enet_out();
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-fec");
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		pr_err("%s: failed to find fec device\n", __func__);
+		return;
+	}
+
+	pctl = pinctrl_get_select(&pdev->dev, "gpio_mode");
+	if (IS_ERR(pctl)) {
+		pr_err("%s: failed to get pinctrl state\n", __func__);
+		return;
+	}
+
+	ret = gpio_request_array(tx28_gpios, ARRAY_SIZE(tx28_gpios));
+	if (ret) {
+		pr_err("%s: failed to request gpios: %d\n", __func__, ret);
+		return;
+	}
+
+	/* Power up fec phy */
+	gpio_set_value(TX28_FEC_PHY_POWER, 1);
+	mdelay(26); /* 25ms according to data sheet */
+
+	/* Mode strap pins */
+	gpio_set_value(ENET0_RX_EN__GPIO_4_2, 1);
+	gpio_set_value(ENET0_RXD0__GPIO_4_3, 1);
+	gpio_set_value(ENET0_RXD1__GPIO_4_4, 1);
+
+	udelay(100); /* minimum assertion time for nRST */
+
+	/* Deasserting FEC PHY RESET */
+	gpio_set_value(TX28_FEC_PHY_RESET, 1);
+
+	pinctrl_put(pctl);
+}
+
 static void __init mxs_machine_init(void)
 {
 	if (of_machine_is_compatible("fsl,imx28-evk"))
@@ -286,6 +363,9 @@ static void __init mxs_machine_init(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     mxs_auxdata_lookup, NULL);
+
+	if (of_machine_is_compatible("karo,tx28"))
+		tx28_post_init();
 }
 
 static const char *imx23_dt_compat[] __initdata = {
-- 
1.7.5.4
