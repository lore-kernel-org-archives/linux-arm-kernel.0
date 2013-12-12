From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 12 Dec 2013 17:18:03 +0100
Subject: [PATCH 3/3] ARM: dts: exynos4412-trats2: Use MSHC controller for eMMC
 memory
In-Reply-To: <1386865083-20082-1-git-send-email-t.figa@samsung.com>
References: <1386865083-20082-1-git-send-email-t.figa@samsung.com>
Message-ID: <1386865083-20082-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes device tree node of SDHCI0 controller and replaces
it with MSHC to enable support MMC 4.4 and improve performance of eMMC
memory.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index fb7b9ae..890ad27 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -442,13 +442,25 @@
 		};
 	};
 
-	sdhci at 12510000 {
-		bus-width = <8>;
+	mmc at 12550000 {
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
 		non-removable;
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus8>;
-		pinctrl-names = "default";
+		card-detect-delay = <200>;
 		vmmc-supply = <&vemmc_reg>;
+		clock-frequency = <400000000>;
+		samsung,dw-mshc-ciu-div = <0>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
+		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
+		pinctrl-names = "default";
 		status = "okay";
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <8>;
+		};
 	};
 
 	serial at 13800000 {
-- 
1.8.4.3
