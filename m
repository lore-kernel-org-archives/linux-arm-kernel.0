From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Feb 2014 16:03:02 +0000
Subject: [PATCH 1/4] phy: miphy365x: Add Device Tree bindings for the MiPHY365x
Message-ID: <1392220985-28189-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
devices. It has 2 ports which it can use for either; both SATA, both
PCIe or one of each in any configuration.

Cc: devicetree at vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/phy/phy-miphy365x.txt      | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-miphy365x.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-miphy365x.txt b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
new file mode 100644
index 0000000..fdfa7ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
@@ -0,0 +1,43 @@
+STMicroelectronics STi MIPHY365x PHY binding
+============================================
+
+This binding describes a miphy device that is used to control PHY hardware
+for SATA and PCIe.
+
+Required properties:
+- compatible: Should be "st,miphy365x-phy"
+- #phy-cells: Should be 2 (See example)
+- reg:	      Address and length of the register set for the device
+- reg-names:  The names of the register addresses corresponding to the
+	      registers filled in "reg".
+- st,syscfg : Should be a phandle of the syscfg node.
+
+Example:
+
+	miphy365x_phy: miphy365x at 0 {
+		compatible = "st,miphy365x-phy";
+		#phy-cells = <1>;
+		reg =	<0xfe382000 0x100>,
+			<0xfe38a000 0x100>,
+			<0xfe394000 0x100>,
+			<0xfe804000 0x100>;
+		reg-names = "sata0", "sata1", "pcie0", "pcie1";
+		st,syscfg= <&syscfg_rear>;
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
