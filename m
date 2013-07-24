From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 24 Jul 2013 19:43:32 +0530
Subject: [PATCH v3 2/5] clk/exynos5250: add mout_hdmi mux clock for hdmi
In-Reply-To: <1374675215-27862-1-git-send-email-rahul.sharma@samsung.com>
References: <1374675215-27862-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1374675215-27862-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hdmi driver needs to change the parent of hdmi clock
frequently between pixel clock and hdmiphy clock. hdmiphy is
not stable after power on and for a short interval while changing
the phy configuration. For this duration pixel clock is used to
clock hdmi.

This patch is exposing the mux for changing parent.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 Documentation/devicetree/bindings/clock/exynos5250-clock.txt |    8 ++++++++
 drivers/clk/samsung/clk-exynos5250.c                         |    5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
index 6772971..488fbb2 100644
--- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
@@ -158,6 +158,14 @@ clock which they consume.
   mixer			343
   hdmi			345
 
+
+   [Clock Muxes]
+
+  Clock			ID
+  ----------------------------
+  mout_hdmi		1024
+
+
 Example 1: An example of a clock controller node is listed below.
 
 	clock: clock-controller at 0x10010000 {
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 6f767c5..df44419 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -101,6 +101,9 @@ enum exynos5250_clks {
 	tzpc2, tzpc3, tzpc4, tzpc5, tzpc6, tzpc7, tzpc8, tzpc9, hdmi_cec, mct,
 	wdt, rtc, tmu, fimd1, mie1, dsim0, dp, mixer, hdmi,
 
+	/* mux clocks */
+	mout_hdmi = 1024,
+
 	nr_clks,
 };
 
@@ -232,7 +235,7 @@ struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(none, "mout_fimd1", mout_group1_p, SRC_DISP1_0, 0, 4),
 	MUX(none, "mout_mipi1", mout_group1_p, SRC_DISP1_0, 12, 4),
 	MUX(none, "mout_dp", mout_group1_p, SRC_DISP1_0, 16, 4),
-	MUX(none, "mout_hdmi", mout_hdmi_p, SRC_DISP1_0, 20, 1),
+	MUX(mout_hdmi, "mout_hdmi", mout_hdmi_p, SRC_DISP1_0, 20, 1),
 	MUX(none, "mout_audio0", mout_audio0_p, SRC_MAU, 0, 4),
 	MUX(none, "mout_mmc0", mout_group1_p, SRC_FSYS, 0, 4),
 	MUX(none, "mout_mmc1", mout_group1_p, SRC_FSYS, 4, 4),
-- 
1.7.10.4
