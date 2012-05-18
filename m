From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 18 May 2012 15:16:31 +0530
Subject: [PATCH 5/6] ARM: dts: Add nodes for spi controllers for Samsung
 Exynos4 platforms
In-Reply-To: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
References: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1337334392-6441-6-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device nodes for the three instances of spi controllers in Exynos4
platforms. Enable instance spi 2 for smdkv310 board and disable all
spi instances for origen board.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts   |   12 ++++++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts |   44 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi         |   30 +++++++++++++++++++
 3 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index b8c4763..f27d367 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -134,4 +134,16 @@
 	i2c at 138D0000 {
 		status = "disabled";
 	};
+
+	spi_0: spi at 13920000 {
+		status = "disabled";
+	};
+
+	spi_1: spi at 13930000 {
+		status = "disabled";
+	};
+
+	spi_2: spi at 13940000 {
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 27afc8e..411ac8e 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -21,6 +21,12 @@
 	model = "Samsung smdkv310 evaluation board based on Exynos4210";
 	compatible = "samsung,smdkv310", "samsung,exynos4210";
 
+	aliases {
+		spi0 = &spi_0;
+		spi1 = &spi_1;
+		spi2 = &spi_2;
+	};
+
 	memory {
 		reg = <0x40000000 0x80000000>;
 	};
@@ -42,6 +48,36 @@
 			<&gpk2 6 2 3 3>;
 	};
 
+	spi_2: spi at 13940000 {
+		gpios = <&gpc1 1 5 3 0>,
+			<&gpc1 3 5 3 0>,
+			<&gpc1 4 5 3 0>;
+
+		w25x80 at 0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "w25x80";
+			reg = <0>;
+			spi-max-frequency = <10000>;
+
+			controller-data {
+				cs-gpio = <&gpc1 2 1 0 3>;
+				samsung,spi-feedback-delay = <0>;
+			};
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0x0 0x40000>;
+				read-only;
+			};
+
+			partition at 40000 {
+				label = "Kernel";
+				reg = <0x40000 0xc0000>;
+			};
+		};
+	};
+
 	keypad at 100A0000 {
 		samsung,keypad-num-rows = <2>;
 		samsung,keypad-num-columns = <8>;
@@ -179,4 +215,12 @@
 	i2c at 138D0000 {
 		status = "disabled";
 	};
+
+	spi_0: spi at 13920000 {
+		status = "disabled";
+	};
+
+	spi_1: spi at 13930000 {
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index a1dd2ee..f107c5d 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -147,6 +147,36 @@
 		interrupts = <0 65 0>;
 	};
 
+	spi_0: spi at 13920000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x13920000 0x100>;
+		interrupts = <0 66 0>;
+		tx-dma-channel = <&pdma0 7>;
+		rx-dma-channel = <&pdma0 6>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	spi_1: spi at 13930000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x13930000 0x100>;
+		interrupts = <0 67 0>;
+		tx-dma-channel = <&pdma1 7>;
+		rx-dma-channel = <&pdma1 6>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	spi_2: spi at 13940000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x13940000 0x100>;
+		interrupts = <0 68 0>;
+		tx-dma-channel = <&pdma0 9>;
+		rx-dma-channel = <&pdma0 8>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.6.6.rc2
