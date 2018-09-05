From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Wed, 5 Sep 2018 22:12:27 +0530
Subject: [PATCH v3 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
In-Reply-To: <1536165747-6405-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536165747-6405-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Message-ID: <1536165747-6405-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the document describing dt bindings for ZynqMP
phy. ZynqMP SOC has a High Speed Processing System Gigabit
Transceiver which provides PHY capabilties to USB, SATA,
PCIE, Display Port and Ehernet SGMII controllers.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v3:
	1. Corrected the Documentation as suggested by Vivek Gautam

 Changes in v2:
	1. None
 .../devicetree/bindings/phy/phy-zynqmp.txt         | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-zynqmp.txt b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
new file mode 100644
index 0000000..65007c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
@@ -0,0 +1,104 @@
+Xilinx ZynqMP PHY binding
+
+This binding describes a ZynqMP PHY device that is used to control ZynqMP
+High Speed Gigabit Transceiver(GT). ZynqMP PS GTR provides four lanes
+and are used by USB, SATA, PCIE, Display port and Ethernet SGMMI controllers.
+
+Phy provider node
+=================
+
+Required properties:
+- compatible	: Can be "xlnx,zynqmp-psgtr-v1.1" or "xlnx,zynqmp-psgtr"
+
+- reg           : Address and length of register sets for each device in
+                  "reg-names"
+
+- reg-names     : The names of the register addresses corresponding to the
+		  registers filled in "reg":
+			- serdes: SERDES block register set
+			- siou: SIOU block register set
+
+Optional properties:
+- xlnx,tx_termination_fix : Include this for fixing functional issue with the
+		  TX termination resistance in GT, which can be out of spec for
+		  the XCZU9EG silicon version. This property is not required for
+		  "xlnx,zynqmp-psgtr-v1.1"
+
+Required nodes	:  A sub-node is required for each lane the controller
+		   provides.
+
+Phy sub-nodes
+=============
+
+Required properties:
+lane0:
+- #phy-cells	: Should be 4
+
+lane1:
+- #phy-cells	: Should be 4
+
+lane2:
+- #phy-cells	: Should be 4
+
+lane3:
+- #phy-cells	: Should be 4
+
+Example:
+	zynqmp_phy: phy at fd400000 {
+		compatible = "xlnx,zynqmp-psgtr-v1.1";
+		status = "okay";
+		reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>;
+		reg-names = "serdes", "siou";
+
+		lane0: lane at 0 {
+			#phy-cells = <4>;
+		};
+		lane1: lane at 1 {
+			#phy-cells = <4>;
+		};
+		lane2: lane at 2 {
+			#phy-cells = <4>;
+		};
+		lane3: lane at 3 {
+			#phy-cells = <4>;
+		};
+	};
+
+Specifying phy control of devices
+=================================
+
+Device nodes should specify the configuration required in their "phys"
+property, containing a phandle to the phy port node and a device type.
+
+phys = <PHANDLE CONTROLLER_TYPE CONTROLLER_INSTANCE LANE_NUM LANE_FREQ>;
+
+PHANDLE                 = &lane0 or &lane1 or &lane2 or &lane3
+CONTROLLER_TYPE         = PHY_TYPE_PCIE or PHY_TYPE_SATA or PHY_TYPE_USB
+			  or PHY_TYPE_DP or PHY_TYPE_SGMII
+CONTROLLER_INSTANCE     = Depends on controller type used, can be any of
+				PHY_TYPE_PCIE : 0 or 1 or 2 or 3
+				PHY_TYPE_SATA : 0 or 1
+				PHY_TYPE_USB  : 0 or 1
+				PHY_TYPE_DP   : 0 or 1
+				PHY_TYPE_SGMII: 0 or 1 or 2 or 3
+LANE_NUM                = Depends on which lane clock is used as ref clk, can be
+			  0 or 1 or 2 or 3
+LANE_FREQ               = Frequency that controller can operate, can be any of
+			  19.2Mhz,20Mhz,24Mhz,26Mhz,27Mhz,28.4Mhz,40Mhz,52Mhz,
+			  100Mhz,108Mhz,125Mhz,135Mhz,150Mhz
+
+Example:
+
+#include <dt-bindings/phy/phy.h>
+
+	usb at fe200000 {
+		...
+		phys	  = <&lane2 PHY_TYPE_USB3 0 2 2600000>;
+		...
+	};
+
+	ahci at fd0c0000 {
+		...
+		phys	  = <&lane3 PHY_TYPE_SATA 1 1 125000000>;
+		...
+	};
-- 
2.1.1
