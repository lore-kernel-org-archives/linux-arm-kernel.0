From: dianders@chromium.org (Doug Anderson)
Date: Wed, 19 Nov 2014 11:37:21 -0800
Subject: [PATCH v2] mmc: dw_mmc: Turn the card clock off at suspend time
Message-ID: <1416425841-12681-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the dw_mmc driver was first added to Linux it's had a TODO in it
that we should turn off the card clock during suspend.  I have no idea
for sure why it wasn't done originally, but if I had to guess I'd
guess it was related to the lack of a common clock framework.  Let's
do it now.

There is no reason for the card clock to be left on during suspend and
most systems will eventually turn it off anyway (when whole clock
trees are disabled).  However, it's good to be explicit that it's
disabled at the time that the MMC subsystem is disabled.

This actually fixes a bug on Rockchip rk3288 where an SDIO card wakes
the system back up during suspend.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v2:
- Handle fact that ciu_clk is optional (abrestic)
- Check for errors enabling ciu_clk (abrestic)

 drivers/mmc/host/dw_mmc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5a37c33..49f4013 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2825,11 +2825,11 @@ EXPORT_SYMBOL(dw_mci_remove);
 
 
 #ifdef CONFIG_PM_SLEEP
-/*
- * TODO: we should probably disable the clock to the card in the suspend path.
- */
 int dw_mci_suspend(struct dw_mci *host)
 {
+	if (!IS_ERR(host->ciu_clk))
+		clk_disable(host->ciu_clk);
+
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_suspend);
@@ -2838,9 +2838,15 @@ int dw_mci_resume(struct dw_mci *host)
 {
 	int i, ret;
 
+	if (!IS_ERR(host->ciu_clk)) {
+		ret = clk_enable(host->ciu_clk);
+		if (ret)
+			return ret;
+	}
+
 	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
 		ret = -ENODEV;
-		return ret;
+		goto exit_ciu_enabled;
 	}
 
 	if (host->use_dma && host->dma_ops->init)
@@ -2871,7 +2877,14 @@ int dw_mci_resume(struct dw_mci *host)
 			dw_mci_setup_bus(slot, true);
 		}
 	}
+
 	return 0;
+
+exit_ciu_enabled:
+	if (!IS_ERR(host->ciu_clk))
+		clk_disable(host->ciu_clk);
+
+	return ret;
 }
 EXPORT_SYMBOL(dw_mci_resume);
 #endif /* CONFIG_PM_SLEEP */
-- 
2.1.0.rc2.206.gedb03e5
