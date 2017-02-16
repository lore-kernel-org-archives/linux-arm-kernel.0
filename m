From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2017 11:52:06 +0000
Subject: [PATCH v4 20/36] media: imx: Add CSI subdev driver
In-Reply-To: <1487211578-11360-21-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-21-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170216115206.GL27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 06:19:22PM -0800, Steve Longerbeam wrote:
> +static const struct platform_device_id imx_csi_ids[] = {
> +	{ .name = "imx-ipuv3-csi" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, imx_csi_ids);
> +
> +static struct platform_driver imx_csi_driver = {
> +	.probe = imx_csi_probe,
> +	.remove = imx_csi_remove,
> +	.id_table = imx_csi_ids,
> +	.driver = {
> +		.name = "imx-ipuv3-csi",
> +	},
> +};
> +module_platform_driver(imx_csi_driver);
> +
> +MODULE_DESCRIPTION("i.MX CSI subdev driver");
> +MODULE_AUTHOR("Steve Longerbeam <steve_longerbeam@mentor.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:imx-ipuv3-csi");

Just a reminder that automatic module loading of this is completely
broken right now (not your problem) due to this stupid idea in the
IPUv3 code:

		if (!ret)
			ret = platform_device_add(pdev);
		if (ret) {
			platform_device_put(pdev);
			goto err_register;
		}

		/*
		 * Set of_node only after calling platform_device_add. Otherwise
		 * the platform:imx-ipuv3-crtc modalias won't be used.
		 */
		pdev->dev.of_node = of_node;

setting pdev->dev.of_node changes the modalias exported to userspace,
so udev sees a DT based modalias, which causes it to totally miss any
driver using a non-DT based modalias.

The IPUv3 code needs fixing, not only for imx-media-csi, but also for
imx-ipuv3-crtc too, because that module will also suffer the same
issue.

The only solution is... don't fsck with dev->of_node assignment.  In
this case, it's probably much better to pass it in via platform data.
If you then absolutely must have dev->of_node, doing it in the driver
means that you avoid the modalias mess before the appropriate driver
is loaded.  However, that's still not a nice solution because the
modalias file still ends up randomly changing its contents.

As I say, not _your_ problem, but it's still a problem that needs
solving, and I don't want it forgotten about.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
