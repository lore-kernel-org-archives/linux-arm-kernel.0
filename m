From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed,  8 Feb 2012 18:22:39 +0100
Subject: [PATCH] mmc: atmel-mci: save and restore sdioirq when soft reset is
 performed
Message-ID: <1328721759-10124-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: stable at vger.kernel.org
---
 drivers/mmc/host/atmel-mci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 09ac13b..dfa5dd9 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -965,11 +965,14 @@ static void atmci_start_request(struct atmel_mci *host,
 	host->data_status = 0;
 
 	if (host->need_reset) {
+		iflags = atmci_readl(host, ATMCI_IMR);
+		iflags &= (ATMCI_SDIOIRQA | ATMCI_SDIOIRQB);
 		atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
 		atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
 		atmci_writel(host, ATMCI_MR, host->mode_reg);
 		if (host->caps.has_cfg_reg)
 			atmci_writel(host, ATMCI_CFG, host->cfg_reg);
+		atmci_writel(host, ATMCI_IER, iflags);
 		host->need_reset = false;
 	}
 	atmci_writel(host, ATMCI_SDCR, slot->sdc_reg);
-- 
1.7.5.4
