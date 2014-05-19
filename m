From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 19 May 2014 18:43:22 +0200
Subject: [PATCH v2 01/10] dt-binding: ARM: add clock binding docs for Marvell
 Berlin2 SoCs
In-Reply-To: <1400517811-24668-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1400517811-24668-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1400517811-24668-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds mandatory device tree binding documentation for the clock related
IP found on Marvell Berlin2 (BG2, BG2CD, and BG2Q) SoCs to the Berlin SoC
binding documentation.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v1->v2:
- typo fixed (Reported by Alexandre Belloni)
- reworked binding to not represent individual clocks but chip control
  IP/registers instead (Suggested by Mike Turquette)
- dropped clock indices, refer to the include instead (Requested by Mike
  Turquette)
- moved the documentation from bindings/clock to Marvell Berlin SoC
  binding, as there will be more functions (e.g. pinctrl) to describe

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
Cc: devicetree at vger.kernel.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 .../devicetree/bindings/arm/marvell,berlin.txt     | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
index 0677003e1476..744a7ea569d4 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
@@ -23,3 +23,50 @@ SoC and board used. Currently known SoC compatibles are:
 
 	...
 }
+
+* Marvell Berlin2 chip control binding
+
+Marvell Berlin SoCs have a chip control register set providing several
+individual registers dealing with pinmux, padmux, clock, reset, and secondary
+CPU boot address. Unfortunately, the individual registers are spread among the
+chip control registers, so there should be a single DT node only providing the
+different functions which are described below.
+
+Required properties:
+- compatible: shall be one of
+	"marvell,berlin2-chip-ctrl" for BG2
+	"marvell,berlin2cd-chip-ctrl" for BG2CD
+	"marvell,berlin2q-chip-ctrl" for BG2Q
+- reg: address and length of following register sets for
+  BG2/BG2CD: chip control register set
+  BG2Q: chip control register set and cpu pll registers
+
+* Clock provider binding
+
+As clock related registers are spread among the chip control registers, the
+chip control node also provides the clocks. Marvell Berlin2 (BG2, BG2CD, BG2Q)
+SoCs share the same IP for PLLs and clocks, with some minor differences in
+features and register layout.
+
+Required properties:
+- #clock-cells: shall be set to 1
+- clocks: clock specifiers referencing the core clock input clocks
+- clock-names: array of strings describing the input clock specifiers above.
+    Allowed clock-names for the reference clocks are
+      "refclk" for the SoCs osciallator input on all SoCs,
+    and SoC-specific input clocks for
+      BG2/BG2CD: "video_ext0" for the external video clock input
+
+Clocks provided by core clocks shall be referenced by a clock specifier
+indexing one of the provided clocks. Refer to dt-bindings/clock/berlin<soc>.h
+for the corresponding index mapping.
+
+Example:
+
+chip: chip-control at ea0000 {
+	compatible = "marvell,berlin2-chip-ctrl";
+	#clock-cells = <1>;
+	reg = <0xea0000 0x400>;
+	clocks = <&refclk>, <&externaldev 0>;
+	clock-names = "refclk", "video_ext0";
+};
-- 
1.9.1
