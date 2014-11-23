From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Sun, 23 Nov 2014 11:42:02 +0200
Subject: [PATCH 4/4] ARM: dts: sbc-t3x30: add audio support
In-Reply-To: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
References: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1416735722-26167-5-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add audio related DT nodes

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   16 ++++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |   14 ++++++++++++++
 arch/arm/boot/dts/omap3-sb-t35.dtsi   |   16 ++++++++++++++++
 3 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 63bea24..6ea6d46 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -155,6 +155,15 @@
 			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
 		>;
 	};
+
+	mcbsp2_pins: pinmux_mcbsp2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x213c, PIN_INPUT | MUX_MODE0)	/* mcbsp2_fsx */
+			OMAP3_CORE1_IOPAD(0x213e, PIN_INPUT | MUX_MODE0)	/* mcbsp2_clkx */
+			OMAP3_CORE1_IOPAD(0x2140, PIN_INPUT | MUX_MODE0)	/* mcbsp2_dr */
+			OMAP3_CORE1_IOPAD(0x2142, PIN_OUTPUT | MUX_MODE0)	/* mcbsp2_dx */
+		>;
+	};
 };
 
 &uart3 {
@@ -243,3 +252,10 @@
 		};
 	};
 };
+
+&mcbsp2 {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index 9cc7185..9a4a3ab 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -10,6 +10,14 @@
 			cpu0-supply = <&vcc>;
 		};
 	};
+
+	sound {
+		compatible = "ti,omap-twl4030";
+		ti,model = "cm-t35";
+
+		ti,mcbsp = <&mcbsp2>;
+		ti,codec = <&twl_audio>;
+	};
 };
 
 &omap3_pmx_core {
@@ -59,6 +67,12 @@
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+
+		twl_audio: audio {
+			compatible = "ti,twl4030-audio";
+			codec {
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index aff733e..827f614 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -43,6 +43,16 @@
 			};
 		};
 	};
+
+	audio_amp: audio_amp {
+		compatible = "regulator-fixed";
+		regulator-name = "audio_amp";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sb_t35_audio_amp>;
+		gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;   /* gpio_61 */
+		enable-active-low;
+		regulator-always-on;
+	};
 };
 
 &omap3_pmx_core {
@@ -65,6 +75,12 @@
 			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda */
 		>;
 	};
+
+	sb_t35_audio_amp: pinmux_sb_t35_audio_amp {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20c8, PIN_OUTPUT | MUX_MODE4) /* gpmc_nbe1.gpio_61 */
+		>;
+	};
 };
 
 &i2c3 {
-- 
1.7.5.4
