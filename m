From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Oct 2016 09:25:34 +0200
Subject: [PATCH 1/2] ARM: dts: add EBI2 to the Qualcomm MSM8660 DTSI
Message-ID: <1476775534-4493-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the external bus interface EBI2 to the MSM8660 device
tree, albeit with status = "disabled" so that devices actually
using EBI2 can turn it on if needed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Rebase on kernel v4.9-rc1
- Bindings and driver are merged so should be clear to apply.
ChangeLog v2->v3:
- Use the new #address-cells = <2> for indicating the CS in the
  first address cell
- Use the ranges property properly for defining the six different
  CS address windows
- Define CS3 to properly map over 128MB
- The EBI2 bindings are now ACKed by Rob Herring and a pull request
  to ARM SoC for both binding and driver is pending.
- This should be safe to merge for v4.9
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 8c65e0d82559..0b6348544598 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -141,6 +141,23 @@
 			};
 		};
 
+		ebi2 at 1a100000 {
+			compatible = "qcom,msm8660-ebi2";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x1a800000 0x00800000>,
+				 <1 0x0 0x1b000000 0x00800000>,
+				 <2 0x0 0x1b800000 0x00800000>,
+				 <3 0x0 0x1d000000 0x08000000>,
+				 <4 0x0 0x1c800000 0x00800000>,
+				 <5 0x0 0x1c000000 0x00800000>;
+			reg = <0x1a100000 0x1000>, <0x1a110000 0x1000>;
+			reg-names = "ebi2", "xmem";
+			clocks = <&gcc EBI2_2X_CLK>, <&gcc EBI2_CLK>;
+			clock-names = "ebi2x", "ebi2";
+			status = "disabled";
+		};
+
 		qcom,ssbi at 500000 {
 			compatible = "qcom,ssbi";
 			reg = <0x500000 0x1000>;
-- 
2.7.4
