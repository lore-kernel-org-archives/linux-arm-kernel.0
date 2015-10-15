From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:46:48 +0200
Subject: [PATCH 08/13] clk: add ARM syscon ICST device tree bindings
In-Reply-To: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444916813-31024-9-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device tree bindings for the ARM Syscon ICST
oscillators, which is a register-level interface to the
Integrated Device Technology (IDT) ICS525 and ICS307
serially programmable oscillators.

Cc: devicetree at vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I'm looking for an ACK from the CLK maintainers to take this
through the ARM SoC tree once the series stabilize.
---
 .../devicetree/bindings/clock/arm-syscon-icst.txt  | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/arm-syscon-icst.txt

diff --git a/Documentation/devicetree/bindings/clock/arm-syscon-icst.txt b/Documentation/devicetree/bindings/clock/arm-syscon-icst.txt
new file mode 100644
index 000000000000..19eb3aa765c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/arm-syscon-icst.txt
@@ -0,0 +1,40 @@
+ARM System Controller ICST clocks
+
+The ICS525 and ICS307 oscillators are produced by Integrated Devices
+Technology (IDT). ARM integrated these oscillators deeply into their
+reference designs by adding special control registers that manage such
+oscillators to their system controllers.
+
+The ARM system controller contains logic to serialized and initialize
+an ICST clock request after a write to the 32 bit register at an offset
+into the system controller. Further, to even be able to alter one of
+these frequencies, the system controller must first be unlocked by
+writing a special token to another offset in the system controller.
+
+The ICST oscillator must be provided inside a system controller node.
+
+Required properties:
+- lock-offset: the offset address into the system controller where the
+  unlocking register is located
+- vco-offset: the offset address into the system controller where the
+  ICST control register is located (even 32 bit address)
+- compatible: must be one of "arm,syscon-icst525" or "arm,syscon-icst307"
+- #clock-cells: must be <0>
+- clocks: parent clock, since the ICST needs a parent clock to derive its
+  frequency from, this attribute is compulsory.
+
+Example:
+
+syscon: syscon at 10000000 {
+	compatible = "syscon";
+	reg = <0x10000000 0x1000>;
+
+	oscclk0: osc0 at 0c {
+		compatible = "arm,syscon-icst307";
+		#clock-cells = <0>;
+		lock-offset = <0x20>;
+		vco-offset = <0x0C>;
+		clocks = <&xtal24mhz>;
+	};
+	(...)
+};
-- 
2.4.3
