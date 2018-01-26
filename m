From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 26 Jan 2018 09:23:50 +0100
Subject: [PATCH 1/3] ARM: dts: imx6ull: fix the i.MX6ULL UART8 configuration
In-Reply-To: <1516955032-21167-1-git-send-email-LW@KARO-electronics.de>
References: <1516955032-21167-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1516955032-21167-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART8 on i.MX6ULL is not located on the SPBA bus like on i.MX6UL but
on the (otherwise unused) AIPS-3 bus.
Create the appropriate AIPS-3 bus configuration and move the uart8
definition where it belongs.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ull.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index 0c18291..abc815f 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -41,3 +41,32 @@
 
 #include "imx6ul.dtsi"
 #include "imx6ull-pinfunc.h"
+
+/ {
+	soc {
+		aips-bus at 2000000 {
+			spba-bus at 2000000 {
+				/delete-node/ serial at 2024000;
+			};
+		};
+
+		aips3: aips-bus at 2200000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x02200000 0x100000>;
+			ranges;
+
+			uart8: serial at 2288000 {
+				compatible = "fsl,imx6ul-uart",
+					     "fsl,imx6q-uart";
+				reg = <0x02288000 0x4000>;
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_IPG>,
+					 <&clks IMX6UL_CLK_UART8_SERIAL>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
2.1.4
