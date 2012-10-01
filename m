From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  1 Oct 2012 23:12:05 +0200
Subject: [PATCH V2 2/3] clk: armada-370-xp: add support for clock framework
In-Reply-To: <1349125926-16144-1-git-send-email-gregory.clement@free-electrons.com>
References: <1349125926-16144-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1349125926-16144-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi   |   12 +++++++++
 arch/arm/boot/dts/armada-xp.dtsi    |   48 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig         |    5 ++++
 arch/arm/mach-mvebu/armada-370-xp.c |    8 +++++-
 arch/arm/mach-mvebu/common.h        |    1 +
 5 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 3228ccc..9bfc904 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -31,5 +31,17 @@
 				compatible = "marvell,armada-370-xp-system-controller";
 				reg = <0xd0018200 0x100>;
 		};
+		coreclk: mvebu-sar at d0018230 {
+			#clock-cells = <1>;
+			reg = <0xd0018230 0x08>;
+			compatible = "marvell,armada-370-core-clockctrl";
+			clock-output-names =
+				"tclk",	    /* 0 */
+				"pclk",	    /* 1 */
+				"nbclk",    /* 2 */
+				"hclk",	    /* 3 */
+				"dramclk",  /* 4 */
+		};
+
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 71d6b5d..e75f3a2 100644
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
+	       	compatible = "marvell,sheeva-v7";
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
@@ -47,6 +76,25 @@
 				marvell,timer-25Mhz;
 		};
 
+		coreclk: mvebu-sar at d0018230 {
+			#clock-cells = <1>;
+			reg = <0xd0018230 0x08>;
+			compatible = "marvell,armada-xp-core-clockctrl";
+			clock-output-names =
+				"tclk",	    /* 0 */
+				"pclk",	    /* 1 */
+				"nbclk",    /* 2 */
+				"hclk",	    /* 3 */
+				"dramclk",  /* 4 */
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
index caa2c5e..0370af9 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -2,10 +2,15 @@ if ARCH_MVEBU
 
 menu "Marvell SOC with device tree"
 
+config MVEBU_CLK_CPU
+	   bool
+
 config MACH_ARMADA_370_XP
 	bool "Marvell Armada 370 and Aramada XP boards"
 	select ARMADA_370_XP_TIMER
 	select CPU_V7
+	select CLKDEV_LOOKUP
+	select MVEBU_CLK_CPU
 	help
 
 	  Say 'Y' here if you want your kernel to support boards based on
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 4ef923b..612e2c2 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -37,8 +37,14 @@ void __init armada_370_xp_map_io(void)
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
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 02f89ea..281fab3 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -16,6 +16,7 @@
 #define __ARCH_MVEBU_COMMON_H
 
 void mvebu_restart(char mode, const char *cmd);
+void mvebu_clocks_init(void);
 
 void armada_370_xp_init_irq(void);
 void armada_370_xp_handle_irq(struct pt_regs *regs);
-- 
1.7.9.5
