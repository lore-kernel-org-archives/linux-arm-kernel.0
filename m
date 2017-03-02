From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 2 Mar 2017 17:47:26 +0800
Subject: [PATCH 5/9] mmc: sdhci-of-esdhc: add tuning block support
In-Reply-To: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1488448050-7574-6-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tuning block support for eSDHC.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc.h    |  5 +++++
 drivers/mmc/host/sdhci-of-esdhc.c | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 6869567..c4bbd74 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -53,9 +53,14 @@
 #define ESDHC_CLOCK_HCKEN		0x00000002
 #define ESDHC_CLOCK_IPGEN		0x00000001
 
+/* Tuning Block Control Register */
+#define ESDHC_TBCTL			0x120
+#define ESDHC_TB_EN			0x00000004
+
 /* Control Register for DMA transfer */
 #define ESDHC_DMA_SYSCTL		0x40c
 #define ESDHC_PERIPHERAL_CLK_SEL	0x00080000
+#define ESDHC_FLUSH_ASYNC_FIFO		0x00040000
 #define ESDHC_DMA_SNOOP			0x00000040
 
 #endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index c2619f1..b26a780 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -622,6 +622,21 @@ static int esdhc_signal_voltage_switch(struct sdhci_host *host,
 	}
 }
 
+void esdhc_set_tuning_block(struct sdhci_host *host)
+{
+	u32 val;
+
+	esdhc_clock_enable(host, false);
+	val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
+	val |= ESDHC_FLUSH_ASYNC_FIFO;
+	sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
+
+	val = sdhci_readl(host, ESDHC_TBCTL);
+	val |= ESDHC_TB_EN;
+	sdhci_writel(host, val, ESDHC_TBCTL);
+	esdhc_clock_enable(host, true);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static u32 esdhc_proctl;
 static int esdhc_of_suspend(struct device *dev)
@@ -667,6 +682,7 @@ static const struct sdhci_ops sdhci_esdhc_be_ops = {
 	.reset = esdhc_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.start_signal_voltage_switch = esdhc_signal_voltage_switch,
+	.set_tuning_block = esdhc_set_tuning_block,
 };
 
 static const struct sdhci_ops sdhci_esdhc_le_ops = {
@@ -685,6 +701,7 @@ static const struct sdhci_ops sdhci_esdhc_le_ops = {
 	.reset = esdhc_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.start_signal_voltage_switch = esdhc_signal_voltage_switch,
+	.set_tuning_block = esdhc_set_tuning_block,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_be_pdata = {
-- 
2.1.0.27.g96db324
