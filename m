From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri,  9 Mar 2018 11:09:25 +0100
Subject: [PATCH 1/9] media: vim2m: Try to schedule a m2m device run on request
 submission
In-Reply-To: <20180309100933.15922-1-paul.kocialkowski@bootlin.com>
References: <20180309100933.15922-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180309100933.15922-2-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the most basic use scenario, where only one output and one capture
buffers are queued and the request is submitted, there is no provision
to try to schedule a m2m device run.

This adds the appropriate call to the vim2m_request_submit so that it
can start in that scenario.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/vim2m.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vim2m.c b/drivers/media/platform/vim2m.c
index 02793dd9a330..578c9170083c 100644
--- a/drivers/media/platform/vim2m.c
+++ b/drivers/media/platform/vim2m.c
@@ -933,9 +933,20 @@ static int vim2m_request_submit(struct media_request *req,
 				struct media_request_entity_data *_data)
 {
 	struct v4l2_request_entity_data *data;
+	struct vim2m_ctx *ctx;
+	int rc;
 
 	data = to_v4l2_entity_data(_data);
-	return vb2_request_submit(data);
+
+	ctx = container_of(_data->entity, struct vim2m_ctx, req_entity.base);
+
+	rc = vb2_request_submit(data);
+	if (rc)
+		return rc;
+
+	v4l2_m2m_try_schedule(ctx->fh.m2m_ctx);
+
+	return 0;
 }
 
 static const struct media_request_entity_ops vim2m_request_entity_ops = {
-- 
2.16.2
