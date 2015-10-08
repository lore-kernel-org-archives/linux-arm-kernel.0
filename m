From: songjun.wu@atmel.com (Songjun Wu)
Date: Thu, 8 Oct 2015 15:36:56 +0800
Subject: [PATCH v3 2/2] ASoC: atmel-classd: DT binding for Class D audio
 amplifier driver
In-Reply-To: <1444289816-11648-1-git-send-email-songjun.wu@atmel.com>
References: <1444289816-11648-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <1444289816-11648-3-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

Changes in v3: None
Changes in v2:
- Delete the device node "Sound" in dts.

 .../devicetree/bindings/sound/atmel-classd.txt     |   52 ++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
new file mode 100644
index 0000000..0018451
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-classd.txt
@@ -0,0 +1,52 @@
+* Atmel ClassD driver under ALSA SoC architecture
+
+Required properties:
+- compatible
+	Should be "atmel,sama5d2-classd".
+- reg
+	Should contain ClassD registers location and length.
+- interrupts
+	Should contain the IRQ line for the ClassD.
+- dmas
+	One DMA specifiers as described in atmel-dma.txt and dma.txt files.
+- dma-names
+	Must be "tx".
+- clock-names
+	Tuple listing input clock names.
+	Required elements: "pclk", "gclk" and "aclk".
+- clocks
+	Please refer to clock-bindings.txt.
+
+Optional properties:
+- pinctrl-names, pinctrl-0
+	Please refer to pinctrl-bindings.txt.
+- atmel,model
+	The user-visible name of this sound complex.
+	The default value is "CLASSD".
+- atmel,pwm-type
+	PWM modulation type, "single" or "diff".
+	The default value is "single".
+- atmel,non-overlap-time
+	Set non-overlapping time, the unit is nanosecond(ns).
+	There are four values,
+	<5>, <10>, <15>, <20>, the default value is <10>.
+	Non-overlapping will be disabled if not specified.
+
+Example:
+classd: classd at fc048000 {
+		compatible = "atmel,sama5d2-classd";
+		reg = <0xfc048000 0x100>;
+		interrupts = <59 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas = <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+			| AT91_XDMAC_DT_PERID(47))>;
+		dma-names = "tx";
+		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
+		clock-names = "pclk", "gclk", "aclk";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_classd_default>;
+		atmel,model = "classd @ SAMA5D2-Xplained";
+		atmel,pwm-type = "diff";
+		atmel,non-overlap-time = <10>;
+};
-- 
1.7.9.5
