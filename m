From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 May 2017 13:33:59 +0200
Subject: [PATCH 1/4 v3] ata: Add DT bindings for Faraday Technology FTIDE010
Message-ID: <20170530113402.20450-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings for the Faraday Technology
FTIDE010 found in the Storlink/Storm/Cortina Systems Gemini SoC.

I am not 100% sure that this part is from Faraday Technology but
a lot points in that direction:

- A later IDE interface called FTIDE020 exist and share some
  properties.

- The SATA bridge has the same Built In Self Test (BIST) that the
  Faraday FTSATA100 seems to have, and it has version number 0100
  in the device ID register, so this is very likely a FTSATA100
  bundled with the FTIDE010.

Cc: devicetree at vger.kernel.org
Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes, just resending to keep the patch set together.
ChangeLog v1->v2:
- Cut the timings defintions from the device tree. Hard-code
  it in the driver instead, keeping the nice layout and
  configurability by making it easy to tweak the timings
  in the code.
- Fix up some confused references to 50 MHz in 66 MHz
  properties.
---
 .../devicetree/bindings/ata/faraday,ftide010.txt   | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.txt

diff --git a/Documentation/devicetree/bindings/ata/faraday,ftide010.txt b/Documentation/devicetree/bindings/ata/faraday,ftide010.txt
new file mode 100644
index 000000000000..a0c64a29104d
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/faraday,ftide010.txt
@@ -0,0 +1,38 @@
+* Faraday Technology FTIDE010 PATA controller
+
+This controller is the first Faraday IDE interface block, used in the
+StorLink SL2312 and SL3516, later known as the Cortina Systems Gemini
+platform. The controller can do PIO modes 0 through 4, Multi-word DMA
+(MWDM)modes 0 through 2 and Ultra DMA modes 0 through 6.
+
+On the Gemini platform, this PATA block is accompanied by a PATA to
+SATA bridge in order to support SATA. This is why a phandle to that
+controller is compulsory on that platform.
+
+The timing properties are unique per-SoC, not per-board.
+
+Required properties:
+- compatible: should be one of
+  "cortina,gemini-pata", "faraday,ftide010"
+  "faraday,ftide010"
+- interrupts: interrupt for the block
+- reg: registers and size for the block
+
+Optional properties:
+- clocks: a SoC clock running the peripheral.
+- clock-names: should be set to "PCLK" for the peripheral clock.
+
+Required properties for "cortina,gemini-pata" compatible:
+- sata: a phande to the Gemini PATA to SATA bridge, see
+  cortina,gemini-sata-bridge.txt for details.
+
+Example:
+
+ata at 63000000 {
+	compatible = "cortina,gemini-pata", "faraday,ftide010";
+	reg = <0x63000000 0x100>;
+	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+	clocks = <&gcc GEMINI_CLK_GATE_IDE>;
+	clock-names = "PCLK";
+	sata = <&sata>;
+};
-- 
2.9.4
