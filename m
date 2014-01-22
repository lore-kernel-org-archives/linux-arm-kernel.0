From: marc.ceeeee@gmail.com (Marc Carino)
Date: Tue, 21 Jan 2014 19:30:50 -0800
Subject: [PATCH v5 6/8] ARM: brcmstb: add misc. DT bindings for brcmstb
In-Reply-To: <1390361452-3124-1-git-send-email-marc.ceeeee@gmail.com>
References: <1390361452-3124-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1390361452-3124-7-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the bindings that the Broadcom STB platform needs
for proper bootup.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/brcm-brcmstb.txt       |   95 ++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt

diff --git a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
new file mode 100644
index 0000000..3c436cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
@@ -0,0 +1,95 @@
+ARM Broadcom STB platforms Device Tree Bindings
+-----------------------------------------------
+Boards with Broadcom Brahma15 ARM-based BCMxxxx (generally BCM7xxx variants)
+SoC shall have the following DT organization:
+
+Required root node properties:
+    - compatible: "brcm,bcm<chip_id>", "brcm,brcmstb"
+
+example:
+/ {
+    #address-cells = <2>;
+    #size-cells = <2>;
+    model = "Broadcom STB (bcm7445)";
+    compatible = "brcm,bcm7445", "brcm,brcmstb";
+
+Further, syscon nodes that map platform-specific registers used for general
+system control is required:
+
+    - compatible: "brcm,bcm<chip_id>-sun-top-ctrl", "syscon"
+    - compatible: "brcm,bcm<chip_id>-hif-cpubiuctrl", "syscon"
+    - compatible: "brcm,bcm<chip_id>-hif-continuation", "syscon"
+
+example:
+    rdb {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        compatible = "simple-bus";
+        ranges = <0 0x00 0xf0000000 0x1000000>;
+
+        sun_top_ctrl: syscon at 404000 {
+            compatible = "brcm,bcm7445-sun-top-ctrl", "syscon";
+            reg = <0x404000 0x51c>;
+        };
+
+        hif_cpubiuctrl: syscon at 3e2400 {
+            compatible = "brcm,bcm7445-hif-cpubiuctrl", "syscon";
+            reg = <0x3e2400 0x5b4>;
+        };
+
+        hif_continuation: syscon at 452000 {
+            compatible = "brcm,bcm7445-hif-continuation", "syscon";
+            reg = <0x452000 0x100>;
+        };
+    };
+
+Lastly, nodes that allow for support of SMP initialization and reboot are
+required:
+
+smpboot
+-------
+Required properties:
+
+    - compatible
+        The string "brcm,brcmstb-smpboot".
+
+    - syscon-cpu
+        A phandle / integer array property which lets the BSP know the location
+        of certain CPU power-on registers.
+
+        The layout of the property is as follows:
+            o a phandle to the "hif_cpubiuctrl" syscon node
+            o offset to the base CPU power zone register
+            o offset to the base CPU reset register
+
+    - syscon-cont
+        A phandle pointing to the syscon node which describes the CPU boot
+        continuation registers.
+            o a phandle to the "hif_continuation" syscon node
+
+example:
+    smpboot {
+        compatible = "brcm,brcmstb-smpboot";
+        syscon-cpu = <&hif_cpubiuctrl 0x88 0x178>;
+        syscon-cont = <&hif_continuation>;
+    };
+
+reboot
+-------
+Required properties
+
+    - compatible
+        The string property "brcm,brcmstb-reboot".
+
+    - syscon
+        A phandle / integer array that points to the syscon node which describes
+        the general system reset registers.
+            o a phandle to "sun_top_ctrl"
+            o offset to the "reset source enable" register
+            o offset to the "software master reset" register
+
+example:
+    reboot {
+        compatible = "brcm,brcmstb-reboot";
+        syscon = <&sun_top_ctrl 0x304 0x308>;
+    };
-- 
1.7.1
