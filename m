From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 1 Jun 2016 11:56:07 +0300
Subject: [PATCH 06/28] crypto: omap-sham: avoid executing tasklet where not
 needed
In-Reply-To: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
References: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
Message-ID: <1464771389-10640-7-git-send-email-t-kristo@ti.com>
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
index a5c823b..34ebe1d 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -240,6 +240,8 @@ static struct omap_sham_drv sham = {
 	.lock = __SPIN_LOCK_UNLOCKED(sham.lock),
 };
 
+static void omap_sham_done_task(unsigned long data);
+
 static inline u32 omap_sham_read(struct omap_sham_dev *dd, u32 offset)
 {
 	return __raw_readl(dd->io_base + offset);
@@ -994,7 +996,7 @@ static void omap_sham_finish_req(struct ahash_request *req, int err)
 		req->base.complete(&req->base, err);
 
 	/* handle new request */
-	tasklet_schedule(&dd->done_task);
+	omap_sham_done_task((unsigned long)dd);
 }
 
 static int omap_sham_handle_queue(struct omap_sham_dev *dd,
-- 
1.9.1
