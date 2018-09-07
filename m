From: contact@paulk.fr (Paul Kocialkowski)
Date: Fri, 07 Sep 2018 17:04:29 +0200
Subject: [PATCH v8 4/8] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <890469f8-434f-4ca1-ec95-20542610fd78@xs4all.nl>
References: <20180828073424.30247-1-paul.kocialkowski@bootlin.com>
 <20180828073424.30247-5-paul.kocialkowski@bootlin.com>
 <5faf5eed-eb2c-f804-93e3-5a42f6204d99@xs4all.nl>
 <b7b3cb2320978d45acb34475d15abd7bf03da367.camel@paulk.fr>
 <461c6a0d-a346-b9da-b75e-4aab907054df@xs4all.nl>
 <890469f8-434f-4ca1-ec95-20542610fd78@xs4all.nl>
Message-ID: <d581b9cc8153d063360d8cde290329f5c1786ae9.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le jeudi 06 septembre 2018 ? 09:22 +0200, Hans Verkuil a ?crit :
> On 09/06/2018 09:01 AM, Hans Verkuil wrote:
> > On 09/05/2018 06:29 PM, Paul Kocialkowski wrote:
> > > Hi and thanks for the review!
> > > 
> > > Le lundi 03 septembre 2018 ? 11:11 +0200, Hans Verkuil a ?crit :
> > > > On 08/28/2018 09:34 AM, Paul Kocialkowski wrote:
> > > > > +static int cedrus_queue_setup(struct vb2_queue *vq, unsigned int *nbufs,
> > > > > +			      unsigned int *nplanes, unsigned int sizes[],
> > > > > +			      struct device *alloc_devs[])
> > > > > +{
> > > > > +	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
> > > > > +	struct cedrus_dev *dev = ctx->dev;
> > > > > +	struct v4l2_pix_format_mplane *mplane_fmt;
> > > > > +	struct cedrus_format *fmt;
> > > > > +	unsigned int i;
> > > > > +
> > > > > +	switch (vq->type) {
> > > > > +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> > > > > +		mplane_fmt = &ctx->src_fmt;
> > > > > +		fmt = cedrus_find_format(mplane_fmt->pixelformat,
> > > > > +					 CEDRUS_DECODE_SRC,
> > > > > +					 dev->capabilities);
> > > > > +		break;
> > > > > +
> > > > > +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> > > > > +		mplane_fmt = &ctx->dst_fmt;
> > > > > +		fmt = cedrus_find_format(mplane_fmt->pixelformat,
> > > > > +					 CEDRUS_DECODE_DST,
> > > > > +					 dev->capabilities);
> > > > > +		break;
> > > > > +
> > > > > +	default:
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	if (!fmt)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (fmt->num_buffers == 1) {
> > > > > +		sizes[0] = 0;
> > > > > +
> > > > > +		for (i = 0; i < fmt->num_planes; i++)
> > > > > +			sizes[0] += mplane_fmt->plane_fmt[i].sizeimage;
> > > > > +	} else if (fmt->num_buffers == fmt->num_planes) {
> > > > > +		for (i = 0; i < fmt->num_planes; i++)
> > > > > +			sizes[i] = mplane_fmt->plane_fmt[i].sizeimage;
> > > > > +	} else {
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	*nplanes = fmt->num_buffers;
> > > > 
> > > > This code does not take VIDIOC_CREATE_BUFFERS into account.
> > > > 
> > > > If it is called from that ioctl, then *nplanes is non-zero and you need
> > > > to check if *nplanes equals fmt->num_buffers and that sizes[n] is >=
> > > > the required size of the format. If so, then return 0, otherwise return
> > > > -EINVAL.
> > > 
> > > Thanks for spotting this, I'll fix it as you suggested in the next
> > > revision.
> > > 
> > > > Doesn't v4l2-compliance fail on that? Or is that test skipped because this
> > > > is a decoder for which streaming is not supported (yet)?
> > > 
> > > Apparently, v4l2-compliance doesn't fail since I'm getting:
> > > test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> > 
> > It is tested, but only with the -s option. I'll see if I can improve the
> > tests.
> 
> I've improved the tests. v4l2-compliance should now fail when run (without the
> -s option) against this driver. Can you check that that is indeed the case?

I think this wasn't being tested with v8 of the driver as no default
format was provided (for the G_FMT test), which probably led to MMAP
not being picked up in valid_memorytype. Thus the subsequent
CREATE_BUFS test was reported as not failing, but it really didn't test
much of anything.

Cheers,

Paul

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/d12c74cc/attachment.sig>
