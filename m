From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 06 Nov 2015 13:03:49 +0300
Subject: [PATCH v7 4/4] ARM: dts: Add Ethernet chip to SMDK5410
In-Reply-To: <cover.1446799912.git.p.fedin@samsung.com>
References: <cover.1446799912.git.p.fedin@samsung.com>
Message-ID: <d129d652910aa3afb651e2c55382ef5d0bfebcf1.1446799912.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chip is smsc9115, connected via SROMc bank 3. Additionally, some GPIO
initialization is required.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5410-smdk5410.dts | 41 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5410.dtsi         |  6 +++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index cebeaab..373abf7 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "exynos5410.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 / {
 	model = "Samsung SMDK5410 board based on EXYNOS5410";
 	compatible = "samsung,smdk5410", "samsung,exynos5410", "samsung,exynos5";
@@ -61,6 +62,46 @@
 	disable-wp;
 };
 
+&pinctrl_0 {
+	srom_ctl: srom-ctl {
+		samsung,pins = "gpy0-3", "gpy0-4", "gpy0-5",
+			       "gpy1-0", "gpy1-1", "gpy1-2", "gpy1-3";
+		samsung,pin-function = <2>;
+		samsung,pin-drv = <0>;
+	};
+
+	srom_ebi: srom-ebi {
+		samsung,pins = "gpy3-0", "gpy3-1", "gpy3-2", "gpy3-3",
+			       "gpy3-4", "gpy3-5", "gpy3-6", "gpy3-7",
+			       "gpy5-0", "gpy5-1", "gpy5-2", "gpy5-3",
+			       "gpy5-4", "gpy5-5", "gpy5-6", "gpy5-7",
+			       "gpy6-0", "gpy6-1", "gpy6-2", "gpy6-3",
+			       "gpy6-4", "gpy6-5", "gpy6-6", "gpy6-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&sromc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&srom_ctl>, <&srom_ebi>;
+
+	ethernet at 3 {
+		compatible = "smsc,lan9115";
+		reg = <3 0 0x10000>;
+		phy-mode = "mii";
+		interrupt-parent = <&gpx0>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		reg-io-width = <2>;
+		smsc,irq-push-pull;
+		smsc,force-internal-phy;
+
+		samsung,srom-page-mode = <1>;
+		samsung,srom-timing = <9 12 1 9 1 1>;
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index e2b58f8..9cfb814 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -104,6 +104,12 @@
 		sromc: sromc at 12250000 {
 			compatible = "samsung,exynos-srom";
 			reg = <0x12250000 0x14>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x04000000 0x20000
+				  1 0 0x05000000 0x20000
+				  2 0 0x06000000 0x20000
+				  3 0 0x07000000 0x20000>;
 		};
 
 		pmu_system_controller: system-controller at 10040000 {
-- 
2.4.4
