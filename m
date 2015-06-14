From: linux.amoon@gmail.com (Anand Moon)
Date: Sun, 14 Jun 2015 19:54:03 +0930
Subject: [PATCHv6 2/4] ARM: dts: exynos5422-odroidxu3: Enable TMU at
 Exynos5422 base
In-Reply-To: <1434277445-5243-1-git-send-email-linux.amoon@gmail.com>
References: <1434277445-5243-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1434277445-5243-2-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes enables TMU IP block on the Exynos5422 Odroid-XU3
device.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes rebase on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung branch for-next
Changes from v5: Use LDO7 regulator instead of LD010.

The output of LDO18 goes to VDD_EMMC_1V8. This is not regulator for TMU.

I think the schematics are missing some of details but it can be deducted that:
1. TEMP SE is supplied by VDD18_TS power domain. It consists of 5
pairs of pins (XTSTEST_OUT[0-4], XTSEXT_RES[0-4]).
2. The VDD18_TS01, VDD18_TS23 and VDD18_TS4 are wired to the LDO7 of
S2MPS11 PMIC.
3. I confirmed with the Exynos5422 datasheet that these
VDD18_TS{01,23,4} supply the XTSTEST pins (OUT and RES).

So the LDO7 it is... but before using it there is a caveat. The LDO7
is also connected to VDD of MIPI, HDMI and few more. So when you use
this regulator in TMU it may be turned off by TMU driver (e.g. during
unbind). In such case these other blocks also should be tested and
checked whether they take this regulator and enable it.
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index a2f9941..b6570fc 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -474,6 +474,31 @@
 	status = "okay";
 };
 
+&tmu_cpu0 {
+	vtmu-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
+&tmu_cpu1 {
+	vtmu-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
+&tmu_cpu2 {
+	vtmu-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
+&tmu_cpu3 {
+	vtmu-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
+&tmu_gpu {
+	vtmu-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
-- 
2.4.3
