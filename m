From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 May 2017 23:56:34 +0200
Subject: [PATCH 2/3] rtc: gemini: Augment DT bindings for Faraday
In-Reply-To: <20170518215635.13505-1-linus.walleij@linaro.org>
References: <20170518215635.13505-1-linus.walleij@linaro.org>
Message-ID: <20170518215635.13505-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gemini RTC is actually a standard IP block from Faraday
Technology called FTRTC010. Rename the bindings, add the
generic compatible string and add definitions for the two
available clocks.

Cc: devicetree at vger.kernel.org
Cc: Po-Yu Chuang <ratbert@faraday-tech.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/rtc/cortina,gemini.txt     | 14 -----------
 .../devicetree/bindings/rtc/faraday,ftrtc010.txt   | 28 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt

diff --git a/Documentation/devicetree/bindings/rtc/cortina,gemini.txt b/Documentation/devicetree/bindings/rtc/cortina,gemini.txt
deleted file mode 100644
index 4ce4e794ddbb..000000000000
--- a/Documentation/devicetree/bindings/rtc/cortina,gemini.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-* Cortina Systems Gemini RTC
-
-Gemini SoC real-time clock.
-
-Required properties:
-- compatible : Should be "cortina,gemini-rtc"
-
-Examples:
-
-rtc at 45000000 {
-	compatible = "cortina,gemini-rtc";
-	reg = <0x45000000 0x100>;
-	interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt b/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
new file mode 100644
index 000000000000..e3938f5e0b6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
@@ -0,0 +1,28 @@
+* Faraday Technology FTRTC010 Real Time Clock
+
+This RTC appears in for example the Storlink Gemini family of
+SoCs.
+
+Required properties:
+- compatible : Should be one of:
+  "faraday,ftrtc010"
+  "cortina,gemini-rtc", "faraday,ftrtc010"
+
+Optional properties:
+- clocks: when present should contain clock references to the
+  PCLK and EXTCLK clocks. Faraday calls the later CLK1HZ and
+  says the clock should be 1 Hz, but implementers actually seem
+  to choose different clocks here, like Cortina who chose
+  32768 Hz (a typical low-power clock).
+- clock-names: should name the clocks "PCLK" and "EXTCLK"
+  respectively.
+
+Examples:
+
+rtc at 45000000 {
+	compatible = "cortina,gemini-rtc";
+	reg = <0x45000000 0x100>;
+	interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&foo 0>, <&foo 1>;
+	clock-names = "PCLK", "EXTCLK";
+};
-- 
2.9.3
