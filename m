From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Fri, 23 Aug 2013 12:27:57 +0530
Subject: [PATCH v2 4/5] clk/exynos5420: add hdmi mux to change parents in hdmi
 driver
In-Reply-To: <1377241078-11808-1-git-send-email-rahul.sharma@samsung.com>
References: <1377241078-11808-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1377241078-11808-5-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hdmi driver needs to change the parent of hdmi clock
to pixel clock or hdmiphy clock, based on the stability
of hdmiphy. This patch is exposing the mux for changing
the parent.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 Documentation/devicetree/bindings/clock/exynos5420-clock.txt |    5 +++++
 drivers/clk/samsung/clk-exynos5420.c                         |    5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
index 5758a69..6f16aa8 100644
--- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
@@ -182,6 +182,11 @@ clock which they consume.
   g3d			501
   smmu_mixer		502
 
+  Mux			ID
+  ----------------------------
+
+  mout_hdmi		1024
+
 Example 1: An example of a clock controller node is listed below.
 
 	clock: clock-controller at 0x10010000 {
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 522c033..5f9bc63 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -140,6 +140,9 @@ enum exynos5420_clks {
 	aclk333_g2d = 480, g2d, aclk333_432_gscl = 490, smmu_3aa, smmu_fimcl0,
 	smmu_fimcl1, smmu_fimcl3, fimc_lite3, aclk_g3d = 500, g3d, smmu_mixer,
 
+	/* mux clocks */
+	mout_hdmi = 1024,
+
 	nr_clks,
 };
 
@@ -400,7 +403,7 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(none, "mout_mipi1", group2_p, SRC_DISP10, 16, 3),
 	MUX(none, "mout_dp1", group2_p, SRC_DISP10, 20, 3),
 	MUX(none, "mout_pixel", group2_p, SRC_DISP10, 24, 3),
-	MUX(none, "mout_hdmi", hdmi_p, SRC_DISP10, 28, 1),
+	MUX(mout_hdmi, "mout_hdmi", hdmi_p, SRC_DISP10, 28, 1),
 
 	/* MAU Block */
 	MUX(none, "mout_maudio0", maudio0_p, SRC_MAU, 28, 3),
-- 
1.7.10.4
