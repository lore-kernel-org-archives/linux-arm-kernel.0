From: wxt@rock-chips.com (Caesar Wang)
Date: Fri,  1 Jul 2016 15:36:10 +0800
Subject: [PATCH 2/2] arm64: dts: rockchip: support the pmu node for rk3399
In-Reply-To: <1467358570-24417-1-git-send-email-wxt@rock-chips.com>
References: <1467358570-24417-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1467358570-24417-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the Marc posted the patches [0] to support Partitioning per-cpu
interrupts. Let's add this patch to match it on rk3399 SoCs.

[0]:
https://lkml.org/lkml/2016/4/11/182

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
CC: linux-arm-kernel at lists.infradead.org

---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 8f0a069..b260f62 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -165,6 +165,22 @@
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
 	};
 
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &part0>;
+		interrupt-affinity = <&cpu_l0>,
+				     <&cpu_l1>,
+				     <&cpu_l2>,
+				     <&cpu_l3>;
+	};
+
+	pmu_a72 {
+		compatible = "arm,cortex-a72-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &part1>;
+		interrupt-affinity = <&cpu_b0>,
+				     <&cpu_b1>;
+	};
+
 	xin24m: xin24m {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
@@ -296,6 +312,16 @@
 			msi-controller;
 			reg = <0x0 0xfee20000 0x0 0x20000>;
 		};
+
+		ppi-partitions {
+			part0: interrupt-partition-0 {
+				affinity = <&cpu_l0 &cpu_l1 &cpu_l2 &cpu_l3>;
+			};
+
+			part1: interrupt-partition-1 {
+				affinity = <&cpu_b0 &cpu_b1>;
+			};
+		};
 	};
 
 	i2c1: i2c at ff110000 {
-- 
1.9.1
