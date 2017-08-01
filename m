From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Tue,  1 Aug 2017 12:40:07 +0200
Subject: [PATCH 1/1] clk: imx6: refine hdmi_isfr's parent to make HDMI work on
 i.MX6 SoCs w/o VPU
Message-ID: <1501584007-12433-1-git-send-email-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6 SoCs without VPU (in my case MCIMX6D4AVT10AC), the hdmi driver
fails to probe:

[    2.540030] dwhdmi-imx 120000.hdmi: Unsupported HDMI controller
(0000:00:00)
[    2.548199] imx-drm display-subsystem: failed to bind 120000.hdmi
(ops dw_hdmi_imx_ops): -19
[    2.557403] imx-drm display-subsystem: master bind failed: -19

That's because hdmi_isfr's parent, video_27m, is not correctly ungated.
As explained in commit 5ccc248cc537 ("ARM: imx6q: clk: Add support for
mipi_core_cfg clock as a shared clock gate"), video_27m is gated by
CCM_CCGR3[CG8].

On i.MX6 SoCs with VPU, the hdmi is working thanks to the
CCM_CMEOR[mod_en_ov_vpu] bit which makes the video_27m ungated whatever
is in CCM_CCGR3[CG8]. The issue can be reproduced by setting
CCMEOR[mod_en_ov_vpu] to 0.

Make the HDMI work in every case by setting hdmi_isfr's parent to
mipi_core_cfg.

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
---
 drivers/clk/imx/clk-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index c07df719..8d518ad 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -761,7 +761,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_GPU2D_CORE] = imx_clk_gate2("gpu2d_core", "gpu2d_core_podf", base + 0x6c, 24);
 	clk[IMX6QDL_CLK_GPU3D_CORE]   = imx_clk_gate2("gpu3d_core",    "gpu3d_core_podf",   base + 0x6c, 26);
 	clk[IMX6QDL_CLK_HDMI_IAHB]    = imx_clk_gate2("hdmi_iahb",     "ahb",               base + 0x70, 0);
-	clk[IMX6QDL_CLK_HDMI_ISFR]    = imx_clk_gate2("hdmi_isfr",     "video_27m",         base + 0x70, 4);
+	clk[IMX6QDL_CLK_HDMI_ISFR]    = imx_clk_gate2("hdmi_isfr",     "mipi_core_cfg",     base + 0x70, 4);
 	clk[IMX6QDL_CLK_I2C1]         = imx_clk_gate2("i2c1",          "ipg_per",           base + 0x70, 6);
 	clk[IMX6QDL_CLK_I2C2]         = imx_clk_gate2("i2c2",          "ipg_per",           base + 0x70, 8);
 	clk[IMX6QDL_CLK_I2C3]         = imx_clk_gate2("i2c3",          "ipg_per",           base + 0x70, 10);
-- 
2.7.3
