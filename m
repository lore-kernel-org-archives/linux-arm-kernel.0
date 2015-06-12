From: majun258@huawei.com (Ma Jun)
Date: Fri, 12 Jun 2015 10:49:59 +0800
Subject: [PATCH v2 3/3] dt-binding:Documents the mbigen bindings
In-Reply-To: <1434077399-32200-1-git-send-email-majun258@huawei.com>
References: <1434077399-32200-1-git-send-email-majun258@huawei.com>
Message-ID: <1434077399-32200-4-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the mbigen msi interrupt controller bindings document

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 Documentation/devicetree/bindings/arm/mbigen.txt |   59 ++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt

diff --git a/Documentation/devicetree/bindings/arm/mbigen.txt b/Documentation/devicetree/bindings/arm/mbigen.txt
new file mode 100644
index 0000000..c7c261b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mbigen.txt
@@ -0,0 +1,59 @@
+Hisilicon mbigen device tree bindings.
+=======================================
+
+Mbigen means: message based interrupt generator.
+
+MBI is kind of msi interrupt only used on Non-PCI devices.
+
+To reduce the wired interrupt number connected to GIC,
+Hisilicon designed mbigen to collect and generate interrupt.
+
+
+Non-pci devices can connect to mbigen and gnerate the inteerrupt
+by wirtting ITS register.
+
+The mbigen and devices connect to mbigen have the following properties:
+
+
+Mbigen required properties:
+-------------------------------------------
+-compatible: Should be "hisilicon,mbi-gen"
+-msi-parent: should specified the ITS mbigen connected
+-interrupt controller: Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value is 2 for now.
+
+  The 1st cell is the interrupt number(Hwirq).This value depends on
+  the Soc design.
+
+  The 2nd cell is the interrupt trigger type, encoded as follows:
+		1 = edge triggered
+		4 = level triggered
+
+- reg: Specifies the base physical address and size of the ITS
+  registers.
+
+Examples:
+
+	mbigen_pa: interrupt-controller at 4c030000 {
+			compatible = "hisilicon,mbi-gen";
+			msi-parent = <&its_pa>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x4c030000 0x10000>;
+		};
+
+Device connect to mbigen required properties:
+----------------------------------------------------
+-interrupt-parent: Specifies the mbigen node which device connected.
+-interrupts:specifies the interrupt source.The first cell is hwirq num, the
+  second number is trigger type.
+
+Examples:
+	usb0: ehci at a1000000 {
+		compatible = "generic-ehci";
+		interrupt-parent = <&mbigen_pa>;
+		reg = <0xa1000000 0x10000>;
+		interrupts = <20 4>;
+	};
+
-- 
1.7.1
