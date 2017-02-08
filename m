From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Wed,  8 Feb 2017 11:02:34 +0800
Subject: [PATCH v3 2/3] ASoC: zx-i2s: introduce pclk for zx2967 family
In-Reply-To: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
References: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1486522955-14528-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ZTE's zx2967 I2S controller driver introduces pclk, this
patch documents this fact.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
index 7e5aa6f..77390c0 100644
--- a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
@@ -4,7 +4,7 @@ Required properties:
  - compatible : Must be "zte,zx296702-i2s"
  - reg : Must contain I2S core's registers location and length
  - clocks : Pairs of phandle and specifier referencing the controller's clocks.
- - clock-names: "tx" for the clock to the I2S interface.
+ - clock-names: "wclk" for the wclk, "pclk" for the pclk to the I2S interface.
  - dmas: Pairs of phandle and specifier for the DMA channel that is used by
    the core. The core expects two dma channels for transmit.
  - dma-names : Must be "tx" and "rx"
@@ -15,13 +15,17 @@ please check:
 	* clock/clock-bindings.txt
 	* dma/dma.txt
 
+Please note that ZTE ZX296702 I2S controller driver is compatible for zx296702
+and zx296718, so compatible string might be set as follow:
+	"zte,zx296718-i2s", "zte,zx296702-i2s"
+
 Example:
 	i2s0: i2s0 at 0b005000 {
 		#sound-dai-cells = <0>;
-		compatible = "zte,zx296702-i2s";
+		compatible = "zte,zx296718-i2s", "zte,zx296702-i2s";
 		reg = <0x0b005000 0x1000>;
-		clocks = <&lsp0clk ZX296702_I2S0_DIV>;
-		clock-names = "tx";
+		clocks = <&audiocrm AUDIO_I2S0_WCLK>, <&audiocrm AUDIO_I2S0_PCLK>;
+		clock-names = "wclk", "pclk";
 		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 		dmas = <&dma 5>, <&dma 6>;
 		dma-names = "tx", "rx";
-- 
2.7.4
