From: eajames@linux.vnet.ibm.com (Eddie James)
Date: Thu, 13 Sep 2018 14:00:39 -0500
Subject: [PATCH 4/4] media: platform: Add Aspeed Video Engine driver
In-Reply-To: <77243417-e832-dcfa-0eeb-d45f356dd9e8@xs4all.nl>
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1535576973-8067-5-git-send-email-eajames@linux.vnet.ibm.com>
 <77243417-e832-dcfa-0eeb-d45f356dd9e8@xs4all.nl>
Message-ID: <5cd805fa-31e9-a011-f8cd-32590125f136@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/03/2018 06:40 AM, Hans Verkuil wrote:
> On 08/29/2018 11:09 PM, Eddie James wrote:
>> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
>> can capture and compress video data from digital or analog sources. With
>> the Aspeed chip acting a service processor, the Video Engine can capture
>> the host processor graphics output.
>>
>> Add a V4L2 driver to capture video data and compress it to JPEG images,
>> making the data available through a standard read interface.
>>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
>> ---
>>   drivers/media/platform/Kconfig        |    8 +
>>   drivers/media/platform/Makefile       |    1 +
>>   drivers/media/platform/aspeed-video.c | 1307 +++++++++++++++++++++++++++++++++
> Missing MAINTAINERS file update.
>
>>   3 files changed, 1316 insertions(+)
>>   create mode 100644 drivers/media/platform/aspeed-video.c
>> +
>> +static void aspeed_video_init_jpeg_table(u32 *table, bool yuv420)
>> +{
>> +	int i;
>> +	unsigned int base;
>> +
>> +	for (i = 0; i < ASPEED_VIDEO_JPEG_NUM_QUALITIES; i++) {
>> +		int j;
>> +
>> +		base = 256 * i;	/* AST HW requires this header spacing */
>> +
>> +		for (j = 0; j < ASPEED_VIDEO_JPEG_HEADER_SIZE; j++)
>> +			table[base + j] =
>> +				le32_to_cpu(aspeed_video_jpeg_header[j]);
> This doesn't look right. These tables are in cpu format to begin with,
> so le32_to_cpu doesn't make sense.
>
> BTW, what is the endianness of an aspeed SoC?

Hi,

Yes, Aspeed SoCs are LE, it's a standard ARM core. I'll do a simple copy 
instead of converting endianness, since this code can really only run on 
an Aspeed chip anyway.

>
>> +
>> +		base += ASPEED_VIDEO_JPEG_HEADER_SIZE;
>> +		for (j = 0; j < ASPEED_VIDEO_JPEG_DCT_SIZE; j++)
>> +			table[base + j] =
>> +				le32_to_cpu(aspeed_video_jpeg_dct[i][j]);
>> +
>> +		base += ASPEED_VIDEO_JPEG_DCT_SIZE;
>> +		for (j = 0; j < ASPEED_VIDEO_JPEG_QUANT_SIZE; j++)
>> +			table[base + j] =
>> +				le32_to_cpu(aspeed_video_jpeg_quant[j]);
>> +
>> +		if (yuv420)
>> +			table[base + 2] = le32_to_cpu(0x00220103);
>> +	}
>> +}
>> +
>> +
>> +static int aspeed_video_querycap(struct file *file, void *fh,
>> +				 struct v4l2_capability *cap)
>> +{
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>> +	strncpy(cap->driver, DEVICE_NAME, sizeof(cap->driver));
> Use strlcpy.
>
> Also fill in bus_info ("platform:<foo>").
>
>> +	cap->capabilities = video->vdev.device_caps | V4L2_CAP_DEVICE_CAPS;
> You can drop this, it's filled in for you.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_video_get_format(struct file *file, void *fh,
>> +				   struct v4l2_format *f)
>> +{
>> +	int rc;
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>> +	if (test_bit(VIDEO_RES_CHANGE, &video->flags)) {
>> +		if (file->f_flags & O_NONBLOCK)
>> +			return -EAGAIN;
>> +
>> +		rc = wait_event_interruptible(video->wait,
>> +					      !test_bit(VIDEO_RES_CHANGE,
>> +							&video->flags));
>> +		if (rc)
>> +			return -EINTR;
> No, get_format should always just return the currently set format,
> not the format that is detected.
>
> Use VIDIOC_QUERY_DV_TIMINGS for that.
>
>> +	}
>> +
>> +	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
> Drop this, not needed.
>
>> +	f->fmt.pix = video->fmt;
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_video_set_format(struct file *file, void *fh,
>> +				   struct v4l2_format *f)
>> +{
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>> +	if (f->fmt.pix.pixelformat == video->fmt.pixelformat)
>> +		return 0;
>> +
>> +	if (f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUV444) {
>> +		video->fmt.pixelformat = V4L2_PIX_FMT_YUV444;
>> +		aspeed_video_init_jpeg_table(video->jpeg.virt, false);
>> +		aspeed_video_update(video, VE_SEQ_CTRL, ~VE_SEQ_CTRL_YUV420,
>> +				    0);
>> +	} else if (f->fmt.pix.pixelformat == V4L2_PIX_FMT_YUV420) {
>> +		video->fmt.pixelformat = V4L2_PIX_FMT_YUV420;
>> +		aspeed_video_init_jpeg_table(video->jpeg.virt, true);
>> +		aspeed_video_update(video, VE_SEQ_CTRL, 0xFFFFFFFF,
>> +				    VE_SEQ_CTRL_YUV420);
> This isn't filling in any of the other fields.
>
>> +	} else {
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_video_get_jpegcomp(struct file *file, void *fh,
>> +				     struct v4l2_jpegcompression *a)
>> +{
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>> +	a->quality = video->jpeg_quality;
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_video_set_jpegcomp(struct file *file, void *fh,
>> +				     const struct v4l2_jpegcompression *a)
>> +{
>> +	u32 comp_ctrl;
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>> +	if (a->quality < 0 || a->quality > 11)
>> +		return -EINVAL;
>> +
>> +	video->jpeg_quality = a->quality;
>> +	comp_ctrl = FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
>> +		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
>> +
>> +	aspeed_video_update(video, VE_COMP_CTRL,
>> +			    ~(VE_COMP_CTRL_DCT_LUM | VE_COMP_CTRL_DCT_CHR),
>> +			    comp_ctrl);
>> +
>> +	return 0;
>> +}
> As the spec says, the jpegcomp ioctls are deprecated and you should use
> JPEG controls instead.
>
> See: https://hverkuil.home.xs4all.nl/spec/uapi/v4l/vidioc-g-jpegcomp.html
>
> I stop reviewing here, since the first thing you need to do is to run
> v4l2-compliance for your device driver.
>
> See my reply to patch 0/4.
>
> Regards,
>
> 	Hans

Thanks for all the comments! I have addressed these items and will push 
up another patch set.

Thanks,
Eddie

>
>> +
>> +static int aspeed_video_get_parm(struct file *file, void *fh,
>> +				 struct v4l2_streamparm *a)
>> +{
>> +	struct aspeed_video *video = video_drvdata(file);
>> +
>>
