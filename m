From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 28 Aug 2017 16:29:03 +0200
Subject: [PATCH v3 01/13] mmc: meson-gx: initialize sane clk default before
 clock register
In-Reply-To: <20170828142915.27020-1-jbrunet@baylibre.com>
References: <20170828142915.27020-1-jbrunet@baylibre.com>
Message-ID: <20170828142915.27020-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On boot, the clock divider value is 0 which is a weird unsupported value.
For example, accessing the cfg register with this value set would crash
the SoC.

Previous change removed 0 as possible value for CCF but forgot to properly
initialize the register before registering the clock. This leads to the
CCF finding an illegal value, which it complains about.

Initialize the register properly in a standalone patch so the fix can be
picked up if necessary

Fixes: d045fe8c27af ("mmc: meson-gx: remove CLK_DIVIDER_ALLOW_ZERO clock flag")
Reported-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 8a74a048db88..d2de5c11cdce 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -339,6 +339,15 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	const char *clk_div_parents[1];
 	u32 clk_reg, cfg;
 
+	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
+	clk_reg = 0;
+	clk_reg |= CLK_ALWAYS_ON;
+	clk_reg |= CLK_DIV_MASK;
+	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, host->tp.core_phase);
+	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, host->tp.tx_phase);
+	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, host->tp.rx_phase);
+	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
+
 	/* get the mux parents */
 	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
 		struct clk *clk;
@@ -393,16 +402,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
 		return PTR_ERR(host->cfg_div_clk);
 
-	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
-	clk_reg = 0;
-	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, host->tp.core_phase);
-	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, host->tp.tx_phase);
-	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, host->tp.rx_phase);
-	clk_reg |= FIELD_PREP(CLK_SRC_MASK, CLK_SRC_XTAL);
-	clk_reg |= FIELD_PREP(CLK_DIV_MASK, CLK_DIV_MAX);
-	clk_reg &= ~CLK_ALWAYS_ON;
-	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
-
 	/* Ensure clock starts in "auto" mode, not "always on" */
 	cfg = readl(host->regs + SD_EMMC_CFG);
 	cfg &= ~CFG_CLK_ALWAYS_ON;
-- 
2.9.5
