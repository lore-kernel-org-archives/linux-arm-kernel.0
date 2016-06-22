From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 22 Jun 2016 16:23:38 +0300
Subject: [PATCHv2 05/27] crypto: omap-sham: avoid executing tasklet where not
 needed
In-Reply-To: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
References: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
Message-ID: <1466601840-18486-6-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the call paths of OMAP SHA driver can avoid executing the next
step of the crypto queue under tasklet; instead, execute the next step
directly via function call. This avoids a costly round-trip via the
scheduler giving a slight performance boost.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-sham.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 6247887..84a0027 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -242,6 +242,8 @@ static struct omap_sham_drv sham = {
 	.lock = __SPIN_LOCK_UNLOCKED(sham.lock),
 };
 
+static void omap_sham_done_task(unsigned long data);
+
 static inline u32 omap_sham_read(struct omap_sham_dev *dd, u32 offset)
 {
 	return __raw_readl(dd->io_base + offset);
@@ -1007,7 +1009,7 @@ static void omap_sham_finish_req(struct ahash_request *req, int err)
 		req->base.complete(&req->base, err);
 
 	/* handle new request */
-	tasklet_schedule(&dd->done_task);
+	omap_sham_done_task((unsigned long)dd);
 }
 
 static int omap_sham_handle_queue(struct omap_sham_dev *dd,
-- 
1.9.1
