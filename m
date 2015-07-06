From: majun258@huawei.com (Ma Jun)
Date: Mon, 6 Jul 2015 15:09:08 +0800
Subject: [PATCH v3 3/3] dt-binding:Documents the mbigen bindings
In-Reply-To: <1436166548-34920-1-git-send-email-majun258@huawei.com>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
Message-ID: <1436166548-34920-4-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the mbigen msi interrupt controller bindings document

Change in v3:
---Change the compatible string
---Change the interrupt cells definition.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 Documentation/devicetree/bindings/arm/mbigen.txt |   65 ++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt

diff --git a/Documentation/devicetree/bindings/arm/mbigen.txt b/Documentation/devicetree/bindings/arm/mbigen.txt
new file mode 100644
index 0000000..cf92ef8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mbigen.txt
@@ -0,0 +1,65 @@
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
+-compatible: Should be "hisilicon,mbigen-v2"
+-msi-parent: should specified the ITS mbigen connected
+-interrupt controller: Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value is 5 now.
+
+  The 1st cell is the device id.
+  The 2nd cell is the totall interrupt number of this device
+  The 3rd cell is the hardware pin number of the interrupt.
+  This value depends on the Soc design.
+  The 4th cell is the mbigen node number. This value should refer to the
+  vendor soc specification.
+  The 5th cell is the interrupt trigger type, encoded as follows:
+		1 = edge triggered
+		4 = level triggered
+
+- reg: Specifies the base physical address and size of the ITS
+  registers.
+
+Examples:
+
+		mbigen_dsa: interrupt-controller at c0080000 {
+			compatible = "hisilicon,mbigen-v2";
+			msi-parent = <&its_dsa>;
+			interrupt-controller;
+			#interrupt-cells = <5>;
+			reg = <0xc0080000 0x10000>;
+		};
+
+Device connect to mbigen required properties:
+----------------------------------------------------
+-interrupt-parent: Specifies the mbigen node which device connected.
+-interrupts:specifies the interrupt source.The first cell is hwirq num, the
+  second number is trigger type.
+
+Examples:
+	smmu_dsa {
+		compatible = "arm,smmu-v3";
+		reg = <0x0 0xc0040000 0x0 0x20000>;
+		interrupt-parent  = <&mbigen_dsa>;
+		interrupts = <0x40b20 3 78 6 1>,
+				<0x40b20 3 79 6 1>,
+				<0x40b20 3 80 6 1>;
+		smmu-cb-memtype = <0x0 0x1>;
+	};
+
-- 
1.7.1
