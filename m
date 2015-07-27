From: haibo.chen@freescale.com (Haibo Chen)
Date: Mon, 27 Jul 2015 19:26:46 +0800
Subject: [PATCH 4/5] ARM: dts: imx6ul.dtsi: add TSC support
In-Reply-To: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1437996407-27266-5-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx6ul touchscreen controller support.

TSC module need ADC2 module to measure the touchscreen
coordinate value. This patch put TSC and ADC2 together,
make ADC2 module only be used for TSC, can't be used as
a normal ADC.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index dc0f5b4..33aac1f 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -484,6 +484,17 @@
 			reg = <0x02100000 0x100000>;
 			ranges;
 
+			tsc: tsc at 02040000 {
+				compatible = "fsl,imx6ul-tsc";
+				reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_IPG>,
+					 <&clks IMX6UL_CLK_ADC2>;
+				clock-names = "tsc", "adc";
+				status = "disabled";
+			};
+
 			usdhc1: usdhc at 02190000 {
 				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
 				reg = <0x02190000 0x4000>;
-- 
1.9.1
