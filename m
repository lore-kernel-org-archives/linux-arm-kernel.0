From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  5 Jan 2017 16:02:29 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS
Message-ID: <1483628549-29486-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current hardware is not able to run with all cores enabled at a
cluster frequency superior at 1536MHz.
But the currently shipped u-boot for the platform still reports an OPP
table with possible DVFS frequency up to 2GHz, and will not change since
the off-tree linux tree supports limiting the OPPs with a kernel parameter.
A recent u-boot change reports the boot-time DVFS around 100MHz and
the default performance cpufreq governor sets the maximum frequency.
Previous version of u-boot reported to be already at the max OPP and
left the OPP as is.
Nevertheless, other governors like ondemand could setup the max frequency
and make the system crash.

This patch disables the DVFS clock and disables cpufreq.

Fixes: 70db166a2baa ("ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 238fbea..5e63e3b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -137,6 +137,10 @@
 	};
 };
 
+&scpi_dvfs {
+	status = "disabled";
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
1.9.1
