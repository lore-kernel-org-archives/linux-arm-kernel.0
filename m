From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Mon,  9 Dec 2013 10:25:23 +0100
Subject: [PATCH v2] dma: fix vchan_cookie_complete() debug print
In-Reply-To: <1386344529-25617-1-git-send-email-jonas.jensen@gmail.com>
References: <1386344529-25617-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <1386581123-4706-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vchan_cookie_complete() is supposed to print the cookie value
but it's always zero because:

dma_cookie_complete() is called prior to dev_vdbg()

Move the call, place it after dev_vdbg().

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    Changes since v1:
    
    1. remove local dma_cookie_t
    2. call dma_cookie_complete() after dev_vdbg()
    
    Applies to next-20131209

 drivers/dma/virt-dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 85c19d6..7d6f611 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -85,9 +85,9 @@ static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
 {
 	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
 
-	dma_cookie_complete(&vd->tx);
 	dev_vdbg(vc->chan.device->dev, "txd %p[%x]: marked complete\n",
 		vd, vd->tx.cookie);
+	dma_cookie_complete(&vd->tx);
 	list_add_tail(&vd->node, &vc->desc_completed);
 
 	tasklet_schedule(&vc->task);
-- 
1.8.2.1
