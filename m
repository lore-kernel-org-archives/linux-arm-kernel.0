From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Fri, 28 Feb 2014 20:07:42 +0200
Subject: [PATCH 2/5] Power: reset: add bindings for keystone reset driver
In-Reply-To: <1393610865-23630-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1393610865-23630-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1393610865-23630-3-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node is intended to allow SoC reset in case of software reset
or appropriate watchdogs.

The Keystone SoCs can contain up to 4 watchdog timers to reset
SoC. Each watchdog timer event input is connected to the Reset Mux
block. The Reset Mux block can be configured to cause reset or not.

Additionally soft or hard reset can be configured.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---

CC: Rob Herring <robh+dt@kernel.org>
CC: Pawel Moll <pawel.moll@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
CC: Kumar Gala <galak@codeaurora.org>
CC: Rob Landley <rob@landley.net>

 .../bindings/power/reset/keystone-reset.txt        | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/keystone-reset.txt

diff --git a/Documentation/devicetree/bindings/power/reset/keystone-reset.txt b/Documentation/devicetree/bindings/power/reset/keystone-reset.txt
new file mode 100644
index 0000000..5ad5883
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/keystone-reset.txt
@@ -0,0 +1,59 @@
+* Device tree bindings for Texas Instruments keystone reset
+
+This node is intended to allow SoC reset in case of software reset
+of selected watchdogs.
+
+The Keystone SoCs can contain up to 4 watchdog timers to reset
+SoC. Each watchdog timer event input is connected to the Reset Mux
+block. The Reset Mux block can be configured to cause reset or not.
+
+Additionally soft or hard reset can be configured.
+
+Required properties:
+
+- compatible:		ti,keystone-reset
+
+- reg:			Contains offset/length value for mux registers.
+
+			reg = <0x23100e4 0x10>,
+			      <0x2620328 0x10>;
+
+-reg-names:		Contains two ranges "pllregs" and "muxregs".
+			"pllregs" - PLL reset control regs: RSTYPE, RSCTRL,
+			RSCFG, RSISO.
+			"muxregs" - mux block registers for all watchdogs.
+
+Optional properties:
+
+- ti,soft-reset:	Boolean option indicating soft reset.
+			By default hard reset is used.
+
+- ti,wdt_list:		WDT list that can cause SoC reset.
+			The list in format: <0>, <2>;
+			Begins from 0 to 3, as keystone can contain up
+			to 4 SoC reset watchdogs.
+
+Example 1:
+Setup keystone reset so that in case software reset or
+WDT1 is triggered it issues hard reset for SoC.
+
+rstctrl: reset-controller {
+	compatible = "ti,keystone-reset";
+	reg = <0x23100e4 0x10>,
+	      <0x2620328 0x10>;
+	reg-names = "pllregs", "muxregs";
+	ti,wdt_list = <0>;
+};
+
+Example 2:
+Setup keystone reset so that in case of software reset or
+WDT1 or WDT3 is triggered it issues soft reset for SoC.
+
+rstctrl: reset-controller {
+	compatible = "ti,keystone-reset";
+	reg = <0x23100e4 0x10>,
+	      <0x2620328 0x10>;
+	reg-names = "pllregs", "muxregs";
+	ti,wdt_list = <0>, <2>;
+	ti,soft-reset;
+};
-- 
1.8.3.2
