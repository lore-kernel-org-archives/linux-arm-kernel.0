From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 21 Jan 2016 13:26:29 +0800
Subject: [PATCH RFC 02/15] mmc: sunxi: Return error on mmc_regulator_set_ocr()
 fail in .set_ios op
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Message-ID: <1453354002-28366-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let .set_ios() fail if mmc_regulator_set_ocr() fails to enable and set a
proper voltage for vmmc.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index cce5ca540857..790f01662b4e 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -711,7 +711,10 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 
 	case MMC_POWER_UP:
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+		host->ferror = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+						     ios->vdd);
+		if (host->ferror)
+			return;
 
 		host->ferror = sunxi_mmc_init_host(mmc);
 		if (host->ferror)
-- 
2.7.0.rc3
