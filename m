From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 22 Mar 2017 18:48:33 +0300
Subject: [PATCH v7 6/7] ARM: dts: rockchip: add timer entries to rk3188 SoC
In-Reply-To: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1490197714-25415-7-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch add two timers to all rk3188 based boards.

The first timer is from alive subsystem and it act as a backup
for the local timers at sleep time. It act the same as other
SoC rockchip timers already present in kernel.

The second timer is from CPU subsystem and act as replacement
for the arm-global-timer clocksource and sched clock. It run
at stable frequency 24MHz.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index b3e6a30..a20d501 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -106,6 +106,24 @@
 		};
 	};
 
+	timer3: timer at 2000e000 {
+		compatible = "rockchip,rk3188-timer", "rockchip,rk3288-timer";
+		reg = <0x2000e000 0x20>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TIMER3>, <&cru PCLK_TIMER3>;
+		clock-names = "timer", "pclk";
+		clockevent;
+	};
+
+	timer6: timer at 200380a0 {
+		compatible = "rockchip,rk3188-timer", "rockchip,rk3288-timer";
+		reg = <0x200380a0 0x20>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TIMER6>, <&cru PCLK_TIMER0>;
+		clock-names = "timer", "pclk";
+		clocksource;
+	};
+
 	i2s0: i2s at 1011a000 {
 		compatible = "rockchip,rk3188-i2s", "rockchip,rk3066-i2s";
 		reg = <0x1011a000 0x2000>;
-- 
1.7.9.5
