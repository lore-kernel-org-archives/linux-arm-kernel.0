From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 18 Nov 2015 16:01:55 +0200
Subject: [4.4-rc][PATCH] ARM: dts: am4372: disable arm twd and global timer's
 nodes
Message-ID: <1447855315-419-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep ARM TWD and Global timer's nodes disabled by default - if someone
would like to use them then those nodes have to be enabled explicitly
in board file.

The reason for this change is:
- ARM TWD is not always-on timer on am437x and it will stop in low
  CPUIdle states and, therefore, broadcast timer has to configured
  properly if CPU_IDLE=y.
- ARM Global timer is not always-on timer on am437x and it can't be
  used as clocksource device if CPU_IDLE=y.
- ARM Global timer driver doesn't support CPUfreq now.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d83ff9c..11376e3 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -75,6 +75,7 @@
 		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
 		clocks = <&dpll_mpu_m2_ck>;
+		status = "disabled";
 	};
 
 	local_timer: timer at 48240600 {
@@ -83,6 +84,7 @@
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
 		clocks = <&dpll_mpu_m2_ck>;
+		status = "disabled";
 	};
 
 	l2-cache-controller at 48242000 {
-- 
2.6.3
