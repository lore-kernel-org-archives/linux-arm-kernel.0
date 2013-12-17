From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 17 Dec 2013 22:41:13 +0100
Subject: [RFC PATCH v5 4/4] mvebu: Dove: Add PMU node for cpufreq driver
In-Reply-To: <1387316473-3250-1-git-send-email-andrew@lunn.ch>
References: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
 <1387316473-3250-1-git-send-email-andrew@lunn.ch>
Message-ID: <1387316473-3250-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpufreq driver uses the PMU node in the device tree, since it is
part of the PMU device. The dove-cpufreq driver needs access to the
DDR and CPU clock, which are the two clocks the CPU can use. There is
also an interrupt generated when the DFS hardware completes a change
of frequencey. Add these to the DT.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/dove.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 4c8028513133..42b9810e96c1 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -136,6 +136,16 @@
 				marvell,#interrupts = <5>;
 			};
 
+			pmu: pmu at d0000 {
+				compatible = "marvell,dove-pmu";
+				reg = <0xd0000 0x0700>,
+				      <0xd8000 0x0140>;
+				clocks = <&core_clk 1>, <&core_clk 3>;
+				clock-names = "cpu", "ddr";
+				interrupt-parent = <&pmu_intc>;
+				interrupts = <0>;
+			};
+
 			pmu_intc: pmu-interrupt-ctrl at d0050 {
 				compatible = "marvell,dove-pmu-intc";
 				interrupt-controller;
-- 
1.8.5.1
