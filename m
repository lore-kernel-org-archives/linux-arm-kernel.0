From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri,  9 Mar 2018 11:09:26 +0100
Subject: [PATCH 2/9] media: videobuf2-v4l2: Copy planes when needed in request
 qbuf
In-Reply-To: <20180309100933.15922-1-paul.kocialkowski@bootlin.com>
References: <20180309100933.15922-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multiplanar formats require an extra planes array in their buffers, that
is copied from userspace by the video_usercopy function prior to
dispatching the ioctl request. This wrapper also frees the allocated
planes array after the ioctl handler has returned.

In the context of the V4L2 request API, we need to keep this planes
array around so that it can be used when submitting the request later.

Thus, allocate the array and copy its contents when adding the buffer to
the request-specific queue.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 0627c3339572..c14528d4a518 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -592,6 +592,7 @@ int vb2_qbuf_request(struct vb2_queue *q, struct v4l2_buffer *b,
 	struct media_request *req;
 	struct vb2_buffer *vb;
 	int ret = 0;
+	int i;
 
 	if (b->request_fd <= 0)
 		return vb2_qbuf(q, b);
@@ -657,6 +658,17 @@ int vb2_qbuf_request(struct vb2_queue *q, struct v4l2_buffer *b,
 	qb->pre_req_state = vb->state;
 	qb->queue = q;
 	memcpy(&qb->v4l2_buf, b, sizeof(*b));
+
+	if (V4L2_TYPE_IS_MULTIPLANAR(b->type) && b->length > 0) {
+		qb->v4l2_buf.m.planes = kcalloc(b->length,
+						sizeof(struct v4l2_plane),
+						GFP_KERNEL);
+
+		for (i = 0; i < b->length; i++)
+			 memcpy(&qb->v4l2_buf.m.planes[i], &b->m.planes[i],
+				sizeof(struct v4l2_plane));
+	}
+
 	vb->request = req;
 	vb->state = VB2_BUF_STATE_QUEUED;
 	list_add_tail(&qb->node, &data->queued_buffers);
@@ -672,6 +684,7 @@ EXPORT_SYMBOL_GPL(vb2_qbuf_request);
 int vb2_request_submit(struct v4l2_request_entity_data *data)
 {
 	struct v4l2_vb2_request_buffer *qb, *n;
+	int i;
 
 	/* v4l2 requests require at least one buffer to reach the device */
 	if (list_empty(&data->queued_buffers)) {
@@ -686,6 +699,12 @@ int vb2_request_submit(struct v4l2_request_entity_data *data)
 		list_del(&qb->node);
 		vb->state = qb->pre_req_state;
 		ret = vb2_core_qbuf(q, vb->index, &qb->v4l2_buf);
+
+		if (V4L2_TYPE_IS_MULTIPLANAR(qb->v4l2_buf.type) &&
+		    qb->v4l2_buf.length > 0)
+			for (i = 0; i < qb->v4l2_buf.length; i++)
+				kfree(&qb->v4l2_buf.m.planes[i]);
+
 		kfree(qb);
 		if (ret)
 			return ret;
-- 
2.16.2
