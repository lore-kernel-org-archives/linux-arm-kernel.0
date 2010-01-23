From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sat, 23 Jan 2010 22:48:38 +0100
Subject: [PATCH] MMCI: work around a hardware bug in U300
Message-ID: <1264283318-24087-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the U300 some hardware bug makes the status flag not come up
signalling a successful write (or anything else, like an error, for
that matter) on write requests. This little quirk makes the writes
work on U300.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 90d168a..643818a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -184,6 +184,17 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 {
 	if (status & MCI_DATABLOCKEND) {
 		host->data_xfered += data->blksz;
+#ifdef CONFIG_ARCH_U300
+		/*
+		 * On the U300 some signal or other is
+		 * badly routed so that a data write does
+		 * not properly terminate with a MCI_DATAEND
+		 * status flag. This quirk will make writes
+		 * work again.
+		 */
+		if (data->flags & MMC_DATA_WRITE)
+			status |= MCI_DATAEND;
+#endif
 	}
 	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
 		if (status & MCI_DATACRCFAIL)
-- 
1.6.3.3
