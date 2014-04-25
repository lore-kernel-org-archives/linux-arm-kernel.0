From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:55:30 +0100
Subject: [PATCH 185/222] mmc: sdio_irq: rework sdio irq handling
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wdej4-0007Q2-Vq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than the SDIO support spawning it's own thread for handling card
interrupts, use the generic IRQ infrastructure for this, triggering it
from the host interface's interrupt handling directly.

This avoids a race between the parent thread waiting to receive an
interrupt response from the card, and the slow startup from the sdio
irq thread, which can occur as a result of high system load (eg, while
udev is running.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/core/sdio_irq.c | 41 +++++++++++++++++++++++++++++++----------
 include/linux/mmc/host.h    |  3 +++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index aaa90460ed23..5cc13c8d35bb 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -90,6 +90,15 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	return ret;
 }
 
+void sdio_run_irqs(struct mmc_host *host)
+{
+	mmc_claim_host(host);
+	host->sdio_irq_pending = true;
+	process_sdio_pending_irqs(host);
+	mmc_release_host(host);
+}
+EXPORT_SYMBOL_GPL(sdio_run_irqs);
+
 static int sdio_irq_thread(void *_host)
 {
 	struct mmc_host *host = _host;
@@ -189,14 +198,20 @@ static int sdio_card_irq_get(struct mmc_card *card)
 	WARN_ON(!host->claimed);
 
 	if (!host->sdio_irqs++) {
-		atomic_set(&host->sdio_irq_thread_abort, 0);
-		host->sdio_irq_thread =
-			kthread_run(sdio_irq_thread, host, "ksdioirqd/%s",
-				mmc_hostname(host));
-		if (IS_ERR(host->sdio_irq_thread)) {
-			int err = PTR_ERR(host->sdio_irq_thread);
-			host->sdio_irqs--;
-			return err;
+		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD)) {
+			atomic_set(&host->sdio_irq_thread_abort, 0);
+			host->sdio_irq_thread =
+				kthread_run(sdio_irq_thread, host,
+					    "ksdioirqd/%s", mmc_hostname(host));
+			if (IS_ERR(host->sdio_irq_thread)) {
+				int err = PTR_ERR(host->sdio_irq_thread);
+				host->sdio_irqs--;
+				return err;
+			}
+		} else {
+			mmc_host_clk_hold(host);
+			host->ops->enable_sdio_irq(host, 1);
+			mmc_host_clk_release(host);
 		}
 	}
 
@@ -211,8 +226,14 @@ static int sdio_card_irq_put(struct mmc_card *card)
 	BUG_ON(host->sdio_irqs < 1);
 
 	if (!--host->sdio_irqs) {
-		atomic_set(&host->sdio_irq_thread_abort, 1);
-		kthread_stop(host->sdio_irq_thread);
+		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD)) {
+			atomic_set(&host->sdio_irq_thread_abort, 1);
+			kthread_stop(host->sdio_irq_thread);
+		} else {
+			mmc_host_clk_hold(host);
+			host->ops->enable_sdio_irq(host, 0);
+			mmc_host_clk_release(host);
+		}
 	}
 
 	return 0;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cb61ea4d6945..4c0f94679898 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -278,6 +278,7 @@ struct mmc_host {
 #define MMC_CAP2_PACKED_CMD	(MMC_CAP2_PACKED_RD | \
 				 MMC_CAP2_PACKED_WR)
 #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
+#define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 15)
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
@@ -391,6 +392,8 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 	wake_up_process(host->sdio_irq_thread);
 }
 
+void sdio_run_irqs(struct mmc_host *host);
+
 #ifdef CONFIG_REGULATOR
 int mmc_regulator_get_ocrmask(struct regulator *supply);
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
-- 
1.8.3.1
