From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 19:31:27 +0800
Subject: [PATCH V4 1/2] ARM: dt: tegra: add clock source of PMC
In-Reply-To: <1364988688-24613-1-git-send-email-josephl@nvidia.com>
References: <1364988688-24613-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364988688-24613-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the bindings of the clock source of PMC in DT.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V4:
* move the c code to the patch 2/2 of this series
* the clock related define should be required properties
* fix the oreder of clocks node in DTS file
* add Tegra114 support
V3:
* add clk32k_in as one of the PMC clock source.
* add a fixed clock of clk32k_in for Tegra20 & Tegra30
* add binding document for the clock source of PMC
* get the clock from DT by of_get_clk_by_name()
* fix WARN_ON_ONCE to WARN_ON when there is no clock define in DT
V2:
* new in this series
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 29 +++++++++++++++++++++-
 arch/arm/boot/dts/tegra114-dalmore.dts             | 13 ++++++++++
 arch/arm/boot/dts/tegra114-pluto.dts               | 13 ++++++++++
 arch/arm/boot/dts/tegra114.dtsi                    |  2 ++
 arch/arm/boot/dts/tegra20-colibri-512.dtsi         | 13 ++++++++++
 arch/arm/boot/dts/tegra20-harmony.dts              | 13 ++++++++++
 arch/arm/boot/dts/tegra20-paz00.dts                | 13 ++++++++++
 arch/arm/boot/dts/tegra20-seaboard.dts             | 13 ++++++++++
 arch/arm/boot/dts/tegra20-tamonten.dtsi            | 13 ++++++++++
 arch/arm/boot/dts/tegra20-trimslice.dts            | 13 ++++++++++
 arch/arm/boot/dts/tegra20-ventana.dts              | 13 ++++++++++
 arch/arm/boot/dts/tegra20-whistler.dts             | 13 ++++++++++
 arch/arm/boot/dts/tegra20.dtsi                     |  2 ++
 arch/arm/boot/dts/tegra30-beaver.dts               | 13 ++++++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi              | 13 ++++++++++
 arch/arm/boot/dts/tegra30.dtsi                     |  2 ++
 16 files changed, 190 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index b5846e2..ee529b1 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -1,9 +1,15 @@
 NVIDIA Tegra Power Management Controller (PMC)
 
-Properties:
+Required properties:
 - name : Should be pmc
 - compatible : Should contain "nvidia,tegra<chip>-pmc".
 - reg : Offset and length of the register set for the device
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must include the following entries:
+  "pclk" (The Tegra clock of that name),
+  "clk32k_in" (The 32KHz clock input to Tegra).
+
+Optional properties:
 - nvidia,invert-interrupt : If present, inverts the PMU interrupt signal.
   The PMU is an external Power Management Unit, whose interrupt output
   signal is fed into the PMC. This signal is optionally inverted, and then
@@ -12,8 +18,29 @@ Properties:
 
 Example:
 
+/ SoC dts including file
 pmc at 7000f400 {
 	compatible = "nvidia,tegra20-pmc";
 	reg = <0x7000e400 0x400>;
+	clocks = <&tegra_car 110>, <&clk32k_in>;
+	clock-names = "pclk", "clk32k_in";
 	nvidia,invert-interrupt;
 };
+
+/ Tegra board dts file
+{
+	...
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+	...
+};
diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index ad27ea7..4aa2897 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -839,6 +839,19 @@
 		status = "okay";
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra114-pluto.dts b/arch/arm/boot/dts/tegra114-pluto.dts
index 9bea8f5..5deb869 100644
--- a/arch/arm/boot/dts/tegra114-pluto.dts
+++ b/arch/arm/boot/dts/tegra114-pluto.dts
@@ -18,4 +18,17 @@
 	pmc {
 		nvidia,invert-interrupt;
 	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 5302044..4eb87b8 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -301,6 +301,8 @@
 	pmc {
 		compatible = "nvidia,tegra114-pmc";
 		reg = <0x7000e400 0x400>;
+		clocks = <&tegra_car 261>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
 	};
 
 	iommu {
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index 79af149..d953ccc 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -447,6 +447,19 @@
 		cd-gpios = <&gpio 23 1>; /* gpio PC7 */
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-wm9712-colibri_t20",
 			         "nvidia,tegra-audio-wm9712";
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 5fb0888..2c4da87 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -451,6 +451,19 @@
 		bus-width = <8>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	kbc {
 		status = "okay";
 		nvidia,debounce-delay-ms = <2>;
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 43fd28b..c421db4 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -447,6 +447,19 @@
 		bus-width = <8>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 4f810a5..b8f0400 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -595,6 +595,19 @@
 		bus-width = <8>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 6e9d91f..c190257 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -471,6 +471,19 @@
 		status = "okay";
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 955bf49..51b3a44 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -330,6 +330,19 @@
 		bus-width = <4>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	poweroff {
 		compatible = "gpio-poweroff";
 		gpios = <&gpio 191 1>; /* gpio PX7, active low */
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 3f8ae10..7095e96 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -531,6 +531,19 @@
 		bus-width = <8>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 87e2d85..99746c6 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -520,6 +520,19 @@
 		bus-width = <8>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	kbc {
 		status = "okay";
 		nvidia,debounce-delay-ms = <20>;
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 26c1134..5fc661d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -419,6 +419,8 @@
 	pmc {
 		compatible = "nvidia,tegra20-pmc";
 		reg = <0x7000e400 0x400>;
+		clocks = <&tegra_car 110>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
 	};
 
 	memory-controller at 7000f000 {
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 0a2cd24..6248b24 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -268,6 +268,19 @@
 		bus-width = <8>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 11204e1..7edd51e 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -322,6 +322,19 @@
 		bus-width = <8>;
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock {
+			compatible = "fixed-clock";
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 6042cc1..15ded60 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -428,6 +428,8 @@
 	pmc {
 		compatible = "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
+		clocks = <&tegra_car 218>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
 	};
 
 	memory-controller {
-- 
1.8.2
