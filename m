From: drake@endlessm.com (Daniel Drake)
Date: Mon, 29 Sep 2014 15:42:14 -0600
Subject: [PATCH] ARM: dts: Enable temperature sensor on exynos4412 & ODROID
Message-ID: <1412026934-25947-1-git-send-email-drake@endlessm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos4412 has a Thermal Management Unit (TMU) which provides
a temperature sensor and related functionality.

This must be enabled on a per-board basis, as it requires a 100k
resistance to ground on the XtsRES_EXT pin, as well as a 1.8V input on
VDD18_TS pin. If that voltage is not supplied, the machine immediately
reports a maximum temperature of 255C and triggers the thermal subsystem
to shut down the system.

This patch also enables the TMU on the ODROID boards via the appropriate
power supply.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  5 +++++
 arch/arm/boot/dts/exynos4412.dtsi               | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 3d8c623..9994a44 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -400,3 +400,8 @@
 		samsung,pin-drv = <0>;
 	};
 };
+
+&tmu {
+	status = "okay";
+	vtmu-supply = <&ldo10_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 0f6ec93..ee58e7f 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -66,4 +66,14 @@
 	pmu_system_controller: system-controller at 10020000 {
 		compatible = "samsung,exynos4412-pmu", "syscon";
 	};
+
+	tmu: tmu at 100C0000 {
+		compatible = "samsung,exynos4412-tmu";
+		interrupt-parent = <&combiner>;
+		reg = <0x100C0000 0x100>;
+		interrupts = <2 4>;
+		clocks = <&clock CLK_TMU_APBIF>;
+		clock-names = "tmu_apbif";
+		status = "disabled";
+	};
 };
-- 
1.9.1
