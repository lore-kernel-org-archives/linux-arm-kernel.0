From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 17 Jan 2017 11:17:35 +0000
Subject: [PATCH] arm64: dts: marvell: Add DT for MACCHIATOBin board
Message-ID: <E1cTRlf-0005dY-L8@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a cut-down version of the DTS file for the community board
MACCHIATOBin from SolidRun based on Marvell Armada 8040 SoC to suit
the current mainlined Armada 8040 state.

This brings support for mainly SATA, SPI flash and UART.  The USB
descriptions are included but are not tested in this form due to the
lack of mainline GPIO.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
Acked-by: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
This is derived from a version from Marvell, but severly cut down,
cleaned up, re-organised and added to to suit mainline kernels.  The
only common parts are the header comment, top level model and compatible
strings, the rest has been changed by me in some way.

I'm planning to submit further patches as the mainline Armada 8k support
moves forward.

This is submitted with Rabeeh's confirmation and ack that he (as Solid
Run's CTO) is happy for this to be upstreamed.

Note - the license text is rather "interesting" but matches that which
is already on other ARM64 Marvell-based platforms.  I suspect someone at
Free Electrons needs to talk to Marvell to correct the "library" thing,
and clear up the "GPLv2" vs "GPLv2+" confusion in there.

 arch/arm64/boot/dts/marvell/Makefile              |   1 +
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 138 ++++++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 1690883b931a..3e6ce6c15a74 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
new file mode 100644
index 000000000000..b7298429ffa1
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2016 Marvell Technology Group Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPLv2 or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * Device Tree file for MACCHIATOBin Armada 8040 community board platform
+ */
+
+#include "armada-8040.dtsi"
+
+/ {
+	model = "Marvell 8040 MACHIATOBin";
+	compatible = "marvell,armada8040-mcbin", "marvell,armada8040",
+			"marvell,armada-ap806-quad", "marvell,armada-ap806";
+
+	memory at 00000000 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	/* Regulator labels correspond with schematics */
+	v_3_3: regulator-3-3v {
+		compatible = "regulator-fixed";
+		regulator-name = "v_3_3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		status = "okay";
+	};
+
+	v_vddo_h: regulator-1-8v {
+		compatible = "regulator-fixed";
+		regulator-name = "v_vddo_h";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		status = "okay";
+	};
+
+	v_5v0_usb3_hst_vbus: regulator-usb3-vbus0 {
+		compatible = "regulator-fixed";
+		regulator-name = "v_5v0_usb3_hst_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		/* actually GPIO controlled, but 8k has no GPIO support yet */
+		regulator-always-on;
+		status = "okay";
+	};
+
+	usb3h0_phy: usb3_phy0 {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&v_5v0_usb3_hst_vbus>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&cpm_i2c0 {
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&cpm_sata0 {
+	/* CPM Lane 0 - U29 */
+	status = "okay";
+};
+
+&cpm_usb3_0 {
+	/* J38? - USB2.0 only */
+	status = "okay";
+};
+
+&cpm_usb3_1 {
+	/* J38? - USB2.0 only */
+	status = "okay";
+};
+
+&cps_sata0 {
+	/* CPS Lane 1 - U32 */
+	/* CPS Lane 3 - U31 */
+	status = "okay";
+};
+
+&cps_spi1 {
+	status = "okay";
+
+	spi-flash at 0 {
+		compatible = "st,w25q32";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+	};
+};
+
+&cps_usb3_0 {
+	/* CPS Lane 2 - CON7 */
+	usb-phy = <&usb3h0_phy>;
+	status = "okay";
+};
-- 
2.7.4
