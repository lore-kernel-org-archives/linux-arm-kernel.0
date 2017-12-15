From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 15 Dec 2017 11:16:42 -0600
Subject: [PATCH 1/2] ARM: dts: am437x-idk-evm: Disable OPP50 for MPU
In-Reply-To: <20171215171643.8345-1-d-gerlach@ti.com>
References: <20171215171643.8345-1-d-gerlach@ti.com>
Message-ID: <20171215171643.8345-2-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x IDK has a TPS386000 supply voltage supervisor on the VDD_MPU rail
set to trigger undervoltage condition at 0.96V. Because of this, OPP50,
which is normally configured to 300MHz at 0.95V, must be disabled to
avoid triggering the undervoltage condition. Also mark OPP100 as the
suspend-opp as it is now our lowest OPP.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am437x-idk-evm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 5e364473067f..20132477a871 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -519,3 +519,17 @@
 &cpu {
 	cpu0-supply = <&tps>;
 };
+
+&cpu0_opp_table {
+	/*
+	 * Supply voltage supervisor on board will not allow opp50 so
+	 * disable it and set opp100 as suspend OPP.
+	 */
+	opp50 at 300000000 {
+		status = "disabled";
+	};
+
+	opp100 at 600000000 {
+		opp-suspend;
+	};
+};
-- 
2.15.1
