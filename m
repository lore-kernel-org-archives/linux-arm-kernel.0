From: addy.ke@rock-chips.com (Addy Ke)
Date: Sat, 14 Feb 2015 14:17:46 +0800
Subject: [PATCH v4 1/3] mmc: dw_mmc: update clock after host reach a stable
 voltage
In-Reply-To: <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1423894668-8886-2-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As show in mmc_power_up(), in MMC_POWER_UP state, the voltage isn't
stable and we may get 'data busy' which can't be cleaned by resetting
all blocks. So we should not send command to update clock in this state.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4d2e3c2..3472f9b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1102,7 +1102,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		drv_data->set_ios(slot->host, ios);
 
 	/* Slot specific timing and width adjustment */
-	dw_mci_setup_bus(slot, false);
+	if (ios->power_mode != MMC_POWER_UP)
+		dw_mci_setup_bus(slot, false);
 
 	if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
 		slot->host->state = STATE_IDLE;
-- 
1.8.3.2
