From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Apr 2017 22:40:54 +0200
Subject: [PATCH 1/5 v3] usb: host: add DT bindings for faraday fotg2
Message-ID: <20170421204058.6206-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans Ulli Kroll <ulli.kroll@googlemail.com>

This adds device tree bindings for the Faraday FOTG2
dual-mode host controller.

Cc: devicetree at vger.kernel.org
Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v3:
- Change compatible to "faraday,fotg210" as the name of the
  hardware block.
- Add an elaborate SoC-specific compatible string for the
  Cortina Systems Gemini so that SoC-specific features can
  be enabled.
- Add cortina,gemini-mini-b to indicate a Gemini PHY with
  a Mini-B adapter connected.
- Indicated that the Gemini version can handle "wakeup-source".
- Add optional IP block clock.
---
 .../devicetree/bindings/usb/faraday,fotg210.txt    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/faraday,fotg210.txt

diff --git a/Documentation/devicetree/bindings/usb/faraday,fotg210.txt b/Documentation/devicetree/bindings/usb/faraday,fotg210.txt
new file mode 100644
index 000000000000..cf06808303e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/faraday,fotg210.txt
@@ -0,0 +1,35 @@
+Faraday FOTG Host controller
+
+This OTG-capable USB host controller is found in Cortina Systems
+Gemini and other SoC products.
+
+Required properties:
+- compatible: should be one of:
+  "faraday,fotg210"
+  "cortina,gemini-usb", "faraday,fotg210"
+- reg: should contain one register range i.e. start and length
+- interrupts: description of the interrupt line
+
+Optional properties:
+- clocks: should contain the IP block clock
+- clock-names: should be "PCLK" for the IP block clock
+
+Required properties for "cortina,gemini-usb" compatible:
+- syscon: a phandle to the system controller to access PHY registers
+
+Optional properties for "cortina,gemini-usb" compatible:
+- cortina,gemini-mini-b: boolean property that indicates that a Mini-B
+  OTH connector is in use
+- wakeup-source: see power/wakeup-source.txt
+
+Example for Gemini:
+
+usb at 68000000 {
+	compatible = "cortina,gemini-usb", "faraday,fotg210";
+	reg = <0x68000000 0x1000>;
+	interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cc 12>;
+	clock-names = "PCLK";
+	syscon = <&syscon>;
+	wakeup-source;
+};
-- 
2.9.3
