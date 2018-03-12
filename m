From: joonas.kylmala@iki.fi (=?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?=)
Date: Mon, 12 Mar 2018 18:18:00 +0000
Subject: [linux-sunxi] [PATCH 2/9] media: videobuf2-v4l2: Copy planes when
 needed in request qbuf
In-Reply-To: <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
References: <20180309100933.15922-1-paul.kocialkowski@bootlin.com>
 <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
Message-ID: <f5b1c8b7-d7c7-a81b-181b-46ef0323dfdd@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Kocialkowski:
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 0627c3339572..c14528d4a518 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -592,6 +592,7 @@ int vb2_qbuf_request(struct vb2_queue *q, struct v4l2_buffer *b,
>  	struct media_request *req;
>  	struct vb2_buffer *vb;
>  	int ret = 0;
> +	int i;
>  
>  	if (b->request_fd <= 0)
>  		return vb2_qbuf(q, b);
> @@ -657,6 +658,17 @@ int vb2_qbuf_request(struct vb2_queue *q, struct v4l2_buffer *b,
>  	qb->pre_req_state = vb->state;
>  	qb->queue = q;
>  	memcpy(&qb->v4l2_buf, b, sizeof(*b));
> +
> +	if (V4L2_TYPE_IS_MULTIPLANAR(b->type) && b->length > 0) {
> +		qb->v4l2_buf.m.planes = kcalloc(b->length,
> +						sizeof(struct v4l2_plane),
> +						GFP_KERNEL);
> +
> +		for (i = 0; i < b->length; i++)
> +			 memcpy(&qb->v4l2_buf.m.planes[i], &b->m.planes[i],
> +				sizeof(struct v4l2_plane));
> +	}
> +
>  	vb->request = req;
>  	vb->state = VB2_BUF_STATE_QUEUED;
>  	list_add_tail(&qb->node, &data->queued_buffers);
> @@ -672,6 +684,7 @@ EXPORT_SYMBOL_GPL(vb2_qbuf_request);
>  int vb2_request_submit(struct v4l2_request_entity_data *data)
>  {
>  	struct v4l2_vb2_request_buffer *qb, *n;
> +	int i;
>  
>  	/* v4l2 requests require at least one buffer to reach the device */
>  	if (list_empty(&data->queued_buffers)) {
> @@ -686,6 +699,12 @@ int vb2_request_submit(struct v4l2_request_entity_data *data)
>  		list_del(&qb->node);
>  		vb->state = qb->pre_req_state;
>  		ret = vb2_core_qbuf(q, vb->index, &qb->v4l2_buf);
> +
> +		if (V4L2_TYPE_IS_MULTIPLANAR(qb->v4l2_buf.type) &&
> +		    qb->v4l2_buf.length > 0)

The test "qb->v4l2_buf.length > 0" seems unnecessary as it's already
checked in the loop:

> +			for (i = 0; i < qb->v4l2_buf.length; i++)
> +				kfree(&qb->v4l2_buf.m.planes[i]);
> +
>  		kfree(qb);
>  		if (ret)
>  			return ret;
> 
