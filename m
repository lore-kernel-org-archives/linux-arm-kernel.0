From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 17 Apr 2015 15:33:48 -0700
Subject: [PATCH 3/7] Documentation: DT: Document SMP DT nodes and properties
 for BCM63138
In-Reply-To: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
References: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429310032-19402-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for the additional nodes and properties
required to get the secondary CPU online on the BCM63138 SoC.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/bcm63138.txt       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt b/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
index bd49987a8812..18afe5b42549 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
@@ -7,3 +7,45 @@ following properties:
 Required root node property:
 
 compatible: should be "brcm,bcm63138"
+
+An optional Boot lookup table Device Tree node is required for secondary CPU
+initialization as well as a 'resets' phandle to the correct PMB controller as
+defined in reset/brcm,bcm63138-pmb.txt for this secondary CPU, and an
+'enable-method' property.
+
+Required properties for the Boot lookup table node:
+- compatible: should be "brcm,bcm63138-bootlut"
+- reg: register base address and length for the Boot Lookup table
+
+Optional properties for the primary CPU node:
+- enable-method: should be "brcm,bcm63138"
+
+Optional properties for the secondary CPU node:
+- enable-method: should be "brcm,bcm63138"
+- resets: phandle to the relevant PMB controller, one integer indicating the internal
+  bus number, and a second integer indicating the address of the CPU in the PMB
+  internal bus number.
+
+Example:
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,cotex-a9";
+			reg = <0>;
+			...
+			enable-method = "brcm,bcm63138";
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			...
+			enable-method = "brcm,bcm63138";
+			resets = <&pmb0 0 4>;
+		};
+	};
+
+	bootlut: bootlut at 8000 {
+		compatible = "brcm,bcm63138-bootlut";
+		reg = <0x8000 0x50>;
+	};
-- 
2.1.0
