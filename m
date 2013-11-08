From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri,  8 Nov 2013 14:48:41 +0100
Subject: [PATCH 2/2] ARM: i.MX28: define external RTC crystal frequency in DT
In-Reply-To: <1383918521-4668-1-git-send-email-mkl@pengutronix.de>
References: <1383918521-4668-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1383918521-4668-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

The RTC in the i.MX28 may be clocked with different crystals. Get the rate of
the connected one from the DT.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/clock/imx28-clock.txt | 1 +
 arch/arm/boot/dts/imx28.dtsi                            | 5 +++++
 drivers/clk/mxs/clk-imx28.c                             | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx28-clock.txt b/Documentation/devicetree/bindings/clock/imx28-clock.txt
index e6587af..c3a9d94 100644
--- a/Documentation/devicetree/bindings/clock/imx28-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx28-clock.txt
@@ -76,6 +76,7 @@ clocks and IDs.
 	usb0_phy	62
 	usb1_phy	63
 	enet_out	64
+	rtc_32k		65
 
 Examples:
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 979c37d..6af9094 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -47,6 +47,11 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		xtal-32k {
+			compatible = "fsl,mxs-xtal-32k", "fixed-clock";
+			clock-frequency = <0>;
+		};
+
 		xtal-24m {
 			compatible = "fsl,mxs-xtal-24m", "fixed-clock";
 			clock-frequency = <24000000>;
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 874ca4e..b6afeb1 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -144,7 +144,7 @@ enum imx28_clk {
 	clk32k_div, rtc, lradc, spdif_div, clk32k, pwm, uart, ssp0,
 	ssp1, ssp2, ssp3, gpmi, spdif, emi, saif0, saif1, lcdif, etm,
 	fec, can0, can1, usb0, usb1, usb0_phy, usb1_phy, enet_out,
-	clk_max
+	rtc_32k, clk_max
 };
 
 static struct clk *clks[clk_max];
@@ -178,6 +178,8 @@ int __init mx28_clocks_init(void)
 
 		if (of_device_is_compatible(np_tmp, "fsl,mxs-xtal-24m"))
 			clks[ref_xtal] = mxs_clk_fixed("ref_xtal", rate);
+		else if (of_device_is_compatible(np_tmp, "fsl,mxs-xtal-32k"))
+			clks[rtc_32k] = mxs_clk_fixed("rtc_32k", rate);
 	}
 
 	/* if not set, use default frequency */
-- 
1.8.4.rc3
