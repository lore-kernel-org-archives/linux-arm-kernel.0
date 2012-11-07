From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 07 Nov 2012 16:37:40 +0530
Subject: [PATCH] mmc: dw_mmc: Add sdio power bindings
In-Reply-To: <1352286460-13925-1-git-send-email-a.kesavan@samsung.com>
References: <1352286460-13925-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1352286460-13925-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt-based retrieval of host sdio pm capabilities. Based on
the dt based discovery do a bus init in the resume function.

Signed-off-by: Olof Johansson <olofj@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   20 +++++++++++++++++---
 include/linux/mmc/dw_mmc.h |    1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c0667c8..5979203 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -617,13 +617,13 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 		cmd, arg, cmd_status);
 }
 
-static void dw_mci_setup_bus(struct dw_mci_slot *slot)
+static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
 	u32 div;
 	u32 clk_en_a;
 
-	if (slot->clock != host->current_speed) {
+	if (slot->clock != host->current_speed || force_clkinit) {
 		div = host->bus_hz / slot->clock;
 		if (host->bus_hz % slot->clock && host->bus_hz > slot->clock)
 			/*
@@ -684,7 +684,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 		host->pdata->select_slot(slot->id);
 
 	/* Slot specific timing and width adjustment */
-	dw_mci_setup_bus(slot);
+	dw_mci_setup_bus(slot, false);
 
 	host->cur_slot = slot;
 	host->mrq = mrq;
@@ -1850,6 +1850,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
 
+	if (host->pdata->pm_caps)
+		mmc->pm_caps = host->pdata->pm_caps;
+
 	if (host->dev->of_node) {
 		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
 		if (ctrl_id < 0)
@@ -2072,6 +2075,12 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			return ERR_PTR(ret);
 	}
 
+	if (of_find_property(np, "keep-power-in-suspend", NULL))
+		pdata->pm_caps |= MMC_PM_KEEP_POWER;
+
+	if (of_find_property(np, "enable-sdio-wakeup", NULL))
+		pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+
 	return pdata;
 }
 
@@ -2411,6 +2420,11 @@ int dw_mci_resume(struct dw_mci *host)
 		struct dw_mci_slot *slot = host->slot[i];
 		if (!slot)
 			continue;
+		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
+			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
+			dw_mci_setup_bus(slot, true);
+		}
+
 		ret = mmc_resume_host(host->slot[i]->mmc);
 		if (ret < 0)
 			return ret;
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 9653166..b27471d 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -231,6 +231,7 @@ struct dw_mci_board {
 
 	unsigned int caps;	/* Capabilities */
 	unsigned int caps2;	/* More capabilities */
+	unsigned int pm_caps;	/* PM capabilities */
 	/*
 	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
 	 * but note that this may not be reliable after a bootloader has used
-- 
1.6.6.1
