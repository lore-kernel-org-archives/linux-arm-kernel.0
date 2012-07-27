From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Jul 2012 13:45:45 +0100
Subject: [PATCH 01/18] Documentation: Describe the ux500 realated audio
 related DT nodes
In-Reply-To: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also explains the related AB8500 CODEC configuration properties.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/sound/ux500.txt |   62 +++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ux500.txt

diff --git a/Documentation/devicetree/bindings/sound/ux500.txt b/Documentation/devicetree/bindings/sound/ux500.txt
new file mode 100644
index 0000000..af1c902
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ux500.txt
@@ -0,0 +1,62 @@
+* ux500 Audio Driver and ab8500 Audio CODEC
+
+Required properties:
+ - compatible:
+   - Machine Driver : "stericsson,snd-soc-mop500"
+   - CPU-side DAI   : "stericsson,ux500-msp-i2s"
+   - DMA (platform) : "stericsson,ux500-pcm"
+   - Audio CODEC    : "stericsson,ab8500-codec"
+
+Optional properties:
+ - reg              : Physical base address and length of the device's registers.
+ - interrupts       : The interrupt outputs from the device.
+ - interrupt-parent : The parent interrupt controller.
+ - <name>-supply    : Phandle to the regulator <name> supply
+
+Non-standard properties:
+ - Machine Driver:
+   - stericsson,platform-pcm-dma : Phandle to the DMA (platform) node
+   - stericsson,cpu-dai          : Phandle to the CPU-side DAI
+   - stericsson,audio-codec      : Phandle to the Audio CODEC
+ - CPU-side DAI:
+   - stericcson,use-pinctrl      : Indicates whether an MSP port has pinctrl support
+ - Audio CODEC:
+   - stericsson,amic[1|2]-type-single-ended : Single-ended Analoge Mic (default: differential)
+   - stericsson,amic1a-bias-vamic2          : Analoge Mic wishes to use a non-standard Vamic
+   - stericsson,amic1b-bias-vamic2          : Analoge Mic wishes to use a non-standard Vamic
+   - stericsson,amic2-bias-vamic1           : Analoge Mic wishes to use a non-standard Vamic
+   - stericsson,earpeice-cmv                : Earpeice voltage (only: 950 | 1100 | 1270 | 1580)
+
+Example:
+
+	sound {
+		compatible = "stericsson,snd-soc-mop500";
+
+		stericsson,platform-pcm-dma = <&pcm>;
+		stericsson,cpu-dai = <&msp1 &msp3>;
+		stericsson,audio-codec = <&codec>;
+	};
+
+	pcm: ux500-pcm {
+		compatible = "stericsson,ux500-pcm";
+	};
+
+	msp1: msp at 80124000 {
+		compatible = "stericsson,ux500-msp-i2s";
+		reg = <0x80124000 0x1000>;
+		interrupts = <0 62 0x4>;
+		v-ape-supply = <&db8500_vape_reg>;
+		stericcson,use-pinctrl;
+	};
+
+	msp3: msp at 80125000 {
+		compatible = "stericsson,ux500-msp-i2s";
+		reg = <0x80125000 0x1000>;
+		interrupts = <0 62 0x4>;
+		v-ape-supply = <&db8500_vape_reg>;
+	};
+
+	codec: ab8500-codec {
+		compatible = "stericsson,ab8500-codec";
+		stericsson,earpeice-cmv = <950>; /* Units in mV. */
+	};
-- 
1.7.9.5
