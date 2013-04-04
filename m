From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 4 Apr 2013 09:25:03 +0200
Subject: [PATCH 2/6] rtc: rtc-m48t86: add hooks to support driver side
 memory mapping
In-Reply-To: <1364858565-17192-3-git-send-email-alex@digriz.org.uk>
References: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
 <1364858565-17192-3-git-send-email-alex@digriz.org.uk>
Message-ID: <20130404072503.GE28914@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -static int m48t86_rtc_probe(struct platform_device *dev)
> +static int m48t86_rtc_probe(struct platform_device *pdev)
>  {
>  	unsigned char reg;
> -	struct m48t86_ops *ops = dev->dev.platform_data;
> -	struct rtc_device *rtc = rtc_device_register("m48t86",
> -				&dev->dev, &m48t86_rtc_ops, THIS_MODULE);
> -
> -	if (IS_ERR(rtc))
> -		return PTR_ERR(rtc);
> -
> -	platform_set_drvdata(dev, rtc);
> +	int err;
> +	struct resource *res_index, *res_data;
> +	struct m48t86_rtc_private_data *priv;
> +
> +	/* Allocate memory for the device structure (and zero it) */
> +	priv = kzalloc(sizeof(struct m48t86_rtc_private_data), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	if (!pdev->dev.platform_data) {
> +		res_index = platform_get_resource_byname(
> +					pdev, IORESOURCE_MEM, "rtc_index");
> +		if (!res_index) {
> +			err = -ENXIO;
> +			goto out_free;
> +		}
> +
> +		res_data = platform_get_resource_byname(
> +					pdev, IORESOURCE_MEM, "rtc_data");
> +		if (!res_data) {
> +			err = -ENXIO;
> +			goto out_free;
> +		}
> +
> +		if (!request_mem_region(res_index->start,
> +					resource_size(res_index),
> +					dev_name(&pdev->dev))) {
> +			err = -EBUSY;
> +			goto out_free;
> +		}
> +
> +		if (!request_mem_region(res_data->start,
> +					resource_size(res_data),
> +					dev_name(&pdev->dev))) {
> +			err = -EBUSY;
> +			goto out_release_index;
> +		}
> +
> +		priv->io_index = ioremap(res_index->start,
> +					resource_size(res_index));
> +		if (!priv->io_index) {
> +			err = -EIO;
> +			goto out_release_data;
> +		}
> +
> +		priv->io_data = ioremap(res_data->start,
> +					resource_size(res_data));
> +		if (!priv->io_data) {
> +			err = -EIO;
> +			goto out_io_index;
> +		}
> +	} else

Hi Alexander

It would be good to use the devm_ functions here. It will make the
cleanup on error much simpler, solve your warnings problem, and simply
the remove function.


> +		priv->ops = pdev->dev.platform_data;
> +
> +	priv->rtc = rtc_device_register("m48t86",
> +				&pdev->dev, &m48t86_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(priv->rtc)) {
> +		err = PTR_ERR(priv->rtc);
> +		if (!pdev->dev.platform_data)
> +			goto out_io_data;
> +		else
> +			goto out_free;
> +	}
>  
>  	/* read battery status */
> -	reg = ops->readbyte(M48T86_REG_D);
> -	dev_info(&dev->dev, "battery %s\n",
> +	reg = m48t86_rtc_readbyte(&pdev->dev, M48T86_REG_D);
> +	dev_info(&pdev->dev, "battery %s\n",
>  		(reg & M48T86_REG_D_VRT) ? "ok" : "exhausted");
>  
>  	return 0;
> +
> +out_io_data:
> +	iounmap(priv->io_data);
> +out_io_index:
> +	iounmap(priv->io_index);
> +out_release_data:
> +	release_mem_region(res_data->start, resource_size(res_data));
> +out_release_index:
> +	release_mem_region(res_index->start, resource_size(res_index));
> +out_free:
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(priv);
> +	return err;
>  }
>  
> -static int m48t86_rtc_remove(struct platform_device *dev)
> +static int m48t86_rtc_remove(struct platform_device *pdev)
>  {
> -	struct rtc_device *rtc = platform_get_drvdata(dev);
> +	struct resource *res;
> +	struct m48t86_rtc_private_data *priv = platform_get_drvdata(pdev);
> +
> +	if (priv->rtc)
> +		rtc_device_unregister(priv->rtc);
> +
> +	if (priv->io_data) {
> +		iounmap(priv->io_data);
> +		res = platform_get_resource_byname(
> +					pdev, IORESOURCE_MEM, "rtc_data");
> +		release_mem_region(res->start, resource_size(res));
> +	}
> +
> +	if (priv->io_index) {
> +		iounmap(priv->io_index);
> +		res = platform_get_resource_byname(
> +					pdev, IORESOURCE_MEM, "rtc_index");
> +		release_mem_region(res->start, resource_size(res));
> +	}
>  
> - 	if (rtc)
> -		rtc_device_unregister(rtc);
> +	platform_set_drvdata(pdev, NULL);
>  
> -	platform_set_drvdata(dev, NULL);
> +	kfree(priv);
>  
>  	return 0;
>  }
> -- 
> 1.7.10.4
> 
