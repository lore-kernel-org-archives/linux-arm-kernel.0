From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 13 Oct 2014 17:35:59 +0800
Subject: [PATCHv5 2/6] ARM: dts: Add initial LS1021A QDS board dts support
In-Reply-To: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
References: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1413192963-11153-3-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingchang Lu <b35083@freescale.com>

Signed-off-by: Alison Wang <alison.wang@freescale.com>
Signed-off-by: Chao Fu <B44548@freescale.com>
Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/ls1021a-qds.dts | 240 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 241 insertions(+)
 create mode 100644 arch/arm/boot/dts/ls1021a-qds.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8f12390..f89e5da 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -251,6 +251,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-tx6q-1110.dtb \
 	imx6sl-evk.dtb \
 	imx6sx-sdb.dtb \
+	ls1021a-qds.dtb \
 	vf610-colibri-eval-v3.dtb \
 	vf610-cosmic.dtb \
 	vf610-twr.dtb
diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
new file mode 100644
index 0000000..037e28a
--- /dev/null
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -0,0 +1,240 @@
+/*
+ * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
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
+#include "ls1021a.dtsi"
+
+/ {
+	model = "LS1021A QDS Board";
+
+	aliases {
+		enet0_rgmii_phy = &rgmii_phy1;
+		enet1_rgmii_phy = &rgmii_phy2;
+		enet2_rgmii_phy = &rgmii_phy3;
+		enet0_sgmii_phy = &sgmii_phy1c;
+		enet1_sgmii_phy = &sgmii_phy1d;
+	};
+};
+
+&dspi0 {
+	bus-num = <0>;
+	status = "okay";
+
+	dspiflash: at45db021d at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "atmel,at45db021d", "atmel,at45", "atmel,dataflash";
+		spi-max-frequency = <16000000>;
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	pca9547: mux at 77 {
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			ds3232: rtc at 68 {
+				compatible = "dallas,ds3232";
+				reg = <0x68>;
+				interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			ina220 at 40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
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
+			eeprom at 56 {
+				compatible = "atmel,24c512";
+				reg = <0x56>;
+			};
+
+			eeprom at 57 {
+				compatible = "atmel,24c512";
+				reg = <0x57>;
+			};
+
+			adt7461a at 4c {
+				compatible = "adi,adt7461a";
+				reg = <0x4c>;
+			};
+		};
+	};
+};
+
+&ifc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	/* NOR, NAND Flashes and FPGA on board */
+	ranges = <0x0 0x0 0x0 0x60000000 0x08000000
+		0x2 0x0 0x0 0x7e800000 0x00010000
+		0x3 0x0 0x0 0x7fb00000 0x00000100>;
+	status = "okay";
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
+	fpga: board-control at 3,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		reg = <0x3 0x0 0x0000100>;
+		bank-width = <1>;
+		device-width = <1>;
+		ranges = <0 3 0 0x100>;
+
+		mdio-mux-emi1 {
+			compatible = "mdio-mux-mmioreg";
+			mdio-parent-bus = <&mdio0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x54 1>; /* BRDCFG4 */
+			mux-mask = <0xe0>; /* EMI1[2:0] */
+
+			/* Onboard PHYs */
+			ls1021amdio0: mdio at 0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				rgmii_phy1: ethernet-phy at 1 {
+					reg = <0x1>;
+				};
+			};
+
+			ls1021amdio1: mdio at 20 {
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				rgmii_phy2: ethernet-phy at 2 {
+					reg = <0x2>;
+				};
+			};
+
+			ls1021amdio2: mdio at 40 {
+				reg = <0x40>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				rgmii_phy3: ethernet-phy at 3 {
+					reg = <0x3>;
+				};
+			};
+
+			ls1021amdio3: mdio at 60 {
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sgmii_phy1c: ethernet-phy at 1c {
+					reg = <0x1c>;
+				};
+			};
+
+			ls1021amdio4: mdio at 80 {
+				reg = <0x80>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sgmii_phy1d: ethernet-phy at 1d {
+					reg = <0x1d>;
+				};
+			};
+		};
+	};
+};
+
+&lpuart0 {
+	status = "okay";
+};
+
+&mdio0 {
+	tbi0: tbi-phy at 8 {
+		reg = <0x8>;
+		device_type = "tbi-phy";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
-- 
1.8.0
