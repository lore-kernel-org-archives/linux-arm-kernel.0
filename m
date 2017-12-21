From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 22:30:07 +0100
Subject: [PATCH] ARM: dts: exynos: fix RTC interrupt for exynos5410
Message-ID: <20171221213020.3080361-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the comment added to exynos_dt_pmu_match[] in commit
8b283c025443 ("ARM: exynos4/5: convert pmu wakeup to stacked domains"),
the RTC is not able to wake up the system through the PMU on Exynos5410,
unlike Exynos5420.

However, when the RTC DT node got added, it was a straight copy of
the Exynos5420 node, which now causes a warning from dtc.

This removes the incorrect interrupt-parent, which should get the
interrupt working and avoid the warning.

Fixes: e1e146b1b062 ("ARM: dts: exynos: Add RTC and I2C to Exynos5410")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/exynos5410.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 06713ec86f0d..d2174727df9a 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -333,7 +333,6 @@
 &rtc {
 	clocks = <&clock CLK_RTC>;
 	clock-names = "rtc";
-	interrupt-parent = <&pmu_system_controller>;
 	status = "disabled";
 };
 
-- 
2.9.0
