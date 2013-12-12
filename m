From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Dec 2013 12:23:06 -0700
Subject: [PATCH 2/2] ARM: tegra: fix node sort order
In-Reply-To: <1386876186-2247-1-git-send-email-swarren@wwwdotorg.org>
References: <1386876186-2247-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1386876186-2247-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

For Tegra DT files, I've been attempting to keep the nodes sorted in
the order:
1) Nodes with reg, in order of reg.
2) Nodes without reg, alphabetically.

This patch fixes a few escapees that I missed:-(

The diffs look larger than they really are, because sometimes when one
node was moved up or down, diff chose to represent this as many other
nodes being moved the other way!

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-colibri-512.dtsi |  56 +++---
 arch/arm/boot/dts/tegra20-harmony.dts      | 184 +++++++++----------
 arch/arm/boot/dts/tegra20-iris-512.dts     |  14 +-
 arch/arm/boot/dts/tegra20-seaboard.dts     | 281 +++++++++++++++--------------
 arch/arm/boot/dts/tegra20-whistler.dts     |  26 +--
 arch/arm/boot/dts/tegra30-beaver.dts       |  64 +++----
 arch/arm/boot/dts/tegra30-cardhu-a02.dts   |  14 +-
 arch/arm/boot/dts/tegra30-cardhu-a04.dts   |  14 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi      |  12 +-
 9 files changed, 333 insertions(+), 332 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index f20fc9794e89..78f7e919ab6f 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -199,6 +199,14 @@
 		};
 	};
 
+	ac97: ac97 at 70002000 {
+		status = "okay";
+		nvidia,codec-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
+			GPIO_ACTIVE_HIGH>;
+		nvidia,codec-sync-gpio = <&gpio TEGRA_GPIO(P, 0)
+			GPIO_ACTIVE_HIGH>;
+	};
+
 	i2c at 7000c000 {
 		clock-frequency = <400000>;
 	};
@@ -442,14 +450,6 @@
 		};
 	};
 
-	ac97: ac97 at 70002000 {
-		status = "okay";
-		nvidia,codec-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
-			GPIO_ACTIVE_HIGH>;
-		nvidia,codec-sync-gpio = <&gpio TEGRA_GPIO(P, 0)
-			GPIO_ACTIVE_HIGH>;
-	};
-
 	usb at c5004000 {
 		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
@@ -479,26 +479,6 @@
 		};
 	};
 
-	sound {
-		compatible = "nvidia,tegra-audio-wm9712-colibri_t20",
-			         "nvidia,tegra-audio-wm9712";
-		nvidia,model = "Colibri T20 AC97 Audio";
-
-		nvidia,audio-routing =
-			"Headphone", "HPOUTL",
-			"Headphone", "HPOUTR",
-			"LineIn", "LINEINL",
-			"LineIn", "LINEINR",
-			"Mic", "MIC1";
-
-		nvidia,ac97-controller = <&ac97>;
-
-		clocks = <&tegra_car TEGRA20_CLK_PLL_A>,
-			 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA20_CLK_CDEV1>;
-		clock-names = "pll_a", "pll_a_out0", "mclk";
-	};
-
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -525,4 +505,24 @@
 			gpio = <&gpio TEGRA_GPIO(BB, 1) GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	sound {
+		compatible = "nvidia,tegra-audio-wm9712-colibri_t20",
+			         "nvidia,tegra-audio-wm9712";
+		nvidia,model = "Colibri T20 AC97 Audio";
+
+		nvidia,audio-routing =
+			"Headphone", "HPOUTL",
+			"Headphone", "HPOUTR",
+			"LineIn", "LINEINL",
+			"LineIn", "LINEINR",
+			"Mic", "MIC1";
+
+		nvidia,ac97-controller = <&ac97>;
+
+		clocks = <&tegra_car TEGRA20_CLK_PLL_A>,
+			 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA20_CLK_CDEV1>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
+	};
 };
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index b9c6f67e87ef..94d2189a47a7 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -415,98 +415,6 @@
 		};
 	};
 
