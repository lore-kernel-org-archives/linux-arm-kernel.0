From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 16 Jun 2014 09:58:01 +0200
Subject: [PATCH 1/3] mmc: mmci: Remove redundant check of status for DATA irq
In-Reply-To: <1402905483-22567-1-git-send-email-ulf.hansson@linaro.org>
References: <1402905483-22567-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402905483-22567-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to verify the content of the status register twice, while
we are about to handle a DATA irq. Instead let's leave all verification
to be handled by mmci_data_irq().

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 6483c5c..a723ed2 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -888,6 +888,10 @@ static void
 mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
+	/* Make sure we have data to handle */
+	if (!data)
+		return;
+
 	/* First check for errors */
 	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_STARTBITERR|
 		      MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
@@ -1206,7 +1210,6 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 
 	do {
 		struct mmc_command *cmd;
-		struct mmc_data *data;
 
 		status = readl(host->base + MMCISTATUS);
 
@@ -1232,11 +1235,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 			MCI_CMDSENT|MCI_CMDRESPEND) && cmd)
 			mmci_cmd_irq(host, cmd, status);
 
-		data = host->data;
-		if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_STARTBITERR|
-			      MCI_TXUNDERRUN|MCI_RXOVERRUN|MCI_DATAEND|
-			      MCI_DATABLOCKEND) && data)
-			mmci_data_irq(host, data, status);
+		mmci_data_irq(host, host->data, status);
 
 		/* Don't poll for busy completion in irq context. */
 		if (host->busy_status)
-- 
1.7.9.5
