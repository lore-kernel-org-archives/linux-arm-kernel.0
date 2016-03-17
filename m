From: nm@ti.com (Nishanth Menon)
Date: Wed, 16 Mar 2016 19:23:13 -0500
Subject: [PATCH V3 1/2] Documentation: dt: mailbox: Add TI Message Manager
In-Reply-To: <1458174194-22320-1-git-send-email-nm@ti.com>
References: <1458174194-22320-1-git-send-email-nm@ti.com>
Message-ID: <1458174194-22320-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Message Manager is a hardware block used to communicate with various
processor systems within certain Texas Instrument's Keystone
generation SoCs.

This hardware engine is used to transfer messages from various compute
entities(or processors) within the SoC. It is designed to be self
contained without needing software initialization for operation.

Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in V3:
	- Just picked up Rob's ack from v2
V2: https://patchwork.kernel.org/patch/8442641/
V1: https://patchwork.kernel.org/patch/8237111/

 .../bindings/mailbox/ti,message-manager.txt        | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/ti,message-manager.txt

diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
new file mode 100644
index 000000000000..b449d025049f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
@@ -0,0 +1,50 @@
+Texas Instruments' Message Manager Driver
+========================================
+
+The Texas Instruments' Message Manager is a mailbox controller that has
+configurable queues selectable at SoC(System on Chip) integration. The Message
+manager is broken up into queues in different address regions that are called
+"proxies" - each instance is unidirectional and is instantiated at SoC
+integration level to indicate receive or transmit path.
+
+Message Manager Device Node:
+===========================
+Required properties:
+--------------------
+- compatible:		Shall be: "ti,k2g-message-manager"
+- reg-names 		queue_proxy_region - Map the queue proxy region.
+			queue_state_debug_region - Map the queue state debug
+			region.
+- reg:			Contains the register map per reg-names.
+- #mbox-cells		Shall be 2. Contains the queue ID and proxy ID in that
+		        order referring to the transfer path.
+- interrupt-names:	Contains interrupt names matching the rx transfer path
+			for a given SoC. Receive interrupts shall be of the
+			format: "rx_<QID>_<PID>".
+			For ti,k2g-message-manager, this shall contain:
+				"rx_005_002", "rx_057_002"
+- interrupts:		Contains the interrupt information corresponding to
+			interrupt-names property.
+
+Example(K2G):
+------------
+
+	msgmgr: msgmgr at 02a00000 {
+		compatible = "ti,k2g-message-manager";
+		#mbox-cells = <2>;
+		reg-names = "queue_proxy_region", "queue_state_debug_region";
+		reg = <0x02a00000 0x400000>, <0x028c3400 0x400>;
+		interrupt-names = "rx_005", "rx_057";
+		interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmmc: pmmc {
+		[...]
+		mbox-names = "rx", "tx";
+		# RX queue ID is 5, proxy ID is 2
+		# TX queue ID is 0, proxy ID is 0
+		mboxes= <&msgmgr 5 2>,
+			<&msgmgr 0 0>;
+		[...]
+	};
-- 
2.8.0.rc3
