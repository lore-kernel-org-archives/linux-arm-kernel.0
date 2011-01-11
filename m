From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 16:35:56 +0000
Subject: [PATCH] MMCI: don't read command response when invalid
In-Reply-To: <20110111163502.GJ11039@n2100.arm.linux.org.uk>
References: <20110111163502.GJ11039@n2100.arm.linux.org.uk>
Message-ID: <20110111163556.GA18746@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't read the command response from the registers when either the
command timed out (because there was no response from the card) or
the checksum on the response was invalid.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/mmci.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5630228..040de4f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -394,15 +394,15 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 
 	host->cmd = NULL;
 
-	cmd->resp[0] = readl(base + MMCIRESPONSE0);
-	cmd->resp[1] = readl(base + MMCIRESPONSE1);
-	cmd->resp[2] = readl(base + MMCIRESPONSE2);
-	cmd->resp[3] = readl(base + MMCIRESPONSE3);
-
 	if (status & MCI_CMDTIMEOUT) {
 		cmd->error = -ETIMEDOUT;
 	} else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
 		cmd->error = -EILSEQ;
+	} else {
+		cmd->resp[0] = readl(base + MMCIRESPONSE0);
+		cmd->resp[1] = readl(base + MMCIRESPONSE1);
+		cmd->resp[2] = readl(base + MMCIRESPONSE2);
+		cmd->resp[3] = readl(base + MMCIRESPONSE3);
 	}
 
 	if (!cmd->data || cmd->error) {
