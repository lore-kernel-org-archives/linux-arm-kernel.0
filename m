From: majun258@huawei.com (MaJun)
Date: Wed, 21 Oct 2015 14:04:29 +0800
Subject: [PATCH v7 1/4] dt-binding:Documents of the mbigen bindings
In-Reply-To: <1445407472-6120-1-git-send-email-majun258@huawei.com>
References: <1445407472-6120-1-git-send-email-majun258@huawei.com>
Message-ID: <1445407472-6120-2-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

Add the mbigen msi interrupt controller bindings document.

This patch based on Mark Rutland's patch
https://lkml.org/lkml/2015/7/23/558

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 Documentation/devicetree/bindings/arm/mbigen.txt |   63 ++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt

diff --git a/Documentation/devicetree/bindings/arm/mbigen.txt b/Documentation/devicetree/bindings/arm/mbigen.txt
new file mode 100644
index 0000000..eb9a7fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mbigen.txt
@@ -0,0 +1,63 @@
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
+Non-pci devices can connect to mbigen and generate the
+interrupt by writing ITS register.
+
+The mbigen chip and devices connect to mbigen have the following properties:
+
+Mbigen main node required properties:
+-------------------------------------------
+- compatible: Should be "hisilicon,mbigen-v2"
+- reg: Specifies the base physical address and size of the Mbigen
+  registers.
+- interrupt controller: Identifies the node as an interrupt controller
+- msi-parent: This property has two cells.
+	The 1st cell specifies the ITS this device connected.
+	The 2nd cell specifies the device id.
+- nr-msis:Specifies the total number of interrupt this device has.
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value is 2 now.
+
+  The 1st cell is global hardware pin number of the interrupt.
+		This value depends on the Soc design.
+  The 2nd cell is the interrupt trigger type.
+
+Examples:
+
+ 	mbigen_device_gmac:intc {
+			compatible = "hisilicon,mbigen-v2";
+			reg = <0x0 0xc0080000 0x0 0x10000>;
+			interrupt-controller;
+			msi-parent = <&its_dsa 0x40b1c>;
+			num-msis = <9>;
+			#interrupt-cells = <2>;
+ 	};
+
+Devices connect to mbigen required properties:
+----------------------------------------------------
+-interrupt-parent: Specifies the mbigen device node which device connected.
+-interrupts:specifies the interrupt source.
+  The 1st cell is global hardware pin number of the interrupt.
+		This value depends on the Soc design.
+  The 2nd cell is the interrupt trigger type
+
+Examples:
+	gmac0: ethernet at c2080000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0xc2080000 0 0x20000>,
+		      <0 0xc0000000 0 0x1000>;
+		interrupt-parent  = <&mbigen_device_gmac>;
+		interrupts =	<656 1>,
+				<657 1>;
+	};
+
-- 
1.7.1
