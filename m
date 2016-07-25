From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Jul 2016 11:51:13 +0200
Subject: [PATCH 5/5] mfd: sunxi-gpadc-mfd: probe sunxi-gpadc-ts driver
In-Reply-To: <11247e4f-d04d-d5bc-6ebf-a637820c011d@kernel.org>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-6-git-send-email-quentin.schulz@free-electrons.com>
 <20160721060812.GA5993@lukather>
 <11247e4f-d04d-d5bc-6ebf-a637820c011d@kernel.org>
Message-ID: <20160725095113.GJ7419@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Sun, Jul 24, 2016 at 12:26:56PM +0100, Jonathan Cameron wrote:
> >> @@ -142,23 +159,45 @@ static int sunxi_gpadc_mfd_probe(struct platform_device *pdev)
> >>  	}
> >>  
> >>  	if (of_device_is_compatible(pdev->dev.of_node,
> >> -				    "allwinner,sun4i-a10-ts"))
> >> -		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> -				      sun4i_gpadc_mfd_cells,
> >> -				      ARRAY_SIZE(sun4i_gpadc_mfd_cells), NULL,
> >> -				      0, NULL);
> >> -	else if (of_device_is_compatible(pdev->dev.of_node,
> >> -					 "allwinner,sun5i-a13-ts"))
> >> -		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> -				      sun5i_gpadc_mfd_cells,
> >> -				      ARRAY_SIZE(sun5i_gpadc_mfd_cells), NULL,
> >> -				      0, NULL);
> >> -	else if (of_device_is_compatible(pdev->dev.of_node,
> >> -					 "allwinner,sun6i-a31-ts"))
> >> -		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> -				      sun6i_gpadc_mfd_cells,
> >> -				      ARRAY_SIZE(sun6i_gpadc_mfd_cells), NULL,
> >> -				      0, NULL);
> >> +				    "allwinner,sun4i-a10-ts")) {
> >> +		if (of_property_read_bool(pdev->dev.of_node,
> >> +					  "allwinner,ts-attached"))
> >> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun4i_gpadc_mfd_cells_ts,
> >> +					      ARRAY_SIZE(sun4i_gpadc_mfd_cells_ts),
> >> +					      NULL, 0, NULL);
> >> +		else
> >> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun4i_gpadc_mfd_cells,
> >> +					      ARRAY_SIZE(sun4i_gpadc_mfd_cells),
> >> +					      NULL, 0, NULL);
> >> +	} else if (of_device_is_compatible(pdev->dev.of_node,
> >> +					 "allwinner,sun5i-a13-ts")) {
> >> +		if (of_property_read_bool(pdev->dev.of_node,
> >> +					  "allwinner,ts-attached"))
> >> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun5i_gpadc_mfd_cells_ts,
> >> +					      ARRAY_SIZE(sun5i_gpadc_mfd_cells_ts),
> >> +					      NULL, 0, NULL);
> >> +		else
> >> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun5i_gpadc_mfd_cells,
> >> +					      ARRAY_SIZE(sun5i_gpadc_mfd_cells),
> >> +					      NULL, 0, NULL);
> >> +	} else if (of_device_is_compatible(pdev->dev.of_node,
> >> +					 "allwinner,sun6i-a31-ts")) {
> >> +		if (of_property_read_bool(pdev->dev.of_node,
> >> +					  "allwinner,ts-attached"))
> >> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun6i_gpadc_mfd_cells_ts,
> >> +					      ARRAY_SIZE(sun6i_gpadc_mfd_cells_ts),
> >> +					      NULL, 0, NULL);
> >> +		else
> >> +			ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> >> +					      sun6i_gpadc_mfd_cells,
> >> +					      ARRAY_SIZE(sun6i_gpadc_mfd_cells),
> >> +					      NULL, 0, NULL);
> >> +	}
> > 
> > Please don't use any of_device_is_compatible.
> Hi Maxime,
> 
> Why?  (Just curious...)

This is completely redundant. The compatible has already been looked
up once to match the driver, and you can associate a void * pointer to
any compatible you register in the of_device_id array.

So you can just retrieve the compatible that probed you in the first
place, and use it's private data pointer to store whatever you want,
without the numerous (and expensive) calls to of_device_is_compatible.

It's also easier to maintain in the long term, since you can simply
add a new field to the structure you would register there, instead of
keeping adding more conditions.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/6c7dc35d/attachment.sig>
