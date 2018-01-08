From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:08 -0600
Subject: [PATCH v5 09/44] dt-bindings: clock: New bindings for TI Davinci PSC
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-10-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new binding for the Power Sleep Controller (PSC) for the
mach-davinci family of processors.

Note: Although TI Keystone has a very similar PSC, we are not using the
existing bindings. Keystone is using a legacy one-node-per-clock binding
(actually two nodes if you count the separate reset binding for the same
IP block). Also, some davinci LPSCs have quirks that aren't handled by
the keystone bindings, so we would be adding one compatible string per
clock with quirks instead of just a new compatible string for each
controller.

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../devicetree/bindings/clock/ti/davinci/psc.txt   | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/psc.txt

diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt b/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
new file mode 100644
index 0000000..83a9da5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
@@ -0,0 +1,47 @@
+Binding for TI DaVinci Power Sleep Controller (PSC)
+
+The PSC provides power management, clock gating and reset functionality. It is
+primarily used for clocking.
+
+Required properties:
+- compatible: shall be one of:
+	- "ti,da850-psc0" for PSC0 on DA850/OMAP-L138/AM18XX
+	- "ti,da850-psc1" for PSC1 on DA850/OMAP-L138/AM18XX
+- reg: physical base address and size of the controller's register area.
+- #clock-cells: from common clock binding; shall be set to 1.
+- #reset-cells: from reset binding; shall be set to 1.
+
+Consumers:
+
+	Clock and reset consumers shall use the local power domain module ID
+	(LPSC) as the index corresponding to the clock cell. Refer to the
+	device-specific	datasheet to find these numbers. NB: Most local domains
+	only provide a clock and not a reset.
+
+Examples:
+
+	psc0: clock-controller at 10000 {
+		compatible = "ti,da850-psc0";
+		reg = <0x10000 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	/* consumer */
+	dsp: dsp at 11800000 {
+		compatible = "ti,da850-dsp";
+		reg = <0x11800000 0x40000>,
+		      <0x11e00000 0x8000>,
+		      <0x11f00000 0x8000>,
+		      <0x01c14044 0x4>,
+		      <0x01c14174 0x8>;
+		reg-names = "l2sram", "l1pram", "l1dram", "host1cfg", "chipsig";
+		interrupt-parent = <&intc>;
+		interrupts = <28>;
+		clocks = <&psc0 15>;
+		resets = <&psc0 15>;
+	};
+
+Also see:
+- Documentation/devicetree/bindings/clock/clock-bindings.txt
+- Documentation/devicetree/bindings/reset/reset.txt
-- 
2.7.4
