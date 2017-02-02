From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Feb 2017 22:35:28 +0000
Subject: [PATCH v3 20/24] media: imx: Add Camera Interface subdev driver
In-Reply-To: <1483755102-24785-21-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-21-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170202223528.GX27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:11:38PM -0800, Steve Longerbeam wrote:
> +struct camif_priv {
> +	struct device         *dev;
> +	struct video_device    vfd;

You can't do this.

> +static struct video_device camif_videodev = {
> +	.fops		= &camif_fops,
> +	.ioctl_ops	= &camif_ioctl_ops,
> +	.minor		= -1,
> +	.release	= video_device_release,
> +	.vfl_dir	= VFL_DIR_RX,
> +	.tvnorms	= V4L2_STD_NTSC | V4L2_STD_PAL | V4L2_STD_SECAM,
> +};

> +static int camif_probe(struct platform_device *pdev)
> +{
> +	struct imx_media_internal_sd_platformdata *pdata;
> +	struct camif_priv *priv;
> +	struct video_device *vfd;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;

You kmalloc this structure, so this structure has the lifetime of
the driver being bound to the platform device.

> +	vfd = &priv->vfd;
> +	*vfd = camif_videodev;

However, "*vfd" contains a struct device, and you _correctly_ set the
release function for "*vfd" to video_device_release via camif_videodev.

However, if you try to rmmod imx-media, then you end up with a kernel
warning that you're freeing memory containing a held lock, and later
chaos ensues because kmalloc has been corrupted.

The root cause of this is embedding the device structure within the
video_device into the driver's private data.  *Any* structure what so
ever that contains a kref is reference counted, and that includes
struct device, and therefore also includes struct video_device.  What
that means is that its lifetime is _not_ under _your_ control, and
you may not free it except through its release function (which is
video_device_release().)  However, that also tries to kfree (with an
offset of 4) your private data, which results in the warning and the
corrupted kmalloc free lists.

The solution is simple, make "vfd" a pointer in your private data
structure and kmalloc() it separately, letting video_device_release()
kfree() that data when it needs to.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
