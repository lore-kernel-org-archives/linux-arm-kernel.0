From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 03 Nov 2016 15:21:26 +0900
Subject: [PATCH 04/13] mmc: dw_mmc: use the hold register when send stop
 command
In-Reply-To: <20161103062135.10697-1-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Message-ID: <20161103062135.10697-5-jh80.chung@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If DW_MMC_CARD_NO_USE_HOLD isn't set, it's usesd by default.
Enve if SDMMC_CMD_USB_HOLD_REG is set in prepare_command(), but it
doesn't set in pre_stop_abort().

To maintain the consistency, add the checking condition for this.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6ccb817..23fc505 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -337,6 +337,9 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	cmdr = stop->opcode | SDMMC_CMD_STOP |
 		SDMMC_CMD_RESP_CRC | SDMMC_CMD_RESP_EXP;
 
+	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags))
+		cmdr |= SDMMC_CMD_USE_HOLD_REG;
+
 	return cmdr;
 }
 
-- 
2.10.1
