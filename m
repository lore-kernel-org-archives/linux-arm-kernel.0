From: hugues.fruchet@st.com (Hugues FRUCHET)
Date: Mon, 26 Jun 2017 14:41:58 +0000
Subject: [PATCH v1 3/5] [media] stm32-dcmi: crop sensor image to match
 user resolution
In-Reply-To: <2844ed1a-d310-4381-c4a7-88ab4633f32f@xs4all.nl>
References: <1498144371-13310-1-git-send-email-hugues.fruchet@st.com>
 <1498144371-13310-4-git-send-email-hugues.fruchet@st.com>
 <ee46bbd4-9343-7060-3c1b-455486eb7a9c@xs4all.nl>
 <8ae4c160-3137-0fa8-3d78-e4e1284521a4@st.com>
 <2844ed1a-d310-4381-c4a7-88ab4633f32f@xs4all.nl>
Message-ID: <3f04ca80-28cd-c793-72da-e0ea8efdb8a9@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/26/2017 12:07 PM, Hans Verkuil wrote:
> On 26/06/17 11:53, Hugues FRUCHET wrote:
>> Hi Hans, thanks for review.
>>
>> Reply below.
>>
>> BR
>> Hugues.
>>
>> On 06/22/2017 05:19 PM, Hans Verkuil wrote:
>>> On 06/22/2017 05:12 PM, Hugues Fruchet wrote:
>>>> Add flexibility on supported resolutions by cropping sensor
>>>> image to fit user resolution format request.
>>>>
>>>> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
>>>> ---
>>>>     drivers/media/platform/stm32/stm32-dcmi.c | 54 ++++++++++++++++++++++++++++++-
>>>>     1 file changed, 53 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
>>>> index 75d53aa..bc5e052 100644
>>>> --- a/drivers/media/platform/stm32/stm32-dcmi.c
>>>> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
>>>> @@ -131,6 +131,8 @@ struct stm32_dcmi {
>>>>     	struct v4l2_async_notifier	notifier;
>>>>     	struct dcmi_graph_entity	entity;
>>>>     	struct v4l2_format		fmt;
>>>> +	struct v4l2_rect		crop;
>>>> +	bool				do_crop;
>>>>     
>>>>     	const struct dcmi_format	**user_formats;
>>>>     	unsigned int			num_user_formats;
>>>> @@ -538,6 +540,27 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
>>>>     	if (dcmi->bus.flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
>>>>     		val |= CR_PCKPOL;
>>>>     
>>>> +	if (dcmi->do_crop) {
>>>> +		u32 size, start;
>>>> +
>>>> +		/* Crop resolution */
>>>> +		size = ((dcmi->crop.height - 1) << 16) |
>>>> +			((dcmi->crop.width << 1) - 1);
>>>> +		reg_write(dcmi->regs, DCMI_CWSIZE, size);
>>>> +
>>>> +		/* Crop start point */
>>>> +		start = ((dcmi->crop.top) << 16) |
>>>> +			 ((dcmi->crop.left << 1));
>>>> +		reg_write(dcmi->regs, DCMI_CWSTRT, start);
>>>> +
>>>> +		dev_dbg(dcmi->dev, "Cropping to %ux%u@%u:%u\n",
>>>> +			dcmi->crop.width, dcmi->crop.height,
>>>> +			dcmi->crop.left, dcmi->crop.top);
>>>> +
>>>> +		/* Enable crop */
>>>> +		val |= CR_CROP;
>>>> +	};
>>>> +
>>>>     	reg_write(dcmi->regs, DCMI_CR, val);
>>>>     
>>>>     	/* Enable dcmi */
>>>> @@ -707,6 +730,8 @@ static int dcmi_try_fmt(struct stm32_dcmi *dcmi, struct v4l2_format *f,
>>>>     		.which = V4L2_SUBDEV_FORMAT_TRY,
>>>>     	};
>>>>     	int ret;
>>>> +	__u32 width, height;
>>>> +	struct v4l2_mbus_framefmt *mf = &format.format;
>>>>     
>>>>     	dcmi_fmt = find_format_by_fourcc(dcmi, pixfmt->pixelformat);
>>>>     	if (!dcmi_fmt) {
>>>> @@ -724,8 +749,18 @@ static int dcmi_try_fmt(struct stm32_dcmi *dcmi, struct v4l2_format *f,
>>>>     	if (ret < 0)
>>>>     		return ret;
>>>>     
>>>> +	/* Align format on what sensor can do */
>>>> +	width = pixfmt->width;
>>>> +	height = pixfmt->height;
>>>>     	v4l2_fill_pix_format(pixfmt, &format.format);
>>>>     
>>>> +	/* We can do any resolution thanks to crop */
>>>> +	if ((mf->width > width) || (mf->height > height)) {
>>>> +		/* Restore width/height */
>>>> +		pixfmt->width = width;
>>>> +		pixfmt->height = height;
>>>> +	};
>>>> +
>>>>     	pixfmt->field = V4L2_FIELD_NONE;
>>>>     	pixfmt->bytesperline = pixfmt->width * dcmi_fmt->bpp;
>>>>     	pixfmt->sizeimage = pixfmt->bytesperline * pixfmt->height;
>>>> @@ -741,6 +776,8 @@ static int dcmi_set_fmt(struct stm32_dcmi *dcmi, struct v4l2_format *f)
>>>>     	struct v4l2_subdev_format format = {
>>>>     		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>>>>     	};
>>>> +	struct v4l2_mbus_framefmt *mf = &format.format;
>>>> +	struct v4l2_pix_format *pixfmt = &f->fmt.pix;
>>>>     	const struct dcmi_format *current_fmt;
>>>>     	int ret;
>>>>     
>>>> @@ -748,13 +785,28 @@ static int dcmi_set_fmt(struct stm32_dcmi *dcmi, struct v4l2_format *f)
>>>>     	if (ret)
>>>>     		return ret;
>>>>     
>>>> -	v4l2_fill_mbus_format(&format.format, &f->fmt.pix,
>>>> +	v4l2_fill_mbus_format(&format.format, pixfmt,
>>>>     			      current_fmt->mbus_code);
>>>>     	ret = v4l2_subdev_call(dcmi->entity.subdev, pad,
>>>>     			       set_fmt, NULL, &format);
>>>>     	if (ret < 0)
>>>>     		return ret;
>>>>     
>>>> +	/* Enable crop if sensor resolution is larger than request */
>>>> +	dcmi->do_crop = false;
>>>> +	if ((mf->width > pixfmt->width) || (mf->height > pixfmt->height)) {
>>>> +		dcmi->crop.width = pixfmt->width;
>>>> +		dcmi->crop.height = pixfmt->height;
>>>> +		dcmi->crop.left = (mf->width - pixfmt->width) / 2;
>>>> +		dcmi->crop.top = (mf->height - pixfmt->height) / 2;
>>>> +		dcmi->do_crop = true;
>>>
>>> Why not implement the selection API instead? I assume that you can crop from any
>>> region of the sensor, not just the center part.
>>
>> The point here was to add some flexibility for user in term of
>> resolution and also less memory consumption.
>> For example here I want to make a 480x272 preview:
>> - without this change: S_FMT(480x272) returns VGA (the OV9655 larger
>> discrete resolution), then app has to capture VGA frames then crop to
>> fit 480x272 frame buffer.
>> - with this change: S_FMT(480x272) returns 480x272 (crop done by
>> hardware), app can directly capture 480x272 then copy to framebuffer
>> without any conversion.
>>
>> Implementation of V4L2 crop using SELECTION API could also be used,
>> but I need to change app.
>>
>> More generally, with a given couple ISP+sensor, will S_FMT()
>> return the sensor only supported resolutions ? or the supported
>> resolutions of the couple ISP+sensor (ISP will downscale/upscale/crop
>> the sensor discrete resolution to fit user request) ?
>>
>> Hans, what are your recommendations ?
> 
> This is not the way the V4L2 API works.
> 
> Sensors report their supported resolutions through the ENUM_FRAMESIZES
> (and the related ENUM_FRAMEINTERVALS) ioctls.
> 
> With S_FMT you pick the resolution you want.
> 
> If you then want to crop the driver should implement the selection API
> (this will also automatically enable the G/S_CROP/CROPCAP ioctls) so the
> application can select which part of the image should be cropped. Assuming
> there is no scaler then after cropping the format size will be reduced
> to the size of the cropped image.
> 
> That's in a nutshell how these ioctls relate to one another.
> 
> Regards,
> 
> 	Hans
> 

Ok, crystal clear, I'll implement selection API so.
BR,
Hugues.

>>
>>>
>>> Regards,
>>>
>>> 	Hans
>>>
>>>> +
>>>> +		dev_dbg(dcmi->dev, "%ux%u cropped to %ux%u@(%u,%u)\n",
>>>> +			mf->width, mf->height,
>>>> +			dcmi->crop.width, dcmi->crop.height,
>>>> +			dcmi->crop.left, dcmi->crop.top);
>>>> +	};
>>>> +
>>>>     	dcmi->fmt = *f;
>>>>     	dcmi->current_fmt = current_fmt;
>>>>     
>>>>
> 
