From: colin.king@canonical.com (Colin King)
Date: Fri,  2 Nov 2018 19:01:26 +0000
Subject: [PATCH][staging-next] drivers: staging: cedrus: find ctx before
 dereferencing it ctx
Message-ID: <20181102190126.5628-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Currently if count is an invalid value the v4l2_info message will
dereference a null ctx pointer to get the dev information. Fix
this by finding ctx first and then checking for an invalid count,
this way ctxt will be non-null hence avoiding the null pointer
dereference.

Detected by CoverityScan, CID#1475337 ("Explicit null dereferenced")

Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 22 ++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 82558455384a..699d62dceb6c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -108,17 +108,6 @@ static int cedrus_request_validate(struct media_request *req)
 	unsigned int count;
 	unsigned int i;
 
-	count = vb2_request_buffer_cnt(req);
-	if (!count) {
-		v4l2_info(&ctx->dev->v4l2_dev,
-			  "No buffer was provided with the request\n");
-		return -ENOENT;
-	} else if (count > 1) {
-		v4l2_info(&ctx->dev->v4l2_dev,
-			  "More than one buffer was provided with the request\n");
-		return -EINVAL;
-	}
-
 	list_for_each_entry(obj, &req->objects, list) {
 		struct vb2_buffer *vb;
 
@@ -133,6 +122,17 @@ static int cedrus_request_validate(struct media_request *req)
 	if (!ctx)
 		return -ENOENT;
 
+	count = vb2_request_buffer_cnt(req);
+	if (!count) {
+		v4l2_info(&ctx->dev->v4l2_dev,
+			  "No buffer was provided with the request\n");
+		return -ENOENT;
+	} else if (count > 1) {
+		v4l2_info(&ctx->dev->v4l2_dev,
+			  "More than one buffer was provided with the request\n");
+		return -EINVAL;
+	}
+
 	parent_hdl = &ctx->hdl;
 
 	hdl = v4l2_ctrl_request_hdl_find(req, parent_hdl);
-- 
2.19.1
