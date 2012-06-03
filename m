From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 03 Jun 2012 18:12:48 +0530
Subject: [PATCH v2 5/6] ARM: dts: Add nodes for spi controllers for Samsung
 Exynos4 platforms
In-Reply-To: <1338727369-18241-1-git-send-email-thomas.abraham@linaro.org>
References: <1338727369-18241-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1338727369-18241-6-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device nodes for the three instances of spi controllers in Exynos4
platforms. Enable instance spi 2 for smdkv310 board and disable all
spi instances for origen board.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts   |   12 +++++++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts |   38 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi         |   36 +++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index b8c4763..0c49caa 100644
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
index 27afc8e..1beccc8 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -179,4 +179,42 @@
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
+		gpios = <&gpc1 1 5 3 0>,
+			<&gpc1 3 5 3 0>,
+			<&gpc1 4 5 3 0>;
+
+		w25x80 at 0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "w25x80";
+			reg = <0>;
+			spi-max-frequency = <1000000>;
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
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index a1dd2ee..61be174 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -25,6 +25,12 @@
 	compatible = "samsung,exynos4210";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		spi0 = &spi_0;
+		spi1 = &spi_1;
+		spi2 = &spi_2;
+	};
+
 	gic:interrupt-controller at 10490000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
@@ -147,6 +153,36 @@
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
