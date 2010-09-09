From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 9 Sep 2010 22:31:55 +0200
Subject: [PATCH] MMCI: use _cansleep GPIO functions
Message-ID: <1284064315-14515-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the kernel is screaming about slowpath at me for the
wp/cd callbacks. Swicth to the _cansleep variants so as to silence
this. Also remove the double-negate in front of the cd GPIO read.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f0c7313..082abad 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -614,7 +614,7 @@ static int mmci_get_ro(struct mmc_host *mmc)
 	if (host->gpio_wp == -ENOSYS)
 		return -ENOSYS;
 
-	return gpio_get_value(host->gpio_wp);
+	return gpio_get_value_cansleep(host->gpio_wp);
 }
 
 static int mmci_get_cd(struct mmc_host *mmc)
@@ -629,7 +629,8 @@ static int mmci_get_cd(struct mmc_host *mmc)
 
 		status = plat->status(mmc_dev(host->mmc));
 	} else
-		status = !!gpio_get_value(host->gpio_cd) ^ plat->cd_invert;
+		status = gpio_get_value_cansleep(host->gpio_cd) ^
+			plat->cd_invert;
 
 	/*
 	 * Use positive logic throughout - status is zero for no card,
-- 
1.6.3.3
