From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Mar 2017 00:14:28 +0100
Subject: [PATCH] ARM: dts: rockchip: fix PPI misconfiguration on Cortex-A9 socs
Message-ID: <20170321231428.23802-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to [0] pointed out by Marc Zyngier in a report about a
similar error message, PPIs 11 and 13 are edge triggered on
Cortex-A9 socs including the rk3066 and rk3188 which currently
mark them as level triggered.

Until some time ago the gic did not care but commit 992345a58e0c
("irqchip/gic: WARN if setting the interrupt type for a PPI fails")
introduced a warning for that case.

Fix the warning on these socs by describing the interrupts correctly
and also using the binding constants for easier reading in the future.

[0] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0407f/CCHEIGIC.html

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188.dtsi | 4 ++--
 arch/arm/boot/dts/rk3xxx.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index cf91254d0a43..fa1bdb8875ae 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -529,11 +529,11 @@
 };
 
 &global_timer {
-	interrupts = <GIC_PPI 11 0xf04>;
+	interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 };
 
 &local_timer {
-	interrupts = <GIC_PPI 13 0xf04>;
+	interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 };
 
 &i2c0 {
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 4480534d1b46..39e3f8bded1c 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -132,14 +132,14 @@
 	global_timer: global-timer at 1013c200 {
 		compatible = "arm,cortex-a9-global-timer";
 		reg = <0x1013c200 0x20>;
-		interrupts = <GIC_PPI 11 0x304>;
+		interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 		clocks = <&cru CORE_PERI>;
 	};
 
 	local_timer: local-timer at 1013c600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x1013c600 0x20>;
-		interrupts = <GIC_PPI 13 0x304>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 		clocks = <&cru CORE_PERI>;
 	};
 
-- 
2.11.0
