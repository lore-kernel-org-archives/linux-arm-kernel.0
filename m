From: njun@marvell.com (Jun Nie)
Date: Wed, 21 Sep 2011 21:07:26 +0800
Subject: [PATCH] mmc: check SDIO card wake up during suspending
In-Reply-To: <1316610446-24183-1-git-send-email-njun@marvell.com>
References: <1316610446-24183-1-git-send-email-njun@marvell.com>
Message-ID: <1316610446-24183-6-git-send-email-njun@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible that SDIO card issue card interrupt to wake up
system just after SDIO func driver and SDIO card firmware commit
suspend state, while system is still in suspending process and
mmc interrupt is not release yet.

Interrupt storm may happen if func driver does not notify firmware
to clear the wake up source. If func driver issue SDIO bus transaction
to have firmware clear the source and driver try to handle the wake
up event, system may enter suspend before all transaction done.
In this case, SDIO card will not enter lower power mode never. But
system can not be wake up for only card insert/remove/interrupt irq are
listed in wake up source in SD spec. Data/command done irq can
not wake up system.

This patch check SDIO card interrupt and stop system suspend if there
are card interrupt after func driver suspend.

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/mmc/core/sdio.c       |   14 ++++++++++++++
 drivers/mmc/core/sdio_irq.c   |    5 +++++
 drivers/mmc/host/sdhci.c      |   14 +++++++++++++-
 include/linux/mmc/card.h      |    2 ++
 include/linux/mmc/sdio_func.h |    2 ++
 5 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index c3ad105..48a4106 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -584,6 +584,14 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 
 	for (i = 0; i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
+		/* cancel suspend once we detect external wake up source */
+		if (host->card->pending_interrupt) {
+			host->card->pending_interrupt = 0;
+			err = -EBUSY;
+			printk(KERN_ALERT "%s: wake up event after device suspended\n",
+					mmc_hostname(host));
+			break;
+		}
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			if (!pmops || !pmops->suspend || !pmops->resume) {
@@ -593,10 +601,15 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 				err = pmops->suspend(&func->dev);
 			if (err)
 				break;
+			else
+				/* It is prefer that func driver set it in its
+				   suspend function with mmc_claim_host */
+				func->suspended = true;
 		}
 	}
 	while (err && --i >= 0) {
 		struct sdio_func *func = host->card->sdio_func[i];
+		func->suspended = false;
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			pmops->resume(&func->dev);
@@ -639,6 +652,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	 */
 	for (i = 0; !err && i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
+		func->suspended = false;
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			err = pmops->resume(&func->dev);
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index bb192f9..2665974 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -49,6 +49,11 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
 					mmc_card_id(card));
 				ret = -EINVAL;
 			} else if (func->irq_handler) {
+				if (func->suspended) {
+					card->pending_interrupt = true;
+					printk(KERN_WARNING "%s: IRQ that arrives in suspend mode"
+						" mode\n", sdio_func_id(func));
+				}
 				func->irq_handler(func);
 				count++;
 			} else {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..670c141 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -24,6 +24,7 @@
 #include <linux/leds.h>
 
 #include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
 
 #include "sdhci.h"
 
@@ -1631,7 +1632,7 @@ out:
 
 int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 {
-	int ret;
+	int ret = 0;
 
 	sdhci_disable_card_detection(host);
 
@@ -1644,6 +1645,14 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 	if (host->vmmc)
 		ret = regulator_disable(host->vmmc);
 
+	if (host->mmc->card && host->mmc->card->pending_interrupt) {
+		DBG("*** %s wake up event after suspend, resuming to handle it\n",
+			mmc_hostname(host->mmc));
+		host->mmc->card->pending_interrupt = 0;
+		sdhci_resume_host(host);
+		ret = -EBUSY;
+	}
+
 	return ret;
 }
 
@@ -1659,6 +1668,9 @@ int sdhci_resume_host(struct sdhci_host *host)
 			return ret;
 	}
 
+	if (host->mmc->card && host->mmc->card->pending_interrupt)
+		host->mmc->card->pending_interrupt = 0;
+
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if (host->ops->enable_dma)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 8ce0827..2252fe2 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -146,6 +146,8 @@ struct mmc_card {
 	struct sdio_func_tuple	*tuples;	/* unknown common tuples */
 
 	struct dentry		*debugfs_root;
+	/* external interrupt arrived after sdio function suspended */
+	u32			pending_interrupt;
 };
 
 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 31baaf8..5c1c462 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -59,6 +59,8 @@ struct sdio_func {
 	const char		**info;		/* info strings */
 
 	struct sdio_func_tuple *tuples;
+
+	int			suspended; /* SDIO function driver state */
 };
 
 #define sdio_func_present(f)	((f)->state & SDIO_STATE_PRESENT)
-- 
1.7.0.4
