From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Thu, 22 Mar 2018 07:30:47 -0400
Subject: [PATCH] media: s5p_mfc_enc: get rid of new warnings
Message-ID: <93eaf301a7d2c992595baf54c1ae8b835c7bf4df.1521718244.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The values of enc_y_addr and enc_c_addr are initialized by
s5p_mfc_hw_call(), but, in thesis, this macro might be doing
nothing, if the get_enc_frame_buffer() is not declared.
That causes those GCC warnings:

	drivers/media/platform/s5p-mfc/s5p_mfc_enc.c:1242 enc_post_frame_start() error: uninitialized symbol 'enc_y_addr'.
	drivers/media/platform/s5p-mfc/s5p_mfc_enc.c:1243 enc_post_frame_start() error: uninitialized symbol 'enc_c_addr'.
	drivers/media/platform/s5p-mfc/s5p_mfc_enc.c:1256 enc_post_frame_start() error: uninitialized symbol 'enc_y_addr'.
	drivers/media/platform/s5p-mfc/s5p_mfc_enc.c:1257 enc_post_frame_start() error: uninitialized symbol 'enc_c_addr'.

Change the logic by initializing those constants to zero,
with should hopefully do the right thing.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
index 7382b41f4f6d..5c0462ca9993 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
@@ -1220,7 +1220,7 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
 	struct s5p_mfc_buf *mb_entry;
-	unsigned long enc_y_addr, enc_c_addr;
+	unsigned long enc_y_addr = 0, enc_c_addr = 0;
 	unsigned long mb_y_addr, mb_c_addr;
 	int slice_type;
 	unsigned int strm_size;
-- 
2.14.3
