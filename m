From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 12 Oct 2015 18:07:18 +0530
Subject: [PATCH v2] arm: dts: Fix audio card detection on peach boards
Message-ID: <1444653438-6532-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 2fad972d45c4 ("ARM: dts: Add mclk entry for Peach boards"),
sound card detection is broken on peach boards and gives below errors:

[    3.630457] max98090 7-0010: MAX98091 REVID=0x51
[    3.634233] max98090 7-0010: use default 2.8v micbias
[    3.640985] snow-audio sound: HiFi <-> 3830000.i2s mapping ok
[    3.645307] max98090 7-0010: Invalid master clock frequency
[    3.650824] snow-audio sound: ASoC: Peach-Pi-I2S-MAX98091 late_probe() failed: -22
[    3.658914] snow-audio sound: snd_soc_register_card failed (-22)
[    3.664366] snow-audio: probe of sound failed with error -22

This patch adds missing assigned-clocks and assigned-clock-parents for
pmu_system_controller node which is used as "mclk" for audio codec.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Fixes: 2fad972d45c4 ("ARM: dts: Add mclk entry for Peach boards")
Cc: <stable@vger.kernel.org>
---
Changes since v1:
Addressed Krzysztof's review comments.

 arch/arm/boot/dts/exynos5420-peach-pit.dts |    5 +++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 8f4d76c5e11c..1b95da79293c 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -915,6 +915,11 @@
 	};
 };
 
+&pmu_system_controller {
+	assigned-clocks = <&pmu_system_controller 0>;
+	assigned-clock-parents = <&clock CLK_FIN_PLL>;
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&max77802 MAX77802_CLK_32K_AP>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7d5b386b5ae6..8f40c7e549bd 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -878,6 +878,11 @@
 	};
 };
 
+&pmu_system_controller {
+	assigned-clocks = <&pmu_system_controller 0>;
+	assigned-clock-parents = <&clock CLK_FIN_PLL>;
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&max77802 MAX77802_CLK_32K_AP>;
-- 
1.7.10.4
