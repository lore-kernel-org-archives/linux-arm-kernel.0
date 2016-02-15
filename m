From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 15 Feb 2016 21:38:33 +0100
Subject: [PATCH v3 5/7] ARM: dts: r8a7794: Add L2 cache-controller node
In-Reply-To: <1455568715-20880-1-git-send-email-geert+renesas@glider.be>
References: <1455568715-20880-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1455568715-20880-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the L2 cache, and link the CPU nodes to it.

The L2 cache for the Cortex-A7 CPU cores is 512 KiB large (organized as
64 KiB x 8 ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Change one-line summary prefix to match current arm-soc practices,

v2:
  - Drop (incorrect) optional cache-{size,sets,{block,line}-size}
    properties, as this information is auto-detected,
  - Integrate linking CPUs to L2 cache into this patch,
  - Extracted from series "[PATCH/RFC 00/15] ARM: shmobile: R-Car: Add
    SYSC PM Domain DT Support".
---
 arch/arm/boot/dts/r8a7794.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index df0861e84a4b81eb..21a02df3609b24aa 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -40,6 +40,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			next-level-cache = <&L2_CA7>;
 		};
 
 		cpu1: cpu at 1 {
@@ -47,9 +48,16 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			next-level-cache = <&L2_CA7>;
 		};
 	};
 
+	L2_CA7: cache-controller at 1 {
+		compatible = "cache";
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	gic: interrupt-controller at f1001000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
1.9.1
