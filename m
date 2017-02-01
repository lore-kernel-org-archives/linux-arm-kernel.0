From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Feb 2017 23:44:38 +0000
Subject: [PATCH v3 21/24] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <1483755102-24785-22-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-22-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170201234438.GS27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:11:39PM -0800, Steve Longerbeam wrote:
> +static int imxcsi2_get_fmt(struct v4l2_subdev *sd,
> +			   struct v4l2_subdev_pad_config *cfg,
> +			   struct v4l2_subdev_format *sdformat)
> +{
> +	struct imxcsi2_dev *csi2 = sd_to_dev(sd);
> +
> +	sdformat->format = csi2->format_mbus;
> +
> +	return 0;
> +}

Hi Steve,

This isn't correct, and I suspect the other get_fmt implementations are
the same - I've just checked imx-csi.c, and that also appears to have
the same issue.

When get_fmt() is called with sdformat->which == V4L2_SUBDEV_FORMAT_TRY,
you need to return the try format rather than the current format.  See
the second paragraph of Documentation/media/uapi/v4l/dev-subdev.rst's
"Format Negotiation" section, where it talks about using
V4L2_SUBDEV_FORMAT_TRY with both VIDIOC_SUBDEV_G_FMT and
VIDIOC_SUBDEV_S_FMT.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
