From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:26:14 +0900
Subject: [PATCH v4 7/8] ARM: dts: Use labels for overriding nodes in
 exynos5440 boards
In-Reply-To: <1431851175-32624-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431851175-32624-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431851175-32624-8-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos5440-sd5v1.dts    | 10 ++--
 arch/arm/boot/dts/exynos5440-ssdk5440.dts | 85 +++++++++++++++----------------
 2 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440-sd5v1.dts b/arch/arm/boot/dts/exynos5440-sd5v1.dts
index 268609a42b2c..a98501bab6fc 100644
--- a/arch/arm/boot/dts/exynos5440-sd5v1.dts
+++ b/arch/arm/boot/dts/exynos5440-sd5v1.dts
@@ -27,13 +27,13 @@
 		};
 	};
 
-	gmac: ethernet at 00230000 {
-		fixed_phy;
-		phy_addr = <1>;
-	};
-
 	spi {
 		status = "disabled";
 	};
 
 };
+
+&gmac {
+	fixed_phy;
+	phy_addr = <1>;
+};
diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index ff55dac6e219..e4443f4e6572 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -20,59 +20,58 @@
 		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel earlyprintk no_console_suspend mem=2048M at 0x80000000 mem=6144M at 0x100000000 console=ttySAC0,115200";
 	};
 
-	spi_0: spi at D0000 {
-
-		flash: w25q128 at 0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "winbond,w25q128";
-			spi-max-frequency = <15625000>;
-			reg = <0>;
-			controller-data {
-				samsung,spi-feedback-delay = <0>;
-			};
+	fixed-rate-clocks {
+		xtal {
+			compatible = "samsung,clock-xtal";
+			clock-frequency = <50000000>;
+		};
+	};
+};
 
-			partition at 00000 {
-				label = "BootLoader";
-				reg = <0x60000 0x80000>;
-				read-only;
-			};
+&pcie_0 {
+	reset-gpio = <&pin_ctrl 5 0>;
+	status = "okay";
+};
 
-			partition at e0000 {
-				label = "Recovery-Kernel";
-				reg = <0xe0000 0x300000>;
-				read-only;
-			};
+&pcie_1 {
+	reset-gpio = <&pin_ctrl 22 0>;
+	status = "okay";
+};
 
-			partition at 3e0000 {
-				label = "CRAM-FS";
-				reg = <0x3e0000 0x700000>;
-				read-only;
-			};
+&spi_0 {
+	flash: w25q128 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128";
+		spi-max-frequency = <15625000>;
+		reg = <0>;
+		controller-data {
+			samsung,spi-feedback-delay = <0>;
+		};
 
-			partition at ae0000 {
-				label = "User-Data";
-				reg = <0xae0000 0x520000>;
-			};
+		partition at 00000 {
+			label = "BootLoader";
+			reg = <0x60000 0x80000>;
+			read-only;
+		};
 
+		partition at e0000 {
+			label = "Recovery-Kernel";
+			reg = <0xe0000 0x300000>;
+			read-only;
 		};
 
-	};
+		partition at 3e0000 {
+			label = "CRAM-FS";
+			reg = <0x3e0000 0x700000>;
+			read-only;
+		};
 
-	fixed-rate-clocks {
-		xtal {
-			compatible = "samsung,clock-xtal";
-			clock-frequency = <50000000>;
+		partition at ae0000 {
+			label = "User-Data";
+			reg = <0xae0000 0x520000>;
 		};
-	};
 
-	pcie at 290000 {
-		reset-gpio = <&pin_ctrl 5 0>;
-		status = "okay";
 	};
 
-	pcie at 2a0000 {
-		reset-gpio = <&pin_ctrl 22 0>;
-		status = "okay";
-	};
 };
-- 
2.1.4
