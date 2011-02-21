From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 21 Feb 2011 17:54:55 +0800
Subject: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
In-Reply-To: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix no INT in MULTI-BLK IO.

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 9b82910..2eeb03e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -113,7 +113,10 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
-	if (cpu_is_mx35() || cpu_is_mx51())
+	if (cpu_is_mx53())
+		host->quirks |= SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;
+
+	if (cpu_is_mx35() || cpu_is_mx51() || cpu_is_mx53())
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	/* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..db7d0b7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -828,6 +828,20 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 			mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
 		else
 			mode |= SDHCI_TRNS_MULTI;
+
+		if (host->quirks & SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO) {
+			/*
+			 * Fix no INT bug in SDIO MULTI-BLK read
+			 * set bit1 of Vendor Spec Registor
+			 */
+			if ((host->cmd->opcode == 0x35)
+					&& (data->flags & MMC_DATA_READ)) {
+				u32 v;
+				v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
+				v |= 0x2;
+				writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
+			}
+		}
 	}
 	if (data->flags & MMC_DATA_READ)
 		mode |= SDHCI_TRNS_READ;
@@ -868,6 +882,12 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	else
 		data->bytes_xfered = data->blksz * data->blocks;
 
+	if (host->quirks & SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO) {
+		if (readl(host->ioaddr + SDHCI_VENDOR_SPEC) & 0x2)
+			writel(readl(host->ioaddr + SDHCI_VENDOR_SPEC) & ~0x2,
+					host->ioaddr + SDHCI_VENDOR_SPEC);
+	}
+
 	if (data->stop) {
 		/*
 		 * The controller needs a reset of internal state machines
@@ -950,6 +970,11 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (cmd->data)
 		flags |= SDHCI_CMD_DATA;
 
+	/*Set the CMD_TYPE of the CMD12, fix no INT in MULTI_BLK IO */
+	if (host->quirks & SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO) {
+		if (cmd->opcode == 12)
+			flags |= SDHCI_CMD_ABORTCMD;
+	}
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..1bd761f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -45,6 +45,7 @@
 #define  SDHCI_CMD_CRC		0x08
 #define  SDHCI_CMD_INDEX	0x10
 #define  SDHCI_CMD_DATA		0x20
+#define  SDHCI_CMD_ABORTCMD	0xC0
 
 #define  SDHCI_CMD_RESP_NONE	0x00
 #define  SDHCI_CMD_RESP_LONG	0x01
@@ -183,6 +184,8 @@
 
 /* 60-FB reserved */
 
+#define SDHCI_VENDOR_SPEC	0xC0
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 83bd9f7..ae3c6de 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -85,6 +85,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
 #define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
+/* Controller can't come to the correct status in MULTI-BLK IO automatically */
+#define SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO		(1<<31)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.1
