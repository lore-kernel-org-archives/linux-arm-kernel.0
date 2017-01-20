From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 20 Jan 2017 07:41:30 -0300
Subject: [PATCH] clk: samsung: exynos5420: Mark CLK_ACLK432_SCALER as
 CLK_IS_CRITICAL
Message-ID: <1484908891-11820-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos5800 SoC the SCALER block uses 2 input clocks: CLK_ACLK_300_GSCL
and CLK_ACLK432_SCALER, so both needs to be ungated in order to access it.

But Exynos5420 only has the CLK_ACLK_300_GSCL as gsc_pd clk. So just using
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

So until a proper solution based on runtime PM gets merged, mark the clock
as critical to prevent it to be gated.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/clk/samsung/clk-exynos5420.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 8c8b495cbf0d..9876ec28b94c 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -586,7 +586,7 @@ static const struct samsung_gate_clock exynos5800_gate_clks[] __initconst = {
 	GATE(CLK_ACLK550_CAM, "aclk550_cam", "mout_user_aclk550_cam",
 				GATE_BUS_TOP, 24, 0, 0),
 	GATE(CLK_ACLK432_SCALER, "aclk432_scaler", "mout_user_aclk432_scaler",
-				GATE_BUS_TOP, 27, 0, 0),
+				GATE_BUS_TOP, 27, CLK_IS_CRITICAL, 0),
 };
 
 static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
-- 
2.7.4
