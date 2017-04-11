From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 11 Apr 2017 18:20:56 +0800
Subject: [PATCH 2/2] mmc: sdhci: provide isr for card-detect interrupts
In-Reply-To: <20170411102056.2869-1-jszhang@marvell.com>
References: <20170411102056.2869-1-jszhang@marvell.com>
Message-ID: <20170411102056.2869-3-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We found one issue on BG4CT platforms with GPIO for sdcar card detect
interrupt: remove sdcard when there's read write access to the sdcard,
sometimes the card remove event can't be handled for a long time, so
the  system still think the sdcard is still plugged in. It turns out
that the sdhci_card_event() is missing in common slot gpio's card
detect isr.

We fix this issue by providing sdhci's own isr for card-detect
interrupts. In this own isr, we call sdhci_card_event() then process
the change of state.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 63bc33a54d0d..b6c5021a5892 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2777,6 +2777,16 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	return result;
 }
 
+static irqreturn_t sdhci_cd_irq(int irq, void *dev_id)
+{
+	struct mmc_host *mmc = dev_id;
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	mmc->ops->card_event(mmc);
+	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 {
 	struct sdhci_host *host = dev_id;
@@ -3617,6 +3627,8 @@ int __sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
+	mmc_gpio_set_cd_isr(mmc, sdhci_cd_irq);
+
 	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
 				   IRQF_SHARED,	mmc_hostname(mmc), host);
 	if (ret) {
-- 
2.11.0
