From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Sep 2013 11:29:34 +0200
Subject: [PATCH V3 2/4] mmc: mmci: Use optional sleep pinctrl state
In-Reply-To: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1378200576-13413-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By optionally putting the pins into sleep state in the .runtime_suspend
callback we can accomplish two things. One is to minimize current leakage
from pins and thus save power, second we can prevent the IP from driving
pins output in an uncontrolled manner, which may happen if the power domain
drops the domain regulator.

When returning from idle, entering .runtime_resume callback, the pins
are restored to default state.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5dffbbd..c550b3e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1750,6 +1750,7 @@ static int mmci_runtime_suspend(struct device *dev)
 
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
+		pinctrl_pm_select_sleep_state(dev);
 		clk_disable_unprepare(host->clk);
 	}
 
@@ -1764,6 +1765,7 @@ static int mmci_runtime_resume(struct device *dev)
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
 		clk_prepare_enable(host->clk);
+		pinctrl_pm_select_default_state(dev);
 	}
 
 	return 0;
-- 
1.7.9.5
