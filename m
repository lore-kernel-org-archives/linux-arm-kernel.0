From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 15:31:13 +0100
Subject: [PATCH 5/8] clk: armada-370-xp: add support for clock framework
In-Reply-To: <1353421876-13759-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353421876-13759-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353421876-13759-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi        |   15 +++++++++++++
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   12 +++++++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |   19 +++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |   34 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp.dtsi         |   20 ++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig              |    4 ++++
 arch/arm/mach-mvebu/armada-370-xp.c      |    9 +++++++-
 7 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 2069151..175df28 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -75,5 +75,20 @@
 			#interrupts-cells = <2>;
 			interrupts = <91>;
 		};
+
+		coreclk: mvebu-sar at d0018230 {
+			compatible = "marvell,armada-370-core-clock";
+			reg = <0xd0018230 0x08>;
+			#clock-cells = <1>;
+		};
+
+		gateclk: clock-gating-control at d0018220 {
+			compatible = "marvell,armada-370-gating-clock";
+			reg = <0xd0018220 0x4>;
+			clocks = <&coreclk 0>;
+			#clock-cells = <1>;
+		};
+
+
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index ea35519..c45c7b4 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -24,6 +24,18 @@
 		gpio1 = &gpio1;
 	};
 
+	cpus {
+	    #address-cells = <1>;
+	    #size-cells = <0>;
+
+	    cpu at 0 {
+		device_type = "cpu";
+		compatible = "marvell,sheeva-v7";
+		reg = <0>;
+		clocks = <&cpuclk 0>;
+	    };
+	}
+
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78230-pinctrl";
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 2057863..a2aee57 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -25,6 +25,25 @@
 		gpio2 = &gpio2;
 	};
 
+	cpus {
+	    #address-cells = <1>;
+	    #size-cells = <0>;
+
+	    cpu at 0 {
+		device_type = "cpu";
+		compatible = "marvell,sheeva-v7";
+		reg = <0>;
+		clocks = <&cpuclk 0>;
+	    };
+
+	    cpu at 1 {
+		device_type = "cpu";
+		compatible = "marvell,sheeva-v7";
+		reg = <1>;
+		clocks = <&cpuclk 1>;
+	    };
+	};
+
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78260-pinctrl";
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index ffac983..da03a12 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -25,6 +25,40 @@
 		gpio2 = &gpio2;
 	};
 
+
+	cpus {
+	    #address-cells = <1>;
+	    #size-cells = <0>;
+
+	    cpu at 0 {
+		device_type = "cpu";
+		compatible = "marvell,sheeva-v7";
+		reg = <0>;
+		clocks = <&cpuclk 0>;
+	    };
+
+	    cpu at 1 {
+		device_type = "cpu";
+		compatible = "marvell,sheeva-v7";
+		reg = <1>;
+		clocks = <&cpuclk 1>;
+	    };
+
+	    cpu at 2 {
+		device_type = "cpu";
+		compatible = "marvell,sheeva-v7";
+		reg = <2>;
+		clocks = <&cpuclk 2>;
+	    };
+
+	    cpu at 3 {
+		device_type = "cpu";
+		compatible = "marvell,sheeva-v7";
+		reg = <3>;
+		clocks = <&cpuclk 3>;
+	    };
+	};
+
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78460-pinctrl";
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 71d6b5d..f51554e 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -47,6 +47,26 @@
 				marvell,timer-25Mhz;
 		};
 
+		coreclk: mvebu-sar at d0018230 {
+			compatible = "marvell,armada-xp-core-clock";
+			reg = <0xd0018230 0x08>;
+			#clock-cells = <1>;
+		};
+
+		cpuclk: clock-complex at d0018700 {
+			#clock-cells = <1>;
+			compatible = "marvell,armada-xp-cpu-clock";
+			reg = <0xd0018700 0xA0>;
+			clocks = <&coreclk 1>;
+		};
+
+		gateclk: clock-gating-control at d0018220 {
+			compatible = "marvell,armada-xp-gating-clock";
+			reg = <0xd0018220 0x4>;
+			clocks = <&coreclk 0>;
+			#clock-cells = <1>;
+		};
+
 		system-controller at d0018200 {
 				compatible = "marvell,armada-370-xp-system-controller";
 				reg = <0xd0018200 0x500>;
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 416d46e..79299cd 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -9,6 +9,10 @@ config ARCH_MVEBU
 	select PINCTRL
 	select PLAT_ORION
 	select SPARSE_IRQ
+	select CLKDEV_LOOKUP
+	select MVEBU_CLK_CORE
+	select MVEBU_CLK_CPU
+	select MVEBU_CLK_GATING
 
 if ARCH_MVEBU
 
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 49d7915..3292d6d 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/time-armada-370-xp.h>
+#include <linux/clk/mvebu.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -37,8 +38,14 @@ void __init armada_370_xp_map_io(void)
 	iotable_init(armada_370_xp_io_desc, ARRAY_SIZE(armada_370_xp_io_desc));
 }
 
+void __init armada_370_xp_timer_and_clk_init(void)
+{
+	mvebu_clocks_init();
+	armada_370_xp_timer_init();
+}
+
 struct sys_timer armada_370_xp_timer = {
-	.init		= armada_370_xp_timer_init,
+	.init		= armada_370_xp_timer_and_clk_init,
 };
 
 static void __init armada_370_xp_dt_init(void)
-- 
1.7.9.5
