From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 4 Apr 2012 17:05:36 +0530
Subject: [PATCH V2 4/4] SPEAr3xx: Add pinctrl support for boards
In-Reply-To: <cover.1333538869.git.viresh.kumar@st.com>
References: <cover.1333538869.git.viresh.kumar@st.com>
Message-ID: <1ac94a157f9b15d0eabce4768ff83338cbd4ff4a.1333538870.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/boot/dts/spear300-evb.dts |    4 ++++
 arch/arm/boot/dts/spear300.dtsi    |    5 +++++
 arch/arm/boot/dts/spear310.dtsi    |    5 +++++
 arch/arm/boot/dts/spear320-evb.dts |    4 ++++
 arch/arm/boot/dts/spear320.dtsi    |    7 ++++++-
 arch/arm/mach-spear3xx/Kconfig     |    3 +++
 arch/arm/mach-spear3xx/spear300.c  |   25 +++++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear310.c  |   30 ++++++++++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear320.c  |   29 +++++++++++++++++++++++++++++
 arch/arm/plat-spear/Kconfig        |    1 +
 10 files changed, 112 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear300-evb.dts
index eaecc29..219cdaf 100644
--- a/arch/arm/boot/dts/spear300-evb.dts
+++ b/arch/arm/boot/dts/spear300-evb.dts
@@ -25,6 +25,10 @@
 	};
 
 	ahb {
+		pinmux at 99000000 {
+			st,pinmux-mode=<2>;
+		};
+
 		clcd at 60000000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
index f9fcbf4..01c5e35 100644
--- a/arch/arm/boot/dts/spear300.dtsi
+++ b/arch/arm/boot/dts/spear300.dtsi
@@ -21,6 +21,11 @@
 		ranges = <0x60000000 0x60000000 0x50000000
 			  0xd0000000 0xd0000000 0x30000000>;
 
+		pinmux at 99000000 {
+			compatible = "st,spear300-pinmux";
+			reg = <0x99000000 0x1000>;
+		};
+
 		clcd at 60000000 {
 			compatible = "arm,clcd-pl110", "arm,primecell";
 			reg = <0x60000000 0x1000>;
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index dc7fa14..e47081c 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -22,6 +22,11 @@
 			  0xb0000000 0xb0000000 0x10000000
 			  0xd0000000 0xd0000000 0x30000000>;
 
+		pinmux at b4000000 {
+			compatible = "st,spear310-pinmux";
+			reg = <0xb4000000 0x1000>;
+		};
+
 		fsmc: flash at 44000000 {
 			compatible = "st,spear600-fsmc-nand";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index d43de71..d675057 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -25,6 +25,10 @@
 	};
 
 	ahb {
+		pinmux at b3000000 {
+			st,pinmux-mode=<3>;
+		};
+
 		clcd at 90000000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index 9a0267a..5372ca3 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -18,9 +18,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		ranges = <0x40000000 0x40000000 0x70000000
+		ranges = <0x40000000 0x40000000 0x80000000
 			  0xd0000000 0xd0000000 0x30000000>;
 
+		pinmux at b3000000 {
+			compatible = "st,spear320-pinmux";
+			reg = <0xb3000000 0x1000>;
+		};
+
 		clcd at 90000000 {
 			compatible = "arm,clcd-pl110", "arm,primecell";
 			reg = <0x90000000 0x1000>;
diff --git a/arch/arm/mach-spear3xx/Kconfig b/arch/arm/mach-spear3xx/Kconfig
index d9fe11c..8bd3729 100644
--- a/arch/arm/mach-spear3xx/Kconfig
+++ b/arch/arm/mach-spear3xx/Kconfig
@@ -7,16 +7,19 @@ if ARCH_SPEAR3XX
 menu "SPEAr3xx Implementations"
 config MACH_SPEAR300
 	bool "SPEAr300 Machine support with Device Tree"
+	select PINCTRL_SPEAR300
 	help
 	  Supports ST SPEAr300 machine configured via the device-tree
 
 config MACH_SPEAR310
 	bool "SPEAr310 Machine support with Device Tree"
+	select PINCTRL_SPEAR310
 	help
 	  Supports ST SPEAr310 machine configured via the device-tree
 
 config MACH_SPEAR320
 	bool "SPEAr320 Machine support with Device Tree"
+	select PINCTRL_SPEAR320
 	help
 	  Supports ST SPEAr320 machine configured via the device-tree
 endmenu
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 2db0bd1..a08eccd 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -15,6 +15,7 @@
 
 #include <linux/amba/pl08x.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/machine.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <plat/shirq.h>
@@ -270,6 +271,24 @@ static struct of_dev_auxdata spear300_auxdata_lookup[] __initdata = {
 	{}
 };
 
+static struct pinctrl_map __initdata spear300_evb_pmx_map[] = {
+	/* spear3xx per-device maps */
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", NULL, "i2c0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", NULL, "ssp0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", NULL, "mii0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", NULL, "uart0"),
+
+	/* spear310 per-device maps */
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", "clcd_pfmode_grp",
+			"clcd"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", "sdhci_4bit_grp",
+			"sdhci"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", "gpio1_0_to_3_grp",
+			"gpio"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("99000000.pinmux", "gpio1_4_to_7_grp",
+			"gpio"),
+};
+
 static void __init spear300_dt_init(void)
 {
 	int ret;
@@ -287,6 +306,12 @@ static void __init spear300_dt_init(void)
 		if (ret)
 			pr_err("Error registering Shared IRQ\n");
 	}
+
+	if (of_machine_is_compatible("st,spear300-evb")) {
+		if (pinctrl_register_mappings(spear300_evb_pmx_map,
+					ARRAY_SIZE(spear300_evb_pmx_map)))
+			pr_err("Error registering pinmux map\n");
+	}
 }
 
 static const char * const spear300_dt_board_compat[] = {
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index aec07c9..848ab78 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -16,6 +16,7 @@
 #include <linux/amba/pl08x.h>
 #include <linux/amba/serial.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/machine.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <plat/shirq.h>
@@ -369,6 +370,29 @@ static struct of_dev_auxdata spear310_auxdata_lookup[] __initdata = {
 	{}
 };
 
+static struct pinctrl_map __initdata spear310_evb_pmx_map[] = {
+	/* spear3xx per-device maps */
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "gpio0_pin0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "gpio0_pin1"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "gpio0_pin2"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "gpio0_pin3"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "gpio0_pin4"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "gpio0_pin5"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "i2c0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "mii0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "ssp0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "uart0"),
+
+	/* spear310 per-device maps */
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "emi"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "fsmc"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "uart1"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "uart2"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "uart3"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "uart4"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b4000000.pinmux", NULL, "uart5"),
+};
+
 static void __init spear310_dt_init(void)
 {
 	void __iomem *base;
@@ -407,6 +431,12 @@ static void __init spear310_dt_init(void)
 		if (ret)
 			pr_err("Error registering Shared IRQ 4\n");
 	}
+
+	if (of_machine_is_compatible("st,spear310-evb")) {
+		if (pinctrl_register_mappings(spear310_evb_pmx_map,
+					ARRAY_SIZE(spear310_evb_pmx_map)))
+			pr_err("Error registering pinmux map\n");
+	}
 }
 
 static const char * const spear310_dt_board_compat[] = {
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 4812c69..67a8a8a 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -17,6 +17,7 @@
 #include <linux/amba/pl08x.h>
 #include <linux/amba/serial.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/machine.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <plat/shirq.h>
@@ -381,6 +382,28 @@ static struct of_dev_auxdata spear320_auxdata_lookup[] __initdata = {
 	{}
 };
 
+static struct pinctrl_map __initdata spear320_evb_pmx_map[] = {
+	/* spear3xx per-device maps */
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", NULL, "i2c0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", NULL, "mii0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", NULL, "ssp0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", NULL, "uart0"),
+
+	/* spear320 per-device maps */
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", "sdhci_cd_51_grp",
+			"sdhci"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", NULL, "i2s"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", NULL, "uart1"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", NULL, "uart2"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", NULL, "can0"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", NULL, "can1"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", NULL, "mii2"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", "pwm0_1_pin_14_15_grp",
+			"pwm0_1"),
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT("b3000000.pinmux", "pwm2_pin_13_grp",
+			"pwm2"),
+};
+
 static void __init spear320_dt_init(void)
 {
 	void __iomem *base;
@@ -413,6 +436,12 @@ static void __init spear320_dt_init(void)
 		if (ret)
 			pr_err("Error registering Shared IRQ 4\n");
 	}
+
+	if (of_machine_is_compatible("st,spear320-evb")) {
+		if (pinctrl_register_mappings(spear320_evb_pmx_map,
+					ARRAY_SIZE(spear320_evb_pmx_map)))
+			pr_err("Error registering pinmux map\n");
+	}
 }
 
 static const char * const spear320_dt_board_compat[] = {
diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index 6c066fc..387655b 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -13,6 +13,7 @@ config ARCH_SPEAR3XX
 	select ARM_VIC
 	select CPU_ARM926T
 	select USE_OF
+	select PINCTRL
 	help
 	  Supports for ARM's SPEAR3XX family
 
-- 
1.7.9
