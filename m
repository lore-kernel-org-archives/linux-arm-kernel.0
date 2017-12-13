From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 13 Dec 2017 15:24:06 +0100
Subject: [PATCH] ARM: dts: imx51: add CodaHx4 VPU
Message-ID: <20171213142406.5088-1-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the CodaHx4 VPU to the i.MX51 device tree.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
This patch should only be applied once the patch to fix VPU register access on
i.MX51 [1] is merged. The coda driver with patches [2] applied will start
accessing VPU registers on i.MX51, which hangs the system without [1].

[1] https://patchwork.kernel.org/patch/10109781/
    ("clk: imx51: uart4, uart5 gates only exist on imx50, imx53")
[2] https://patchwork.linuxtv.org/patch/45929/
    ("media: dt-bindings: coda: Add compatible for CodaHx4 on i.MX51")
    https://patchwork.linuxtv.org/patch/45930/
    ("media: coda: Add i.MX51 (CodaHx4) support")
---
 arch/arm/boot/dts/imx51.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 378be720b3c76..6d6c19ede2be0 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -597,6 +597,17 @@
 				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
+
+			vpu at 83ff4000 {
+				compatible = "fsl,imx51-vpu", "cnm,codahx4";
+				reg = <0x83ff4000 0x1000>;
+				interrupts = <9>;
+				clocks = <&clks IMX5_CLK_VPU_REFERENCE_GATE>,
+					 <&clks IMX5_CLK_VPU_GATE>;
+				clock-names = "per", "ahb";
+				resets = <&src 1>;
+				iram = <&iram>;
+			};
 		};
 	};
 };
-- 
2.11.0
