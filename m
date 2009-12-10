From: ramaxlo@gmail.com (Ramax Lo)
Date: Thu, 10 Dec 2009 21:48:16 +0800
Subject: [PATCH] s3cmci: Set the number of data segment to 1 for S3C24XX
	platform
In-Reply-To: <>
References: <>
Message-ID: <1260452896-17268-1-git-send-email-ramaxlo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since S3C24XX platform doesn't support scatter-gather DMA, we just set
the structure members max_phys_segs & max_hw_segs to 1 for DMA mode transfer.

Signed-off-by: Ramax Lo <ramaxlo@gmail.com>
---
 drivers/mmc/host/s3cmci.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 99b74a3..b1e10c1 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1735,8 +1735,13 @@ static int __devinit s3cmci_probe(struct platform_device *pdev)
 	mmc->max_req_size	= 4095 * 512;
 	mmc->max_seg_size	= mmc->max_req_size;
 
-	mmc->max_phys_segs	= 128;
-	mmc->max_hw_segs	= 128;
+	if (s3cmci_host_usedma(host)) {
+		mmc->max_phys_segs	= 1;
+		mmc->max_hw_segs	= 1;
+	} else {
+		mmc->max_phys_segs	= 128;
+		mmc->max_hw_segs	= 128;
+	}
 
 	dbg(host, dbg_debug,
 	    "probe: mode:%s mapped mci_base:%p irq:%u irq_cd:%u dma:%u.\n",
-- 
1.5.4.3
