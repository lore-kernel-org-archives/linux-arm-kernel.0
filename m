From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  7 Jul 2011 22:27:35 +0200
Subject: [PATCH] mmci: adjust calculation of f_min
Message-ID: <1310070455-26418-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@stericsson.com>

The ARM version maximum clock divider is 512 whereas for the ST
variants it's 257. Let's use DIV_ROUND_UP() for both cases so we
can see clearly what's going on here.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Reviewed-by: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
[Use DIV_ROUND_UP to clarify elder code]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index fe14072..50f4f77 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1063,7 +1063,15 @@ static int __devinit mmci_probe(struct amba_device *dev,
 	}
 
 	mmc->ops = &mmci_ops;
-	mmc->f_min = (host->mclk + 511) / 512;
+	/*
+	 * The ARM and ST versions of the block have slightly different
+	 * clock divider equations which means that the minimum divider
+	 * differs too.
+	 */
+	if (variant->st_clkdiv)
+		mmc->f_min = DIV_ROUND_UP(host->mclk, 257);
+	else
+		mmc->f_min = DIV_ROUND_UP(host->mclk, 512);
 	/*
 	 * If the platform data supplies a maximum operating
 	 * frequency, this takes precedence. Else, we fall back
-- 
1.7.6
