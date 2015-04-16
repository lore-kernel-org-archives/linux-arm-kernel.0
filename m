From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 16 Apr 2015 16:40:37 +0900
Subject: [PATCH 3/4] ARM: dts: UniPhier: add support for UniPhier SoCs and
 boards
In-Reply-To: <1429170038-16757-1-git-send-email-yamada.masahiro@socionext.com>
References: <1429170038-16757-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1429170038-16757-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial device trees for UniPhier SoCs: PH1-sLD3, PH1-LD4, PH1-Pro4,
and PH1-sLD8.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/Makefile                   |  5 ++
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts   | 51 +++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi      | 78 +++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts  | 51 +++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi     | 85 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts  | 52 +++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi     | 85 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts  | 51 +++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi     | 78 +++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-support-card.dtsi | 39 +++++++++++++
 10 files changed, 575 insertions(+)
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-support-card.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..d639a90 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -588,6 +588,11 @@ dtb-$(CONFIG_ARCH_U8500) += \
 	ste-hrefv60plus-tvk.dtb \
 	ste-ccu8540.dtb \
 	ste-ccu9540.dtb
+dtb-$(CONFIG_ARCH_UNIPHIER) += \
+	uniphier-ph1-sld3-ref.dtb \
+	uniphier-ph1-ld4-ref.dtb \
+	uniphier-ph1-pro4-ref.dtb \
+	uniphier-ph1-sld8-ref.dtb
 dtb-$(CONFIG_ARCH_VERSATILE) += \
 	versatile-ab.dtb \
 	versatile-pb.dtb
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
new file mode 100644
index 0000000..2e83363
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
@@ -0,0 +1,51 @@
+/*
+ * Device Tree Source for UniPhier PH1-LD4 Reference Board
+ *
+ * Copyright (C) 2015 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+/include/ "uniphier-ph1-ld4.dtsi"
+/include/ "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier PH1-LD4 Reference Board";
+	compatible = "socionext,ph1-ld4-ref", "socionext,ph1-ld4";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	aliases {
+		serial0 = &serialsc;
+	};
+};
+
+&extbus {
+	ranges = <0 0x00000000 0x0f000000 0x01000000
+		  1 0x00000000 0x00000000 0x08000000>;
+};
+
+&support_card {
+	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+};
+
+&serialsc {
+	interrupts = <0 49 4>;
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
new file mode 100644
index 0000000..f1b31dc
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -0,0 +1,78 @@
+/*
+ * Device Tree Source for UniPhier PH1-LD4 SoC
+ *
+ * Copyright (C) 2015 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "socionext,ph1-ld4";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+	};
+
+	clocks {
+		arm_timer_clk: arm_timer_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		extbus: extbus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		timer at 60000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x60000200 0x20>;
+			interrupts = <1 11 0x104>;
+			interrupt-parent = <&intc>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		timer at 60000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x60000600 0x20>;
+			interrupts = <1 13 0x104>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		intc: interrupt-controller at 60001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x60001000 0x1000>,
+			      <0x60000100 0x100>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
new file mode 100644
index 0000000..5e33995
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
@@ -0,0 +1,51 @@
+/*
+ * Device Tree Source for UniPhier PH1-Pro4 Reference Board
+ *
+ * Copyright (C) 2015 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+/include/ "uniphier-ph1-pro4.dtsi"
+/include/ "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier PH1-Pro4 Reference Board";
+	compatible = "socionext,ph1-pro4-ref", "socionext,ph1-pro4";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	aliases {
+		serial0 = &serialsc;
+	};
+};
+
+&extbus {
+	ranges = <0 0x00000000 0x0f000000 0x01000000
+		  1 0x00000000 0x00000000 0x08000000>;
+};
+
+&support_card {
+	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+};
+
+&serialsc {
+	interrupts = <0 50 4>;
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
new file mode 100644
index 0000000..7fceedc
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -0,0 +1,85 @@
+/*
+ * Device Tree Source for UniPhier PH1-Pro4 SoC
+ *
+ * Copyright (C) 2015 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "socionext,ph1-pro4";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "socionext,uniphier-smp";
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
+	clocks {
+		arm_timer_clk: arm_timer_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		extbus: extbus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		timer at 60000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x60000200 0x20>;
+			interrupts = <1 11 0x304>;
+			interrupt-parent = <&intc>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		timer at 60000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x60000600 0x20>;
+			interrupts = <1 13 0x304>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		intc: interrupt-controller at 60001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x60001000 0x1000>,
+			      <0x60000100 0x100>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
new file mode 100644
index 0000000..f8f2fa3
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
@@ -0,0 +1,52 @@
+/*
+ * Device Tree Source for UniPhier PH1-sLD3 Reference Board
+ *
+ * Copyright (C) 2015 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+/include/ "uniphier-ph1-sld3.dtsi"
+/include/ "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier PH1-sLD3 Reference Board";
+	compatible = "socionext,ph1-sld3-ref", "socionext,ph1-sld3";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000
+		       0xc0000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	aliases {
+		serial0 = &serialsc;
+	};
+};
+
+&extbus {
+	ranges = <0 0x00000000 0x0f000000 0x01000000
+		  1 0x00000000 0x00000000 0x08000000>;
+};
+
+&support_card {
+	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+};
+
+&serialsc {
+	interrupts = <0 49 4>;
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
new file mode 100644
index 0000000..06db2a4
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -0,0 +1,85 @@
+/*
+ * Device Tree Source for UniPhier PH1-sLD3 SoC
+ *
+ * Copyright (C) 2015 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "socionext,ph1-sld3";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "socionext,uniphier-smp";
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
+	clocks {
+		arm_timer_clk: arm_timer_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		extbus: extbus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		timer at 20000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x20000200 0x20>;
+			interrupts = <1 11 0x304>;
+			interrupt-parent = <&intc>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		timer at 20000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x20000600 0x20>;
+			interrupts = <1 13 0x304>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		intc: interrupt-controller at 20001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x20001000 0x1000>,
+			      <0x20000100 0x100>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
new file mode 100644
index 0000000..279a997
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
@@ -0,0 +1,51 @@
+/*
+ * Device Tree Source for UniPhier PH1-sLD8 Reference Board
+ *
+ * Copyright (C) 2015 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+/include/ "uniphier-ph1-sld8.dtsi"
+/include/ "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier PH1-sLD8 Reference Board";
+	compatible = "socionext,ph1-sld8-ref", "socionext,ph1-sld8";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	aliases {
+		serial0 = &serialsc;
+	};
+};
+
+&extbus {
+	ranges = <0 0x00000000 0x0f000000 0x01000000
+		  1 0x00000000 0x00000000 0x08000000>;
+};
+
+&support_card {
+	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+};
+
+&serialsc {
+	interrupts = <0 48 4>;
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
new file mode 100644
index 0000000..47d9d61
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -0,0 +1,78 @@
+/*
+ * Device Tree Source for UniPhier PH1-sLD8 SoC
+ *
+ * Copyright (C) 2015 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "socionext,ph1-sld8";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+	};
+
+	clocks {
+		arm_timer_clk: arm_timer_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		extbus: extbus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		timer at 60000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x60000200 0x20>;
+			interrupts = <1 11 0x104>;
+			interrupt-parent = <&intc>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		timer at 60000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x60000600 0x20>;
+			interrupts = <1 13 0x104>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		intc: interrupt-controller at 60001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x60001000 0x1000>,
+			      <0x60000100 0x100>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
new file mode 100644
index 0000000..2abbec1
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -0,0 +1,39 @@
+/*
+ * Device Tree Source for UniPhier Support Card (Expansion Board)
+ *
+ * Copyright (C) 2015 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+&extbus {
+	support_card: support_card {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		ethsc: ethernet at 00000000 {
+			compatible = "smsc,lan9118", "smsc,lan9115";
+			reg = <0x00000000 0x1000>;
+			phy-mode = "mii";
+			reg-io-width = <4>;
+		};
+
+		serialsc: uart at 000b0000 {
+			compatible = "ns16550a";
+			reg = <0x000b0000 0x20>;
+			clock-frequency = <12288000>;
+			reg-shift = <1>;
+			fifo-size = <16>;
+		};
+	};
+};
-- 
1.9.1
