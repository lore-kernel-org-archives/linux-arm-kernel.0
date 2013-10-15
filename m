From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 13:00:03 +0200
Subject: [PATCH 2/5] ARM: rockchip: enable arm-global-timer
In-Reply-To: <201310151258.53435.heiko@sntech.de>
References: <201310151258.53435.heiko@sntech.de>
Message-ID: <201310151300.03542.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK2928 and RK3066 contain a dw_apb timer component, while the rk3188 uses
a slightly similar but still different timer component. But all of them
support the ARM-global-timer that got added as clocksource driver recently.

So enable support for it to get a working clocksource for rk3188.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3xxx.dtsi  |    7 +++++++
 arch/arm/mach-rockchip/Kconfig |    2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index fd3e476..0fcbcfd 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -41,6 +41,13 @@
 			cache-level = <2>;
 		};
 
+		global-timer at 1013c200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x1013c200 0x20>;
+			interrupts = <GIC_PPI 11 0x304>;
+			clocks = <&dummy150m>;
+		};
+
 		local-timer at 1013c600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x1013c600 0x20>;
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 25ee12b..6fef464 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -11,6 +11,8 @@ config ARCH_ROCKCHIP
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select DW_APB_TIMER_OF
+	select ARM_GLOBAL_TIMER
+	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	help
 	  Support for Rockchip's Cortex-A9 Single-to-Quad-Core-SoCs
 	  containing the RK2928, RK30xx and RK31xx series.
-- 
1.7.10.4
