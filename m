From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 22 Sep 2014 14:52:02 +0200
Subject: [PATCH] [media] s5p-mfc: Use decode status instead of display status
 on MFCv5
Message-ID: <1411390322-25212-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 90c0ae50097 changed how the frame_type of a decoded frame
gets determined, by switching from the get_dec_frame_type to
get_disp_frame_type operation. Unfortunately it seems that on MFC v5 the
result of get_disp_frame_type is always 0 (no display) when decoding
(tested with H264), resulting in no frame ever being output from the
decoder.

This patch reverts MFC v5 to the previous behaviour while keeping the
new behaviour for v6 and up.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index d35b041..27ca9d0 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -264,7 +264,12 @@ static void s5p_mfc_handle_frame_new(struct s5p_mfc_ctx *ctx, unsigned int err)
 	unsigned int frame_type;
 
 	dspl_y_addr = s5p_mfc_hw_call(dev->mfc_ops, get_dspl_y_adr, dev);
-	frame_type = s5p_mfc_hw_call(dev->mfc_ops, get_disp_frame_type, ctx);
+	if (IS_MFCV6_PLUS(dev))
+		frame_type = s5p_mfc_hw_call(dev->mfc_ops,
+			get_disp_frame_type, ctx);
+	else
+		frame_type = s5p_mfc_hw_call(dev->mfc_ops,
+			get_dec_frame_type, dev);
 
 	/* If frame is same as previous then skip and do not dequeue */
 	if (frame_type == S5P_FIMV_DECODE_FRAME_SKIPPED) {
-- 
2.1.0
