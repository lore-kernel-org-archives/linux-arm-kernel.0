From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 18:09:16 +0200
Subject: [PATCH 2/2] arm64: dts: marvell: add CPU Idle power state support on
 Armada 7K/8K
In-Reply-To: <20180921160916.12393-1-gregory.clement@bootlin.com>
References: <20180921160916.12393-1-gregory.clement@bootlin.com>
Message-ID: <20180921160916.12393-3-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: orenbh <orenbh@marvell.com>

This patch adds CPU deep Idle and Cluster deep Idle states BUT it defines
the idle state for each cpu (defined under cpu-idle-states parameter)
only for the quad version therefore it does NOT activate CPU Idle
capability for the other version.

[gregory: extract from a larger patch]
Signed-off-by: orenbh <orenbh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../boot/dts/marvell/armada-ap806-quad.dtsi   |  4 +++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 27 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
index 01ea662afba8..64632c873888 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
@@ -20,24 +20,28 @@
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x001>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 		cpu2: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 		cpu3: cpu at 101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 27930394249d..4a65e4e830aa 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -27,6 +27,33 @@
 		method = "smc";
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		idle_states {
+			entry_method = "arm,pcsi";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <80>;
+				exit-latency-us  = <160>;
+				min-residency-us = <320>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x1010000>;
+				entry-latency-us = <500>;
+				exit-latency-us = <1000>;
+				min-residency-us = <2500>;
+			};
+		};
+	};
+
 	ap806 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.19.0
