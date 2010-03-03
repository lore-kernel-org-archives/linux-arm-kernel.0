From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed,  3 Mar 2010 15:17:35 +0100
Subject: [PATCH] mmc: at91_mci: correct kunmap_atomic()
In-Reply-To: <20100302133434.761df661.akpm@linux-foundation.org>
References: <20100302133434.761df661.akpm@linux-foundation.org>
Message-ID: <1267625855-32695-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kunmap_atomic() accepts a pointer to any location in the page so we do not need
the subtraction and cast.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Andrew,
I created a new patch that you can stack at the top of the previous
patch series. I guess that you cannot fold it in other patches as the
kunmap_atomic() correction impacts two different patches.

Thanks.

 drivers/mmc/host/at91_mci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 55507da..91dc60c 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -248,7 +248,7 @@ static inline void at91_mci_sg_to_dma(struct at91mci_host *host, struct mmc_data
 			dmabuf = (unsigned *)tmpv;
 		}
 
-		kunmap_atomic(((void *)sgbuffer) - sg->offset, KM_BIO_SRC_IRQ);
+		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
 
 		if (size == 0)
 			break;
@@ -313,7 +313,7 @@ static void at91_mci_post_dma_read(struct at91mci_host *host)
 			dmabuf = (unsigned *)tmpv;
 		}
 
-		kunmap_atomic(((void *)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);
+		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
 		dmac_flush_range((void *)sgbuffer, ((void *)sgbuffer) + amount);
 		data->bytes_xfered += amount;
 		if (size == 0)
-- 
1.5.6.5
