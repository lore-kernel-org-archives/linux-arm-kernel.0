From: Vincent.Yang@tw.fujitsu.com (Vincent Yang)
Date: Sun, 13 Jul 2014 13:21:08 +0800
Subject: [PATCH 2/4] mmc: sdhci: add quirk for tuning work around
In-Reply-To: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <1405228870-5088-3-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines a quirk for tuning work
around for some sdhci host controller. It sets
both SDHCI_CTRL_EXEC_TUNING and SDHCI_CTRL_TUNED_CLK
for tuning.
It is a preparation and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/host/sdhci.c  | 2 ++
 include/linux/mmc/sdhci.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d62262b..900b4e4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1867,6 +1867,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	ctrl |= SDHCI_CTRL_EXEC_TUNING;
+	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
+		ctrl |= SDHCI_CTRL_TUNED_CLK;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	/*
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 5433f04..bcbad45 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -100,6 +100,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
 /* Do a callback when switching voltages so do controller-specific actions */
 #define SDHCI_QUIRK2_VOLTAGE_SWITCH			(1<<8)
+/* forced tuned clock */
+#define SDHCI_QUIRK2_TUNING_WORK_AROUND		(1<<9)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0
