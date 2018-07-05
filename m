From: arnaud.ferraris.external@sigfox.com (Arnaud Ferraris)
Date: Thu,  5 Jul 2018 16:30:41 +0200
Subject: [PATCH] arm64: dts: marvell: a3700: reserve ATF memory
Message-ID: <1530801041-6909-1-git-send-email-arnaud.ferraris.external@sigfox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell Armada 3700, the ARM Trusted Firmware is loaded in RAM at address
0x04000000, and can use up to 16MiB (0x01000000).

As the ATF is responsible for handling PSCI calls (including, but not limited
to, system reset management), its memory area should never be overwritten
during runtime.

Declaring a range of reserved memory solves this problem.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris.external@sigfox.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 3353252..2110e7d 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -34,6 +34,17 @@
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		arm-trusted-firmware at 4000000 {
+			no-map;
+			reg = <0x0 0x04000000 0x0 0x01000000>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
-- 
2.7.4
