From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 2 Dec 2010 14:36:58 +0100
Subject: [PATCH] mmci: drop superfluous regulator #ifdef
Message-ID: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator and MMC frameworks provide the proper stub functions
for the regulator functions anyway, get rid of this.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3709ab3..7567872 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -844,7 +844,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 		mmc->f_max = min(host->mclk, fmax);
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
 
-#ifdef CONFIG_REGULATOR
 	/* If we're using the regulator framework, try to fetch a regulator */
 	host->vcc = regulator_get(&dev->dev, "vmmc");
 	if (IS_ERR(host->vcc))
@@ -863,7 +862,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 				 "(using regulator instead)\n");
 		}
 	}
-#endif
+
 	/* Fall back to platform data if no regulator is found */
 	if (host->vcc == NULL)
 		mmc->ocr_avail = plat->ocr_mask;
-- 
1.7.3.2
