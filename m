From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 03 Jun 2012 18:12:49 +0530
Subject: [PATCH v2 6/6] ARM: dts: Add nodes for spi controllers for Samsung
 Exynos5 platforms
In-Reply-To: <1338727369-18241-1-git-send-email-thomas.abraham@linaro.org>
References: <1338727369-18241-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1338727369-18241-7-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device nodes for the three instances of spi controllers in Exynos5
platforms and enable instance spi 1 for smdk5250 board.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   38 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   36 +++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 49945cc..8a5e348 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -71,4 +71,42 @@
 	i2c at 12CD0000 {
 		status = "disabled";
 	};
+
+	spi_0: spi at 12d20000 {
+		status = "disabled";
+	};
+
+	spi_1: spi at 12d30000 {
+		gpios = <&gpa2 4 2 3 0>,
+			<&gpa2 6 2 3 0>,
+			<&gpa2 7 2 3 0>;
+
+		w25q80bw at 0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "w25x80";
+			reg = <0>;
+			spi-max-frequency = <1000000>;
+
+			controller-data {
+				cs-gpio = <&gpa2 5 1 0 3>;
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
+	spi_2: spi at 12d40000 {
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 4272b29..a3a2eb2 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -23,6 +23,12 @@
 	compatible = "samsung,exynos5250";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		spi0 = &spi_0;
+		spi1 = &spi_1;
+		spi2 = &spi_2;
+	};
+
 	gic:interrupt-controller at 10481000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
@@ -146,6 +152,36 @@
 		#size-cells = <0>;
 	};
 
+	spi_0: spi at 12d20000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x12d20000 0x100>;
+		interrupts = <0 66 0>;
+		tx-dma-channel = <&pdma0 5>;
+		rx-dma-channel = <&pdma0 4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	spi_1: spi at 12d30000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x12d30000 0x100>;
+		interrupts = <0 67 0>;
+		tx-dma-channel = <&pdma1 5>;
+		rx-dma-channel = <&pdma1 4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	spi_2: spi at 12d40000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x12d40000 0x100>;
+		interrupts = <0 68 0>;
+		tx-dma-channel = <&pdma0 7>;
+		rx-dma-channel = <&pdma0 6>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.6.6.rc2
