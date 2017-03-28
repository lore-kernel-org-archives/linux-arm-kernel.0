From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Tue, 28 Mar 2017 17:12:46 +0300
Subject: [PATCH v6 17/39] platform: add video-multiplexer subdevice driver
In-Reply-To: <1490661656-10318-18-git-send-email-steve_longerbeam@mentor.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-18-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <14adece8-d73f-212b-2bfa-70eb3602666c@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On 03/28/2017 03:40 AM, Steve Longerbeam wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> This driver can handle SoC internal and external video bus multiplexers,
> controlled either by register bit fields or by a GPIO. The subdevice
> passes through frame interval and mbus configuration of the active input
> to the output side.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> - fixed a cut&paste error in vidsw_remove(): v4l2_async_register_subdev()
>   should be unregister.
> 
> - added media_entity_cleanup() to vidsw_remove().
> 
> - added missing MODULE_DEVICE_TABLE().
>   Suggested-by: Javier Martinez Canillas <javier@dowhile0.org>
> 
> - there was a line left over from a previous iteration that negated
>   the new way of determining the pad count just before it which
>   has been removed (num_pads = of_get_child_count(np)).
> 
> - removed [gs]_frame_interval ops. timeperframe is not used anywhwere
>   in this subdev, and currently it has no control over frame rate.
> 
> - add link_validate to media_entity_operations.
> 
> - moved devicetree binding doc to a separate commit.
> 
> - Philipp Zabel has developed a set of patches that allow adding
>   to the subdev async notifier waiting list using a chaining method
>   from the async registered callbacks (v4l2_of_subdev_registered()
>   and the prep patches for that). For now, I've removed the use of
>   v4l2_of_subdev_registered() for the vidmux driver's registered
>   callback. This doesn't affect the functionality of this driver,
>   but allows for it to be merged now, before adding the chaining
>   support.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> ---
>  drivers/media/platform/Kconfig             |   8 +
>  drivers/media/platform/Makefile            |   2 +
>  drivers/media/platform/video-multiplexer.c | 451 +++++++++++++++++++++++++++++
>  3 files changed, 461 insertions(+)
>  create mode 100644 drivers/media/platform/video-multiplexer.c
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index ab0bb48..c9b8d9c 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -74,6 +74,14 @@ config VIDEO_M32R_AR_M64278
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called arv.
>  
> +config VIDEO_MULTIPLEXER
> +	tristate "Video Multiplexer"
> +	depends on VIDEO_V4L2_SUBDEV_API && MEDIA_CONTROLLER

+ depends on OF

> +	help
> +	  This driver provides support for SoC internal N:1 video bus
> +	  multiplexers controlled by register bitfields as well as external
> +	  2:1 video multiplexers controlled by a single GPIO.
> +

[snip]

> +static int vidsw_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct of_endpoint endpoint;
> +	struct device_node *ep;
> +	struct reg_field field;
> +	struct vidsw *vidsw;
> +	struct regmap *map;
> +	unsigned int num_pads;
> +	int ret;
> +
> +	vidsw = devm_kzalloc(&pdev->dev, sizeof(*vidsw), GFP_KERNEL);
> +	if (!vidsw)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, vidsw);
> +
> +	v4l2_subdev_init(&vidsw->subdev, &vidsw_subdev_ops);
> +	snprintf(vidsw->subdev.name, sizeof(vidsw->subdev.name), "%s",
> +			np->name);

.... or oops here       ^^^^^^^^^.

> +	vidsw->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> +	vidsw->subdev.dev = &pdev->dev;
> +
> +	/*
> +	 * The largest numbered port is the output port. It determines
> +	 * total number of pads
> +	 */
> +	num_pads = 0;
> +	for_each_endpoint_of_node(np, ep) {
> +		of_graph_parse_endpoint(ep, &endpoint);
> +		num_pads = max(num_pads, endpoint.port + 1);
> +	}
> +
> +	if (num_pads < 2) {
> +		dev_err(&pdev->dev, "Not enough ports %d\n", num_pads);
> +		return -EINVAL;
> +	}

This unveils another runtime dependency on OF.

> +
> +	ret = of_get_reg_field(np, &field);
> +	if (ret == 0) {
> +		map = syscon_node_to_regmap(np->parent);
> +		if (!map) {
> +			dev_err(&pdev->dev, "Failed to get syscon register map\n");
> +			return PTR_ERR(map);
> +		}
> +
> +		vidsw->field = devm_regmap_field_alloc(&pdev->dev, map, field);
> +		if (IS_ERR(vidsw->field)) {
> +			dev_err(&pdev->dev, "Failed to allocate regmap field\n");
> +			return PTR_ERR(vidsw->field);
> +		}
> +
> +		regmap_field_read(vidsw->field, &vidsw->active);
> +	} else {
> +		if (num_pads > 3) {
> +			dev_err(&pdev->dev, "Too many ports %d\n", num_pads);
> +			return -EINVAL;
> +		}
> +
> +		vidsw->gpio = devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
> +		if (IS_ERR(vidsw->gpio)) {
> +			dev_warn(&pdev->dev,
> +				 "could not request control gpio: %d\n", ret);
> +			vidsw->gpio = NULL;
> +		}
> +
> +		vidsw->active = gpiod_get_value(vidsw->gpio) ? 1 : 0;

vidsw->active is always set to 0 ?

> +	}
> +
> +	vidsw->num_pads = num_pads;
> +	vidsw->pads = devm_kzalloc(&pdev->dev, sizeof(*vidsw->pads) * num_pads,
> +			GFP_KERNEL);
> +	vidsw->format_mbus = devm_kzalloc(&pdev->dev,
> +			sizeof(*vidsw->format_mbus) * num_pads, GFP_KERNEL);
> +	vidsw->endpoint = devm_kzalloc(&pdev->dev,
> +			sizeof(*vidsw->endpoint) * (num_pads - 1), GFP_KERNEL);
> +
> +	ret = vidsw_async_init(vidsw, np);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +

--
With best wishes,
Vladimir
