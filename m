From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:39:05 +0900
Subject: [PATCH 17/18] ARM: S5PV210: Add 'clock source gate' clock definitions
Message-ID: <1274056745-14746-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The non-glitch-free clock muxes can suffer from glitches when changing
clock sources. It is recommended to disable the output of non-glitch-
free muxes before trying to change the clock source. After clock change
is complete, the non-glitch-free clock can be re-enabled.

These clocks are added to the list of clocks to be enabled at boot time.
Device drivers that need to disable the non-glitch-free mux output clock
can 'clk_get' these clocks, disable them, change the clock selection
of the mux and then re-enable the non-glitch-free mux output.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |  140 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 140 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 154bca4..a2c3ab5 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -183,6 +183,11 @@ static int s5pv210_clk_mask0_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLK_SRC_MASK0, clk, enable);
 }
 
+static int s5pv210_clk_mask1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLK_SRC_MASK1, clk, enable);
+}
+
 static struct clk clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
 	.id		= -1,
@@ -448,6 +453,141 @@ static struct clk init_clocks[] = {
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<10),
+	}, {
+		.name		= "mout_hdmi",
+		.id		= -1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 0),
+	}, {
+		.name		= "mout_mixer",
+		.id		= -1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "mout_dac",
+		.id		= -1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 2),
+	}, {
+		.name		= "mout_cam",
+		.id		= 0,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "mout_cam",
+		.id		= 1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "mout_fimd",
+		.id		= -1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 5),
+	}, {
+		.name		= "mout_csis",
+		.id		= -1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 6),
+	}, {
+		.name		= "mout_finvpll",
+		.id		= -1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 7),
+	}, {
+		.name		= "mout_mmc",
+		.id		= 0,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 8),
+	}, {
+		.name		= "mout_mmc",
+		.id		= 1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 9),
+	}, {
+		.name		= "mout_mmc",
+		.id		= 2,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 10),
+	}, {
+		.name		= "mout_mmc",
+		.id		= 3,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 11),
+	}, {
+		.name		= "mout_uart",
+		.id		= 0,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 12),
+	}, {
+		.name		= "mout_uart",
+		.id		= 1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 13),
+	}, {
+		.name		= "mout_uart",
+		.id		= 2,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 14),
+	}, {
+		.name		= "mout_uart",
+		.id		= 3,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 15),
+	}, {
+		.name		= "mout_spi",
+		.id		= 0,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 16),
+	}, {
+		.name		= "mout_spi",
+		.id		= 1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 17),
+	}, {
+		.name		= "mout_pwm",
+		.id		= -1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 19),
+	}, {
+		.name		= "mout_audio",
+		.id		= 0,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 24),
+	}, {
+		.name		= "mout_audio",
+		.id		= 1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 25),
+	}, {
+		.name		= "mout_audio",
+		.id		= 2,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 26),
+	}, {
+		.name		= "mout_spdif",
+		.id		= -1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 27),
+	}, {
+		.name		= "mout_pwi",
+		.id		= -1,
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 29),
+	}, {
+		.name		= "mout_fimc",
+		.id		= 0,
+		.enable		= s5pv210_clk_mask1_ctrl,
+		.ctrlbit	= (1 << 2),
+	}, {
+		.name		= "mout_fimc",
+		.id		= 1,
+		.enable		= s5pv210_clk_mask1_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "mout_fimc",
+		.id		= 2,
+		.enable		= s5pv210_clk_mask1_ctrl,
+		.ctrlbit	= (1 << 4),
 	},
 };
 
-- 
1.6.2.5
