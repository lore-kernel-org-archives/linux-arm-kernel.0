From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 21 Jun 2013 01:31:34 +0200
Subject: [PATCH v6 3/3] arm: add basic support for Rockchip RK3066a boards
In-Reply-To: <201306210129.54629.heiko@sntech.de>
References: <201306210129.54629.heiko@sntech.de>
Message-ID: <201306210131.34334.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a generic devicetree board file and a dtsi for boards
based on the RK3066a SoCs from Rockchip.

Apart from the generic parts (gic, clocks, pinctrl) the only components
currently supported are the timers, uarts and mmc ports (all DesignWare-
based).

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/Kconfig                  |    2 +
 arch/arm/Makefile                 |    1 +
 arch/arm/boot/dts/rk3066a.dtsi    |  390 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig    |   16 ++
 arch/arm/mach-rockchip/Makefile   |    1 +
 arch/arm/mach-rockchip/rockchip.c |   52 +++++
 6 files changed, 462 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a.dtsi
 create mode 100644 arch/arm/mach-rockchip/Kconfig
 create mode 100644 arch/arm/mach-rockchip/Makefile
 create mode 100644 arch/arm/mach-rockchip/rockchip.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ca30d75..6c696f5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1006,6 +1006,8 @@ source "arch/arm/mach-mmp/Kconfig"
 
 source "arch/arm/mach-realview/Kconfig"
 
