From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue,  7 Sep 2010 18:16:36 +0300
Subject: [PATCH 2/2] s3cmci: minor fixups
In-Reply-To: <1283872143-32492-1-git-send-email-anarsoul@gmail.com>
References: <1283872143-32492-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1283872596-687-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- It's not necessary to start DMA op manually, as we have
autostart feature enabled
- Restore prescaler before DMA operation, otherwise it
takes ages to complete DMA op.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/mmc/host/s3cmci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 2e16e0a..5d1a8ed 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1106,6 +1106,8 @@ static int s3cmci_prepare_dma(struct s3cmci_host *host, struct mmc_data *data)
 		    sg_dma_address(&data->sg[i]),
 		    sg_dma_len(&data->sg[i]));
 
+		/* Restore prescaler value */
+		writel(host->prescaler, host->base + S3C2410_SDIPRE);
 		res = s3c2410_dma_enqueue(host->dma, host,
 					  sg_dma_address(&data->sg[i]),
 					  sg_dma_len(&data->sg[i]));
@@ -1116,8 +1118,6 @@ static int s3cmci_prepare_dma(struct s3cmci_host *host, struct mmc_data *data)
 		}
 	}
 
-	s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_START);
-
 	return 0;
 }
 
-- 
1.7.2.2
