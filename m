From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Sep 2015 17:30:25 +0200
Subject: [PATCH 2/3] mmc: Wait for card_busy before starting sdio requests
In-Reply-To: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
References: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1442935826-16758-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some sdio wifi chips will not work properly if we try to start new
sdio-rw requests while the device is signalling that it is busy.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/core/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0520064..ced66b8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -204,6 +204,23 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 		return;
 	}
 
+	/*
+	 * For sdio rw commands we must wait for card busy otherwise some
+	 * sdio devices won't work properly.
+	 */
+	if (mmc_is_io_op(mrq->cmd->opcode) && host->ops->card_busy) {
+		int tries = 500; /* Wait aprox 500ms at maximum */
+
+		while (host->ops->card_busy(host) && --tries)
+			mmc_delay(1);
+
+		if (tries == 0) {
+			mrq->cmd->error = -EBUSY;
+			mmc_request_done(host, mrq);
+			return;
+		}
+	}
+
 	host->ops->request(host, mrq);
 }
 
-- 
2.4.3