+source "arch/arm/mach-rockchip/Kconfig"
+
 source "arch/arm/mach-sa1100/Kconfig"
 
 source "arch/arm/plat-samsung/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d7e5e8c..c01e4a7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -172,6 +172,7 @@ machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
 machine-$(CONFIG_ARCH_SIRF)		+= prima2
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
+machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
 machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx
 machine-$(CONFIG_ARCH_S3C64XX)		+= s3c64xx
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
new file mode 100644
index 0000000..56bfac9
--- /dev/null
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -0,0 +1,390 @@
+/*
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "skeleton.dtsi"
+#include "rk3066a-clocks.dtsi"
+
+/ {
+	compatible = "rockchip,rk3066a";
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x0>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x1>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		gic: interrupt-controller at 1013d000 {
+			compatible = "arm,cortex-a9-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x1013d000 0x1000>,
+			      <0x1013c100 0x0100>;
+		};
+
+		L2: l2-cache-controller at 10138000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x10138000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		local-timer at 1013c600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x1013c600 0x20>;
+			interrupts = <GIC_PPI 13 0x304>;
+			clocks = <&dummy150m>;
+		};
+
+		timer at 20038000 {
+			compatible = "snps,dw-apb-timer-osc";
+			reg = <0x20038000 0x100>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_gates1 0>, <&clk_gates7 7>;
+			clock-names = "timer", "pclk";
+		};
+
+		timer at 2003a000 {
+			compatible = "snps,dw-apb-timer-osc";
+			reg = <0x2003a000 0x100>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_gates1 1>, <&clk_gates7 8>;
+			clock-names = "timer", "pclk";
+		};
+
+		timer at 2000e000 {
+			compatible = "snps,dw-apb-timer-osc";
+			reg = <0x2000e000 0x100>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_gates1 2>, <&clk_gates7 9>;
+			clock-names = "timer", "pclk";
+		};
+
+		pinctrl at 20008000 {
+			compatible = "rockchip,rk3066a-pinctrl";
+			reg = <0x20008000 0x150>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			gpio0: gpio0 at 20034000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x20034000 0x100>;
+				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_gates8 9>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio1: gpio1 at 2003c000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x2003c000 0x100>;
+				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_gates8 10>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio2: gpio2 at 2003e000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x2003e000 0x100>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_gates8 11>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio3: gpio3 at 20080000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x20080000 0x100>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_gates8 12>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio4: gpio4 at 20084000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x20084000 0x100>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_gates8 13>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio6: gpio6 at 2000a000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x2000a000 0x100>;
+				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_gates8 15>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			pcfg_pull_default: pcfg_pull_default {
+				bias-pull-pin-default;
+			};
+
+			pcfg_pull_none: pcfg_pull_none {
+				bias-disable;
+			};
+
+			uart0 {
+				uart0_xfer: uart0-xfer {
+					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_default>,
+							<RK_GPIO1 1 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				uart0_cts: uart0-cts {
+					rockchip,pins = <RK_GPIO1 2 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				uart0_rts: uart0-rts {
+					rockchip,pins = <RK_GPIO1 3 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+			};
+
+			uart1 {
+				uart1_xfer: uart1-xfer {
+					rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 &pcfg_pull_default>,
+							<RK_GPIO1 5 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				uart1_cts: uart1-cts {
+					rockchip,pins = <RK_GPIO1 6 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				uart1_rts: uart1-rts {
+					rockchip,pins = <RK_GPIO1 7 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+			};
+
+			uart2 {
+				uart2_xfer: uart2-xfer {
+					rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 &pcfg_pull_default>,
+							<RK_GPIO1 9 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+				/* no rts / cts for uart2 */
+			};
+
+			uart3 {
+				uart3_xfer: uart3-xfer {
+					rockchip,pins = <RK_GPIO3 27 RK_FUNC_1 &pcfg_pull_default>,
+							<RK_GPIO3 28 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				uart3_cts: uart3-cts {
+					rockchip,pins = <RK_GPIO3 29 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				uart3_rts: uart3-rts {
+					rockchip,pins = <RK_GPIO3 30 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+			};
+
+			sd0 {
+				sd0_clk: sd0-clk {
+					rockchip,pins = <RK_GPIO3 8 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				sd0_cmd: sd0-cmd {
+					rockchip,pins = <RK_GPIO3 9 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				sd0_cd: sd0-cd {
+					rockchip,pins = <RK_GPIO3 14 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				sd0_wp: sd0-wp {
+					rockchip,pins = <RK_GPIO3 15 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				sd0_bus1: sd0-bus-width1 {
+					rockchip,pins = <RK_GPIO3 10 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				sd0_bus4: sd0-bus-width4 {
+					rockchip,pins = <RK_GPIO3 10 RK_FUNC_1 &pcfg_pull_default>,
+							<RK_GPIO3 11 RK_FUNC_1 &pcfg_pull_default>,
+							<RK_GPIO3 12 RK_FUNC_1 &pcfg_pull_default>,
+							<RK_GPIO3 13 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+			};
+
+			sd1 {
+				sd1_clk: sd1-clk {
+					rockchip,pins = <RK_GPIO3 21 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				sd1_cmd: sd1-cmd {
+					rockchip,pins = <RK_GPIO3 16 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				sd1_cd: sd1-cd {
+					rockchip,pins = <RK_GPIO3 22 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				sd1_wp: sd1-wp {
+					rockchip,pins = <RK_GPIO3 23 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				sd1_bus1: sd1-bus-width1 {
+					rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+
+				sd1_bus4: sd1-bus-width4 {
+					rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_default>,
+							<RK_GPIO3 18 RK_FUNC_1 &pcfg_pull_default>,
+							<RK_GPIO3 19 RK_FUNC_1 &pcfg_pull_default>,
+							<RK_GPIO3 20 RK_FUNC_1 &pcfg_pull_default>;
+					rockchip,config = <&pcfg_pull_default>;
+				};
+			};
+		};
+
+		uart0: serial at 10124000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x10124000 0x400>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+			clocks = <&clk_gates1 8>;
+			status = "disabled";
+		};
+
+		uart1: serial at 10126000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x10126000 0x400>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+			clocks = <&clk_gates1 10>;
+			status = "disabled";
+		};
+
+		uart2: serial at 20064000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x20064000 0x400>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+			clocks = <&clk_gates1 12>;
+			status = "disabled";
+		};
+
+		uart3: serial at 20068000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x20068000 0x400>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+			clocks = <&clk_gates1 14>;
+			status = "disabled";
+		};
+
+		dwmmc at 10214000 {
+			compatible = "rockchip,rk2928-dw-mshc";
+			reg = <0x10214000 0x1000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			clocks = <&clk_gates5 10>, <&clk_gates2 11>;
+			clock-names = "biu", "ciu";
+
+			status = "disabled";
+		};
+
+		dwmmc at 10218000 {
+			compatible = "rockchip,rk2928-dw-mshc";
+			reg = <0x10218000 0x1000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			clocks = <&clk_gates5 11>, <&clk_gates2 13>;
+			clock-names = "biu", "ciu";
+
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
new file mode 100644
index 0000000..25ee12b
--- /dev/null
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -0,0 +1,16 @@
+config ARCH_ROCKCHIP
+	bool "Rockchip RK2928 and RK3xxx SOCs" if ARCH_MULTI_V7
+	select PINCTRL
+	select PINCTRL_ROCKCHIP
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_GIC
+	select CACHE_L2X0
+	select HAVE_ARM_TWD if LOCAL_TIMERS
+	select HAVE_SMP
+	select LOCAL_TIMERS if SMP
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select DW_APB_TIMER_OF
+	help
+	  Support for Rockchip's Cortex-A9 Single-to-Quad-Core-SoCs
+	  containing the RK2928, RK30xx and RK31xx series.
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
new file mode 100644
index 0000000..1547d4f
--- /dev/null
+++ b/arch/arm/mach-rockchip/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_ROCKCHIP) += rockchip.o
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
new file mode 100644
index 0000000..724d2d8
--- /dev/null
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -0,0 +1,52 @@
+/*
+ * Device Tree support for Rockchip SoCs
+ *
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/irqchip.h>
+#include <linux/dw_apb_timer.h>
+#include <linux/clk-provider.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/hardware/cache-l2x0.h>
+
+static void __init rockchip_timer_init(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
+
+static void __init rockchip_dt_init(void)
+{
+	l2x0_of_init(0, ~0UL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const rockchip_board_dt_compat[] = {
+	"rockchip,rk2928",
+	"rockchip,rk3066a",
+	"rockchip,rk3066b",
+	"rockchip,rk3188",
+	NULL,
+};
+
+DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
+	.init_machine	= rockchip_dt_init,
+	.init_time	= rockchip_timer_init,
+	.dt_compat	= rockchip_board_dt_compat,
+MACHINE_END
-- 
1.7.10.4
