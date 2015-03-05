From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 5 Mar 2015 07:59:05 -0800
Subject: [PATCH 1/4] mmc: sdhci: add quirk for ACMD23 broken
In-Reply-To: <1425571148-5876-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1425571148-5876-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1425571148-5876-2-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add quirk to handle broken auto-CMD23.
Some controllers do not respond after the first auto-CMD23 is issued.

This allows CMD23 to still work (mandatory for the faster UHS-I mode)
rather than disabling CMD23 entirely via SDHCI_QUIRK2_HOST_NO_CMD23.

Signed-off by: Corneliu Doban <cdoban@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>

Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/mmc/host/sdhci.c  | 3 ++-
 include/linux/mmc/sdhci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f1a488e..fcf78ab 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3085,7 +3085,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	/* Auto-CMD23 stuff only works in ADMA or PIO. */
 	if ((host->version >= SDHCI_SPEC_300) &&
 	    ((host->flags & SDHCI_USE_ADMA) ||
-	     !(host->flags & SDHCI_USE_SDMA))) {
+	     !(host->flags & SDHCI_USE_SDMA)) &&
+	     !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
 		host->flags |= SDHCI_AUTO_CMD23;
 		DBG("%s: Auto-CMD23 available\n", mmc_hostname(mmc));
 	} else {
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index f767a0d..a29e9bb 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -106,6 +106,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD	(1<<10)
 /* Capability register bit-63 indicates HS400 support */
 #define SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400		(1<<11)
+/* Controller broken with using ACMD23 */
+#define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<12)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.2.2
