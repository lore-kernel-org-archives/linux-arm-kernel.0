From: Bhaskar.Upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Fri, 26 Aug 2016 15:57:21 +0530
Subject: [PATCH v2 1/1] arm64: Add DTS support for FSL's LS1012A SoC
Message-ID: <1472207241-18461-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device tree support for FSL LS1012A SoC.
Following levels of DTSI/DTS files have been created for the LS1012A
SoC family:

        - fsl-ls1012a.dtsi:
                DTS-Include file for FSL LS1012A SoC.

        - fsl-ls1012a-frdm.dts:
                DTS file for FSL LS1012A FRDM board.

        - fsl-ls1012a-qds.dts:
                DTS file for FSL LS1012A QDS board.

        - fsl-ls1012a-rdb.dts:
                DTS file for FSL LS1012A RDB board.

Changes vs version1:
	- Consistent Licensing for dts files
	- Removed the PFE node
	- Update reset node with reboot node
	- Update clocks property in codec node
	- Update regulators node
	- Update timer node
	- Update compatible property of clockgen with "fsl,ls1012a-clockgen" only
	- Update compatible property of scfg with "fsl,ls1012a-scfg" only
	- Update compatible property with proper ordering in tmu node

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Pratiyush Mohan Srivastava <pratiyush.srivastava@nxp.com>
Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts | 150 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  | 180 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  |  79 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 480 +++++++++++++++++++++
 5 files changed, 892 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 1b7783d..3503c46 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,3 +1,6 @@
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
new file mode 100644
index 0000000..dc6df47
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
@@ -0,0 +1,150 @@
+/*
+ * Device Tree file for Freescale Layerscape-1012A family SoC.
+ *
+ * Copyright 2016, Freescale Semiconductor
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
+/dts-v1/;
+
+#include "fsl-ls1012a.dtsi"
+
+/ {
+	model = "LS1012A Freedom Board";
+	compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
+
+	aliases {
+		crypto = &crypto;
+	};
+
+	sys_mclk: clock-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	regulators {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg_1p8v: regulator at 0 {
+			compatible = "regulator-fixed";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0>;
+			regulator-name = "1P8V";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker Ext",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"Microphone Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Speaker Ext", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+			frame-master;
+			bitclock-master;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&codec>;
+			frame-master;
+			bitclock-master;
+			system-clock-frequency = <25000000>;
+		};
+	};
+};
+
+&qspi {
+	num-cs = <2>;
+	bus-num = <0>;
+	status = "disabled";
+	fsl,ddr-sampling-point = <4>;
+
+	qflash0: s25fs512s at 0 {
+		compatible = "spansion,m25p80";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		m25p,fast-read;
+		reg = <0>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	codec: sgtl5000 at a {
+		#sound-dai-cells = <0>;
+		compatible = "fsl,sgtl5000";
+		reg = <0xa>;
+		VDDA-supply = <&reg_1p8v>;
+		VDDIO-supply = <&reg_1p8v>;
+		clocks = <&sys_mclk>;
+	};
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&esdhc0 {
+	status = "disabled";
+};
+
+&esdhc1 {
+	status = "disabled";
+};
+
+&sai2 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
new file mode 100644
index 0000000..382d070
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
@@ -0,0 +1,180 @@
+/*
+ * Device Tree file for Freescale Layerscape-1012A family SoC.
+ *
+ * Copyright 2016, Freescale Semiconductor
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
+/dts-v1/;
+
+#include "fsl-ls1012a.dtsi"
+
+/ {
+	model = "LS1012A QDS Board";
+	compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
+
+	aliases {
+		crypto = &crypto;
+	};
+
+	sys_mclk: clock-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
+	regulators {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg_3p3v: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0x0>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker Ext",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"Microphone Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Speaker Ext", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+			frame-master;
+			bitclock-master;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&codec>;
+			frame-master;
+			bitclock-master;
+			system-clock-frequency = <24576000>;
+		};
+	};
+};
+
+&dspi0 {
+	bus-num = <0>;
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128a11", "jedec,spi-nor";  /* 16MB */
+		reg = <0>;
+		spi-max-frequency = <10000000>; /* input clock */
+	};
+
+	flash at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "sst,sst25wf040b", "jedec,spi-nor";  /* 512KB */
+		reg = <1>;
+		spi-max-frequency = <35000000>; /* input clock */
+	};
+
+	flash at 2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "eon,en25s64", "jedec,spi-nor";   /* 8MB */
+		reg = <2>;
+		spi-max-frequency = <35000000>; /* input clock */
+	};
+};
+
+&qspi {
+	num-cs = <2>;
+	bus-num = <0>;
+	status = "disabled";
+
+	qflash0: s25fs512s at 0 {
+		compatible = "spansion,m25p80";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		m25p,fast-read;
+		reg = <0>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	pca9547 at 77 {
+		compatible = "nxp,pca9547";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+
+			codec: sgtl5000 at a {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,sgtl5000";
+				reg = <0xa>;
+				VDDA-supply = <&reg_3p3v>;
+				VDDIO-supply = <&reg_3p3v>;
+				clocks = <&sys_mclk>;
+			};
+		};
+	};
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&sai2 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
new file mode 100644
index 0000000..b609032
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
@@ -0,0 +1,79 @@
+/*
+ * Device Tree file for Freescale Layerscape-1012A family SoC.
+ *
+ * Copyright 2016, Freescale Semiconductor
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
+/dts-v1/;
+
+#include "fsl-ls1012a.dtsi"
+
+/ {
+	model = "LS1012A RDB Board";
+	compatible = "fsl,ls1012a-rdb", "fsl,ls1012a";
+
+	aliases {
+		crypto = &crypto;
+	};
+};
+
+&qspi {
+	num-cs = <2>;
+	bus-num = <0>;
+	status = "disabled";
+	fsl,ddr-sampling-point = <4>;
+
+	qflash0: s25fs512s at 0 {
+		compatible = "spansion,m25p80";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		m25p,fast-read;
+		reg = <0>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&duart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
new file mode 100644
index 0000000..80fe028
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -0,0 +1,480 @@
+/*
+ * Device Tree Include file for Freescale Layerscape-1012A family SoC.
+ *
+ * Copyright 2016, Freescale Semiconductor
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
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	compatible = "fsl,ls1012a";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x0>;
+			clocks = <&clockgen 1 0>;
+			#cooling-cells = <2>;
+		};
+	};
+
+	sysclk: sysclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "sysclk";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 0x1>, /* Physical Secure PPI */
+			     <1 14 0x1>, /* Physical Non-Secure PPI */
+			     <1 11 0x1>, /* Virtual PPI */
+			     <1 10 0x1>; /* Hypervisor PPI */
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <0 106 0x4>;
+	};
+
+	gic: interrupt-controller at 1400000 {
+		compatible = "arm,gic-400";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0x1401000 0 0x1000>, /* GICD */
+		      <0x0 0x1402000 0 0x2000>, /* GICC */
+		      <0x0 0x1404000 0 0x2000>, /* GICH */
+		      <0x0 0x1406000 0 0x2000>; /* GICV */
+		interrupts = <1 9 0xf08>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		clockgen: clocking at 1ee1000 {
+			compatible = "fsl,ls1012a-clockgen";
+			reg = <0x0 0x1ee1000 0x0 0x1000>;
+			#clock-cells = <2>;
+			clocks = <&sysclk>;
+		};
+
+		scfg: scfg at 1570000 {
+			compatible = "fsl,ls1012a-scfg", "syscon";
+			reg = <0x0 0x1570000 0x0 0x10000>;
+			big-endian;
+		};
+
+		dcfg: dcfg at 1ee0000 {
+			compatible = "fsl,ls1012a-dcfg",
+				     "fsl,ls1043a-dcfg",
+				     "syscon";
+			reg = <0x0 0x1ee0000 0x0 0x10000>;
+			big-endian;
+		};
+
+		crypto: crypto at 1700000 {
+			compatible = "fsl,sec-v5.4", "fsl,sec-v5.0",
+				     "fsl,sec-v4.0";
+			fsl,sec-era = <8>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x00 0x1700000 0x100000>;
+			reg = <0x00 0x1700000 0x0 0x100000>;
+			interrupts = <0 75 0x4>;
+
+			sec_jr0: jr at 10000 {
+				compatible = "fsl,sec-v5.4-job-ring",
+					     "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x10000 0x10000>;
+				interrupts = <0 71 0x4>;
+			};
+
+			sec_jr1: jr at 20000 {
+				compatible = "fsl,sec-v5.4-job-ring",
+					     "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x20000 0x10000>;
+				interrupts = <0 72 0x4>;
+			};
+
+			sec_jr2: jr at 30000 {
+				compatible = "fsl,sec-v5.4-job-ring",
+					     "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x30000 0x10000>;
+				interrupts = <0 73 0x4>;
+			};
+
+			sec_jr3: jr at 40000 {
+				compatible = "fsl,sec-v5.4-job-ring",
+					     "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x40000 0x10000>;
+				interrupts = <0 74 0x4>;
+			};
+		};
+
+		reboot {
+			compatible ="syscon-reboot";
+			regmap = <&dcfg>;
+			offset = <0xb0>;
+			mask = <0x02>;
+		};
+
+		rcpm: rcpm at 1ee2000 {
+			compatible = "fsl,ls1012a-rcpm";
+			reg = <0x0 0x1ee2000 0x0 0x10000>;
+		};
+
+		esdhc0: esdhc at 1560000 {
+			compatible = "fsl,ls1012a-esdhc0", "fsl,esdhc";
+			reg = <0x0 0x1560000 0x0 0x10000>;
+			interrupts = <0 62 0x4>;
+			clock-frequency = <0>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			big-endian;
+			bus-width = <4>;
+		};
+
+		esdhc1: esdhc at 1580000 {
+			compatible = "fsl,ls1012a-esdhc1", "fsl,esdhc";
+			reg = <0x0 0x1580000 0x0 0x10000>;
+			interrupts = <0 65 0x4>;
+			clock-frequency = <0>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			big-endian;
+			bus-width = <4>;
+		};
+
+		dspi0: dspi at 2100000 {
+			compatible = "fsl,ls1012a-dspi",
+				     "fsl,ls1043a-dspi",
+				     "fsl,ls1021a-v1.0-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2100000 0x0 0x10000>;
+			interrupts = <0 64 0x4>;
+			clock-names = "dspi";
+			clocks = <&clockgen 4 0>;
+			spi-num-chipselects = <5>;
+			big-endian;
+			status = "enabled";
+		};
+
+		qspi: quadspi at 1550000 {
+			compatible =  "fsl,ls1012a-qspi",
+				      "fsl,ls1043a-qspi",
+				      "fsl,ls1021a-qspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x1550000 0x0 0x10000>,
+				<0x0 0x40000000 0x0 0x4000000>;
+			reg-names = "QuadSPI", "QuadSPI-memory";
+			interrupts = <0 99 0x4>;
+			clock-names = "qspi_en", "qspi";
+			clocks = <&clockgen 4 0>, <&clockgen 4 0>;
+			big-endian;
+			amba-base = <0x42000000>;
+		};
+
+		tmu: tmu at 1f00000 {
+			compatible = "fsl,ls1012a-tmu", "fsl,qoriq-tmu";
+			reg = <0x0 0x1f00000 0x0 0x10000>;
+			interrupts = <0 33 0x4>;
+			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
+			fsl,tmu-calibration = <0x00000000 0x00000026
+					       0x00000001 0x0000002d
+					       0x00000002 0x00000032
+					       0x00000003 0x00000039
+					       0x00000004 0x0000003f
+					       0x00000005 0x00000046
+					       0x00000006 0x0000004d
+					       0x00000007 0x00000054
+					       0x00000008 0x0000005a
+					       0x00000009 0x00000061
+					       0x0000000a 0x0000006a
+					       0x0000000b 0x00000071
+
+					       0x00010000 0x00000025
+					       0x00010001 0x0000002c
+					       0x00010002 0x00000035
+					       0x00010003 0x0000003d
+					       0x00010004 0x00000045
+					       0x00010005 0x0000004e
+					       0x00010006 0x00000057
+					       0x00010007 0x00000061
+					       0x00010008 0x0000006b
+					       0x00010009 0x00000076
+
+					       0x00020000 0x00000029
+					       0x00020001 0x00000033
+					       0x00020002 0x0000003d
+					       0x00020003 0x00000049
+					       0x00020004 0x00000056
+					       0x00020005 0x00000061
+					       0x00020006 0x0000006d
+
+					       0x00030000 0x00000021
+					       0x00030001 0x0000002a
+					       0x00030002 0x0000003c
+					       0x00030003 0x0000004e>;
+			big-endian;
+			#thermal-sensor-cells = <1>;
+		};
+
+		thermal-zones {
+			cpu_thermal: cpu-thermal {
+				polling-delay-passive = <1000>;
+				polling-delay = <5000>;
+
+				thermal-sensors = <&tmu 0>;
+
+				trips {
+					cpu_alert: cpu-alert {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu_crit: cpu-crit {
+						temperature = <95000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&cpu_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+		};
+
+		i2c0: i2c at 2180000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2180000 0x0 0x10000>;
+			interrupts = <0 56 0x4>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 2190000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2190000 0x0 0x10000>;
+			interrupts = <0 57 0x4>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 0>;
+			status = "disabled";
+		};
+
+
+		duart0: serial at 21c0500 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x00 0x21c0500 0x0 0x100>;
+			interrupts = <0 54 0x4>;
+			clocks = <&clockgen 4 0>;
+		};
+
+		duart1: serial at 21c0600 {
+			compatible = "fsl,ns16550", "ns16550a";
+			reg = <0x00 0x21c0600 0x0 0x100>;
+			interrupts = <0 54 0x4>;
+			clocks = <&clockgen 4 0>;
+		};
+
+		gpio0: gpio at 2300000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2300000 0x0 0x10000>;
+			interrupts = <0 66 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio at 2310000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2310000 0x0 0x10000>;
+			interrupts = <0 67 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		wdog0: wdog at 2ad0000 {
+			compatible = "fsl,ls1012a-wdt",
+				     "fsl,ls1043a-wdt",
+				     "fsl,imx21-wdt";
+			reg = <0x0 0x2ad0000 0x0 0x10000>;
+			interrupts = <0 83 0x4>;
+			clocks = <&clockgen 4 0>;
+			clock-names = "wdog";
+			big-endian;
+		};
+
+		sai1: sai at 2b50000 {
+			#sound-dai-cells = <0>;
+			compatible = "fsl,vf610-sai";
+			reg = <0x0 0x2b50000 0x0 0x10000>;
+			interrupts = <0 148 0x4>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>,
+				 <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "bus", "mclk1", "mclk2", "mclk3";
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 47>,
+			       <&edma0 1 46>;
+			status = "disabled";
+		};
+
+		sai2: sai at 2b60000 {
+			#sound-dai-cells = <0>;
+			compatible = "fsl,vf610-sai";
+			reg = <0x0 0x2b60000 0x0 0x10000>;
+			interrupts = <0 149 0x4>;
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>,
+				 <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "bus", "mclk1", "mclk2", "mclk3";
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 45>,
+			       <&edma0 1 44>;
+			status = "disabled";
+		};
+
+		edma0: edma at 2c00000 {
+			#dma-cells = <2>;
+			compatible = "fsl,vf610-edma";
+			reg = <0x0 0x2c00000 0x0 0x10000>,
+			      <0x0 0x2c10000 0x0 0x10000>,
+			      <0x0 0x2c20000 0x0 0x10000>;
+			interrupts = <0 103 0x4>,
+				     <0 103 0x4>;
+			interrupt-names = "edma-tx", "edma-err";
+			dma-channels = <32>;
+			big-endian;
+			clock-names = "dmamux0", "dmamux1";
+			clocks = <&clockgen 4 3>,
+				 <&clockgen 4 3>;
+		};
+
+		sata: sata at 3200000 {
+			compatible = "fsl,ls1012a-ahci";
+			reg = <0x0 0x3200000 0x0 0x10000>;
+			interrupts = <0 69 0x4>;
+			clocks = <&clockgen 4 0>;
+		};
+
+		msi2: msi-controller2 at 1572000 {
+			compatible ="fsl,1s1012a-msi", "fsl,1s1021a-msi";
+			reg = <0x0 0x1572000 0x0 0x4>,
+			      <0x0 0x1572004 0x0 0x4>;
+			reg-names = "msiir", "msir";
+			msi-controller;
+			interrupts = <0 126 0x4>;
+		};
+
+		usb at 8600000 {
+			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
+			reg = <0x0 0x8600000 0x0 0x1000>;
+			interrupts = <0 139 0x4>;
+			dr_mode = "host";
+			phy_type = "ulpi";
+			fsl,usb-erratum-a005697;
+		};
+
+		usb0: usb3 at 2f00000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x2f00000 0x0 0x10000>;
+			interrupts = <0 60 0x4>;
+			dr_mode = "host";
+			configure-gfladj;
+			snps,dis_rxdet_inp3_quirk;
+		};
+
+		pcie at 3400000 {
+			compatible = "fsl,ls1012a-pcie",
+				     "fsl,ls1043a-pcie",
+				     "snps,dw-pcie";
+			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
+			interrupts = <0 118 0x4>, /* controller interrupt */
+				     <0 117 0x4>; /* PME interrupt */
+			interrupt-names = "intr", "pme";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			num-lanes = <4>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
+				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&msi2>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 110 0x4>,
+					<0000 0 0 2 &gic 0 111 0x4>,
+					<0000 0 0 3 &gic 0 112 0x4>,
+					<0000 0 0 4 &gic 0 113 0x4>;
+		};
+	};
+};
-- 
1.9.1
