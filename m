From: majun258@huawei.com (MaJun)
Date: Thu, 17 Mar 2016 16:34:00 +0800
Subject: [PATCH v3 1/2] irqchip/mbigen:Change the mbigen node definition in dt
 binding file
In-Reply-To: <1458203641-17172-1-git-send-email-majun258@huawei.com>
References: <1458203641-17172-1-git-send-email-majun258@huawei.com>
Message-ID: <1458203641-17172-2-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

For mbigen module, there is a special case that more than one mbigen
device nodes use the same reg definition in DTS when these devices
exist in the same mbigen hardware module.

In current mbigen driver, these mbigen devices definition as below:
mbigen_dev1:intc_dev1 {
	...
	reg = <0x0 0xc0080000 0x0 0x10000>;
	...
};

mbigen_dev2:intc_dev2 {
	...
	reg = <0x0 0xc0080000 0x0 0x10000>;
	...
};

On this case, devm_ioremap_resource() returns fail with info
"can't request region for resource" because of memory region check.

To fix this problem, the mbigen node definition and
structure are changed as Mark Rutland suggested in v1 patch[1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/403691.html

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 .../interrupt-controller/hisilicon,mbigen-v2.txt   |   22 +++++++++++++++----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
index 720f7c9..3b2f4c4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
@@ -21,6 +21,8 @@ Mbigen main node required properties:
 - reg: Specifies the base physical address and size of the Mbigen
   registers.
 
+Mbigen sub node required properties:
+------------------------------------------
 - interrupt controller: Identifies the node as an interrupt controller
 
 - msi-parent: Specifies the MSI controller this mbigen use.
@@ -45,13 +47,23 @@ Mbigen main node required properties:
 
 Examples:
 
-	mbigen_device_gmac:intc {
+	mbigen_chip_dsa {
 			compatible = "hisilicon,mbigen-v2";
 			reg = <0x0 0xc0080000 0x0 0x10000>;
-			interrupt-controller;
-			msi-parent = <&its_dsa 0x40b1c>;
-			num-pins = <9>;
-			#interrupt-cells = <2>;
+
+			mbigen_gmac:intc_gmac {
+				interrupt-controller;
+				msi-parent = <&its_dsa 0x40b1c>;
+				num-pins = <9>;
+				#interrupt-cells = <2>;
+			};
+
+			mbigen_i2c:intc_i2c {
+				interrupt-controller;
+				msi-parent = <&its_dsa 0x40b0e>;
+				num-pins = <2>;
+				#interrupt-cells = <2>;
+			};
 	};
 
 Devices connect to mbigen required properties:
-- 
1.7.1
