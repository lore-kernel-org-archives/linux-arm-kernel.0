From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 10 Jul 2014 10:09:31 +0100
Subject: [PATCH v3+1 1/5] phy: miphy365x: Add Device Tree bindings for the
 MiPHY365x
In-Reply-To: <1404906074-31992-2-git-send-email-lee.jones@linaro.org>
References: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
 <1404906074-31992-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20140710090931.GA11948@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
devices. It has 2 ports which it can use for either; both SATA, both
PCIe or one of each in any configuration.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/Documentation/devicetree/bindings/phy/phy-miphy365x.txt b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
new file mode 100644
index 0000000..42c88088
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
@@ -0,0 +1,76 @@
+STMicroelectronics STi MIPHY365x PHY binding
+============================================
+
+This binding describes a miphy device that is used to control PHY hardware
+for SATA and PCIe.
+
+Required properties (controller (parent) node):
+- compatible    : Should be "st,miphy365x-phy"
+- st,syscfg     : Should be a phandle of the system configuration register group
+		  which contain the SATA, PCIe mode setting bits
+
+Required nodes	:  A sub-node is required for each channel the controller
+		   provides. Address range information including the usual
+		   'reg' and 'reg-names' properties are used inside these
+		   nodes to describe the controller's topology. These nodes
+		   are translated by the driver's .xlate() function.
+
+Required properties (port (child) node):
+- #phy-cells 	: Should be 1 (See second example)
+		  Cell after port phandle is device type from:
+			- MIPHY_TYPE_SATA
+			- MIPHY_TYPE_PCI
+- reg        	: Address and length of register sets for each device in
+		  "reg-names"
+- reg-names     : The names of the register addresses corresponding to the
+		  registers filled in "reg":
+			- sata:   For SATA devices
+			- pcie:   For PCIe devices
+			- syscfg: To specify the syscfg based config register
+
+Optional properties (port (child) node):
+- st,sata-gen	     :	Generation of locally attached SATA IP. Expected values
+			are {1,2,3). If not supplied generation 1 hardware will
+			be expected
+- st,pcie-tx-pol-inv :	Bool property to invert the polarity PCIe Tx (Txn/Txp)
+- st,sata-tx-pol-inv :	Bool property to invert the polarity SATA Tx (Txn/Txp)
+
+Example:
+
+	miphy365x_phy: miphy365x at fe382000 {
+		compatible      = "st,miphy365x-phy";
+		st,syscfg  	= <&syscfg_rear>;
+		#address-cells	= <1>;
+		#size-cells	= <1>;
+		ranges;
+
+		phy_port0: port at fe382000 {
+			reg = <0xfe382000 0x100>, <0xfe394000 0x100>, <0x824 0x4>;
+			reg-names = "sata", "pcie", "syscfg";
+			#phy-cells = <1>;
+			st,sata-gen = <3>;
+		};
+
+		phy_port1: port at fe38a000 {
+			reg = <0xfe38a000 0x100>, <0xfe804000 0x100>, <0x828 0x4>;;
+			reg-names = "sata", "pcie", "syscfg";
+			#phy-cells = <1>;
+			st,pcie-tx-pol-inv;
+		};
+	};
+
+Specifying phy control of devices
+=================================
+
+Device nodes should specify the configuration required in their "phys"
+property, containing a phandle to the phy port node and a device type.
+
+Example:
+
+#include <dt-bindings/phy/phy-miphy365x.h>
+
+	sata0: sata at fe380000 {
+		...
+		phys	  = <&phy_port0 MIPHY_TYPE_SATA>;
+		...
+	};
