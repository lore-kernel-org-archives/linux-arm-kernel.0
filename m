From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 26 Feb 2010 19:39:30 +0100
Subject: [PATCH 2/7] mmc: at91_mci: fix timeout errors
In-Reply-To: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
Message-ID: <7edd0d2f43b28d03e73fdf180e40ce9ae977ee56.1267209149.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfgang Muees <wolfgang.mues@auerswald.de>

Fix two timeout errors, one for slow SDHC cards and one for slow users while
inserting SD cards.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/at91_mci.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 6835104..f2cb716 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -756,7 +756,8 @@ static void at91_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->request = mrq;
 	host->flags = 0;
 
-	mod_timer(&host->timer, jiffies +  HZ);
+	/* more than 1s timeout needed with slow SD cards */
+	mod_timer(&host->timer, jiffies +  msecs_to_jiffies(2000));
 
 	at91_mci_process_next(host);
 }
@@ -944,7 +945,8 @@ static irqreturn_t at91_mmc_det_irq(int irq, void *_host)
 			pr_debug("****** Resetting SD-card bus width ******\n");
 			at91_mci_write(host, AT91_MCI_SDCR, at91_mci_read(host, AT91_MCI_SDCR) & ~AT91_MCI_SDCBUS);
 		}
-		mmc_detect_change(host->mmc, msecs_to_jiffies(100));
+		/* 0.5s needed because of early card detect switch firing */
+		mmc_detect_change(host->mmc, msecs_to_jiffies(500));
 	}
 	return IRQ_HANDLED;
 }
-- 
1.5.6.5
