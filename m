From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 11 Sep 2010 13:39:04 +0200
Subject: [PATCH] MMCI: use _cansleep GPIO functions
In-Reply-To: <20100911113236.GA25922@n2100.arm.linux.org.uk>
References: <1284064315-14515-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTikOOZED5i86j6Jayqvccmw8pa6+RKmG+xYFF-2b@mail.gmail.com>
	<AANLkTi=oMh2ff+VnE3E5-1TpJFsfYe5PoNZOar3OXQfV@mail.gmail.com>
	<20100911113236.GA25922@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikT5Jg5dqfjMrNTxb57BaGmcuAqsqiC9e7_d0TW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/11 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> You'll find !! used throughout the kernel sources.

Aha it's a kernel idiom, OK!!

I'll just test it on hardware and I'll put it in the patch tracker.

From: Linus Walleij <linus.walleij@stericsson.com>
Date: Sat, 11 Sep 2010 13:36:20 +0200
Subject: [PATCH] MMCI: use _cansleep GPIO functions

Currently the kernel is screaming about slowpath at me for the
wp/cd callbacks. Swicth to the _cansleep variants so as to silence
this.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f0c7313..c5fbf19 100644
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
+		status = !!gpio_get_value_cansleep(host->gpio_cd)
+			^ plat->cd_invert;

 	/*
 	 * Use positive logic throughout - status is zero for no card,
-- 
1.7.2.2
