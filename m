From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Nov 2015 10:58:03 +0900
Subject: [PATCH] ARM: shmobile: r8a7779: Add L2 cache-controller node
Message-ID: <1448416683-1411-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing L2 cache-controller node, and link the CPU nodes to it.

The L2 cache is an ARM L2C-310 (r3p2), of size 1 MB (64 KiB x 16 ways).

Based on work for the r8a7740 by Geert Uytterhoeven.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

* About the r8a7778 (M1A)

  My reading of the documentation is that although a pl310 L2 cache
  controller is present it is not available for use as there is no L2
  cache memory present. For this reason I do not intend to follow up
  with a similar patch for the r8a7798.

* Lightly tested against renesas-devel-20151124-v4.4-rc2
---
 arch/arm/boot/dts/r8a7779.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 6afa909865b5..f27fa2db16ee 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -28,24 +28,28 @@
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			next-level-cache = <&L2>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			next-level-cache = <&L2>;
 		};
 		cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
 			clock-frequency = <1000000000>;
+			next-level-cache = <&L2>;
 		};
 		cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
 			clock-frequency = <1000000000>;
+			next-level-cache = <&L2>;
 		};
 	};
 
@@ -63,6 +67,17 @@
 		      <0xf0000100 0x100>;
 	};
 
+	L2: cache-controller {
+		compatible = "arm,pl310-cache";
+		reg = <0xf0100000 0x1000>;
+		interrupts = <0 122 IRQ_TYPE_LEVEL_HIGH>;
+		arm,data-latency = <3 3 3>;
+		arm,tag-latency = <2 2 2>;
+		arm,shared-override;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	timer at f0000600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0xf0000600 0x20>;
-- 
2.1.4
