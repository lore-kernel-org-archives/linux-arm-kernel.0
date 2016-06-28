From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 28 Jun 2016 10:51:54 +0200
Subject: [PATCH 1/3] mfd: add support for Allwinner SoCs ADC
In-Reply-To: <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
 <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <20160628085154.GE4472@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jun 28, 2016 at 10:18:15AM +0200, Quentin Schulz wrote:
> diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpadc-mfd.c
> new file mode 100644
> index 0000000..710e297
> --- /dev/null
> +++ b/drivers/mfd/sunxi-gpadc-mfd.c
> @@ -0,0 +1,188 @@

[...]

> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "allwinner,sun4i-a10-ts"))
> +		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +				      sun4i_gpadc_mfd_cells,
> +				      ARRAY_SIZE(sun4i_gpadc_mfd_cells), NULL,
> +				      0, NULL);
> +	else if (of_device_is_compatible(pdev->dev.of_node,
> +					 "allwinner,sun5i-a13-ts"))
> +		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +				      sun5i_gpadc_mfd_cells,
> +				      ARRAY_SIZE(sun5i_gpadc_mfd_cells), NULL,
> +				      0, NULL);
> +	else if (of_device_is_compatible(pdev->dev.of_node,
> +					 "allwinner,sun6i-a31-ts"))
> +		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
> +				      sun6i_gpadc_mfd_cells,
> +				      ARRAY_SIZE(sun6i_gpadc_mfd_cells), NULL,
> +				      0, NULL);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add MFD devices: %d\n", ret);
> +		regmap_del_irq_chip(irq, sunxi_gpadc_mfd_dev->regmap_irqc);
> +		mfd_remove_devices(&pdev->dev);

You don't need to explicitly call mfd_remove_devices() when
mfd_add_devices() fails. See:
http://lxr.free-electrons.com/source/drivers/mfd/mfd-core.c#L298

> +		return ret;
> +	}

Thanks,

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/a0e72c12/attachment.sig>
