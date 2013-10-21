From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 21 Oct 2013 22:27:01 +0800
Subject: [PATCH 1/7] mmc: sdhci: clear auto cmd setting bits for no data cmds
In-Reply-To: <1382365627-26816-1-git-send-email-b29396@freescale.com>
References: <1382365627-26816-1-git-send-email-b29396@freescale.com>
Message-ID: <1382365627-26816-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The auto cmd settings bits should be cleared before sending new commands
or we may receive command timeout error for normal commands due to wrongly
pre-sent auto cmd.

e.g. we receive CMD13 timeout error due to ACMD23 is wrongly enabled
by former data commands.

mmc2: new high speed DDR MMC card at address 0001
mmcblk1: mmc2:0001 SEM08G 7.39 GiB
mmcblk1boot0: mmc2:0001 SEM08G partition 1 2.00 MiB
mmcblk1boot1: mmc2:0001 SEM08G partition 2 2.00 MiB
mmcblk1rpmb: mmc2:0001 SEM08G partition 3 128 KiB
 mmcblk1: p1 p2 p3 p4 < p5 p6 p7 >
mmc2: Timeout waiting for hardware interrupt.
 mmcblk1boot1: unknown partition table
mmc2: Timeout waiting for hardware interrupt.
 mmcblk1boot0: unknown partition table

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a21a710..f868e9b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -898,6 +898,11 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	u16 mode;
 	struct mmc_data *data = cmd->data;
 
+	/* clear Auto CMD settings for no data CMDs */
+	mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
+	sdhci_writew(host, mode & ~(SDHCI_TRNS_AUTO_CMD12 |
+			SDHCI_TRNS_AUTO_CMD23), SDHCI_TRANSFER_MODE);
+
 	if (data == NULL)
 		return;
 
-- 
1.7.2.rc3
