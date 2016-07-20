From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 20 Jul 2016 20:28:47 +0200
Subject: [PATCH 3/3] mmc: sunxi: Add support to the Allwinner A83T
In-Reply-To: <cover.1469082481.git.moinejf@free.fr>
References: <cover.1469082481.git.moinejf@free.fr>
Message-ID: <0ddc5f7d9a42515f901c95b8c0c1f5a5e4d575e9.1469082481.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rate of the PLL-PERIPH clock is usually set to 1.2GHz in the A83T.
This patch sets the phase delays of the output and sample clocks
accordingly.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
Note: The impacted phase delays are only for 50MHz.
The phase delays are not used in 50MHz 8 bits DDR (new timing mode).
---
 drivers/mmc/host/sunxi-mmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 7f9c31a..e161a64 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -961,6 +961,7 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", },
 	{ .compatible = "allwinner,sun5i-a13-mmc", },
+	{ .compatible = "allwinner,sun8i-a83t-mmc", },
 	{ .compatible = "allwinner,sun9i-a80-mmc", },
 	{ /* sentinel */ }
 };
@@ -986,6 +987,14 @@ static const struct sunxi_mmc_clk_delay sunxi_mmc_clk_delays[] = {
 	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  90, .sample = 180 },
 };
 
+static const struct sunxi_mmc_clk_delay sun8i_a83t_mmc_clk_delays[] = {
+	[SDXC_CLK_400K]		= { .output = 180, .sample = 180 },
+	[SDXC_CLK_25M]		= { .output = 180, .sample =  75 },
+	[SDXC_CLK_50M]		= { .output =  90, .sample = 105 },
+	[SDXC_CLK_50M_DDR]	= { .output =  60, .sample = 120 },
+	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  180, .sample = 180 },
+};
+
 static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
 	[SDXC_CLK_400K]		= { .output = 180, .sample = 180 },
 	[SDXC_CLK_25M]		= { .output = 180, .sample =  75 },
@@ -1007,6 +1016,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 
 	if (of_device_is_compatible(np, "allwinner,sun9i-a80-mmc"))
 		host->clk_delays = sun9i_mmc_clk_delays;
+	else if (of_device_is_compatible(np, "allwinner,sun8i-a83t-mmc"))
+		host->clk_delays = sun8i_a83t_mmc_clk_delays;
 	else
 		host->clk_delays = sunxi_mmc_clk_delays;
 
-- 
2.9.2
