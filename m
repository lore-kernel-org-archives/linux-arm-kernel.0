From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 19 Jan 2017 19:29:54 -0300
Subject: [PATCH 1/2] ARM: dts: exynos: Add CLK_ACLK432_SCALER clock to gsc_pd
 for Exynos5800
Message-ID: <1484864995-10679-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos5800 SoC the SCALER block uses 2 input clocks: CLK_ACLK_300_GSCL
and CLK_ACLK432_SCALER, so both needs to be ungated in order to access it.

The SoC manual say the CLK_ACLK432_SCALER is needed to access the internal
buses, so add this clock as another asynchronous bridges (ASB) clock.

The Exynos5420 only has the CLK_ACLK_300_GSCL clock defined. So just using
this definition from exynos5420.dtsi in Exynos5800 leads to the following:

[  227.008559] Unhandled fault: imprecise external abort (0x1c06) at 0x00048e14
[  227.015116] pgd = ed5dc000
[  227.017213] [00048e14] *pgd=b17c6835
[  227.020889] Internal error: : 1c06 [#1] PREEMPT SMP ARM
...
[  227.241585] [<bf2429bc>] (gsc_wait_reset [exynos_gsc]) from [<bf24009c>] (gsc_runtime_resume+0x9c/0xec [exynos_gsc])
[  227.252331] [<bf24009c>] (gsc_runtime_resume [exynos_gsc]) from [<c042e488>] (genpd_runtime_resume+0x120/0x1d4)
[  227.262294] [<c042e488>] (genpd_runtime_resume) from [<c04241c0>] (__rpm_callback+0xc8/0x218)

domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
power-domain at 100440C0           on
    /devices/platform/soc/14450000.mixer                active
    /devices/platform/soc/14530000.hdmi                 active
power-domain at 10044120           on
power-domain at 10044060           off-0
power-domain at 10044020           on
power-domain at 10044000           on
    /devices/platform/soc/13e00000.video-scaler         suspended
    /devices/platform/soc/13e10000.video-scaler         resuming

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/exynos5800.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 8213016803e5..4847abbf7a92 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -134,3 +134,11 @@
 &mfc {
 	compatible = "samsung,mfc-v8";
 };
+
+&gsc_pd {
+	clocks = <&clock CLK_FIN_PLL>,
+		<&clock CLK_MOUT_USER_ACLK300_GSCL>,
+		<&clock CLK_GSCL0>, <&clock CLK_GSCL1>,
+		<&clock CLK_ACLK432_SCALER>;
+	clock-names = "oscclk", "clk0", "asb0", "asb1", "asb2";
+};
-- 
2.7.4
