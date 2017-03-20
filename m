From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 20 Mar 2017 13:49:27 +0100
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170319121402.GS21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170319121402.GS21222@n2100.armlinux.org.uk>
Message-ID: <b6cf3479-d0c7-8e28-078a-9e45b25ade34@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2017 01:14 PM, Russell King - ARM Linux wrote:
> On Sat, Mar 18, 2017 at 12:58:27PM -0700, Steve Longerbeam wrote:
>> On 03/18/2017 12:22 PM, Russell King - ARM Linux wrote:
>>> 0:00:01.955927879 20954  0x15ffe90 INFO                    v4l2 gstv4l2object.c:3811:gst_v4l2_object_get_caps:<v4l2src0> probed caps: video/x-bayer, format=(string)rggb, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)I420, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)YV12, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)BGR, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1; video/x-raw, format=(string)RGB, framerate=(fraction)30000/1001, width=(int)816, height=(int)616, interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1
>>>
>>>    despite the media pipeline actually being configured for 60fps.
>>>
>>>    Forcing it by adjusting the pipeline only results in gstreamer
>>>    failing, because it believes that v4l2 is unable to operate at
>>>    60fps.
>>>
>>>    Also note the complaints from v4l2src about the non-compliance...
>>
>> Thanks, I've fixed most of v4l2-compliance issues, but this is not
>> done yet. Is that something you can help with?
> 
> I've looked at this, and IMHO it's yet another media control API mess.
> 
> - media-ctl itself allows setting the format on subdev pads via
>   struct v4l2_subdev_format.
> 
> - struct v4l2_subdev_format contains a struct v4l2_mbus_framefmt.
> 
> - struct v4l2_mbus_framefmt contains:
>   * @width:      frame width
>   * @height:     frame height
>   * @code:       data format code (from enum v4l2_mbus_pixelcode)
>   * @field:      used interlacing type (from enum v4l2_field)
>   * @colorspace: colorspace of the data (from enum v4l2_colorspace)
>   * @ycbcr_enc:  YCbCr encoding of the data (from enum v4l2_ycbcr_encoding)
>   * @quantization: quantization of the data (from enum v4l2_quantization)
>   * @xfer_func:  transfer function of the data (from enum v4l2_xfer_func)
> 
> - media-ctl sets width, height, code and field, but nothing else.
> 
> We're already agreed that the fields that media-ctl are part of the
> format negotiation between the ultimate source, flowing down to the
> capture device.  However, there's no support in media-ctl to deal
> with these other fields - so media-ctl in itself is only half-
> implemented.

Correct. The colorspace et al fields are in practice unimportant for sensors.
For HDMI/DP they are very important, though.

It's the reason why nobody worked on adding support for this to media-ctl,
it's almost exclusively used with sensors. Not saying that it is right that
it hasn't been added to media-ctl, just that it never had a high enough prio.

Regards,

	Hans

> 
> From what I can tell, _we_ are doing the right thing in imx-media-capture.
> 
> However, I think part of the problem is the set_fmt implementation.
> When a source pad is configured via set_fmt(), any fields that can
> not be altered (eg, because the subdev doesn't support colorspace
> conversion) need to be preserved from the subdev's sink pad.
> 
> Right now, CSI doesn't do that - it only looks at the width, height,
> code, and field.
> 
> I think we've got other bugs though that haven't been picked up by any
> review - csi_try_fmt() adjusts the format using the _current_
> configuration of the sink pad, even when using V4L2_SUBDEV_FORMAT_TRY.
> This seems wrong according to the docs: the purpose of the try
> mechanism is to be able to setup the _entire_ pipeline using the TRY
> mechanism to work out whether the configuration works, before then
> setting for real.  If we're validating the TRY formats against the
> live configuration, then we're not doing that.
> 
> There's calls for:
> 
> v4l2_subdev_get_try_format
> v4l2_subdev_get_try_crop
> v4l2_subdev_get_try_compose
> 
> to get the try configuration - we hardly make use of all of these.  I
> would suggest that we change the approach to implementing the various
> subdevs such that:
> 
> 1) like __csi_get_fmt(), we have accessors that gets a pointer to the
>    correct state for the TRY/live settings.
> 
> 2) everywhere we're asked to get or set parameters that can be TRY/live,
>    we use these accessors to retrieve a pointer to the correct state to
>    not only read, but also modify.
> 
> 3) when we're evaluating parameters against another pad, we use these
>    accessors to obtain the other pad's configuration, rather than poking
>    about in the state saved in the subdev's priv-> (which is irrelevant
>    for the TRY variant.)
> 
> 4) ensure that all parameters which the subdev itself does not support
>    modification of are correctly propagated from the sink pad to all
>    source pads, and are unable to be modified via the source pad.
> 
