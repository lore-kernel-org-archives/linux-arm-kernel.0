From: sebastian.huber@embedded-brains.de (Sebastian Huber)
Date: Mon, 10 Jul 2017 09:28:59 +0200
Subject: [PATCH] soc/qbman: Simplify bman_release()
Message-ID: <20170710072859.2616-1-sebastian.huber@embedded-brains.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get the affine portal only once for the complete transaction.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 drivers/soc/fsl/qbman/bman.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index a3d6d7cfa929..0af2069a6b7e 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -723,26 +723,23 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num)
 
 	DPAA_ASSERT(num > 0 && num <= 8);
 
-	do {
+	while (1) {
 		p = get_affine_portal();
 		local_irq_save(irqflags);
 		avail = bm_rcr_get_avail(&p->p);
 		if (avail < 2)
 			update_rcr_ci(p, avail);
 		r = bm_rcr_start(&p->p);
-		local_irq_restore(irqflags);
-		put_affine_portal();
 		if (likely(r))
 			break;
 
+		local_irq_restore(irqflags);
+		put_affine_portal();
+		if (unlikely(--timeout == 0))
+			return -ETIMEDOUT;
 		udelay(1);
-	} while (--timeout);
-
-	if (unlikely(!timeout))
-		return -ETIMEDOUT;
+	}
 
-	p = get_affine_portal();
-	local_irq_save(irqflags);
 	/*
 	 * we can copy all but the first entry, as this can trigger badness
 	 * with the valid-bit
-- 
2.12.3
