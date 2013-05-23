From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 23 May 2013 11:45:05 +0200
Subject: [PATCH V2 1/3] mmc: mmci: Use optional sleep pinctrl state
In-Reply-To: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1369302307-28540-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

By optionally putting the pins into sleep state in the .runtime_suspend
callback we can accomplish two things. One is to minimize current leakage
from pins and thus save power, second we can prevent the IP from driving
pins output in an uncontrolled manner, which may happen if the power domain
drops the domain regulator.

When returning from idle, entering .runtime_resume callback, the pins
are restored to default state.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Changes in v2:
	Just adding Linus reviewed by.
---
 drivers/mmc/host/mmci.c |   16 ++++++++++++++++
 drivers/mmc/host/mmci.h |    1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c3785ed..9fa8855 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1527,6 +1527,12 @@ static int mmci_probe(struct amba_device *dev,
 	} else
 		dev_warn(&dev->dev, "could not get default pinstate\n");
 
+	/* fetch optional sleep state of pins */
+	host->pins_sleep = pinctrl_lookup_state(host->pinctrl,
+			PINCTRL_STATE_SLEEP);
+	if (IS_ERR(host->pins_sleep))
+		dev_dbg(&dev->dev, "could not get sleep pinstate\n");
+
 	/* Get regulators and the supported OCR mask */
 	mmc_regulator_get_supply(mmc);
 	if (!mmc->ocr_avail)
@@ -1767,6 +1773,11 @@ static int mmci_runtime_suspend(struct device *dev)
 
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
+
+		/* Optionally let pins go into sleep state */
+		if (!IS_ERR(host->pins_sleep))
+			pinctrl_select_state(host->pinctrl, host->pins_sleep);
+
 		clk_disable_unprepare(host->clk);
 	}
 
@@ -1780,7 +1791,12 @@ static int mmci_runtime_resume(struct device *dev)
 
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
+
 		clk_prepare_enable(host->clk);
+
+		/* Optionally enable pins to be muxed in and configured */
+		if (!IS_ERR(host->pins_default))
+			pinctrl_select_state(host->pinctrl, host->pins_default);
 	}
 
 	return 0;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 69080fa..060f919 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -203,6 +203,7 @@ struct mmci_host {
 	/* pinctrl handles */
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	*pins_default;
+	struct pinctrl_state	*pins_sleep;
 
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
-- 
1.7.10
