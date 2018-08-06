From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon, 06 Aug 2018 15:50:11 +0200
Subject: [PATCH v6 4/8] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <b45a8a89-1313-7a08-206d-b93017724754@xs4all.nl>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <20180725100256.22833-5-paul.kocialkowski@bootlin.com>
 <b45a8a89-1313-7a08-206d-b93017724754@xs4all.nl>
Message-ID: <dba0f9496b393c76f355398018b14ae06b2b18c9.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans and thanks for the review!

On Sat, 2018-08-04 at 14:18 +0200, Hans Verkuil wrote:
> Hi Paul,
> 
> See below for my review comments. Mostly small fry, the main issue I found is
> that there is no support for VIDIOC_DECODER_CMD. That's the proper way of
> stopping a decoder. Don't rely on the deprecated allow_zero_bytesused field.

Mhh, it looks like this was kept around by negligence, but we do expect
that streamoff stops the decoder, not a zero bytesused field.

Is it still required to implement the V4L2_DEC_CMD_STOP
VIDIOC_DECODER_CMD in that case? I read in the doc that this ioctl
should be optional.

[...]

> > +static int cedrus_request_validate(struct media_request *req)
> > +{
> > +	struct media_request_object *obj, *obj_safe;
> > +	struct v4l2_ctrl_handler *parent_hdl, *hdl;
> > +	struct cedrus_ctx *ctx = NULL;
> > +	struct v4l2_ctrl *ctrl_test;
> > +	unsigned int i;
> > +
> > +	list_for_each_entry_safe(obj, obj_safe, &req->objects, list) {
> > +		struct vb2_buffer *vb;
> > +
> > +		if (vb2_request_object_is_buffer(obj)) {
> > +			vb = container_of(obj, struct vb2_buffer, req_obj);
> > +			ctx = vb2_get_drv_priv(vb->vb2_queue);
> > +
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!ctx)
> > +		return -EINVAL;
> 
> Return -ENOENT, just as vb2_request_validate does.

Thanks, will fix this and the following errors in the next revision.
> > +
> > +	parent_hdl = &ctx->hdl;
> > +
> > +	hdl = v4l2_ctrl_request_hdl_find(req, parent_hdl);
> > +	if (!hdl) {
> > +		v4l2_err(&ctx->dev->v4l2_dev, "Missing codec control(s)\n");
> > +		return -EINVAL;
> 
> Ditto, return -ENOENT.
> 
> > +	}
> > +
> > +	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
> > +		if (cedrus_controls[i].codec != ctx->current_codec ||
> > +		    !cedrus_controls[i].required)
> > +			continue;
> > +
> > +		ctrl_test = v4l2_ctrl_request_hdl_ctrl_find(hdl,
> > +			cedrus_controls[i].id);
> > +		if (!ctrl_test) {
> > +			v4l2_err(&ctx->dev->v4l2_dev,
> > +				 "Missing required codec control\n");
> > +			return -EINVAL;
> 
> Ditto.
> 
> The documentation of MEDIA_REQUEST_IOC_QUEUE says this for ENOENT:
> 
> ENOENT
>     The request did not contain any buffers. All requests are required
>     to have at least one buffer. This can also be returned if required
>     controls are missing.
> 
> So ENOENT is the correct error code when checking for required controls.

Thanks for the explanation!

[...]

> > +static int cedrus_release(struct file *file)
> > +{
> > +	struct cedrus_dev *dev = video_drvdata(file);
> > +	struct cedrus_ctx *ctx = container_of(file->private_data,
> > +					      struct cedrus_ctx, fh);
> > +
> > +	mutex_lock(&dev->dev_mutex);
> > +
> > +	v4l2_fh_del(&ctx->fh);
> > +	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> > +
> > +	v4l2_ctrl_handler_free(&ctx->hdl);
> > +	kfree(ctx->ctrls);
> > +
> > +	v4l2_fh_exit(&ctx->fh);
> > +	v4l2_fh_exit(&ctx->fh);
> 
> Why call this twice?

Woops, looks like a mistake.

[...]

> > +void cedrus_device_run(void *priv)
> > +{
> > +	struct cedrus_ctx *ctx = priv;
> > +	struct cedrus_dev *dev = ctx->dev;
> > +	struct cedrus_run run = { 0 };
> > +	struct media_request *src_req;
> > +	unsigned long flags;
> > +
> > +	run.src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> > +	run.dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> > +
> > +	/* Apply request(s) controls if needed. */
> > +	src_req = run.src->vb2_buf.req_obj.req;
> > +
> > +	if (src_req)
> > +		v4l2_ctrl_request_setup(src_req, &ctx->hdl);
> > +
> > +	ctx->job_abort = 0;
> > +
> > +	spin_lock_irqsave(&ctx->dev->irq_lock, flags);
> > +
> > +	switch (ctx->src_fmt.pixelformat) {
> > +	case V4L2_PIX_FMT_MPEG2_SLICE:
> > +		run.mpeg2.slice_params = cedrus_find_control_data(ctx,
> > +			V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS);
> > +		run.mpeg2.quantization = cedrus_find_control_data(ctx,
> > +			V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION);
> > +		break;
> > +
> > +	default:
> > +		ctx->job_abort = 1;
> 
> Add break; here.

Good catch, will do.

[...]

> > +static int cedrus_querycap(struct file *file, void *priv,
> > +			   struct v4l2_capability *cap)
> > +{
> > +	strncpy(cap->driver, CEDRUS_NAME, sizeof(cap->driver) - 1);
> > +	strncpy(cap->card, CEDRUS_NAME, sizeof(cap->card) - 1);
> > +	snprintf(cap->bus_info, sizeof(cap->bus_info),
> > +		 "platform:%s", CEDRUS_NAME);
> > +
> > +	cap->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
> > +	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
> 
> Set device_caps in struct video_device and drop these two lines here.
> The v4l2 core will take care of setting device_caps and capabilities.

Nice, will do!

> > +static int cedrus_start_streaming(struct vb2_queue *q, unsigned int count)
> > +{
> > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(q);
> > +	struct cedrus_dev *dev = ctx->dev;
> > +	int ret = 0;
> > +
> > +	switch (ctx->src_fmt.pixelformat) {
> > +	case V4L2_PIX_FMT_MPEG2_SLICE:
> > +		ctx->current_codec = CEDRUS_CODEC_MPEG2;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (V4L2_TYPE_IS_OUTPUT(q->type) &&
> > +	    dev->dec_ops[ctx->current_codec]->start)
> > +		ret = dev->dec_ops[ctx->current_codec]->start(ctx);
> > +
> > +	return ret;
> 
> If start_streaming returns an error, then all queued buffers need to
> be returned to vb2 with state VB2_BUF_STATE_QUEUED.

Okay, so I suppose I will take the code from streamoff, make it common
and pass it the target buf state.

> > +int cedrus_queue_init(void *priv, struct vb2_queue *src_vq,
> > +		      struct vb2_queue *dst_vq)
> > +{
> > +	struct cedrus_ctx *ctx = priv;
> > +	int ret;
> > +
> > +	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> > +	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> > +	src_vq->drv_priv = ctx;
> > +	src_vq->buf_struct_size = sizeof(struct cedrus_buffer);
> > +	src_vq->allow_zero_bytesused = 1;
> 
> Don't use this, it's deprecated. Implement VIDIOC_DECODER_CMD instead.

Looks like we can just get rid of it at this point, it's not used by
userspace to indicate that there is no data left to send.

> > +	src_vq->min_buffers_needed = 1;
> > +	src_vq->ops = &cedrus_qops;
> > +	src_vq->mem_ops = &vb2_dma_contig_memops;
> > +	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> > +	src_vq->lock = &ctx->dev->dev_mutex;
> > +	src_vq->dev = ctx->dev->dev;
> > +
> > +	ret = vb2_queue_init(src_vq);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> > +	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> > +	dst_vq->drv_priv = ctx;
> > +	dst_vq->buf_struct_size = sizeof(struct cedrus_buffer);
> > +	dst_vq->allow_zero_bytesused = 1;
> 
> Ditto. It's pointless for the capture side anyway.
> 
> > +	dst_vq->min_buffers_needed = 1;
> > +	dst_vq->ops = &cedrus_qops;
> > +	dst_vq->mem_ops = &vb2_dma_contig_memops;
> > +	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> > +	dst_vq->lock = &ctx->dev->dev_mutex;
> > +	dst_vq->dev = ctx->dev->dev;
> > +
> > +	return vb2_queue_init(dst_vq);
> > +}
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.h b/drivers/staging/media/sunxi/cedrus/cedrus_video.h
> > new file mode 100644
> > index 000000000000..56afcc8c02ba
> > --- /dev/null
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.h
> > @@ -0,0 +1,31 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Sunxi-Cedrus VPU driver
> > + *
> > + * Copyright (C) 2018 Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > + * Copyright (C) 2016 Florent Revest <florent.revest@free-electrons.com>
> > + *
> > + * Based on the vim2m driver, that is:
> > + *
> > + * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
> > + * Pawel Osciak, <pawel@osciak.com>
> > + * Marek Szyprowski, <m.szyprowski@samsung.com>
> > + */
> > +
> > +#ifndef _CEDRUS_VIDEO_H_
> > +#define _CEDRUS_VIDEO_H_
> > +
> > +struct cedrus_format {
> > +	u32		pixelformat;
> > +	u32		directions;
> > +	unsigned int	num_planes;
> > +	unsigned int	num_buffers;
> > +	unsigned int	capabilities;
> > +};
> > +
> > +extern const struct v4l2_ioctl_ops cedrus_ioctl_ops;
> > +
> > +int cedrus_queue_init(void *priv, struct vb2_queue *src_vq,
> > +		      struct vb2_queue *dst_vq);
> > +
> > +#endif

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180806/e95d992b/attachment.sig>
