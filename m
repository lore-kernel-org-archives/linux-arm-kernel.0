From: songjun.wu@atmel.com (Songjun Wu)
Date: Thu, 17 Dec 2015 17:44:58 +0800
Subject: [PATCH v2 2/2] ASoC: atmel-classd: DT binding for PDMIC driver
In-Reply-To: <1450345498-20130-1-git-send-email-songjun.wu@atmel.com>
References: <1450345498-20130-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <1450345498-20130-2-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT binding documentation for this new ASoC driver.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

Changes in v2: None

 .../devicetree/bindings/sound/atmel-pdmic.txt      |   55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-pdmic.txt b/Documentation/devicetree/bindings/sound/atmel-pdmic.txt
new file mode 100644
index 0000000..e0875f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-pdmic.txt
@@ -0,0 +1,55 @@
+* Atmel PDMIC driver under ALSA SoC architecture
+
+Required properties:
+- compatible
+	Should be "atmel,sama5d2-pdmic".
+- reg
+	Should contain PDMIC registers location and length.
+- interrupts
+	Should contain the IRQ line for the PDMIC.
+- dmas
+	One DMA specifiers as described in atmel-dma.txt and dma.txt files.
+- dma-names
+	Must be "rx".
+- clock-names
+	Required elements:
+	- "pclk"	peripheral clock
+	- "gclk"	generated clock
+- clocks
+	Must contain an entry for each required entry in clock-names.
+	Please refer to clock-bindings.txt.
+- atmel,mic-min-freq
+	The minimal frequency that the micphone supports.
+- atmel,mic-max-freq
+	The maximal frequency that the micphone supports.
+
+Optional properties:
+- pinctrl-names, pinctrl-0
+	Please refer to pinctrl-bindings.txt.
+- atmel,model
+	The user-visible name of this sound card.
+	The default value is "PDMIC".
+- atmel,mic-offset
+	The offset that should be added.
+	The range is from -32768 to 32767.
+	The default value is 0.
+
+Example:
+	pdmic at f8018000 {
+				compatible = "atmel,sama5d2-pdmic";
+				reg = <0xf8018000 0x124>;
+				interrupts = <48 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(50))>;
+				dma-names = "rx";
+				clocks = <&pdmic_clk>, <&pdmic_gclk>;
+				clock-names = "pclk", "gclk";
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pdmic_default>;
+				atmel,model = "PDMIC @ sama5d2_xplained";
+				atmel,mic-min-freq = <1000000>;
+				atmel,mic-max-freq = <3246000>;
+				atmel,mic-offset = <0x0>;
+	};
-- 
1.7.9.5
