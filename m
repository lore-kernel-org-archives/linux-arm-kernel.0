From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 26 Nov 2016 15:56:34 +0100
Subject: [PATCH 4/5] ARM64: dts: meson-gxm: add GXM specific USB configuration
In-Reply-To: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
References: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161126145635.24488-5-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB configuration on GXM is slightly different than on GXL. On GXM
the dwc2 controller is limited (via GHWCFG2_OP_MODE_MASK) to "device
mode".
The dwc3 controller's internal hub has 3 ports (instead of 2 on GXL)
enabled. It's hardware configuration limits it (via DWC3_GHWPARAMS0)
to host mode only.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index 2b1d276e..0a6b224 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -121,3 +121,13 @@
 	clock-indices = <0 1>;
 	clock-output-names = "vbig", "vlittle";
 };
+
+&usb3_phy0 {
+	/* dwc3 on GXM enables 3 USB ports on the internal hub */
+	phys = <&usb2_phys 0>, <&usb2_phys 1>, <&usb2_phys 2>;
+};
+
+&usb1 {
+	/* the dwc2 hardware configuration on GXM only allows device mode */
+	dr_mode = "device";
+};
-- 
2.10.2
