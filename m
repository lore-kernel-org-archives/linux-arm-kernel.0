From: thibault.saunier@osg.samsung.com (Thibault Saunier)
Date: Fri, 10 Feb 2017 13:37:44 -0300
Subject: [PATCH v3 1/4] [media] exynos-gsc: Use 576p instead 720p as a
 threshold for colorspaces
In-Reply-To: <4270fc60-579b-64d0-4256-403e4e5bf371@xs4all.nl>
References: <20170210141022.25412-1-thibault.saunier@osg.samsung.com>
 <20170210141022.25412-2-thibault.saunier@osg.samsung.com>
 <4270fc60-579b-64d0-4256-403e4e5bf371@xs4all.nl>
Message-ID: <37b11e67-7ed7-244d-b27e-ec3bb7732b0e@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2017 12:07 PM, Hans Verkuil wrote:
> On 02/10/2017 03:10 PM, Thibault Saunier wrote:
>> From: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> The media documentation says that the V4L2_COLORSPACE_SMPTE170M colorspace
>> should be used for SDTV and V4L2_COLORSPACE_REC709 for HDTV. But drivers
>> don't agree on the display resolution that should be used as a threshold.
>>
>> Some drivers set V4L2_COLORSPACE_REC709 for 720p and higher while others
>> set V4L2_COLORSPACE_REC709 for anything higher than 576p. Newers drivers
>> use the latter and that also matches what user-space multimedia programs
>> do (i.e: GStreamer), so change the driver logic to be aligned with this.
>>
>> Also, check for the resolution in G_FMT instead unconditionally setting
>> the V4L2_COLORSPACE_REC709 colorspace.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>
>> Signed-off-by: Thibault Saunier <thibault.saunier@osg.samsung.com>
>> ---
>>
>> Changes in v3:
>> - Do not check values in the g_fmt functions as Andrzej explained in previous review
>> - Added 'Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>'
>>
>> Changes in v2: None
>>
>>   drivers/media/platform/exynos-gsc/gsc-core.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
>> index 59a634201830..db7d9883861b 100644
>> --- a/drivers/media/platform/exynos-gsc/gsc-core.c
>> +++ b/drivers/media/platform/exynos-gsc/gsc-core.c
>> @@ -472,7 +472,7 @@ int gsc_try_fmt_mplane(struct gsc_ctx *ctx, struct v4l2_format *f)
>>   
>>   	pix_mp->num_planes = fmt->num_planes;
>>   
>> -	if (pix_mp->width >= 1280) /* HD */
>> +	if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
>>   		pix_mp->colorspace = V4L2_COLORSPACE_REC709;
>>   	else /* SD */
>>   		pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
>> @@ -519,9 +519,13 @@ int gsc_g_fmt_mplane(struct gsc_ctx *ctx, struct v4l2_format *f)
>>   	pix_mp->height		= frame->f_height;
>>   	pix_mp->field		= V4L2_FIELD_NONE;
>>   	pix_mp->pixelformat	= frame->fmt->pixelformat;
>> -	pix_mp->colorspace	= V4L2_COLORSPACE_REC709;
>>   	pix_mp->num_planes	= frame->fmt->num_planes;
>>   
>> +	if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
>> +		pix_mp->colorspace = V4L2_COLORSPACE_REC709;
>> +	else /* SD */
>> +		pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
>> +
>>   	for (i = 0; i < pix_mp->num_planes; ++i) {
>>   		pix_mp->plane_fmt[i].bytesperline = (frame->f_width *
>>   			frame->fmt->depth[i]) / 8;
>>
> This is a mem2mem device, right? In the case of mem2mem devices the driver should never
> set the colorspace, instead it just copies it from what the application provides (the
> video output side) to the capture side.
>
> After all, you are just scaling here so the input and output colorspaces are
> exactly the same, and the scaler doesn't care what the colorspace is.

This device also does color conversion so I think it matters here, am I 
misunderstanding something?
Also, is that comment only for the try_fmt part as it looks like in 
g_fmt the driver should fill up the structure
with its values?

Thanks for you review.

Regards,

Thibault Saunier
> Regards,
>
> 	Hans
