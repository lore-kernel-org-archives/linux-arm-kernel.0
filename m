From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Oct 2013 19:41:21 +0200
Subject: [PATCH 7/7] clk: samsung: exynos5250: Fix parents of gate clocks from
 MFC domain
In-Reply-To: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
References: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
Message-ID: <1381858881-25611-8-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds mout_aclk333_sub mux clock and updates gate clocks from
MFC domain to have it as their parent as specified in SoC documentation.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 1290da9..93b82db 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -198,6 +198,7 @@ PNAME(mout_aclk166_p)	= { "mout_cpll", "mout_mpll_user" };
 PNAME(mout_aclk200_p)	= { "mout_mpll_user", "mout_bpll_user" };
 PNAME(mout_aclk200_sub_p) = { "fin_pll", "div_aclk200" };
 PNAME(mout_aclk266_sub_p) = { "fin_pll", "div_aclk266" };
+PNAME(mout_aclk333_sub_p) = { "fin_pll", "div_aclk333" };
 PNAME(mout_hdmi_p)	= { "div_hdmi_pixel", "sclk_hdmiphy" };
 PNAME(mout_usb3_p)	= { "mout_mpll_user", "mout_cpll" };
 PNAME(mout_group1_p)	= { "fin_pll", "fin_pll", "sclk_hdmi27m",
@@ -283,6 +284,7 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 
 	MUX(none, "mout_aclk200_disp1_sub", mout_aclk200_sub_p, SRC_TOP3, 4, 1),
 	MUX(none, "mout_aclk266_gscl_sub", mout_aclk266_sub_p, SRC_TOP3, 8, 1),
+	MUX(none, "mout_aclk333_sub", mout_aclk333_sub_p, SRC_TOP3, 24, 1),
 
 	MUX(none, "mout_cam_bayer", mout_group1_p, SRC_GSCL, 12, 4),
 	MUX(none, "mout_cam0", mout_group1_p, SRC_GSCL, 16, 4),
@@ -517,9 +519,9 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(mixer, "mixer", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 5, 0, 0),
 	GATE(hdmi, "hdmi", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 6, 0, 0),
 
-	GATE(mfc, "mfc", "div_aclk333", GATE_IP_MFC, 0, 0, 0),
-	GATE(smmu_mfcl, "smmu_mfcl", "div_aclk333", GATE_IP_MFC, 1, 0, 0),
-	GATE(smmu_mfcr, "smmu_mfcr", "div_aclk333", GATE_IP_MFC, 2, 0, 0),
+	GATE(mfc, "mfc", "mout_aclk333_sub", GATE_IP_MFC, 0, 0, 0),
+	GATE(smmu_mfcl, "smmu_mfcl", "mout_aclk333_sub", GATE_IP_MFC, 1, 0, 0),
+	GATE(smmu_mfcr, "smmu_mfcr", "mout_aclk333_sub", GATE_IP_MFC, 2, 0, 0),
 
 	GATE(rotator, "rotator", "div_aclk266", GATE_IP_GEN, 1, 0, 0),
 	GATE(jpeg, "jpeg", "div_aclk166", GATE_IP_GEN, 2, 0, 0),
-- 
1.8.3.2
