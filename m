From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 5 Mar 2015 07:59:06 -0800
Subject: [PATCH 2/4] mmc: sdhci: do not set AUTO_CMD12 for multi-block CMD53
In-Reply-To: <1425571148-5876-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1425571148-5876-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1425571148-5876-3-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Corneliu Doban <cdoban@broadcom.com>

For CMD53 in block mode, the host does not need to stop the transfer,
as it stops when the block count (present in CMD53) is reached.

Signed-off-by: Corneliu Doban <cdoban@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fcf78ab..f35d413 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -28,6 +28,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/sdio.h>
 #include <linux/mmc/slot-gpio.h>
 
 #include "sdhci.h"
@@ -934,7 +935,8 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		 * If we are sending CMD23, CMD12 never gets sent
 		 * on successful completion (so no Auto-CMD12).
 		 */
-		if (!host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD12))
+		if (!host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD12) &&
+		    (cmd->opcode != SD_IO_RW_EXTENDED))
 			mode |= SDHCI_TRNS_AUTO_CMD12;
 		else if (host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
 			mode |= SDHCI_TRNS_AUTO_CMD23;
-- 
2.2.2
