From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 18 Jun 2018 14:59:00 +1000
Subject: [PATCH v2 2/4] dt-bindings: misc: Aspeed coprocessor interrupt
 controller
In-Reply-To: <20180618045902.11453-1-benh@kernel.crashing.org>
References: <20180618045902.11453-1-benh@kernel.crashing.org>
Message-ID: <20180618045902.11453-3-benh@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device-tree binding definition for the AST2400
and AST2500 coprocessor interrupt controller

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 .../devicetree/bindings/misc/aspeed,cvic.txt  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt b/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
new file mode 100644
index 000000000000..2562e2991e4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
@@ -0,0 +1,35 @@
+* Aspeed AST2400 and AST2500 coprocessor interrupt controller
+
+This file describes the bindings for the interrupt controller present
+in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
+ColdFire coprocessor.
+
+It is not a normal interrupt controller and it would be rather
+inconvenient to create an interrupt tree for it as it somewhat shares
+some of the same sources as the main ARM interrupt controller but with
+different numbers.
+
+The AST2500 supports a SW generated interrupt
+
+Required properties:
+- reg: address and length of the register for the device.
+- compatible: "aspeed,cvic" and one of:
+		"aspeed,ast2400-cvic"
+	      or
+		"aspeed,ast2500-cvic"
+
+- valid-sources: One cell, bitmap of supported sources for the implementation
+
+Optional properties;
+- copro-sw-interrupts: List of interrupt numbers that can be used as
+		       SW interrupts from the ARM to the coprocessor.
+		       (AST2500 only)
+
+Example:
+
+	cvic: copro-interrupt-controller at 1e6c2000 {
+		compatible = "aspeed,ast2500-cvic";
+		valid-sources = <0xffffffff>;
+		copro-sw-interrupts = <1>;
+		reg = <0x1e6c2000 0x80>;
+	};
-- 
2.17.1
