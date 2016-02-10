From: shaun.ren@linux.com (Shaun Ren)
Date: Tue,  9 Feb 2016 18:45:28 -0800
Subject: [PATCH v3 9/9] Staging: rts5208: Add missing dma_mapping_error
In-Reply-To: <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
References: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
 <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455072328-7033-10-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a dma_mapping_error call to debug potential DMA mapping
errors after the dma_map_single call in rtsx_transport.c.

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 46fc8c2..2b38de7 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -658,7 +658,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 		return -ENXIO;
 
 	addr = dma_map_single(&rtsx->pci->dev, buf, len, dma_dir);
-	if (!addr)
+	if (dma_mapping_error(&rtsx->pci->dev, addr))
 		return -ENOMEM;
 
 	if (card == SD_CARD)
-- 
2.7.0
