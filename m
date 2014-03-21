From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:13:58 +0100
Subject: [PATCH 01/20] mmc: mmci: Convert to the mmc gpio API
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid duplication of code while handling card detect and write
protect GPIO pins/irqs, let's convert to use the mmc gpio API.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   97 ++++++++---------------------------------------
 drivers/mmc/host/mmci.h |    3 --
 2 files changed, 15 insertions(+), 85 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 771c60a..b0b81ac 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -23,6 +23,7 @@
 #include <linux/mmc/pm.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
@@ -1326,35 +1327,18 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
-static int mmci_get_ro(struct mmc_host *mmc)
-{
-	struct mmci_host *host = mmc_priv(mmc);
-
-	if (host->gpio_wp == -ENOSYS)
-		return -ENOSYS;
-
-	return gpio_get_value_cansleep(host->gpio_wp);
-}
-
 static int mmci_get_cd(struct mmc_host *mmc)
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmci_platform_data *plat = host->plat;
-	unsigned int status;
+	unsigned int status = mmc_gpio_get_cd(mmc);
 
-	if (host->gpio_cd == -ENOSYS) {
+	if (status == -ENOSYS) {
 		if (!plat->status)
 			return 1; /* Assume always present */
 
 		status = plat->status(mmc_dev(host->mmc));
-	} else
-		status = !!gpio_get_value_cansleep(host->gpio_cd)
-			^ plat->cd_invert;
-
-	/*
-	 * Use positive logic throughout - status is zero for no card,
-	 * non-zero for card inserted.
-	 */
+	}
 	return status;
 }
 
@@ -1391,21 +1375,12 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
-static irqreturn_t mmci_cd_irq(int irq, void *dev_id)
-{
-	struct mmci_host *host = dev_id;
-
-	mmc_detect_change(host->mmc, msecs_to_jiffies(500));
-
-	return IRQ_HANDLED;
-}
-
 static struct mmc_host_ops mmci_ops = {
 	.request	= mmci_request,
 	.pre_req	= mmci_pre_request,
 	.post_req	= mmci_post_request,
 	.set_ios	= mmci_set_ios,
-	.get_ro		= mmci_get_ro,
+	.get_ro		= mmc_gpio_get_ro,
 	.get_cd		= mmci_get_cd,
 	.start_signal_voltage_switch = mmci_sig_volt_switch,
 };
@@ -1494,10 +1469,6 @@ static int mmci_probe(struct amba_device *dev,
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 
-	host->gpio_wp = -ENOSYS;
-	host->gpio_cd = -ENOSYS;
-	host->gpio_cd_irq = -1;
-
 	host->hw_designer = amba_manf(dev);
 	host->hw_revision = amba_rev(dev);
 	dev_dbg(mmc_dev(mmc), "designer ID = 0x%02x\n", host->hw_designer);
@@ -1568,6 +1539,9 @@ static int mmci_probe(struct amba_device *dev,
 
 	mmc->caps = plat->capabilities;
 	mmc->caps2 = plat->capabilities2;
+	if (!plat->cd_invert)
+		mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+	mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
 	if (variant->busy_detect) {
 		mmci_ops.card_busy = mmci_card_busy;
@@ -1621,49 +1595,23 @@ static int mmci_probe(struct amba_device *dev,
 		goto err_gpio_cd;
 	}
 	if (gpio_is_valid(plat->gpio_cd)) {
-		ret = gpio_request(plat->gpio_cd, DRIVER_NAME " (cd)");
-		if (ret == 0)
-			ret = gpio_direction_input(plat->gpio_cd);
-		if (ret == 0)
-			host->gpio_cd = plat->gpio_cd;
-		else if (ret != -ENOSYS)
+		ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
+		if (ret)
 			goto err_gpio_cd;
-
-		/*
-		 * A gpio pin that will detect cards when inserted and removed
-		 * will most likely want to trigger on the edges if it is
-		 * 0 when ejected and 1 when inserted (or mutatis mutandis
-		 * for the inverted case) so we request triggers on both
-		 * edges.
-		 */
-		ret = request_any_context_irq(gpio_to_irq(plat->gpio_cd),
-				mmci_cd_irq,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				DRIVER_NAME " (cd)", host);
-		if (ret >= 0)
-			host->gpio_cd_irq = gpio_to_irq(plat->gpio_cd);
 	}
 	if (plat->gpio_wp == -EPROBE_DEFER) {
 		ret = -EPROBE_DEFER;
-		goto err_gpio_wp;
+		goto err_gpio_cd;
 	}
 	if (gpio_is_valid(plat->gpio_wp)) {
-		ret = gpio_request(plat->gpio_wp, DRIVER_NAME " (wp)");
-		if (ret == 0)
-			ret = gpio_direction_input(plat->gpio_wp);
-		if (ret == 0)
-			host->gpio_wp = plat->gpio_wp;
-		else if (ret != -ENOSYS)
-			goto err_gpio_wp;
+		ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
+		if (ret)
+			goto err_gpio_cd;
 	}
 
-	if ((host->plat->status || host->gpio_cd != -ENOSYS)
-	    && host->gpio_cd_irq < 0)
-		mmc->caps |= MMC_CAP_NEEDS_POLL;
-
 	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
 	if (ret)
-		goto unmap;
+		goto err_gpio_cd;
 
 	if (!dev->irq[1])
 		host->singleirq = true;
@@ -1695,14 +1643,6 @@ static int mmci_probe(struct amba_device *dev,
 
  irq0_free:
 	free_irq(dev->irq[0], host);
- unmap:
-	if (host->gpio_wp != -ENOSYS)
-		gpio_free(host->gpio_wp);
- err_gpio_wp:
-	if (host->gpio_cd_irq >= 0)
-		free_irq(host->gpio_cd_irq, host);
-	if (host->gpio_cd != -ENOSYS)
-		gpio_free(host->gpio_cd);
  err_gpio_cd:
 	iounmap(host->base);
  clk_disable:
@@ -1741,13 +1681,6 @@ static int mmci_remove(struct amba_device *dev)
 		if (!host->singleirq)
 			free_irq(dev->irq[1], host);
 
-		if (host->gpio_wp != -ENOSYS)
-			gpio_free(host->gpio_wp);
-		if (host->gpio_cd_irq >= 0)
-			free_irq(host->gpio_cd_irq, host);
-		if (host->gpio_cd != -ENOSYS)
-			gpio_free(host->gpio_cd);
-
 		iounmap(host->base);
 		clk_disable_unprepare(host->clk);
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 58b1b88..8fc5814 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -176,9 +176,6 @@ struct mmci_host {
 	struct mmc_data		*data;
 	struct mmc_host		*mmc;
 	struct clk		*clk;
-	int			gpio_cd;
-	int			gpio_wp;
-	int			gpio_cd_irq;
 	bool			singleirq;
 
 	spinlock_t		lock;
-- 
1.7.9.5
