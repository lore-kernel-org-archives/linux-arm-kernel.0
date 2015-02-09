From: addy.ke@rock-chips.com (Addy Ke)
Date: Mon,  9 Feb 2015 15:25:26 +0800
Subject: [PATCH v2 2/2] mmc: dw_mmc: Don't start command while data busy
In-Reply-To: <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
References: <1423134801-23219-1-git-send-email-addy.ke@rock-chips.com>
 <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1423466726-20833-3-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should wait for data busy here in non-volt-switch state.
This may happend when sdio sends CMD53.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b0b57e3..b40080d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1007,6 +1007,13 @@ static void __dw_mci_start_request(struct dw_mci *host,
 		mci_writel(host, BLKSIZ, data->blksz);
 	}
 
+	/*
+	 * We should wait for data busy here in non-volt-switch state.
+	 * This may happend when sdio sends CMD53.
+	 */
+	if (host->state != STATE_WAITING_CMD11_DONE)
+		dw_mci_wait_busy(slot);
+
 	cmdflags = dw_mci_prepare_command(slot->mmc, cmd);
 
 	/* this is the first command, send the initialization clock */
-- 
1.8.3.2
