From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  4 Feb 2015 15:15:11 +0100
Subject: [PATCH v2 1/5] ARM: shmobile: r8a7740 dtsi: Add cache-controller node
In-Reply-To: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
References: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1423059315-28519-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing cache-controller node. This will allow migration to the
generic l2c OF initialization.

The L2 cache is an ARM L2C-310 (r3p1-150rel0), of size 256 KiB (32 KiB x
8 ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "ARM: shmobile: r8a7740 dtsi: Add PM domain support"
due to the pd_a3sm reference.

v2:
  - Fix interrupt (should be 3 cells, not 1),
  - Describe cache better.
---
 arch/arm/boot/dts/r8a7740.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 83c1c3ca1b8f1400..c84a99931e30304c 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -37,6 +37,21 @@
 		      <0xc2000000 0x1000>;
 	};
 
+	L2: cache-controller {
+		compatible = "arm,pl310-cache";
+		reg = <0xf0100000 0x1000>;
+		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd_a3sm>;
+		arm,data-latency = <3 3 3>;
+		arm,tag-latency = <2 2 2>;
+		cache-unified;
+		cache-level = <2>;
+		cache-size = <0x40000>;
+		cache-sets = <1024>;
+		cache-block-size = <32>;
+		cache-line-size = <32>;
+	};
+
 	dbsc3: memory-controller at fe400000 {
 		compatible = "renesas,dbsc3-r8a7740";
 		reg = <0xfe400000 0x400>;
-- 
1.9.1
