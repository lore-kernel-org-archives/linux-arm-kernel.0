From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  6 Sep 2016 02:17:15 +0800
Subject: [PATCH v3 2/2] arm64: dts: rockchip: support the pmu node for rk3399
In-Reply-To: <1473099435-28198-1-git-send-email-wxt@rock-chips.com>
References: <1473099435-28198-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1473099435-28198-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds to enable the ARM Performance Monitor Units for rk3399.
ARM cores often have a PMU for counting cpu and cache events like cache
misses and hits.

Also, as the Marc posted the patches [0] to support Partitioning per-cpu
interrupts. Let's add this patch to match it on rk3399 SoCs.

[0]:
https://lkml.org/lkml/2016/4/11/182

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
CC: linux-arm-kernel at lists.infradead.org

---

Changes in v3:
- updated on next kernel(20160905).
- add the Mark's ACK for PATCH[2/2].

Changes in v2:
- AS Mark comments on https://patchwork.kernel.org/patch/9209369/
  remove the interrupt-affinity property, we need depend on Marc' perf
  code on https://patchwork.kernel.org/patch/9209369/.

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e9e22fe..4e65f3b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -166,6 +166,16 @@
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
 	};
 
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &part0>;
+	};
+
+	pmu_a72 {
+		compatible = "arm,cortex-a72-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &part1>;
+	};
+
 	xin24m: xin24m {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
@@ -354,6 +364,16 @@
 		status = "disabled";
 	};
 
+	ppi-partitions {
+		part0: interrupt-partition-0 {
+			affinity = <&cpu_l0 &cpu_l1 &cpu_l2 &cpu_l3>;
+		};
+
+		part1: interrupt-partition-1 {
+			affinity = <&cpu_b0 &cpu_b1>;
+		};
+	};
+
 	i2c1: i2c at ff110000 {
 		compatible = "rockchip,rk3399-i2c";
 		reg = <0x0 0xff110000 0x0 0x1000>;
-- 
1.9.1