-	pmc at 7000e400 {
-		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <1>;
-		nvidia,cpu-pwr-good-time = <5000>;
-		nvidia,cpu-pwr-off-time = <5000>;
-		nvidia,core-pwr-good-time = <3845 3845>;
-		nvidia,core-pwr-off-time = <3875>;
-		nvidia,sys-clock-req-active-high;
-	};
-
-	pcie-controller at 80003000 {
-		pex-clk-supply = <&pci_clk_reg>;
-		vdd-supply = <&pci_vdd_reg>;
-		status = "okay";
-
-		pci at 1,0 {
-			status = "okay";
-		};
-
-		pci at 2,0 {
-			status = "okay";
-		};
-	};
-
-	usb at c5000000 {
-		status = "okay";
-	};
-
-	usb-phy at c5000000 {
-		status = "okay";
-	};
-
-	usb at c5004000 {
-		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
-			GPIO_ACTIVE_LOW>;
-	};
-
-	usb-phy at c5004000 {
-		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
-			GPIO_ACTIVE_LOW>;
-	};
-
-	usb at c5008000 {
-		status = "okay";
-	};
-
-	usb-phy at c5008000 {
-		status = "okay";
-	};
-
-	sdhci at c8000200 {
-		status = "okay";
-		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
-		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
-		power-gpios = <&gpio TEGRA_GPIO(T, 3) GPIO_ACTIVE_HIGH>;
-		bus-width = <4>;
-	};
-
-	sdhci at c8000600 {
-		status = "okay";
-		cd-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_LOW>;
-		wp-gpios = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
-		power-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
-		bus-width = <8>;
-	};
-
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		clk32k_in: clock at 0 {
-			compatible = "fixed-clock";
-			reg=<0>;
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		power {
-			label = "Power";
-			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
-			linux,code = <116>; /* KEY_POWER */
-			gpio-key,wakeup;
-		};
-	};
-
 	kbc at 7000e200 {
 		status = "okay";
 		nvidia,debounce-delay-ms = <2>;
@@ -624,6 +532,98 @@
 				0x1F0400D6>;	/* KEY_QUESTION */
 	};
 
+	pmc at 7000e400 {
+		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <1>;
+		nvidia,cpu-pwr-good-time = <5000>;
+		nvidia,cpu-pwr-off-time = <5000>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <3875>;
+		nvidia,sys-clock-req-active-high;
+	};
+
+	pcie-controller at 80003000 {
+		pex-clk-supply = <&pci_clk_reg>;
+		vdd-supply = <&pci_vdd_reg>;
+		status = "okay";
+
+		pci at 1,0 {
+			status = "okay";
+		};
+
+		pci at 2,0 {
+			status = "okay";
+		};
+	};
+
+	usb at c5000000 {
+		status = "okay";
+	};
+
+	usb-phy at c5000000 {
+		status = "okay";
+	};
+
+	usb at c5004000 {
+		status = "okay";
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_LOW>;
+	};
+
+	usb-phy at c5004000 {
+		status = "okay";
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_LOW>;
+	};
+
+	usb at c5008000 {
+		status = "okay";
+	};
+
+	usb-phy at c5008000 {
+		status = "okay";
+	};
+
+	sdhci at c8000200 {
+		status = "okay";
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(T, 3) GPIO_ACTIVE_HIGH>;
+		bus-width = <4>;
+	};
+
+	sdhci at c8000600 {
+		status = "okay";
+		cd-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
+		bus-width = <8>;
+	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock at 0 {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts b/arch/arm/boot/dts/tegra20-iris-512.dts
index 770fc66e5fce..274d252c90f8 100644
--- a/arch/arm/boot/dts/tegra20-iris-512.dts
+++ b/arch/arm/boot/dts/tegra20-iris-512.dts
@@ -36,31 +36,31 @@
 		};
 	};
 
