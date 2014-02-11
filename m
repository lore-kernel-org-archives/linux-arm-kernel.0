From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 11 Feb 2014 18:50:43 +0100
Subject: [PATCH] ARM: dts: exynos5250-arndale: Keep G3D regulator always on
Message-ID: <1392141043-27170-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apparently, if G3D regulator is powered off, the SoC cannot enter low
power modes and just hangs. This patch fixes this by keeping the
regulator always on when the system is running, as suggested by Exynos 4
User's Manual in case of Exynos4210/4x12 SoCs (Exynos5250 UM does not
have such note, but observed behavior seems to confirm that it is true
for this SoC as well).

This fixes an issue preventing Arndale board from entering sleep mode
observed since commit

346f372f7b72a0 clk: exynos5250: Add CLK_IGNORE_UNUSED flag for pmu clock

that landed in kernel 3.11, which has fixed the clock driver to make the
SoC actually try to enter the sleep mode.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: stable at vger.kernel.org
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index e14dd62..5e9ddb8 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -287,6 +287,7 @@
 					regulator-name = "vdd_g3d";
 					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
 					regulator-boot-on;
 					op_mode = <1>;
 				};
-- 
1.8.5.2
