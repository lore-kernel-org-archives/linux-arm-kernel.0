From: addy.ke@rock-chips.com (Addy Ke)
Date: Thu,  5 Feb 2015 19:13:21 +0800
Subject: [PATCH] mmc: dw_mmc: fix bug that cause 'Timeout sending command'
Message-ID: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because of some uncertain factors, such as worse card or worse hardware,
DAT[3:0](the data lines) may be pulled down by card, and mmc controller
will be in busy state. This should not happend when mmc controller
send command to update card clocks. If this happends, mci_send_cmd will
be failed and we will get 'Timeout sending command', and then system will
be blocked. To avoid this, we need reset mmc controller.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4d2e3c2..b1d6dfb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -100,6 +100,7 @@ struct idmac_desc {
 };
 #endif /* CONFIG_MMC_DW_IDMAC */
 
+static int dw_mci_card_busy(struct mmc_host *mmc);
 static bool dw_mci_reset(struct dw_mci *host);
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
 
@@ -888,6 +889,26 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 		cmd, arg, cmd_status);
 }
 
+static void dw_mci_wait_busy(struct dw_mci_slot *slot)
+{
+	struct dw_mci *host = slot->host;
+	unsigned long timeout = jiffies + msecs_to_jiffies(500);
+
+	while (time_before(jiffies, timeout)) {
+		if (!dw_mci_card_busy(slot->mmc))
+			return;
+	}
+	dev_err(host->dev, "Data busy (status %#x)\n",
+		mci_readl(slot->host, STATUS));
+
+	/*
+	 * Data busy, this should not happend when mmc controller send command
+	 * to update card clocks in non-volt-switch state. If it happends, we
+	 * should reset controller to avoid getting "Timeout sending command".
+	 */
+	dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS);
+}
+
 static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
@@ -899,6 +920,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	/* We must continue to set bit 28 in CMD until the change is complete */
 	if (host->state == STATE_WAITING_CMD11_DONE)
 		sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
+	else
+		dw_mci_wait_busy(slot);
 
 	if (!clock) {
 		mci_writel(host, CLKENA, 0);
-- 
1.8.3.2
