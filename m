From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 Nov 2012 22:28:22 +0100
Subject: [PATCH 3/7] clk: armada-370-xp: add support for clock framework
In-Reply-To: <1353014906-31566-1-git-send-email-andrew@lunn.ch>
References: <1353014906-31566-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353014906-31566-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi   |    7 ++++++
 arch/arm/boot/dts/armada-xp.dtsi    |   42 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig         |    6 +++++
 arch/arm/mach-mvebu/armada-370-xp.c |    9 +++++++-
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 2069151..dae966c 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -75,5 +75,12 @@
 			#interrupts-cells = <2>;
 			interrupts = <91>;
 		};
+
+		coreclk: mvebu-sar at d0018230 {
+			compatible = "marvell,armada-370-core-clocks";
+			reg = <0xd0018230 0x08>;
+			#clock-cells = <1>;
+		};
+
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 71d6b5d..f8382a8 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -27,6 +27,35 @@
 		    <0xd0021870 0x58>;
 	};
 
+	cpus {
+	    #address-cells = <1>;
+	    #size-cells = <0>;
+
+	    cpu at 0 {
+		compatible = "marvell,sheeva-v7";
+		reg = <0>;
+		clocks = <&cpuclk 0>;
+	    };
+
+	    cpu at 1 {
+		compatible = "marvell,sheeva-v7";
+		reg = <1>;
+		clocks = <&cpuclk 1>;
+	    };
+
+	    cpu at 2 {
+		compatible = "marvell,sheeva-v7";
+		reg = <2>;
+		clocks = <&cpuclk 2>;
+	    };
+
+	    cpu at 3 {
+		compatible = "marvell,sheeva-v7";
+		reg = <3>;
+		clocks = <&cpuclk 3>;
+	    };
+	};
+
 	soc {
 		serial at d0012200 {
 				compatible = "ns16550";
@@ -47,6 +76,19 @@
 				marvell,timer-25Mhz;
 		};
 
+		coreclk: mvebu-sar at d0018230 {
+			compatible = "marvell,armada-xp-core-clocks";
+			reg = <0xd0018230 0x08>;
+			#clock-cells = <1>;
+		};
+
+		cpuclk: clock-complex at d0018700 {
+			#clock-cells = <1>;
+			compatible = "marvell,armada-xp-cpu-clockctrl";
+			reg = <0xd0018700 0xA0>;
+			clocks = <&coreclk 1>;
+		};
+
 		system-controller at d0018200 {
 				compatible = "marvell,armada-370-xp-system-controller";
 				reg = <0xd0018200 0x500>;
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 416d46e..e5f0ae2 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -9,11 +9,17 @@ config ARCH_MVEBU
 	select PINCTRL
 	select PLAT_ORION
 	select SPARSE_IRQ
+	select CLKDEV_LOOKUP
+	select MVEBU_CLK_CORE
+	select MVEBU_CLK_CPU
 
 if ARCH_MVEBU
 
 menu "Marvell SOC with device tree"
 
+config MVEBU_CLK_CPU
+	   bool
+
 config MACH_ARMADA_370_XP
 	bool
 	select ARMADA_370_XP_TIMER
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
1.7.10.4