-	usb at c5000000 {
+	serial at 70006000 {
 		status = "okay";
 	};
 
-	usb-phy at c5000000 {
+	serial at 70006300 {
 		status = "okay";
 	};
 
-	usb at c5008000 {
+	i2c_ddc: i2c at 7000c400 {
 		status = "okay";
 	};
 
-	usb-phy at c5008000 {
+	usb at c5000000 {
 		status = "okay";
 	};
 
-	serial at 70006000 {
+	usb-phy at c5000000 {
 		status = "okay";
 	};
 
-	serial at 70006300 {
+	usb at c5008000 {
 		status = "okay";
 	};
 
-	i2c_ddc: i2c at 7000c400 {
+	usb-phy at c5008000 {
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 01442fc257de..07ff55a0d631 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -386,6 +386,13 @@
 		status = "okay";
 		clock-frequency = <400000>;
 
+		magnetometer at c {
+			compatible = "ak,ak8975";
+			reg = <0xc>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(N, 5) IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pmic: tps6586x at 34 {
 			compatible = "ti,tps6586x";
 			reg = <0x34>;
@@ -507,146 +514,6 @@
 			compatible = "onnn,nct1008";
 			reg = <0x4c>;
 		};
-
-		magnetometer at c {
-			compatible = "ak,ak8975";
-			reg = <0xc>;
-			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(N, 5) IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-
-	pmc at 7000e400 {
-		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <1>;
-		nvidia,cpu-pwr-good-time = <5000>;
-		nvidia,cpu-pwr-off-time = <5000>;
-		nvidia,core-pwr-good-time = <3845 3845>;
-		nvidia,core-pwr-off-time = <3875>;
-		nvidia,sys-clock-req-active-high;
-	};
-
-	memory-controller at 7000f400 {
-		emc-table at 190000 {
-			reg = <190000>;
-			compatible = "nvidia,tegra20-emc-table";
-			clock-frequency = <190000>;
-			nvidia,emc-registers = <0x0000000c 0x00000026
-				0x00000009 0x00000003 0x00000004 0x00000004
-				0x00000002 0x0000000c 0x00000003 0x00000003
-				0x00000002 0x00000001 0x00000004 0x00000005
-				0x00000004 0x00000009 0x0000000d 0x0000059f
-				0x00000000 0x00000003 0x00000003 0x00000003
-				0x00000003 0x00000001 0x0000000b 0x000000c8
-				0x00000003 0x00000007 0x00000004 0x0000000f
-				0x00000002 0x00000000 0x00000000 0x00000002
-				0x00000000 0x00000000 0x00000083 0xa06204ae
-				0x007dc010 0x00000000 0x00000000 0x00000000
-				0x00000000 0x00000000 0x00000000 0x00000000>;
-		};
-
-		emc-table at 380000 {
-			reg = <380000>;
-			compatible = "nvidia,tegra20-emc-table";
-			clock-frequency = <380000>;
-			nvidia,emc-registers = <0x00000017 0x0000004b
-				0x00000012 0x00000006 0x00000004 0x00000005
-				0x00000003 0x0000000c 0x00000006 0x00000006
-				0x00000003 0x00000001 0x00000004 0x00000005
-				0x00000004 0x00000009 0x0000000d 0x00000b5f
-				0x00000000 0x00000003 0x00000003 0x00000006
-				0x00000006 0x00000001 0x00000011 0x000000c8
-				0x00000003 0x0000000e 0x00000007 0x0000000f
-				0x00000002 0x00000000 0x00000000 0x00000002
-				0x00000000 0x00000000 0x00000083 0xe044048b
-				0x007d8010 0x00000000 0x00000000 0x00000000
-				0x00000000 0x00000000 0x00000000 0x00000000>;
-		};
-	};
-
-	usb at c5000000 {
-		status = "okay";
-		dr_mode = "otg";
-	};
-
-	usb-phy at c5000000 {
-		status = "okay";
-		vbus-supply = <&vbus_reg>;
-		dr_mode = "otg";
-	};
-
-	usb at c5004000 {
-		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
-			GPIO_ACTIVE_LOW>;
-	};
-
-	usb-phy at c5004000 {
-		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
-			GPIO_ACTIVE_LOW>;
-	};
-
-	usb at c5008000 {
-		status = "okay";
-	};
-
-	usb-phy at c5008000 {
-		status = "okay";
-	};
-
-	sdhci at c8000000 {
-		status = "okay";
-		power-gpios = <&gpio TEGRA_GPIO(K, 6) GPIO_ACTIVE_HIGH>;
-		bus-width = <4>;
-		keep-power-in-suspend;
-	};
-
-	sdhci at c8000400 {
-		status = "okay";
-		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
-		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
-		power-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
-		bus-width = <4>;
-	};
-
-	sdhci at c8000600 {
-		status = "okay";
-		bus-width = <8>;
-		non-removable;
-	};
-
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		clk32k_in: clock at 0 {
-			compatible = "fixed-clock";
-			reg=<0>;
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		power {
-			label = "Power";
-			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
-			linux,code = <116>; /* KEY_POWER */
-			gpio-key,wakeup;
-		};
-
-		lid {
-			label = "Lid";
-			gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_HIGH>;
-			linux,input-type = <5>; /* EV_SW */
-			linux,code = <0>; /* SW_LID */
-			debounce-interval = <1>;
-			gpio-key,wakeup;
-		};
 	};
 
 	kbc at 7000e200 {
@@ -788,6 +655,140 @@
 
 				0x1F04008A>;	/* KEY_HELP */
 	};
+
+	pmc at 7000e400 {
+		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <1>;
+		nvidia,cpu-pwr-good-time = <5000>;
+		nvidia,cpu-pwr-off-time = <5000>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <3875>;
+		nvidia,sys-clock-req-active-high;
+	};
+
+	memory-controller at 7000f400 {
+		emc-table at 190000 {
+			reg = <190000>;
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = <190000>;
+			nvidia,emc-registers = <0x0000000c 0x00000026
+				0x00000009 0x00000003 0x00000004 0x00000004
+				0x00000002 0x0000000c 0x00000003 0x00000003
+				0x00000002 0x00000001 0x00000004 0x00000005
+				0x00000004 0x00000009 0x0000000d 0x0000059f
+				0x00000000 0x00000003 0x00000003 0x00000003
+				0x00000003 0x00000001 0x0000000b 0x000000c8
+				0x00000003 0x00000007 0x00000004 0x0000000f
+				0x00000002 0x00000000 0x00000000 0x00000002
+				0x00000000 0x00000000 0x00000083 0xa06204ae
+				0x007dc010 0x00000000 0x00000000 0x00000000
+				0x00000000 0x00000000 0x00000000 0x00000000>;
+		};
+
+		emc-table at 380000 {
+			reg = <380000>;
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = <380000>;
+			nvidia,emc-registers = <0x00000017 0x0000004b
+				0x00000012 0x00000006 0x00000004 0x00000005
+				0x00000003 0x0000000c 0x00000006 0x00000006
+				0x00000003 0x00000001 0x00000004 0x00000005
+				0x00000004 0x00000009 0x0000000d 0x00000b5f
+				0x00000000 0x00000003 0x00000003 0x00000006
+				0x00000006 0x00000001 0x00000011 0x000000c8
+				0x00000003 0x0000000e 0x00000007 0x0000000f
+				0x00000002 0x00000000 0x00000000 0x00000002
+				0x00000000 0x00000000 0x00000083 0xe044048b
+				0x007d8010 0x00000000 0x00000000 0x00000000
+				0x00000000 0x00000000 0x00000000 0x00000000>;
+		};
+	};
+
+	usb at c5000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	usb-phy at c5000000 {
+		status = "okay";
+		vbus-supply = <&vbus_reg>;
+		dr_mode = "otg";
+	};
+
+	usb at c5004000 {
+		status = "okay";
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_LOW>;
+	};
+
+	usb-phy at c5004000 {
+		status = "okay";
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_LOW>;
+	};
+
+	usb at c5008000 {
+		status = "okay";
+	};
+
+	usb-phy at c5008000 {
+		status = "okay";
+	};
+
+	sdhci at c8000000 {
+		status = "okay";
+		power-gpios = <&gpio TEGRA_GPIO(K, 6) GPIO_ACTIVE_HIGH>;
+		bus-width = <4>;
+		keep-power-in-suspend;
+	};
+
+	sdhci at c8000400 {
+		status = "okay";
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
+		bus-width = <4>;
+	};
+
+	sdhci at c8000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock at 0 {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+
+		lid {
+			label = "Lid";
+			gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_HIGH>;
+			linux,input-type = <5>; /* EV_SW */
+			linux,code = <0>; /* SW_LID */
+			debounce-interval = <1>;
+			gpio-key,wakeup;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index b047621b95d2..82037fe814ce 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -495,6 +495,19 @@
 		};
 	};
 
+	kbc at 7000e200 {
+		status = "okay";
+		nvidia,debounce-delay-ms = <20>;
+		nvidia,repeat-delay-ms = <160>;
+		nvidia,kbc-row-pins = <0 1 2>;
+		nvidia,kbc-col-pins = <16 17>;
+		nvidia,wakeup-source;
+		linux,keymap = <0x00000074	/* KEY_POWER */
+				0x01000066	/* KEY_HOME */
+				0x0101009E	/* KEY_BACK */
+				0x0201008B>;	/* KEY_MENU */
+	};
+
 	pmc at 7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
@@ -551,19 +564,6 @@
 		};
 	};
 
-	kbc at 7000e200 {
-		status = "okay";
-		nvidia,debounce-delay-ms = <20>;
-		nvidia,repeat-delay-ms = <160>;
-		nvidia,kbc-row-pins = <0 1 2>;
-		nvidia,kbc-col-pins = <16 17>;
-		nvidia,wakeup-source;
-		linux,keymap = <0x00000074	/* KEY_POWER */
-				0x01000066	/* KEY_HOME */
-				0x0101009E	/* KEY_BACK */
-				0x0201008B>;	/* KEY_MENU */
-	};
-
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index bc28e27e4fe7..3ad193c37436 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -168,19 +168,6 @@
 				<&gpio TEGRA_GPIO(X, 2) GPIO_ACTIVE_HIGH>;
 		};
 
-		tps62361 at 60 {
-			compatible = "ti,tps62361";
-			reg = <0x60>;
-
-			regulator-name = "tps62361-vout";
-			regulator-min-microvolt = <500000>;
-			regulator-max-microvolt = <1500000>;
-			regulator-boot-on;
-			regulator-always-on;
-			ti,vsel0-state-high;
-			ti,vsel1-state-high;
-		};
-
 		pmic: tps65911 at 2d {
 			compatible = "ti,tps65911";
 			reg = <0x2d>;
@@ -284,6 +271,19 @@
 				};
 			};
 		};
+
+		tps62361 at 60 {
+			compatible = "ti,tps62361";
+			reg = <0x60>;
+
+			regulator-name = "tps62361-vout";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-boot-on;
+			regulator-always-on;
+			ti,vsel0-state-high;
+			ti,vsel1-state-high;
+		};
 	};
 
 	spi at 7000da00 {
@@ -296,12 +296,6 @@
 		};
 	};
 
-	ahub at 70080000 {
-		i2s at 70080400 {
-			status = "okay";
-		};
-	};
-
 	pmc at 7000e400 {
 		status = "okay";
 		nvidia,invert-interrupt;
@@ -314,6 +308,12 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	ahub at 70080000 {
+		i2s at 70080400 {
+			status = "okay";
+		};
+	};
+
 	sdhci at 78000000 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
@@ -350,6 +350,19 @@
 		};
 	};
 
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		gpled1 {
+			label = "LED1"; /* CR5A1 (blue) */
+			gpios = <&gpio TEGRA_GPIO(L, 1) GPIO_ACTIVE_HIGH>;
+		};
+		gpled2 {
+			label = "LED2"; /* CR4A2 (green) */
+			gpios = <&gpio TEGRA_GPIO(L, 0) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -453,19 +466,6 @@
 		};
 	};
 
-	gpio-leds {
-		compatible = "gpio-leds";
-
-		gpled1 {
-			label = "LED1"; /* CR5A1 (blue) */
-			gpios = <&gpio TEGRA_GPIO(L, 1) GPIO_ACTIVE_HIGH>;
-		};
-		gpled2 {
-			label = "LED2"; /* CR4A2 (green) */
-			gpios = <&gpio TEGRA_GPIO(L, 0) GPIO_ACTIVE_HIGH>;
-		};
-	};
-
 	sound {
 		compatible = "nvidia,tegra-audio-rt5640-beaver",
 			     "nvidia,tegra-audio-rt5640";
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a02.dts b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
index 1082c5ed90d1..c9bfedcca6ed 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a02.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
@@ -8,6 +8,13 @@
 	model = "NVIDIA Tegra30 Cardhu A02 evaluation board";
 	compatible = "nvidia,cardhu-a02", "nvidia,cardhu", "nvidia,tegra30";
 
+	sdhci at 78000400 {
+		status = "okay";
+		power-gpios = <&gpio TEGRA_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
+		bus-width = <4>;
+		keep-power-in-suspend;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -83,12 +90,5 @@
 			gpio = <&gpio TEGRA_GPIO(K, 3) GPIO_ACTIVE_HIGH>;
 		};
 	};
-
-	sdhci at 78000400 {
-		status = "okay";
-		power-gpios = <&gpio TEGRA_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
-		bus-width = <4>;
-		keep-power-in-suspend;
-	};
 };
 
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
index bf012bddaafb..fadf55e46b2b 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
@@ -8,6 +8,13 @@
 	model = "NVIDIA Tegra30 Cardhu A04 (A05, A06, A07) evaluation board";
 	compatible = "nvidia,cardhu-a04", "nvidia,cardhu", "nvidia,tegra30";
 
+	sdhci at 78000400 {
+		status = "okay";
+		power-gpios = <&gpio TEGRA_GPIO(D, 3) GPIO_ACTIVE_HIGH>;
+		bus-width = <4>;
+		keep-power-in-suspend;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -95,11 +102,4 @@
 			gpio = <&gpio TEGRA_GPIO(DD, 0) GPIO_ACTIVE_HIGH>;
 		};
 	};
-
-	sdhci at 78000400 {
-		status = "okay";
-		power-gpios = <&gpio TEGRA_GPIO(D, 3) GPIO_ACTIVE_HIGH>;
-		bus-width = <4>;
-		keep-power-in-suspend;
-	};
 };
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index b159a41c7338..748b4ba945ee 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -326,12 +326,6 @@
 		};
 	};
 
-	ahub at 70080000 {
-		i2s at 70080400 {
-			status = "okay";
-		};
-	};
-
 	pmc at 7000e400 {
 		status = "okay";
 		nvidia,invert-interrupt;
@@ -344,6 +338,12 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	ahub at 70080000 {
+		i2s at 70080400 {
+			status = "okay";
+		};
+	};
+
 	sdhci at 78000000 {
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
-- 
1.8.1.5
