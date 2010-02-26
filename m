From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 26 Feb 2010 19:39:33 +0100
Subject: [PATCH 5/7] mmc: at91_mci: enable large data blocks
In-Reply-To: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
Message-ID: <ff9a79b6fbed698f446c537550255e571884918a.1267209149.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfgang Muees <wolfgang.mues@auerswald.de>

This patch is setting some max_ variables for the IO elevator, so the elevator
will put requests for large data blocks to the driver. This is critical for
a) speed
and
b) wear leveling of the flash chip controller: Otherwise the controller will
treat the SD card badly with millions of single 4 KByte write commands. This
will lead to a shorter life time for the SD cards.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/at91_mci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 28fd565..4c30c56 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -934,6 +934,9 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	mmc->max_blk_size  = MCI_MAXBLKSIZE;
 	mmc->max_blk_count = MCI_BLKATONCE;
 	mmc->max_req_size  = MCI_BUFSIZE;
+	mmc->max_phys_segs = MCI_BLKATONCE;
+	mmc->max_hw_segs   = MCI_BLKATONCE;
+	mmc->max_seg_size  = MCI_BUFSIZE;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
-- 
1.5.6.5
