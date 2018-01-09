From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 9 Jan 2018 17:52:06 +0800
Subject: [PATCH V4 2/2] ARM: dts: imx7s: add snvs rtc clock
In-Reply-To: <1515491526-14060-1-git-send-email-Anson.Huang@nxp.com>
References: <1515491526-14060-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1515491526-14060-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX7 SNVS RTC clock.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
change since v3:
	add optional for clocks in binding doc statement.
 Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 17 +++++++++++++++++
 arch/arm/boot/dts/imx7s.dtsi                          |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
index 76aec8a..3c1f3a2 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
@@ -415,12 +415,27 @@ Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
 	value type: <u32>
 	Definition: LP register offset. default it is 0x34.
 
+   - clocks
+      Usage: optional, required if SNVS LP RTC requires explicit
+          enablement of clocks
+      Value type: <prop_encoded-array>
+      Definition:  a clock specifier describing the clock required for
+          enabling and disabling SNVS LP RTC.
+
+   - clock-names
+      Usage: optional, required if SNVS LP RTC requires explicit
+          enablement of clocks
+      Value type: <string>
+      Definition: clock name string should be "snvs-rtc".
+
 EXAMPLE
 	sec_mon_rtc_lp at 1 {
 		compatible = "fsl,sec-v4.0-mon-rtc-lp";
 		interrupts = <93 2>;
 		regmap = <&snvs>;
 		offset = <0x34>;
+		clocks = <&clks IMX7D_SNVS_CLK>;
+		clock-names = "snvs-rtc";
 	};
 
 =====================================================================
@@ -543,6 +558,8 @@ FULL EXAMPLE
 			regmap = <&sec_mon>;
 			offset = <0x34>;
 			interrupts = <93 2>;
+			clocks = <&clks IMX7D_SNVS_CLK>;
+			clock-names = "snvs-rtc";
 		};
 
 		snvs-pwrkey at 020cc000 {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 9aa2bb9..02baf42 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -551,6 +551,8 @@
 					offset = <0x34>;
 					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX7D_SNVS_CLK>;
+					clock-names = "snvs-rtc";
 				};
 
 				snvs_poweroff: snvs-poweroff {
-- 
1.9.1
