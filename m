From: addy.ke@rock-chips.com (Addy Ke)
Date: Sat, 14 Feb 2015 14:17:48 +0800
Subject: [PATCH v4 3/3] mmc: dw_mmc: Don't start command while data busy
In-Reply-To: <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1423894668-8886-4-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should wait until unbusy before the next request.
But this does't need if the command is CMD13, which can access
SD Status register regardless of data busy.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
Changes in v4:
- CMD13 doesn't need wait until unbusy.

 drivers/mmc/host/dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ac21863..692d97a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1076,6 +1076,10 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	WARN_ON(slot->mrq);
 
+	/* Wait until unbusy if the command isn't CMD13 */
+	if (mrq->cmd->opcode != MMC_SEND_STATUS)
+		dw_mci_wait_busy(slot);
+
 	/*
 	 * The check for card presence and queueing of the request must be
 	 * atomic, otherwise the card could be removed in between and the
-- 
1.8.3.2
