From: nm@ti.com (Nishanth Menon)
Date: Mon, 16 Jul 2018 13:06:06 -0500
Subject: [PATCH V2 5/6] dt-bindings: mailbox: Add support for secure proxy
 threads
In-Reply-To: <20180716180607.16526-1-nm@ti.com>
References: <20180716180607.16526-1-nm@ti.com>
Message-ID: <20180716180607.16526-6-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Secure Proxy is another communication scheme in Texas Instrument's
devices intended to provide an unique communication path from various
processors in the System on Chip(SoC) to a central System Controller.

Secure proxy is, in effect, an evolution of current generation Message
Manager hardware block found in K2G devices. However the following
changes have taken place:

Secure Proxy instance exposes "threads" or "proxies" which is
primary representation of "a" communication channel. Each thread is
preconfigured by System controller configuration based on SoC usage
requirements. Secure proxy by itself represents a single "queue" of
communication but allows the proxies to be independently operated.

Each Secure proxy thread can uniquely have their own error and threshold
interrupts allowing for more fine control of IRQ handling.

Provide an hardware description of the same for device tree
representation.

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
* Example changed to indicate mailbox instead of secure_proxy
* Picked up Rob's Reviewed-by

V1: https://patchwork.kernel.org/patch/10475343/
RFC: https://patchwork.kernel.org/patch/10447695/

 .../bindings/mailbox/ti,secure-proxy.txt           | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt

diff --git a/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
new file mode 100644
index 000000000000..6c9c7daf0f5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
@@ -0,0 +1,50 @@
+Texas Instruments' Secure Proxy
+========================================
+
+The Texas Instruments' secure proxy is a mailbox controller that has
+configurable queues selectable at SoC(System on Chip) integration. The
+Message manager is broken up into different address regions that are
+called "threads" or "proxies" - each instance is unidirectional and is
+instantiated at SoC integration level by system controller to indicate
+receive or transmit path.
+
+Message Manager Device Node:
+===========================
+Required properties:
+--------------------
+- compatible:		Shall be "ti,am654-secure-proxy"
+- reg-names 		target_data - Map the proxy data region
+			rt - Map the realtime status region
+			scfg - Map the configuration region
+- reg:			Contains the register map per reg-names.
+- #mbox-cells		Shall be 1 and shall refer to the transfer path
+			called thread.
+- interrupt-names:	Contains interrupt names matching the rx transfer path
+			for a given SoC. Receive interrupts shall be of the
+			format: "rx_<PID>".
+- interrupts:		Contains the interrupt information corresponding to
+			interrupt-names property.
+
+Example(AM654):
+------------
+
+	secure_proxy: mailbox at 32c00000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x0 0x32c00000 0x0 0x100000>,
+		      <0x0 0x32400000 0x0 0x100000>,
+		      <0x0 0x32800000 0x0 0x100000>;
+		interrupt-names = "rx_011";
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	dmsc: dmsc {
+		[...]
+		mbox-names = "rx", "tx";
+		# RX Thread ID is 11
+		# TX Thread ID is 13
+		mboxes= <&secure_proxy 11>,
+			<&secure_proxy 13>;
+		[...]
+	};
-- 
2.15.1
