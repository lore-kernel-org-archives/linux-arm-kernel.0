From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 10 Sep 2014 17:09:39 +0200
Subject: [PATCH v2] ARM: dts: Specify Odroid X2/U3 audio clock parents and
 rates
Message-ID: <1410361779-28017-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This ensures the core and the audio subsystem clocks are configured
properly, as expected by the sound machine driver. These bits are
missing to obtain proper audio sample rates in kernel v3.17, where
audio support for Odroid X2/U3 was first added.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
It would be good to have it applied as a fix for v3.17.

First version of this patch was missing settings for EPLL, now it all
should be complete.

 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index adadaf9..4fd7e0e 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -41,10 +41,25 @@
 		clock-names = "iis", "i2s_opclk0";
 	};

+	clock-controller at 10030000 {
+		assigned-clocks = <&clock CLK_FOUT_EPLL>;
+		assigned-clock-rates = <192000000>;
+	};
+
 	sound: sound {
 		compatible = "samsung,odroidx2-audio";
 		samsung,i2s-controller = <&i2s0>;
 		samsung,audio-codec = <&max98090>;
+		assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
+				<&clock_audss EXYNOS_MOUT_I2S>,
+				<&clock_audss EXYNOS_DOUT_SRP>,
+				<&clock_audss EXYNOS_DOUT_AUD_BUS>;
+		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
+				<&clock_audss EXYNOS_MOUT_AUDSS>;
+		assigned-clock-rates = <0>,
+				<0>,
+				<192000000>,
+				<19200000>;
 	};

 	mmc at 12550000 {
--
1.7.9.5
