From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Wed, 15 Oct 2014 01:10:05 +0800
Subject: [PATCH v10 2/5] dt-bindings: document Rockchip thermal
In-Reply-To: <1413306608-11498-1-git-send-email-caesar.wang@rock-chips.com>
References: <1413306608-11498-1-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <1413306608-11498-3-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add the necessary binding documentation for the thermal
found on Rockchip SoCs

Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 .../bindings/thermal/rockchip-thermal.txt          | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
new file mode 100644
index 0000000..d5ff410
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -0,0 +1,45 @@
+* Temperature Sensor ADC (TSADC) on rockchip SoCs
+
+Required properties:
+- compatible: "rockchip,rk3288-tsadc"
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- interrupts: The interrupt number to the cpu. The interrupt specifier format
+	      depends on the interrupt controller.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Shall be "tsadc" for the converter-clock, and "apb_pclk" for
+	       the peripheral clock.
+- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
+
+Exiample:
+tsadc: tsadc at ff280000 {
+	compatible = "rockchip,rk3288-tsadc";
+	reg = <0xff280000 0x100>;
+	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+	clock-names = "tsadc", "apb_pclk";
+};
+
+Example: referring to thermal sensors:
+thermal-zones {
+       cpu_thermal: cpu_thermal {
+	        polling-delay-passive = <500>; /* milliseconds */
+	        polling-delay = <1000>; /* milliseconds */
+
+			        /* sensor	ID */
+	        thermal-sensors = <&tsadc	1>;
+
+	        trips {
+		        cpu_alert0: cpu_alert {
+			        temperature = <80000>; /* millicelsius */
+			        hysteresis = <2000>; /* millicelsius */
+			        type = "passive";
+		        };
+		        cpu_crit: cpu_crit {
+			        temperature = <125000>; /* millicelsius */
+			        hysteresis = <2000>; /* millicelsius */
+			    type = "critical";
+		        };
+	        };
+       };
+};
-- 
1.9.1
