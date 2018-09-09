From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun,  9 Sep 2018 21:10:12 +0200
Subject: [PATCH v2 1/4] media: cedrus: Fix error reporting in request
 validation
In-Reply-To: <20180909191015.20902-1-contact@paulk.fr>
References: <20180909191015.20902-1-contact@paulk.fr>
Message-ID: <20180909191015.20902-2-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes error reporting by using the appropriate logging helpers and
return codes, while introducing new messages when there are not enough
or too many buffers associated with the request.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 09ab1b732c31..0a9363c7db06 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -105,10 +105,19 @@ static int cedrus_request_validate(struct media_request *req)
 	struct v4l2_ctrl_handler *parent_hdl, *hdl;
 	struct cedrus_ctx *ctx = NULL;
 	struct v4l2_ctrl *ctrl_test;
+	unsigned int count;
 	unsigned int i;
 
-	if (vb2_request_buffer_cnt(req) != 1)
+	count = vb2_request_buffer_cnt(req);
+	if (!count) {
+		v4l2_info(&ctx->dev->v4l2_dev,
+			  "No buffer was provided with the request\n");
 		return -ENOENT;
+	} else if (count > 1) {
+		v4l2_info(&ctx->dev->v4l2_dev,
+			  "More than one buffer was provided with the request\n");
+		return -EINVAL;
+	}
 
 	list_for_each_entry(obj, &req->objects, list) {
 		struct vb2_buffer *vb;
@@ -128,7 +137,7 @@ static int cedrus_request_validate(struct media_request *req)
 
 	hdl = v4l2_ctrl_request_hdl_find(req, parent_hdl);
 	if (!hdl) {
-		v4l2_err(&ctx->dev->v4l2_dev, "Missing codec control(s)\n");
+		v4l2_info(&ctx->dev->v4l2_dev, "Missing codec control(s)\n");
 		return -ENOENT;
 	}
 
@@ -140,7 +149,7 @@ static int cedrus_request_validate(struct media_request *req)
 		ctrl_test = v4l2_ctrl_request_hdl_ctrl_find(hdl,
 			cedrus_controls[i].id);
 		if (!ctrl_test) {
-			v4l2_err(&ctx->dev->v4l2_dev,
+			v4l2_info(&ctx->dev->v4l2_dev,
 				 "Missing required codec control\n");
 			return -ENOENT;
 		}
-- 
2.18.0
