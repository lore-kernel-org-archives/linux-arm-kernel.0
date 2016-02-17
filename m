From: tiffany.lin@mediatek.com (tiffany lin)
Date: Wed, 17 Feb 2016 16:33:12 +0800
Subject: [PATCH v4 5/8] [Media] vcodec: mediatek: Add Mediatek V4L2
 Video Encoder Driver
In-Reply-To: <56C425A0.6080005@xs4all.nl>
References: <1454585703-42428-1-git-send-email-tiffany.lin@mediatek.com>
 <1454585703-42428-2-git-send-email-tiffany.lin@mediatek.com>
 <1454585703-42428-3-git-send-email-tiffany.lin@mediatek.com>
 <1454585703-42428-4-git-send-email-tiffany.lin@mediatek.com>
 <1454585703-42428-5-git-send-email-tiffany.lin@mediatek.com>
 <1454585703-42428-6-git-send-email-tiffany.lin@mediatek.com>
 <56C1B4AF.1030207@xs4all.nl> <1455604653.19396.68.camel@mtksdaap41>
 <56C425A0.6080005@xs4all.nl>
Message-ID: <1455697992.26202.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wed, 2016-02-17 at 08:47 +0100, Hans Verkuil wrote:
> On 02/16/2016 07:37 AM, tiffany lin wrote:
> >>> +static int fops_vcodec_open(struct file *file)
> >>> +{
> >>> +	struct video_device *vfd = video_devdata(file);
> >>> +	struct mtk_vcodec_dev *dev = video_drvdata(file);
> >>> +	struct mtk_vcodec_ctx *ctx = NULL;
> >>> +	int ret = 0;
> >>> +
> >>> +	mutex_lock(&dev->dev_mutex);
> >>> +
> >>> +	ctx = devm_kzalloc(&dev->plat_dev->dev, sizeof(*ctx), GFP_KERNEL);
> >>> +	if (!ctx) {
> >>> +		ret = -ENOMEM;
> >>> +		goto err_alloc;
> >>> +	}
> >>> +
> >>> +	if (dev->num_instances >= MTK_VCODEC_MAX_ENCODER_INSTANCES) {
> >>> +		mtk_v4l2_err("Too many open contexts\n");
> >>> +		ret = -EBUSY;
> >>> +		goto err_no_ctx;
> >>
> >> Hmm. I never like it if you can't open a video node because of a reason like this.
> >>
> >> I.e. a simple 'v4l2-ctl -D' (i.e. calling QUERYCAP) should never fail.
> >>
> >> If there are hardware limitation that prevent more than X instances from running at
> >> the same time, then those limitations typically kick in when you start to stream
> >> (or possibly when calling REQBUFS). But before that it should always be possible to
> >> open the device.
> >>
> >> Having this check at open() is an indication of a poor design.
> >>
> >> Is this is a hardware limitation at all?
> >>
> > This is to make sure performance meet requirements, such as bitrate and
> > framerate.
> 
> Is it the driver's job to make enforce this? What if the application only
> deals with low-res video, but wants to encode a lot of those? Or is encoding
> a video off-line?
> 
> The driver generally doesn't know the use-case, so if this is an artificial
> limitation as opposed to a hardware limitation, then I would just drop this.
> 
We got your point, we will remove this artificial limitation in next
version.

best regards,
Tiffany


> Regards,
> 
> 	Hans
> 
> > We got your point. We will remove this and move limitation control to
> > start_streaming or REQBUFS.
> > Appreciated for your suggestion.:)
> > 
> > 
> >>> +	}
> 
