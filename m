From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Aug 2017 11:29:54 +0800
Subject: [PATCH] mmc: sunxi: Fix clock rate passed to sunxi_mmc_clk_set_phase
Message-ID: <20170810032954.9104-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi_mmc_clk_set_phase expects the actual card clock rate to be passed
to it. When the internal divider code was reworked in commit 9a639c6073d3
("mmc: sunxi: Support MMC DDR52 transfer mode with new timing mode"),
this requirement was missed, and the module clock rate was passed in
instead. This broke 8 bit DDR MMC on old controllers, as the module
clock rate is double the card clock rate, for which we have no valid
delay settings.

Fix this by applying the internal divider to the clock rate right after
we configure it in hardware.

Fixes: 9a639c6073d3 ("mmc: sunxi: Support MMC DDR52 transfer mode with
		      new timing mode")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Sorry for all the regressions the A83T MMC series has caused.
I only caught this while testing some other patches on the H3.
I really hope this is the last one.

---
 drivers/mmc/host/sunxi-mmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 6c7eb859ace1..da5f46a14497 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -821,6 +821,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	rval |= div - 1;
 	mmc_writel(host, REG_CLKCR, rval);
 
+	/* update card clock rate to account for internal divider */
+	rate /= div;
+
 	if (host->use_new_timings) {
 		/* Don't touch the delay bits */
 		rval = mmc_readl(host, REG_SD_NTSR);
@@ -828,6 +831,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		mmc_writel(host, REG_SD_NTSR, rval);
 	}
 
+	/* sunxi_mmc_clk_set_phase expects the actual card clock rate */
 	ret = sunxi_mmc_clk_set_phase(host, ios, rate);
 	if (ret)
 		return ret;
@@ -849,7 +853,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		return ret;
 
 	/* And we just enabled our clock back */
-	mmc->actual_clock = rate / div;
+	mmc->actual_clock = rate;
 
 	return 0;
 }
-- 
2.13.3
