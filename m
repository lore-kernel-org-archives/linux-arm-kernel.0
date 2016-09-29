From: colin.king@canonical.com (Colin King)
Date: Thu, 29 Sep 2016 18:57:25 +0100
Subject: [PATCH] dmaengine: coh901318: fix integer overflow when shifting more
 than 32 places
Message-ID: <20160929175725.14157-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Currently U300_DMA_CHANNELS is set to 40, meaning that the shift of 1 can
be more than 32 places, which leads to a 32 bit integer overflow. Fix this
by casting 1 to a u64 (the same type as started_channels) before shifting
it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/coh901318.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 2835f3e..98611e3 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1353,7 +1353,7 @@ static ssize_t coh901318_debugfs_read(struct file *file, char __user *buf,
 	tmp += sprintf(tmp, "DMA -- enabled dma channels\n");
 
 	for (i = 0; i < U300_DMA_CHANNELS; i++)
-		if (started_channels & (1 << i))
+		if (started_channels & ((u64)1 << i))
 			tmp += sprintf(tmp, "channel %d\n", i);
 
 	tmp += sprintf(tmp, "Pool alloc nbr %d\n", pool_count);
-- 
2.9.3
