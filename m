From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue,  1 May 2012 22:07:41 -0700
Subject: [PATCH 2/7] mmc: dw_mmc: add quirk to indicate missing write protect
 line
In-Reply-To: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1335935266-25289-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the write protect pad of the controller is not connected to the write
protect pin of the slot, the driver should be notified of this condition
so that incorrect check for write protection by reading the WRTORT
register can avoided. The get_ro platform callback can be used for in
such cases, but with device tree support enabled, such platform callbacks
cannot be supported.

Add a new quirk for notifying the driver about the missing write protect
line so the driver can assume that the card write protection is disabled.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/dw_mmc.c  |    4 +++-
 include/linux/mmc/dw_mmc.h |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 036846f..38cb7f8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -812,7 +812,9 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 	struct dw_mci_board *brd = slot->host->pdata;
 
 	/* Use platform get_ro function, else try on board write protect */
-	if (brd->get_ro)
+	if (brd->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT)
+		read_only = 0;
+	else if (brd->get_ro)
 		read_only = brd->get_ro(slot->id);
 	else
 		read_only =
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index fa9a139..fb51a5f 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -205,7 +205,8 @@ struct dw_mci_dma_ops {
 #define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
 /* Unreliable card detection */
 #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
-
+/* Write Protect detection not available */
+#define DW_MCI_QUIRK_NO_WRITE_PROTECT		BIT(4)
 
 struct dma_pdata;
 
-- 
1.7.5.4
