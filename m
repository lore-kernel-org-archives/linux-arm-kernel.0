From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 10 Nov 2011 16:33:19 +0100
Subject: [PATCH] mmc: mmci: Fixup handling of MCI_STARTBITERR
Message-ID: <1320939199-30363-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt was previously enabled and then correctly cleared.
Now we also handle it correctly.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 50b5f99..8265981 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -675,7 +675,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
 	/* First check for errors */
-	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_STARTBITERR|
+		      MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
@@ -955,8 +956,9 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
 
 		data = host->data;
-		if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|
-			      MCI_RXOVERRUN|MCI_DATAEND|MCI_DATABLOCKEND) && data)
+		if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_STARTBITERR|
+			      MCI_TXUNDERRUN|MCI_RXOVERRUN|MCI_DATAEND|
+			      MCI_DATABLOCKEND) && data)
 			mmci_data_irq(host, data, status);
 
 		cmd = host->cmd;
-- 
1.7.5.4
