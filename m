From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 17 Jun 2014 23:16:14 -0700
Subject: [PATCH v1 3/9] of: Update Tegra XUSB pad controller binding for USB
In-Reply-To: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
Message-ID: <1403072180-4944-4-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new bindings used for USB support by the Tegra XUSB pad controller.
This includes additional PHY types, USB-specific pinconfig properties, etc.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 .../pinctrl/nvidia,tegra124-xusb-padctl.txt        | 53 ++++++++++++++++++++--
 include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h   |  7 +++
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
index 2f9c0bd..6181019 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
@@ -21,6 +21,12 @@ Required properties:
   - padctl
 - #phy-cells: Should be 1. The specifier is the index of the PHY to reference.
   See <dt-bindings/pinctrl/pinctrl-tegra-xusb.h> for the list of valid values.
+- nvidia,xusb-mbox: Handle to the Tegra XUSB mailbox node.
+
+Optional properties:
+-------------------
+- vbus-otg-{0,1,2}-supply: VBUS regulator for the corresponding UTMI pad.
+- vddio-hsic-supply: VDDIO regulator for the HSIC pads.
 
 Lane muxing:
 ------------
@@ -50,6 +56,16 @@ Optional properties:
   pin or group should be assigned to. Valid values for function names are
   listed below.
 - nvidia,iddq: Enables IDDQ mode of the lane. (0: no, 1: yes)
+- nvidia,usb3-port-num: USB3 port (0 or 1) to which the lane is mapped.
+- nvidia,usb2-port-num: USB2 port (0, 1, or 2) to which the lane is mapped.
+- nvidia,hsic-strobe-trim: HSIC strobe trimmer value.
+- nvidia,hsic-rx-strobe-trim: HSIC RX strobe trimmer value.
+- nvidia,hsic-rx-data-trim: HSIC RX data trimmer value.
+- nvidia,hsic-tx-rtune-n: HSIC TX RTUNEN value.
+- nvidia,hsic-tx-rtune-p: HSIC TX RTUNEP value.
+- nvidia,hsic-tx-slew-n: HSIC TX SLEWN value.
+- nvidia,hsic-tx-slew-p: HSIC TX SLEWP value.
+- nvidia,hsic-auto-term: Enables HSIC AUTO_TERM. (0: no, 1: yes)
 
 Note that not all of these properties are valid for all lanes. Lanes can be
 divided into three groups:
@@ -58,18 +74,25 @@ divided into three groups:
 
     Valid functions for this group are: "snps", "xusb", "uart", "rsvd".
 
-    The nvidia,iddq property does not apply to this group.
+    The nvidia,iddq, nvidia,usb3-port-num, nvidia,usb2-port-num, and
+    nvidia,hsic-* properties do not apply to this group.
 
   - ulpi-0, hsic-0, hsic-1:
 
     Valid functions for this group are: "snps", "xusb".
 
-    The nvidia,iddq property does not apply to this group.
+    The nvidia,iddq, nvidia,usb3-port-num, and nvidia,usb2-port-num
+    properties do not apply to this group.  The nvidia,hsic-*  properties
+    apply only to the pins hsic-{0,1} when the function is xusb.
 
   - pcie-0, pcie-1, pcie-2, pcie-3, pcie-4, sata-0:
 
     Valid functions for this group are: "pcie", "usb3", "sata", "rsvd".
 
+    The nvidia,usb3-port-num and nvidia,usb2-port-num properties only
+    apply and are required when the function is usb3.  The nvidia,hsic-*
+    properties do not apply to this group.
+
 
 Example:
 ========
@@ -83,6 +106,8 @@ SoC file extract:
 		resets = <&tegra_car 142>;
 		reset-names = "padctl";
 
+		nvidia,xusb-mbox = <&mbox>;
+
 		#phy-cells = <1>;
 	};
 
@@ -100,15 +125,35 @@ Board file extract:
 
 	...
 
+	usb at 0,70090000 {
+		...
+
+		phys = <&padctl 5>, <&padctl 6>, <&padctl 7>;
+		phy-names = "utmi-1", "utmi-2", "usb3-0";
+
+		...
+	}
+
+	...
+
 	padctl: padctl at 0,7009f000 {
 		pinctrl-0 = <&padctl_default>;
 		pinctrl-names = "default";
 
+		vbus-otg-2-supply = <&vdd_usb3_vbus>;
+
 		padctl_default: pinmux {
-			usb3 {
-				nvidia,lanes = "pcie-0", "pcie-1";
+			otg {
+				nvidia,lanes = "otg-1", "otg-2";
+				nvidia,function = "xusb";
+			};
+
+			usb3p0 {
+				nvidia,lanes = "pcie-0";
 				nvidia,function = "usb3";
 				nvidia,iddq = <0>;
+				nvidia,usb3-port-num = <0>;
+				nvidia,usb2-port-num = <2>;
 			};
 
 			pcie {
diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h b/include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h
index 914d56d..c83a4d4 100644
--- a/include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h
+++ b/include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h
@@ -3,5 +3,12 @@
 
 #define TEGRA_XUSB_PADCTL_PCIE 0
 #define TEGRA_XUSB_PADCTL_SATA 1
+#define TEGRA_XUSB_PADCTL_USB3_P0 2
+#define TEGRA_XUSB_PADCTL_USB3_P1 3
+#define TEGRA_XUSB_PADCTL_UTMI_P0 4
+#define TEGRA_XUSB_PADCTL_UTMI_P1 5
+#define TEGRA_XUSB_PADCTL_UTMI_P2 6
+#define TEGRA_XUSB_PADCTL_HSIC_P0 7
+#define TEGRA_XUSB_PADCTL_HSIC_P1 8
 
 #endif /* _DT_BINDINGS_PINCTRL_TEGRA_XUSB_H */
-- 
2.0.0.526.g5318336
