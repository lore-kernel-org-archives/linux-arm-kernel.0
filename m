From: jk@ozlabs.org (Jeremy Kerr)
Date: Fri, 9 Dec 2016 15:12:05 +1100
Subject: [PATCH 16/16] drivers/fsi: Add GPIO based FSI master
In-Reply-To: <1481069677-53660-17-git-send-email-christopher.lee.bostic@gmail.com>
References: <1481069677-53660-1-git-send-email-christopher.lee.bostic@gmail.com>
 <1481069677-53660-17-git-send-email-christopher.lee.bostic@gmail.com>
Message-ID: <6a39f4d9-0f20-a146-3122-86d3f75c58fa@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

> +static ssize_t store_scan(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t count)
> +{
> +	struct fsi_master_gpio *master = dev_get_drvdata(dev);
> +
> +	fsi_master_gpio_init(master);
> +
> +	/* clear out any old scan data if present */
> +	fsi_master_unregister(&master->master);
> +	fsi_master_register(&master->master);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(scan, 0200, NULL, store_scan);

I think it would make more sense to have the scan attribute populated by
the fsi core; we want this on all masters, not just GPIO.

Currently, the only GPIO-master-specific functionality here is the
fsi_master_gpio_init() - but isn't this something that we can do at
probe time instead?

> +static int fsi_master_gpio_probe(struct platform_device *pdev)
> +{
> +	struct fsi_master_gpio *master;
> +	struct gpio_desc *gpio;
> +
> +	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
> +	if (!master)
> +		return -ENOMEM;

We should be populating master->dev.parent, see

  https://github.com/jk-ozlabs/linux/commit/5225d6c47


> +	/* Optional pins */
> +
> +	gpio = devm_gpiod_get(&pdev->dev, "trans", 0);
> +	if (IS_ERR(gpio))
> +		dev_dbg(&pdev->dev, "probe: failed to get trans pin\n");
> +	else
> +		master->gpio_trans = gpio;

I found devm_gpiod_get_optional(), which might make this a little
neater.

Cheers,


Jeremy
