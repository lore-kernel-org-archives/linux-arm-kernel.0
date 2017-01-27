From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 27 Jan 2017 16:25:46 +1300
Subject: [PATCHv5 5/5] arm: mvebu: Add device tree for db-dxbc2 and
 db-xc3-24g4xg boards
In-Reply-To: <20170127032546.14657-1-chris.packham@alliedtelesis.co.nz>
References: <20170127032546.14657-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170127032546.14657-6-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These boards are Marvell's evaluation boards for the 98DX4251 and
98DX3336 SoCs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v5:
    - update license text
    - use node labels

 arch/arm/boot/dts/db-dxbc2.dts      | 151 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/db-xc3-24g4xg.dts | 142 +++++++++++++++++++++++++++++++++
 2 files changed, 293 insertions(+)
 create mode 100644 arch/arm/boot/dts/db-dxbc2.dts
 create mode 100644 arch/arm/boot/dts/db-xc3-24g4xg.dts

diff --git a/arch/arm/boot/dts/db-dxbc2.dts b/arch/arm/boot/dts/db-dxbc2.dts
new file mode 100644
index 000000000000..a8130805074e
--- /dev/null
+++ b/arch/arm/boot/dts/db-dxbc2.dts
@@ -0,0 +1,151 @@
+/*
+ * Device Tree file for DB-DXBC2 board
+ *
+ * Copyright (C) 2016 Allied Telesis Labs
+ *
+ * Based on armada-xp-db.dts
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+ *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the default
+ * 0xd0000000). The 0xf1000000 is the default used by the recent,
+ * DT-capable, U-Boot bootloaders provided by Marvell. Some earlier
+ * boards were delivered with an older version of the bootloader that
+ * left internal registers mapped at 0xd0000000. If you are in this
+ * situation, you should either update your bootloader (preferred
+ * solution) or the below Device Tree should be adjusted.
+ */
+
+/dts-v1/;
+#include "armada-xp-98dx4251.dtsi"
+
+/ {
+	model = "Marvell Bobcat2 Evaluation Board";
+	compatible = "marvell,db-dxbc2", "marvell,armadaxp-98dx4251", "marvell,armadaxp", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x00000000 0 0x20000000>; /* 512 MB */
+	};
+
+};
+
+&devbus_bootcs {
+	status = "okay";
+
+	/* Device Bus parameters are required */
+
+	/* Read parameters */
+	devbus,bus-width    = <16>;
+	devbus,turn-off-ps  = <60000>;
+	devbus,badr-skew-ps = <0>;
+	devbus,acc-first-ps = <124000>;
+	devbus,acc-next-ps  = <248000>;
+	devbus,rd-setup-ps  = <0>;
+	devbus,rd-hold-ps   = <0>;
+
+	/* Write parameters */
+	devbus,sync-enable = <0>;
+	devbus,wr-high-ps  = <60000>;
+	devbus,wr-low-ps   = <60000>;
+	devbus,ale-wr-ps   = <60000>;
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&nand {
+	status = "okay";
+	num-cs = <1>;
+	marvell,nand-keep-config;
+	marvell,nand-enable-arbiter;
+	nand-on-flash-bbt;
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+};
+
+&sdio {
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	/* No CD or WP GPIOs */
+	broken-cd;
+};
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p64";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <20000000>;
+		m25p,fast-read;
+
+		partition at u-boot {
+			reg = <0x00000000 0x00100000>;
+			label = "u-boot";
+		};
+		partition at u-boot-env {
+			reg = <0x00100000 0x00040000>;
+			label = "u-boot-env";
+		};
+		partition at unused {
+			reg = <0x00140000 0x00ec0000>;
+			label = "unused";
+		};
+
+	};
+};
diff --git a/arch/arm/boot/dts/db-xc3-24g4xg.dts b/arch/arm/boot/dts/db-xc3-24g4xg.dts
new file mode 100644
index 000000000000..4e07cb6ed800
--- /dev/null
+++ b/arch/arm/boot/dts/db-xc3-24g4xg.dts
@@ -0,0 +1,142 @@
+/*
+ * Device Tree file for DB-XC3-24G4XG board
+ *
+ * Copyright (C) 2016 Allied Telesis Labs
+ *
+ * Based on armada-xp-db.dts
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+ *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the default
+ * 0xd0000000). The 0xf1000000 is the default used by the recent,
+ * DT-capable, U-Boot bootloaders provided by Marvell. Some earlier
+ * boards were delivered with an older version of the bootloader that
+ * left internal registers mapped at 0xd0000000. If you are in this
+ * situation, you should either update your bootloader (preferred
+ * solution) or the below Device Tree should be adjusted.
+ */
+
+/dts-v1/;
+#include "armada-xp-98dx3336.dtsi"
+
+/ {
+	model = "DB-XC3-24G4XG";
+	compatible = "marvell,db-xc3-24g4xg", "marvell,armadaxp-98dx3336", "marvell,armadaxp", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x00000000 0 0x40000000>; /* 1 GB */
+	};
+};
+
+&devbus_bootcs {
+	status = "okay";
+
+	/* Device Bus parameters are required */
+
+	/* Read parameters */
+	devbus,bus-width    = <16>;
+	devbus,turn-off-ps  = <60000>;
+	devbus,badr-skew-ps = <0>;
+	devbus,acc-first-ps = <124000>;
+	devbus,acc-next-ps  = <248000>;
+	devbus,rd-setup-ps  = <0>;
+	devbus,rd-hold-ps   = <0>;
+
+	/* Write parameters */
+	devbus,sync-enable = <0>;
+	devbus,wr-high-ps  = <60000>;
+	devbus,wr-low-ps   = <60000>;
+	devbus,ale-wr-ps   = <60000>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&nand {
+	status = "okay";
+	num-cs = <1>;
+	marvell,nand-keep-config;
+	marvell,nand-enable-arbiter;
+	nand-on-flash-bbt;
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+};
+
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p64";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <20000000>;
+		m25p,fast-read;
+
+		partition at u-boot {
+			reg = <0x00000000 0x00100000>;
+			label = "u-boot";
+		};
+		partition at u-boot-env {
+			reg = <0x00100000 0x00040000>;
+			label = "u-boot-env";
+		};
+		partition at unused {
+			reg = <0x00140000 0x00ec0000>;
+			label = "unused";
+		};
+
+	};
+};
-- 
2.11.0.24.ge6920cf
