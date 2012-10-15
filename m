From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 15 Oct 2012 16:57:20 -0700
Subject: [PATCH RFC 02/11 v4] gpio: Add sysfs support to block GPIO API
In-Reply-To: <1350343887-7344-3-git-send-email-stigge@antcom.de>
References: <1350343887-7344-1-git-send-email-stigge@antcom.de>
 <1350343887-7344-3-git-send-email-stigge@antcom.de>
Message-ID: <20121015235720.GA3132@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 01:31:18AM +0200, Roland Stigge wrote:
> +int gpio_block_export(struct gpio_block *block)
> +{
> +	int		status;
> +	struct device	*dev;
> +
> +	/* can't export until sysfs is available ... */
> +	if (!gpio_class.p) {
> +		pr_debug("%s: called too early!\n", __func__);
> +		return -ENOENT;
> +	}
> +
> +	mutex_lock(&sysfs_lock);
> +	dev = device_create(&gpio_class, NULL, MKDEV(0, 0), block,
> +			    block->name);
> +	if (!IS_ERR(dev))
> +		status = sysfs_create_group(&dev->kobj, &gpio_block_attr_group);
> +	else
> +		status = PTR_ERR(dev);
> +	mutex_unlock(&sysfs_lock);

You just raced with userspace telling it that the device was present,
yet the attributes are not there.  Don't do that, use the default class
attributes for the class and then the driver core will create them
automagically without needing to this "by hand" at all.

thanks,

greg k-h
