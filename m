From: r65037@freescale.com (Richard Zhu)
Date: Wed, 1 Sep 2010 17:45:05 +0800
Subject: [PATCH 1/9] sdhci-1: add host's own set_power func to support the
	controller that used it's own power mechanism
In-Reply-To: <1283334305-12453-1-git-send-email-r65037@freescale.com>
References: <1283334305-12453-1-git-send-email-r65037@freescale.com>
Message-ID: <1283334305-12453-2-git-send-email-r65037@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FSL's eSDHC controllers don't have the STANDARD POWER register in
the IC design, add the set_power api to support the FSL's eSDHC.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/mmc/host/sdhci.c |    5 +++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7855121..2a93c27 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1036,6 +1036,11 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
 	u8 pwr;
 
+	if (host->ops->set_power) {
+		host->ops->set_power(host, power);
+		return;
+	}
+
 	if (power == (unsigned short)-1)
 		pwr = 0;
 	else {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 036cfae..d420b4e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -316,6 +316,7 @@ struct sdhci_ops {
 #endif
 
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
+	void	(*set_power)(struct sdhci_host *host, unsigned int power);
 
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
-- 
1.7.0
