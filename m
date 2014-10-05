From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun,  5 Oct 2014 23:59:19 +0200
Subject: [PATCH v2 7/7] ARM: meson: enable L2 cache
In-Reply-To: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
References: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1412546359-15062-8-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the L2 cache controller available in Amlogic SoCs.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/boot/dts/meson.dtsi  | 7 +++++++
 arch/arm/boot/dts/meson6.dtsi | 2 ++
 arch/arm/boot/dts/meson8.dtsi | 4 ++++
 arch/arm/mach-meson/Kconfig   | 1 +
 arch/arm/mach-meson/meson.c   | 2 ++
 5 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 55feb14..7d27f12 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -50,6 +50,13 @@
 / {
 	interrupt-parent = <&gic>;
 
+	L2: l2-cache-controller at c4200000 {
+		compatible = "arm,pl310-cache";
+		reg = <0xc4200000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	gic: interrupt-controller at c4301000 {
 		compatible = "arm,cortex-a9-gic";
 		reg = <0xc4301000 0x1000>,
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index 4ba4912..8b33be1 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -60,12 +60,14 @@
 		cpu at 200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
 			reg = <0x200>;
 		};
 
 		cpu at 201 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
 			reg = <0x201>;
 		};
 	};
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 42e4026..1f442a7 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -58,24 +58,28 @@
 		cpu at 200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
 			reg = <0x200>;
 		};
 
 		cpu at 201 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
 			reg = <0x201>;
 		};
 
 		cpu at 202 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
 			reg = <0x202>;
 		};
 
 		cpu at 203 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
 			reg = <0x203>;
 		};
 	};
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index b289e8e..18301dc 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -2,6 +2,7 @@ menuconfig ARCH_MESON
 	bool "Amlogic Meson SoCs" if ARCH_MULTI_V7
 	select GENERIC_IRQ_CHIP
 	select ARM_GIC
+	select CACHE_L2X0
 
 if ARCH_MESON
 
diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
index 8f42d8f..5d6affe 100644
--- a/arch/arm/mach-meson/meson.c
+++ b/arch/arm/mach-meson/meson.c
@@ -24,4 +24,6 @@ static const char * const meson_common_board_compat[] = {
 
 DT_MACHINE_START(MESON, "Amlogic Meson platform")
 	.dt_compat	= meson_common_board_compat,
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 MACHINE_END
-- 
1.9.1
