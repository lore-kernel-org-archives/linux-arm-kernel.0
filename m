From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 23 Apr 2015 16:03:00 -0700
Subject: [PATCH v2 1/2] dt-bindings: Add documentation for the BCM63138 timer
 and syscon-reboot
In-Reply-To: <1429830181-28338-1-git-send-email-f.fainelli@gmail.com>
References: <1429830181-28338-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429830181-28338-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A timer node and a syscon-reboot node are required for software reboot
to work on BCM63138, document these two nodes in the platform binding.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,bcm63138.txt  | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt
index bd49987a8812..54468dab498c 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt
@@ -7,3 +7,36 @@ following properties:
 Required root node property:
 
 compatible: should be "brcm,bcm63138"
+
+reboot
+------
+Two nodes are required for software reboot: a timer node and a syscon-reboot node.
+
+Timer node:
+
+- compatible: Must be "brcm,bcm6328-timer", "syscon"
+- reg: Register base address and length
+
+Syscon reboot node:
+
+See Documentation/devicetree/bindings/power/reset/syscon-reboot.txt for the
+detailed list of properties, the two values defined below are specific to the
+BCM6328-style timer:
+
+- offset: Should be 0x34 to denote the offset of the TIMER_WD_TIMER_RESET register
+  from the beginning of the TIMER block
+- mask: Should be 1 for the SoftRst bit.
+
+Example:
+
+	timer: timer at 80 {
+		compatible = "brcm,bcm6328-timer", "syscon";
+		reg = <0x80 0x3c>;
+	};
+
+	reboot {
+		compatible = "syscon-reboot";
+		regmap = <&timer>;
+		offset = <0x34>;
+		mask = <0x1>;
+	};
-- 
2.1.0
