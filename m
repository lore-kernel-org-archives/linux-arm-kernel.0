From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  6 Jan 2017 09:04:32 +0100
Subject: [PATCH v2] ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS
Message-ID: <1483689872-30389-1-git-send-email-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

Changes since v1 at [1] :
 - Disable scpi_clocks instead of scpi_dvfs_clock

[1] http://lkml.kernel.org/r/1483628549-29486-1-git-send-email-narmstrong at baylibre.com

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 238fbea..5d28e1c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -137,6 +137,10 @@
 	};
 };
 
+&scpi_clocks {
+	status = "disabled";
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 51edd5b5..77caedd8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -55,7 +55,7 @@
 		mboxes = <&mailbox 1 &mailbox 2>;
 		shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
 
-		clocks {
+		scpi_clocks: clocks {
 			compatible = "arm,scpi-clocks";
 
 			scpi_dvfs: scpi_clocks at 0 {
-- 
1.9.1
