From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  6 Oct 2015 13:01:49 -0600
Subject: [PATCH V9] dt: add NVIDIA Tegra XUSB controller binding
Message-ID: <1444158109-1590-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Add device-tree binding documentation for the XUSB (xHCI) controller
present on Tegra124 and later SoCs.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
[swarren, combined separate MFD, mailbox, XHCI bindings into one node]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Changes from v8:
 - Combined the separate MFD, mailbox, and XHCI bindings into one; there
   is a single HW module, and so there should be a single DT node to
   represent it. Any Linux-internal driver structure should not influence
   the binding structure. This included squashing the various reg and
   interrupt resources that were previously in the separate modules into
   one list.
 - Used lists to document the compatible, reg, and interrupts properties.
 - Renamed the primary binding from xhci to xusb to reflect the name of
   the overall module.
Changes from v7:
 - Added back non-shared reg/interrupts properties.
Changes from v6:
 - Removed XUSB_DEV related clocks/resets.  They will be consumed by
   a separate driver and binding.
 - Removed reg/interrupts properties.
No changes from v5.
Changes from v4:
 - Updated regulator names, as suggested by Thierry.
No changes from v3.
Changes from v2:
 - Added mbox-names property.
Changes from v1:
 - Updated to use common mailbox bindings.
 - Added remaining XUSB-related clocks and resets.
 - Updated list of power supplies to be more accurate wrt to the hardware.
---
 .../bindings/usb/nvidia,tegra124-xusb.txt          | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
new file mode 100644
index 000000000000..f8de8d49602e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
@@ -0,0 +1,96 @@
+NVIDIA Tegra XUSB (XHCI) controller
+===================================
+
+The Tegra XUSB controller supports both USB2 and USB3 interfaces exposed
+by the Tegra XUSB pad controller.
+
+Required properties:
+--------------------
+ - compatible: Valid options are:
+    - Tegra124: "nvidia,tegra124-xusb".
+    - Tegra132: "nvidia,tegra132-xusb", "nvidia,tegra124-xusb".
+ - reg: Must contain the following entries, in the following order:
+    - The xHCI host registers.
+    - The IPFS registers.
+    - The FPCI registers.
+ - interrupts: Must contain the following entries, in the following order:
+    - The xHCI host interrupt
+    - The XUSB mailbox interrupt.
+ - clocks: Must contain an entry for each entry in clock-names.
+   See ../clock/clock-bindings.txt for details.
+ - clock-names: Must include the following entries:
+    - xusb_host
+    - xusb_host_src
+    - xusb_falcon_src
+    - xusb_ss
+    - xusb_ss_src
+    - xusb_ss_div2
+    - xusb_hs_src
+    - xusb_fs_src
+    - pll_u_480m
+    - clk_m
+    - pll_e
+ - resets: Must contain an entry for each entry in reset-names.
+   See ../reset/reset.txt for details.
+ - reset-names: Must include the following entries:
+   - xusb_host
+   - xusb_ss
+   - xusb_src
+   Note that xusb_src is the shared reset for xusb_{ss,hs,fs,falcon,host}_src.
+ - avddio-pex-supply: PCIe/USB3 analog logic power supply.  Must supply 1.05V.
+ - dvddio-pex-supply: PCIe/USB3 digital logic power supply.  Must supply 1.05V.
+ - avdd-usb-supply: USB controller power supply.  Must supply 3.3V.
+ - avdd-pll-utmip-supply: UTMI PLL power supply.  Must supply 1.8V.
+ - avdd-pll-erefe-supply: PLLE reference PLL power supply.  Must supply 1.05V.
+ - avdd-usb-ss-pll-supply: PCIe/USB3 PLL power supply.  Must supply 1.05V.
+ - hvdd-usb-ss-supply: High-voltage PCIe/USB3 power supply.  Must supply 3.3V.
+ - hvdd-usb-ss-pll-e-supply: High-voltage PLLE power supply.  Must supply 3.3V.
+
+Optional properties:
+--------------------
+ - phys: Must contain an entry for each entry in phy-names.
+   See ../phy/phy-bindings.txt for details.
+ - phy-names: Should include an entry for each PHY used by the controller.
+   Names must be of the form "<type>-<number>" where <type> is one of "utmi",
+   "hsic", or "usb3" and <number> is a 0-based index.  On Tegra124, there may
+   be up to 3 UTMI, 2 HSIC, and 2 USB3 PHYs.
+
+Example:
+--------
+	usb-host at 0,70090000 {
+		compatible = "nvidia,tegra124-xusb";
+		reg = <0x0 0x70090000 0x0 0x8000>,
+		      <0x0 0x70099000 0x0 0x1000>,
+		      <0x0 0x70098000 0x0 0x1000>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_XUSB_HOST>,
+			 <&tegra_car TEGRA124_CLK_XUSB_HOST_SRC>,
+			 <&tegra_car TEGRA124_CLK_XUSB_FALCON_SRC>,
+			 <&tegra_car TEGRA124_CLK_XUSB_SS>,
+			 <&tegra_car TEGRA124_CLK_XUSB_SS_DIV2>,
+			 <&tegra_car TEGRA124_CLK_XUSB_SS_SRC>,
+			 <&tegra_car TEGRA124_CLK_XUSB_HS_SRC>,
+			 <&tegra_car TEGRA124_CLK_XUSB_FS_SRC>,
+			 <&tegra_car TEGRA124_CLK_PLL_U_480M>,
+			 <&tegra_car TEGRA124_CLK_CLK_M>,
+			 <&tegra_car TEGRA124_CLK_PLL_E>;
+		clock-names = "xusb_host", "xusb_host_src", "xusb_falcon_src",
+			      "xusb_ss", "xusb_ss_div2", "xusb_ss_src",
+			      "xusb_hs_src", "xusb_fs_src", "pll_u_480m",
+			      "clk_m", "pll_e";
+		resets = <&tegra_car 89>, <&tegra_car 156>, <&tegra_car 143>;
+		reset-names = "xusb_host", "xusb_ss", "xusb_src";
+		phys = <&padctl TEGRA_XUSB_PADCTL_UTMI_P1>, /* mini-PCIe USB */
+		       <&padctl TEGRA_XUSB_PADCTL_UTMI_P2>, /* USB A */
+		       <&padctl TEGRA_XUSB_PADCTL_USB3_P0>; /* USB A */
+		phy-names = "utmi-1", "utmi-2", "usb3-0";
+		avddio-pex-supply = <&vdd_1v05_run>;
+		dvddio-pex-supply = <&vdd_1v05_run>;
+		avdd-usb-supply = <&vdd_3v3_lp0>;
+		avdd-pll-utmip-supply = <&vddio_1v8>;
+		avdd-pll-erefe-supply = <&avdd_1v05_run>;
+		avdd-usb-ss-pll-supply = <&vdd_1v05_run>;
+		hvdd-usb-ss-supply = <&vdd_3v3_lp0>;
+		hvdd-usb-ss-pll-e-supply = <&vdd_3v3_lp0>;
+	};
-- 
1.9.1
