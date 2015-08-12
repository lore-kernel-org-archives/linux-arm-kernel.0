From: hramrach@gmail.com (Michal Suchanek)
Date: 12 Aug 2015 12:23:11 -0000
Subject: [PATCH 3/3] mmc: sunxi: use controller automatic clock gating.
In-Reply-To: <cover.1439381423.git.hramrach@gmail.com>
References: <cover.1439381423.git.hramrach@gmail.com>
Message-ID: <c33b221f9b622e3bad9d855a7ad1887b82827244.1439381423.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When core does not set the MMC_QUIRK_BROKEN_CLK_GATING flag enable
automatic hardware controlled clock gating on the mmc interface.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index f808a02..443cab5 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -601,8 +601,13 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 	rval = mmc_readl(host, REG_CLKCR);
 	rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON);
 
-	if (oclk_en)
+	if (oclk_en) {
 		rval |= SDXC_CARD_CLOCK_ON;
+		if (!host->mmc->card ||
+		     !(host->mmc->card->quirks & MMC_QUIRK_BROKEN_CLK_GATING))
+
+			rval |= SDXC_LOW_POWER_ON;
+	}
 
 	start = jiffies;
 	end = start + msecs_to_jiffies(750);
-- 
2.1.4
