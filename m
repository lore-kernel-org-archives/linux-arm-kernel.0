From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 05 Sep 2018 18:29:42 +0200
Subject: [PATCH v8 4/8] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <5faf5eed-eb2c-f804-93e3-5a42f6204d99@xs4all.nl>
References: <20180828073424.30247-1-paul.kocialkowski@bootlin.com>
 <20180828073424.30247-5-paul.kocialkowski@bootlin.com>
 <5faf5eed-eb2c-f804-93e3-5a42f6204d99@xs4all.nl>
Message-ID: <b7b3cb2320978d45acb34475d15abd7bf03da367.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi and thanks for the review!

Le lundi 03 septembre 2018 ? 11:11 +0200, Hans Verkuil a ?crit :
> On 08/28/2018 09:34 AM, Paul Kocialkowski wrote:
> > +static int cedrus_request_validate(struct media_request *req)
> > +{
> > +	struct media_request_object *obj, *obj_safe;
> > +	struct v4l2_ctrl_handler *parent_hdl, *hdl;
> > +	struct cedrus_ctx *ctx = NULL;
> > +	struct v4l2_ctrl *ctrl_test;
> > +	unsigned int i;
> > +
> > +	list_for_each_entry_safe(obj, obj_safe, &req->objects, list) {
> 
> You don't need to use the _safe variant during validation.

Okay, I'll use the regular one then.

> > +		struct vb2_buffer *vb;
> > +
> > +		if (vb2_request_object_is_buffer(obj)) {
> > +			vb = container_of(obj, struct vb2_buffer, req_obj);
> > +			ctx = vb2_get_drv_priv(vb->vb2_queue);
> > +
> > +			break;
> > +		}
> > +	}
> 
> Interesting question: what happens if more than one buffer is queued in the
> request? This is allowed by the request API and in that case the associated
> controls in the request apply to all queued buffers.
> 
> Would this make sense at all for this driver? If not, then you need to
> check here if there is more than one buffer in the request and document in
> the spec that this is not allowed.

Well, our driver was written with the (unformal) assumption that we
only deal with a pair of one output and one capture buffer. So I will
add a check for this at request validation time and document it in the
spec. Should that be part of the MPEG-2 PIXFMT documentation (and
duplicated for future formats we add support for)?

> If it does make sense, then you need to test this.
> 
> Again, this can be corrected in a follow-up patch, unless there will be a
> v9 anyway.

[...]

> > +static int cedrus_probe(struct platform_device *pdev)
> > +{
> > +	struct cedrus_dev *dev;
> > +	struct video_device *vfd;
> > +	int ret;
> > +
> > +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> > +	if (!dev)
> > +		return -ENOMEM;
> > +
> > +	dev->dev = &pdev->dev;
> > +	dev->pdev = pdev;
> > +
> > +	ret = cedrus_hw_probe(dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to probe hardware\n");
> > +		return ret;
> > +	}
> > +
> > +	dev->dec_ops[CEDRUS_CODEC_MPEG2] = &cedrus_dec_ops_mpeg2;
> > +
> > +	mutex_init(&dev->dev_mutex);
> > +	spin_lock_init(&dev->irq_lock);
> > +
> > +	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to register V4L2 device\n");
> > +		return ret;
> > +	}
> > +
> > +	dev->vfd = cedrus_video_device;
> > +	vfd = &dev->vfd;
> > +	vfd->lock = &dev->dev_mutex;
> > +	vfd->v4l2_dev = &dev->v4l2_dev;
> > +
> > +	ret = video_register_device(vfd, VFL_TYPE_GRABBER, 0);
> > +	if (ret) {
> > +		v4l2_err(&dev->v4l2_dev, "Failed to register video device\n");
> > +		goto err_v4l2;
> > +	}
> > +
> > +	snprintf(vfd->name, sizeof(vfd->name), "%s", cedrus_video_device.name);
> > +	video_set_drvdata(vfd, dev);
> > +
> > +	v4l2_info(&dev->v4l2_dev,
> > +		  "Device registered as /dev/video%d\n", vfd->num);
> > +
> > +	dev->m2m_dev = v4l2_m2m_init(&cedrus_m2m_ops);
> 
> This ^^^ initialization...
> 
> > +	if (IS_ERR(dev->m2m_dev)) {
> > +		v4l2_err(&dev->v4l2_dev,
> > +			 "Failed to initialize V4L2 M2M device\n");
> > +		ret = PTR_ERR(dev->m2m_dev);
> > +
> > +		goto err_video;
> > +	}
> > +
> > +	dev->mdev.dev = &pdev->dev;
> > +	strlcpy(dev->mdev.model, CEDRUS_NAME, sizeof(dev->mdev.model));
> > +
> > +	media_device_init(&dev->mdev);
> > +	dev->mdev.ops = &cedrus_m2m_media_ops;
> > +	dev->v4l2_dev.mdev = &dev->mdev;
> 
> ...and this ^^^ initialization should be done before you start registering devices.
> 
> > +
> > +	ret = v4l2_m2m_register_media_controller(dev->m2m_dev,
> > +			vfd, MEDIA_ENT_F_PROC_VIDEO_DECODER);
> > +	if (ret) {
> > +		v4l2_err(&dev->v4l2_dev,
> > +			 "Failed to initialize V4L2 M2M media controller\n");
> > +		goto err_m2m;
> > +	}
> 
> ^^^ this one too.
> 
> If you don't do that, then you are registering partially initialized devices,
> which is never a good idea.
> 
> Just move the video_register_device() call to here, just before the
> media_device_register().
> 
> This is worthy of a v9, since this can cause real problems.

Thanks for pointing this out, will fix in the next revision.

[...]

> > +static const u8 intra_quantization_matrix_default[64] = {
> > +	8,  16, 16, 19, 16, 19, 22, 22,
> > +	22, 22, 22, 22, 26, 24, 26, 27,
> > +	27, 27, 26, 26, 26, 26, 27, 27,
> > +	27, 29, 29, 29, 34, 34, 34, 29,
> > +	29, 29, 27, 27, 29, 29, 32, 32,
> > +	34, 34, 37, 38, 37, 35, 35, 34,
> > +	35, 38, 38, 40, 40, 40, 48, 48,
> > +	46, 46, 56, 56, 58, 69, 69, 83
> > +};
> > +
> > +static const u8 non_intra_quantization_matrix_default[64] = {
> > +	16, 16, 16, 16, 16, 16, 16, 16,
> > +	16, 16, 16, 16, 16, 16, 16, 16,
> > +	16, 16, 16, 16, 16, 16, 16, 16,
> > +	16, 16, 16, 16, 16, 16, 16, 16,
> > +	16, 16, 16, 16, 16, 16, 16, 16,
> > +	16, 16, 16, 16, 16, 16, 16, 16,
> > +	16, 16, 16, 16, 16, 16, 16, 16,
> > +	16, 16, 16, 16, 16, 16, 16, 16
> > +};
> 
> Just curious: where do these defaults come from? Might be worth a comment
> in the code.

These are the default quantization coefficients originating from the
MPEG-2 spec. I'll add a comment to make that clear.

[...]

> > +static int cedrus_querycap(struct file *file, void *priv,
> > +			   struct v4l2_capability *cap)
> > +{
> > +	strncpy(cap->driver, CEDRUS_NAME, sizeof(cap->driver) - 1);
> > +	strncpy(cap->card, CEDRUS_NAME, sizeof(cap->card) - 1);
> 
> Please use strlcpy instead.

Will do.

[...]

> > +static int cedrus_queue_setup(struct vb2_queue *vq, unsigned int *nbufs,
> > +			      unsigned int *nplanes, unsigned int sizes[],
> > +			      struct device *alloc_devs[])
> > +{
> > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
> > +	struct cedrus_dev *dev = ctx->dev;
> > +	struct v4l2_pix_format_mplane *mplane_fmt;
> > +	struct cedrus_format *fmt;
> > +	unsigned int i;
> > +
> > +	switch (vq->type) {
> > +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> > +		mplane_fmt = &ctx->src_fmt;
> > +		fmt = cedrus_find_format(mplane_fmt->pixelformat,
> > +					 CEDRUS_DECODE_SRC,
> > +					 dev->capabilities);
> > +		break;
> > +
> > +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> > +		mplane_fmt = &ctx->dst_fmt;
> > +		fmt = cedrus_find_format(mplane_fmt->pixelformat,
> > +					 CEDRUS_DECODE_DST,
> > +					 dev->capabilities);
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!fmt)
> > +		return -EINVAL;
> > +
> > +	if (fmt->num_buffers == 1) {
> > +		sizes[0] = 0;
> > +
> > +		for (i = 0; i < fmt->num_planes; i++)
> > +			sizes[0] += mplane_fmt->plane_fmt[i].sizeimage;
> > +	} else if (fmt->num_buffers == fmt->num_planes) {
> > +		for (i = 0; i < fmt->num_planes; i++)
> > +			sizes[i] = mplane_fmt->plane_fmt[i].sizeimage;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	*nplanes = fmt->num_buffers;
> 
> This code does not take VIDIOC_CREATE_BUFFERS into account.
> 
> If it is called from that ioctl, then *nplanes is non-zero and you need
> to check if *nplanes equals fmt->num_buffers and that sizes[n] is >=
> the required size of the format. If so, then return 0, otherwise return
> -EINVAL.

Thanks for spotting this, I'll fix it as you suggested in the next
revision.

> Doesn't v4l2-compliance fail on that? Or is that test skipped because this
> is a decoder for which streaming is not supported (yet)?

Apparently, v4l2-compliance doesn't fail since I'm getting:
test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK

Cheers,

Paul

> > +
> > +	return 0;
> > +}
> > +
> > +static void cedrus_queue_cleanup(struct vb2_queue *vq, u32 state)
> > +{
> > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
> > +	struct vb2_v4l2_buffer *vbuf;
> > +	unsigned long flags;
> > +
> > +	for (;;) {
> > +		spin_lock_irqsave(&ctx->dev->irq_lock, flags);
> > +
> > +		if (V4L2_TYPE_IS_OUTPUT(vq->type))
> > +			vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> > +		else
> > +			vbuf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> > +
> > +		spin_unlock_irqrestore(&ctx->dev->irq_lock, flags);
> > +
> > +		if (!vbuf)
> > +			return;
> > +
> > +		v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req,
> > +					   &ctx->hdl);
> > +		v4l2_m2m_buf_done(vbuf, state);
> > +	}
> > +}
> > +
> > +static int cedrus_buf_init(struct vb2_buffer *vb)
> > +{
> > +	struct vb2_queue *vq = vb->vb2_queue;
> > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
> > +
> > +	if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> > +		ctx->dst_bufs[vb->index] = vb;
> > +
> > +	return 0;
> > +}
> > +
> > +static void cedrus_buf_cleanup(struct vb2_buffer *vb)
> > +{
> > +	struct vb2_queue *vq = vb->vb2_queue;
> > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
> > +
> > +	if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> > +		ctx->dst_bufs[vb->index] = NULL;
> > +}
> > +
> > +static int cedrus_buf_prepare(struct vb2_buffer *vb)
> > +{
> > +	struct vb2_queue *vq = vb->vb2_queue;
> > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
> > +	struct v4l2_pix_format_mplane *fmt;
> > +	unsigned int buffer_size = 0;
> > +	unsigned int format_size = 0;
> > +	unsigned int i;
> > +
> > +	if (vq->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> > +		fmt = &ctx->src_fmt;
> > +	else if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> > +		fmt = &ctx->dst_fmt;
> > +	else
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i < vb->num_planes; i++)
> > +		buffer_size += vb2_plane_size(vb, i);
> > +
> > +	for (i = 0; i < fmt->num_planes; i++)
> > +		format_size += fmt->plane_fmt[i].sizeimage;
> > +
> > +	if (buffer_size < format_size)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int cedrus_start_streaming(struct vb2_queue *vq, unsigned int count)
> > +{
> > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
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
> > +	if (V4L2_TYPE_IS_OUTPUT(vq->type) &&
> > +	    dev->dec_ops[ctx->current_codec]->start)
> > +		ret = dev->dec_ops[ctx->current_codec]->start(ctx);
> > +
> > +	if (ret)
> > +		cedrus_queue_cleanup(vq, VB2_BUF_STATE_QUEUED);
> > +
> > +	return ret;
> > +}
> > +
> > +static void cedrus_stop_streaming(struct vb2_queue *vq)
> > +{
> > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
> > +	struct cedrus_dev *dev = ctx->dev;
> > +
> > +	if (V4L2_TYPE_IS_OUTPUT(vq->type) &&
> > +	    dev->dec_ops[ctx->current_codec]->stop)
> > +		dev->dec_ops[ctx->current_codec]->stop(ctx);
> > +
> > +	cedrus_queue_cleanup(vq, VB2_BUF_STATE_ERROR);
> > +}
> > +
> > +static void cedrus_buf_queue(struct vb2_buffer *vb)
> > +{
> > +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> > +
> > +	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
> > +}
> > +
> > +static void cedrus_buf_request_complete(struct vb2_buffer *vb)
> > +{
> > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> > +
> > +	v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->hdl);
> > +}
> > +
> > +static struct vb2_ops cedrus_qops = {
> > +	.queue_setup		= cedrus_queue_setup,
> > +	.buf_prepare		= cedrus_buf_prepare,
> > +	.buf_init		= cedrus_buf_init,
> > +	.buf_cleanup		= cedrus_buf_cleanup,
> > +	.buf_queue		= cedrus_buf_queue,
> > +	.buf_request_complete	= cedrus_buf_request_complete,
> > +	.start_streaming	= cedrus_start_streaming,
> > +	.stop_streaming		= cedrus_stop_streaming,
> > +	.wait_prepare		= vb2_ops_wait_prepare,
> > +	.wait_finish		= vb2_ops_wait_finish,
> > +};
> > +
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
> > +	src_vq->min_buffers_needed = 1;
> > +	src_vq->ops = &cedrus_qops;
> > +	src_vq->mem_ops = &vb2_dma_contig_memops;
> > +	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
> > +	src_vq->lock = &ctx->dev->dev_mutex;
> > +	src_vq->dev = ctx->dev->dev;
> > +	src_vq->supports_requests = true;
> > +
> > +	ret = vb2_queue_init(src_vq);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> > +	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> > +	dst_vq->drv_priv = ctx;
> > +	dst_vq->buf_struct_size = sizeof(struct cedrus_buffer);
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
> > index 000000000000..ead1143fdfdc
> > --- /dev/null
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Cedrus VPU driver
> > + *
> > + * Copyright (C) 2016 Florent Revest <florent.revest@free-electrons.com>
> > + * Copyright (C) 2018 Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > + * Copyright (C) 2018 Bootlin
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
> > 
> 
> Regards,
> 
> 	Hans
-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/6894d36f/attachment.sig>
