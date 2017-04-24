From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 24 Apr 2017 22:40:22 +0200
Subject: [PATCH V4] ARM64: dts: hi6220-hikey: Add clock binding for the pmic
 mfd
Message-ID: <1493066439-6889-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hi655x PMIC provides the regulators but also a clock. The latter is missing
in the definition and in the DT, thus it is no possible to enable the WiFi which
depends on this clock.

The hi655x's clock has been added and the hi655x multifunction driver has
updated with a clock-cell.

This patch adds the clock-cells for the PMIC in the DT and updates the
documentation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
---
 Changelog:
	v4:
	   - Added Acked-by's
	   - Updated the commit message with a better description
---
 Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt | 6 ++++++
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts             | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt b/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt
index 0548569..9630ac0 100644
--- a/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt
@@ -16,6 +16,11 @@ Required properties:
 - reg:                  Base address of PMIC on Hi6220 SoC.
 - interrupt-controller: Hi655x has internal IRQs (has own IRQ domain).
 - pmic-gpios:           The GPIO used by PMIC IRQ.
+- #clock-cells:		From common clock binding; shall be set to 0
+
+Optional properties:
+- clock-output-names: From common clock binding to override the
+  default output clock name
 
 Example:
 	pmic: pmic at f8000000 {
@@ -24,4 +29,5 @@ Example:
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		pmic-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		#clock-cells = <0>;
 	}
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index dba3c13..e0496f7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -325,6 +325,7 @@
 	pmic: pmic at f8000000 {
 		compatible = "hisilicon,hi655x-pmic";
 		reg = <0x0 0xf8000000 0x0 0x1000>;
+		#clock-cells = <0>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		pmic-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
-- 
1.9.1
