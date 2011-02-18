From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 18 Feb 2011 16:18:13 -0700
Subject: [PATCH 3/3] video: tegra: Run pll_d at 252mhz for HDMI 640x480
In-Reply-To: <1298071093-23865-1-git-send-email-swarren@nvidia.com>
References: <1298071093-23865-1-git-send-email-swarren@nvidia.com>
Message-ID: <1298071093-23865-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a pll_d clock rate of 216MHz yields a 24MHz pixel clock instead of
25.2MHz. This is just under a 5% error. Instead, use a 252MHz pll_d rate,
which generates 25.2MHz exactly.

This makes it more likely that monitors will sync to the emitted signal.

This also fixes HDMI audio issues, since the CTS/N tables are now based
on the actual pixel clock rate, not merely the intended pixel clock rate.

Tested with a 12MHz pll_m rate on Seaboard, all of 32/44.1/48KHz audio,
all video modes supported by the Tegra dc HDMI driver, and a Dell U2410
dislay.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/video/tegra/dc/dc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/tegra/dc/dc.c b/drivers/video/tegra/dc/dc.c
index 16789c2..c1eea05 100644
--- a/drivers/video/tegra/dc/dc.c
+++ b/drivers/video/tegra/dc/dc.c
@@ -699,8 +699,10 @@ void tegra_dc_setup_clk(struct tegra_dc *dc, struct clk *clk)
 
 		if (dc->mode.pclk > 70000000)
 			rate = 594000000;
-		else
+		else if (dc->mode.pclk >= 27000000)
 			rate = 216000000;
+		else
+			rate = 252000000;
 
 		if (rate != clk_get_rate(pll_d_clk))
 			clk_set_rate(pll_d_clk, rate);
-- 
1.7.1
