From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 1 Feb 2017 16:04:50 -0800
Subject: [PATCH v3 21/24] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <20170201234438.GS27312@n2100.armlinux.org.uk>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-22-git-send-email-steve_longerbeam@mentor.com>
 <20170201234438.GS27312@n2100.armlinux.org.uk>
Message-ID: <defa1129-e341-6b6a-b0b2-bd2d38088245@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/01/2017 03:44 PM, Russell King - ARM Linux wrote:
> On Fri, Jan 06, 2017 at 06:11:39PM -0800, Steve Longerbeam wrote:
>> +static int imxcsi2_get_fmt(struct v4l2_subdev *sd,
>> +			   struct v4l2_subdev_pad_config *cfg,
>> +			   struct v4l2_subdev_format *sdformat)
>> +{
>> +	struct imxcsi2_dev *csi2 = sd_to_dev(sd);
>> +
>> +	sdformat->format = csi2->format_mbus;
>> +
>> +	return 0;
>> +}
> Hi Steve,
>
> This isn't correct, and I suspect the other get_fmt implementations are
> the same - I've just checked imx-csi.c, and that also appears to have
> the same issue.
>
> When get_fmt() is called with sdformat->which == V4L2_SUBDEV_FORMAT_TRY,
> you need to return the try format rather than the current format.  See
> the second paragraph of Documentation/media/uapi/v4l/dev-subdev.rst's
> "Format Negotiation" section, where it talks about using
> V4L2_SUBDEV_FORMAT_TRY with both VIDIOC_SUBDEV_G_FMT and
> VIDIOC_SUBDEV_S_FMT.

Yes that's wrong. I'll fix.

Btw I read over Documentation/media/uapi/v4l/dev-subdev.rst (can't
remember if I ever did!), and it clears up a lot. I do see I'm doing some
other things wrong as well:

-  Formats should be propagated from sink pads to source pads. Modifying
    a format on a source pad should not modify the format on any sink
    pad.

I don't believe I'm affecting the source pad formats during sink pad
negotiation, or vice-versa, yet. But I will, once the pixel width alignment
optimization is implemented based on whether the output format is planar.
And I'll keep this direction-of-propagation rule in mind when I do so.

-  Sub-devices that scale frames using variable scaling factors should
    reset the scale factors to default values when sink pads formats are
    modified. If the 1:1 scaling ratio is supported, this means that
    source pads formats should be reset to the sink pads formats.

I'm not resetting the scaling factors on sink pad format change in
the scaling subdevs (imx-ic-prpenc and imx-ic-prpvf). Will fix that.

Steve
