From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 30 Jan 2011 21:28:56 +0000
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110130212856.GA32737@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

Here's another couple of fixes...

8<----
Subject: [PATCH 1/2] ARM: mmci: complete the transaction on error

When we encounter an error, make sure we complete the transaction
otherwise we'll leave the request dangling.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/mmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b6fd6dc..175a623 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -319,7 +319,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	if (status & MCI_DATABLOCKEND)
 		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
 
-	if (status & MCI_DATAEND) {
+	if (status & MCI_DATAEND || data->error) {
 		mmci_stop_data(host);
 
 		if (!data->error)
-- 
1.6.2.5
