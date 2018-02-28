From: samuel@sholland.org (Samuel Holland)
Date: Tue, 27 Feb 2018 20:27:12 -0600
Subject: [PATCH 1/3] dt-bindings: Add a binding for the sunxi message box
In-Reply-To: <20180228022714.30068-1-samuel@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org>
Message-ID: <20180228022714.30068-2-samuel@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mailbox hardware is present in several Allwinner sun8i and sun50i
SoCs. Add a device tree binding for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../devicetree/bindings/mailbox/sunxi-msgbox.txt   | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
new file mode 100644
index 000000000000..3b3ed7f870a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
@@ -0,0 +1,40 @@
+Allwinner sunxi Message Box
+===========================
+
+The hardware message box on sunxi SoCs is a two-user mailbox controller
+containing 8 unidirectional FIFOs bonded into 4 bidirectional mailbox channels.
+An interrupt is raised for received messages, but software must poll to know
+when a transmitted message has been acknowledged by the remote user.
+
+Refer to ./mailbox.txt for generic information about mailbox device-tree
+bindings.
+
+Mailbox Device Node:
+====================
+
+Required properties:
+--------------------
+- compatible:		Must be "allwinner,sunxi-msgbox".
+- reg:			Contains the mailbox register address range (base
+			address and length).
+- clocks:		phandle for the clock controller and specifier.
+- clock-names:		Must be "bus".
+- resets:		phandle for the reset controller and specifier.
+- reset-names:		Must be "bus".
+- interrupts:		Contains interrupt information for the mailbox.
+- #mbox-cells		Must be 2 - the indexes of the transmit and receive
+			channels, respectively.
+
+Example:
+--------
+
+	msgbox: mailbox at 1c17000 {
+		compatible = "allwinner,sunxi-msgbox";
+		reg = <0x01c17000 0x1000>;
+		clocks = <&ccu CLK_BUS_MSGBOX>;
+		clock-names = "bus";
+		resets = <&ccu RST_BUS_MSGBOX>;
+		reset-names = "bus";
+		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+	};
-- 
2.13.6
