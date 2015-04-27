From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 27 Apr 2015 15:37:21 -0700
Subject: [PATCH V7 8/9] usb: Add NVIDIA Tegra xHCI controller binding
In-Reply-To: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
References: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
Message-ID: <1430174242-29465-9-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-tree binding documentation for the xHCI controller present
on Tegra124 and later SoCs.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
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
 .../bindings/usb/nvidia,tegra124-xhci.txt          | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt
new file mode 100644
index 0000000..5c980b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt
@@ -0,0 +1,90 @@
+NVIDIA Tegra xHCI controller
+============================
+
+The Tegra xHCI controller supports both USB2 and USB3 interfaces exposed
+by the Tegra XUSB pad controller.
+
+Required properties:
+--------------------
+ - compatible: For Tegra124, must contain "nvidia,tegra124-xhci".
+   Otherwise, must contain '"nvidia,<chip>-xhci", "nvidia,tegra124-xhci"'
+   where <chip> is tegra132.
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
+ - mboxes: Must contain an entry for the XUSB mailbox channel.
+   See ../mailbox/mailbox.txt for details.
+ - mbox-names: Must include the following entries:
+   - xusb
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
+	usb-host {
+		compatible = "nvidia,tegra124-xhci";
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
+		mboxes = <&xusb_mbox>;
+		mbox-names = "xusb";
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
2.2.0.rc0.207.ga3a616c
