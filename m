From: addy.ke@rock-chips.com (Addy Ke)
Date: Fri, 13 Feb 2015 19:52:48 +0800
Subject: [PATCH v3 3/3] mmc: dw_mmc: Don't start command while data busy
In-Reply-To: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
References: <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
 <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1423828368-18456-4-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should wait for data busy here in non-volt-switch state.
This may happend when sdio sends CMD53.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f0d9da5..23507c9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1076,6 +1076,12 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(slot->mrq);
 
 	/*
+	 * We should wait for data busy here in non-volt-switch state.
+	 * This may happend when sdio sends CMD53.
+	 */
+	dw_mci_wait_busy(slot);
+
+	/*
 	 * The check for card presence and queueing of the request must be
 	 * atomic, otherwise the card could be removed in between and the
 	 * request wouldn't fail until another card was inserted.
-- 
1.8.3.2
