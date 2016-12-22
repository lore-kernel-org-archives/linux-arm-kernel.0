From: zmarkovic@sierrawireless.com (Zoran Markovic)
Date: Thu, 22 Dec 2016 12:05:36 -0800
Subject: [RFC PATCH 1/4] dt-bindings: mdm9615: Add ADM DMA engine
In-Reply-To: <1482437139-29329-1-git-send-email-zmarkovic@sierrawireless.com>
References: <1482437139-29329-1-git-send-email-zmarkovic@sierrawireless.com>
Message-ID: <1482437139-29329-2-git-send-email-zmarkovic@sierrawireless.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add configuration for ADM DMA engine on MDM9615, used by the EBI2
NAND controller. This commit requires the ADM DMA patches from
Andy Gross:
https://lkml.org/lkml/2015/3/17/19

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-msm at vger.kernel.org
Cc: linux-soc at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Zoran Markovic <zmarkovic@sierrawireless.com>
---
 arch/arm/boot/dts/qcom-mdm9615.dtsi |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 5ae4ec5..fbc7d68 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -336,7 +336,24 @@
 			};
 		};
 
-		sdcc1bam: dma at 12182000{
+		adm_dma: dma at 18300000 {
+			compatible = "qcom,adm";
+			reg = <0x18300000 0x100000>;
+			interrupts = <0 170 0>;
+			#dma-cells = <1>;
+
+			clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
+			clock-names = "core", "iface";
+
+			resets = <&gcc ADM0_RESET>,
+				 <&gcc ADM0_C0_RESET>,
+				 <&gcc ADM0_C1_RESET>,
+				 <&gcc ADM0_C2_RESET>;
+			reset-names = "clk", "c0", "c1", "c2";
+			qcom,ee = <0>;
+		};
+
+		sdcc1bam:dma at 12182000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12182000 0x8000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.7.9.5
