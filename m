From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Nov 2015 12:42:31 +0100
Subject: [PATCH 1/3] dt-bindings: thermal: Add binding document for Mediatek
 thermal controller
In-Reply-To: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1448883753-19068-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device tree binding documentation for the mediatek thermal
controller found on Mediatek MT8173 and other SoCs.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/mediatek-thermal.txt          | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
new file mode 100644
index 0000000..81f9a51
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -0,0 +1,43 @@
+* Mediatek Thermal
+
+This describes the device tree binding for the Mediatek thermal controller
+which measures the on-SoC temperatures. This device does not have its own ADC,
+instead it directly controls the AUXADC via AHB bus accesses. For this reason
+this device needs phandles to the AUXADC. Also it controls a mux in the
+apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
+is also needed.
+
+Required properties:
+- compatible: "mediatek,mt8173-thermal"
+- reg: Address range of the thermal controller
+- interrupts: IRQ for the thermal controller
+- clocks, clock-names: Clocks needed for the thermal controller. required
+                       clocks are:
+		       "therm":	 Main clock needed for register access
+		       "auxadc": The AUXADC clock
+- resets: Reference to the reset controller controlling the thermal controller.
+- mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
+- mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
+- #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
+
+Optional properties:
+- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
+               unspecified default values shall be used.
+- nvmem-cell-names: Should be "calibration-data"
+
+Example:
+
+	thermal: thermal at 1100b000 {
+		#thermal-sensor-cells = <1>;
+		compatible = "mediatek,mt8173-thermal";
+		reg = <0 0x1100b000 0 0x1000>;
+		interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+		clock-names = "therm", "auxadc";
+		resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
+		reset-names = "therm";
+		mediatek,auxadc = <&auxadc>;
+		mediatek,apmixedsys = <&apmixedsys>;
+		nvmem-cells = <&thermal_calibration_data>;
+		nvmem-cell-names = "calibration-data";
+	};
-- 
2.6.2
