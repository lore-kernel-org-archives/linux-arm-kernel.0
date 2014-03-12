From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Mar 2014 13:14:53 +0000
Subject: [PATCH 1/4] phy: miphy365x: Add Device Tree bindings for the MiPHY365x
In-Reply-To: <1394630096-28564-1-git-send-email-lee.jones@linaro.org>
References: <1394630096-28564-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1394630096-28564-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
devices. It has 2 ports which it can use for either; both SATA, both
PCIe or one of each in any configuration.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/phy/phy-miphy365x.txt      | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-miphy365x.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-miphy365x.txt b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
new file mode 100644
index 0000000..cb39de1
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
@@ -0,0 +1,62 @@
+STMicroelectronics STi MIPHY365x PHY binding
+============================================
+
+This binding describes a miphy device that is used to control PHY hardware
+for SATA and PCIe.
+
+Required properties:
+- compatible :	Should be "st,miphy365x-phy"
+- #phy-cells :	Should be 2 (See second example)
+		First cell is the port number from:
+			- MIPHY_PORT_0
+			- MIPHY_PORT_1
+		Second cell is device type from:
+			- MIPHY_TYPE_SATA
+			- MIPHY_TYPE_PCI
+- reg       :	Address and length of register sets for each device in
+		"reg-names"
+- reg-names : 	The names of the register addresses corresponding to the
+		registers filled in "reg", from:
+			- sata0: For SATA port 0 registers
+			- sata1: For SATA port 1 registers
+			- pcie0: For PCIE port 0 registers
+			- pcie1: For PCIE port 1 registers
+- st,syscfg : 	Should be a phandle of the system configuration register group
+		which contain the SATA, PCIe mode setting bits
+
+Optional properties:
+- st,sata-gen	     :	Generation of locally attached SATA IP. Expected values
+			are {1,2,3). If not supplied generation 1 hardware will
+			be expected
+- st,pcie-tx-pol-inv :	Bool property to invert the polarity PCIe Tx (Txn/Txp)
+- st,sata-tx-pol-inv :	Bool property to invert the polarity SATA Tx (Txn/Txp)
+
+Example:
+
+	miphy365x_phy: miphy365x at fe382000 {
+		compatible = "st,miphy365x-phy";
+		#phy-cells = <2>;
+		reg =	<0xfe382000 0x100>,
+			<0xfe38a000 0x100>,
+			<0xfe394000 0x100>,
+			<0xfe804000 0x100>;
+		reg-names = "sata0", "sata1", "pcie0", "pcie1";
+		st,syscfg = <&syscfg_rear>;
+	};
+
+Specifying phy control of devices
+=================================
+
+Device nodes should specify the configuration required in their "phys"
+property, containing a phandle to the miphy device node, a port number
+and a device type.
+
+Example:
+
+#include <dt-bindings/phy/phy-miphy365x.h>
+
+	sata0: sata at fe380000 {
+		...
+		phys	  = <&miphy365x_phy MIPHY_PORT_0 MIPHY_TYPE_SATA>;
+		...
+	};
-- 
1.8.3.2
