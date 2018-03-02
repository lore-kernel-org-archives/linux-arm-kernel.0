From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 2 Mar 2018 09:59:29 +0800
Subject: [PATCH V6 1/2] ARM: dts: imx7s: add temperature monitor support
Message-ID: <1519955970-11365-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX7 temperature monitor support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes since V5:
	no code change, just add Reviewed-by.
 arch/arm/boot/dts/imx7s.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 9aa2bb9..6a5c1bf 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -511,9 +511,29 @@
 			};
 
 			ocotp: ocotp-ctrl at 30350000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx7d-ocotp", "syscon";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clks IMX7D_OCOTP_CLK>;
+
+				tempmon_calib: calib at 3c {
+					reg = <0x3c 0x4>;
+				};
+
+				tempmon_temp_grade: temp-grade at 10 {
+					reg = <0x10 0x4>;
+				};
+			};
+
+			tempmon: tempmon {
+				compatible = "fsl,imx7d-tempmon";
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,tempmon =<&anatop>;
+				nvmem-cells = <&tempmon_calib>,
+					<&tempmon_temp_grade>;
+				nvmem-cell-names = "calib", "temp_grade";
+				clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
 			};
 
 			anatop: anatop at 30360000 {
-- 
2.7.4
