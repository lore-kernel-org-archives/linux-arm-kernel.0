From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 1 Apr 2015 17:17:37 +0530
Subject: [RESEND PATCH 7/8] dts/ls2085a: Add DTS support for LS2085a QDS & RDB
 boards
In-Reply-To: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1427888858-29636-8-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the LS2085a DTS files for QDS and RDB boards
which support the LS2085a SoC.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2085a-qds.dts |  187 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2085a-rdb.dts |  123 ++++++++++++++
 2 files changed, 310 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls2085a-qds.dts
new file mode 100644
index 0000000..38b62d7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a-qds.dts
@@ -0,0 +1,187 @@
+/*
+ * Device Tree file for Freescale LS2085a QDS Board.
+ *
+ * Copyright (C) 2015, Freescale Semiconductor
+ *
+ * Bhupesh Sharma <bhupesh.sharma@freescale.com>
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
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+/dts-v1/;
+
+/include/ "fsl-ls2085a.dtsi"
+
+/ {
+	model = "Freescale Layerscape 2085a QDS Board";
+	compatible = "fsl,ls2085a-qds", "fsl,ls2085a";
+};
+
+&esdhc {
+	status = "okay";
+};
+
+&ifc {
+	status = "okay";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0x0 0x0 0x5 0x80000000 0x08000000>;
+
+	nor at 0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x8000000>;
+		bank-width = <2>;
+		device-width = <1>;
+	};
+};
+
+&ftm0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	pca9547 at 77 {
+		compatible = "nxp,pca9547";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x00>;
+			rtc at 68 {
+				compatible = "dallas,ds3232";
+				reg = <0x68>;
+			};
+		};
+
+		i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x02>;
+
+			ina220 at 40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <500>;
+			};
+
+			ina220 at 41 {
+				compatible = "ti,ina220";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+		};
+
+		i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			adt7481 at 4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&dspi {
+	status = "okay";
+	dflash0: n25q128a {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p80";
+		spi-max-frequency = <3000000>;
+		reg = <0>;
+	};
+	dflash1: sst25wf040b {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p80";
+		spi-max-frequency = <3000000>;
+		reg = <1>;
+	};
+	dflash2: en25s64 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p80";
+		spi-max-frequency = <3000000>;
+		reg = <2>;
+	};
+};
+
+&qspi {
+	status = "okay";
+	qflash0: s25fl008k {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p80";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2085a-rdb.dts
new file mode 100644
index 0000000..43eef18
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a-rdb.dts
@@ -0,0 +1,123 @@
+/*
+ * Device Tree file for Freescale LS2085a RDB Board.
+ *
+ * Copyright (C) 2015, Freescale Semiconductor
+ *
+ * Bhupesh Sharma <bhupesh.sharma@freescale.com>
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
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+/dts-v1/;
+
+/include/ "fsl-ls2085a.dtsi"
+
+/ {
+	model = "Freescale Layerscape 2085a RDB Board";
+	compatible = "fsl,ls2085a-rdb", "fsl,ls2085a";
+};
+
+&esdhc {
+	status = "okay";
+};
+
+&ifc {
+	status = "okay";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0x0 0x0 0x5 0x80000000 0x08000000>;
+
+	nor at 0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x8000000>;
+		bank-width = <2>;
+		device-width = <1>;
+	};
+
+};
+
+&ftm0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&dspi {
+	status = "okay";
+	dflash0: n25q512a {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p80";
+		spi-max-frequency = <3000000>;
+		reg = <0>;
+	};
+};
+
+&qspi {
+	status = "disabled";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
-- 
1.7.9.5
