From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 30 Jan 2016 01:21:48 +0800
Subject: [PATCH 3/3] mmc: sunxi: Enable eMMC HS-DDR (MMC_CAP_1_8V_DDR) support
In-Reply-To: <1454088108-2332-1-git-send-email-wens@csie.org>
References: <1454088108-2332-1-git-send-email-wens@csie.org>
Message-ID: <1454088108-2332-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that clock delay settings for 8 bit DDR are correct, and vqmmc
support is available, we can enable MMC_CAP_1_8V_DDR support. This
enables MMC HS-DDR at up to 52 MHz, even if signal voltage switching
is not available.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

There was discussion about an alternative: setting this capability
in the DT to preserve DT backwards compatibility. However just setting
it in the DT without the driver updates also breaks it. Furthermore,
Maxime's latest "clk: sunxi: Refactor A31 PLL6 so that it can be reused"
patch will break DT compatility. Given the above, I see no reason to
try and maintain compatibility only to fail.

---
 drivers/mmc/host/sunxi-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index bb4592696046..2aee17cd85ae 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1131,6 +1131,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->f_min		=   400000;
 	mmc->f_max		= 52000000;
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
+				  MMC_CAP_1_8V_DDR |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
 	ret = mmc_of_parse(mmc);
-- 
2.7.0
