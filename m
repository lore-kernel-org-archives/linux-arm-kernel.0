From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 2 Mar 2017 17:47:27 +0800
Subject: [PATCH 6/9] mmc: sdhci: add a quirk to restore delay in tuning
In-Reply-To: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1488448050-7574-7-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was a mdelay between tuning cycles which is removed since
eMMC spec didn't require that. However it's observed that eSDHC
needed this delay for HS200 successful tuning. Maybe it's also
needed for some other controllers. This patch is to add a quirk
to fix it.

Fixes: 197160d52e85 ("mmc: sdhci: remove mdelay in eMMC tuning")
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 051b192..b1b6fd3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2100,7 +2100,8 @@ static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode,
 		}
 
 		/* eMMC spec does not require a delay between tuning cycles */
-		if (opcode == MMC_SEND_TUNING_BLOCK)
+		if ((opcode == MMC_SEND_TUNING_BLOCK) ||
+		    (host->quirks2 & SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES))
 			mdelay(1);
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d43519b..b6643bc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -427,6 +427,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Delay is needed between tuning cycles */
+#define SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES	(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.1.0.27.g96db324
