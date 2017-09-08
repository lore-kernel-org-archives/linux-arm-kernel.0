From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 8 Sep 2017 22:53:34 +0200
Subject: [PATCH 3/3] [media] s5p-mfc: Adjust a null pointer check in four
 functions
In-Reply-To: <482a6c92-a85e-0bcd-edf7-3c2f63ea74c5@users.sourceforge.net>
References: <482a6c92-a85e-0bcd-edf7-3c2f63ea74c5@users.sourceforge.net>
Message-ID: <e794361b-8f2a-7457-007f-72ef4fa66d02@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Sep 2017 22:37:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script ?checkpatch.pl? pointed information out like the following.

Comparison to NULL could be written ?

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index abfb70b07032..cf68aed59e0d 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -470,7 +470,7 @@ static void s5p_mfc_handle_error(struct s5p_mfc_dev *dev,
 {
 	mfc_err("Interrupt Error: %08x\n", err);
 
-	if (ctx != NULL) {
+	if (ctx) {
 		/* Error recovery is dependent on the state of context */
 		switch (ctx->state) {
 		case MFCINST_RES_CHANGE_INIT:
@@ -508,7 +508,7 @@ static void s5p_mfc_handle_seq_done(struct s5p_mfc_ctx *ctx,
 {
 	struct s5p_mfc_dev *dev;
 
-	if (ctx == NULL)
+	if (!ctx)
 		return;
 	dev = ctx->dev;
 	if (ctx->c_ops->post_seq_start) {
@@ -562,7 +562,7 @@ static void s5p_mfc_handle_init_buffers(struct s5p_mfc_ctx *ctx,
 	struct s5p_mfc_buf *src_buf;
 	struct s5p_mfc_dev *dev;
 
-	if (ctx == NULL)
+	if (!ctx)
 		return;
 	dev = ctx->dev;
 	s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
@@ -1289,7 +1289,7 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 		return PTR_ERR(dev->regs_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
+	if (!res) {
 		dev_err(&pdev->dev, "failed to get irq resource\n");
 		return -ENOENT;
 	}
-- 
2.14.1
