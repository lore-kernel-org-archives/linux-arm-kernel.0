From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 11 Sep 2010 13:31:28 +0200
Subject: [PATCH] MMCI: use _cansleep GPIO functions
In-Reply-To: <AANLkTi=oMh2ff+VnE3E5-1TpJFsfYe5PoNZOar3OXQfV@mail.gmail.com>
References: <1284064315-14515-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTikOOZED5i86j6Jayqvccmw8pa6+RKmG+xYFF-2b@mail.gmail.com>
	<AANLkTi=oMh2ff+VnE3E5-1TpJFsfYe5PoNZOar3OXQfV@mail.gmail.com>
Message-ID: <AANLkTimAGB5v3WaAU_7kd0XPyfybLpqz3XYn4uANRBDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/11 Linus Walleij <linus.ml.walleij@gmail.com>:

> I'll slam in some intermediate bool or something so it's super
> clear what's happening, OK?

Like this (untested):

From: Linus Walleij <linus.walleij@stericsson.com>
Date: Sat, 11 Sep 2010 13:29:04 +0200
Subject: [PATCH] MMCI: use _cansleep GPIO functions

Currently the kernel is screaming about slowpath at me for the
wp/cd callbacks. Swicth to the _cansleep variants so as to silence
this. Also rewrite the double-negate in front of the cd GPIO read
to make it more clear what is happening.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f0c7313..603d4d5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -614,7 +614,7 @@ static int mmci_get_ro(struct mmc_host *mmc)
 	if (host->gpio_wp == -ENOSYS)
 		return -ENOSYS;

-	return gpio_get_value(host->gpio_wp);
+	return gpio_get_value_cansleep(host->gpio_wp);
 }

 static int mmci_get_cd(struct mmc_host *mmc)
@@ -629,7 +629,9 @@ static int mmci_get_cd(struct mmc_host *mmc)

 		status = plat->status(mmc_dev(host->mmc));
 	} else
-		status = !!gpio_get_value(host->gpio_cd) ^ plat->cd_invert;
+		/* Convert the status to boolean and optionally invert */
+		status = (gpio_get_value_cansleep(host->gpio_cd) ? 1 : 0)
+			^ plat->cd_invert;

 	/*
 	 * Use positive logic throughout - status is zero for no card,
-- 
1.7.2.2
