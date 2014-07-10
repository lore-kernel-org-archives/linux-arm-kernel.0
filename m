From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 10 Jul 2014 14:24:02 +0300
Subject: [PATCH 2/3] ARM: DTS: omap5-uevm: Add node for twl6040 audio codec
In-Reply-To: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
References: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1404991443-14239-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board uses twl6040 as audio codec. Move the corresponding  pinctrl as
well under the node.
twl6040 needs 32k clock from palams.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 9166d479ac1b..c9286166fad5 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -105,7 +105,6 @@
 &omap5_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
-			&twl6040_pins
 			&mcpdm_pins
 			&mcbsp1_pins
 			&mcbsp2_pins
@@ -494,6 +493,25 @@
 			};
 		};
 	};
+
+	twl6040: twl@4b {
+		compatible = "ti,twl6040";
+		reg = <0x4b>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&twl6040_pins>;
+
+		interrupts = <GIC_SPI 119 IRQ_TYPE_NONE>; /* IRQ_SYS_2N cascaded to gic */
+		interrupt-parent = <&gic>;
+		ti,audpwron-gpio = <&gpio5 13 0>;  /* gpio line 141 */
+
+		vio-supply = <&smps7_reg>;
+		v2v1-supply = <&smps9_reg>;
+		enable-active-high;
+
+		clocks = <&clk32kgaudio>;
+		clock-names = "clk32k";
+	};
 };
 
 &i2c5 {
-- 
2.0.0
