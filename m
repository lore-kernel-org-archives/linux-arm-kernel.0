From: gregkh@suse.de (Greg KH)
Date: Mon, 17 Oct 2011 09:18:54 -0700
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <1318852378-14180-3-git-send-email-lee.jones@linaro.org>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
	<1318852378-14180-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20111017161854.GB5108@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 12:52:54PM +0100, Lee Jones wrote:
> +void soc_device_unregister(struct device *dev)

Ick, no, pass in the struct soc_device, which the register function
should return, not a "raw" struct device.


> +{
> +	struct soc_device *soc_dev =
> +		container_of(dev, struct soc_device, dev);
> +
> +	sysfs_remove_group(&dev->kobj, &soc_attr_group);
> +
> +	if (device_is_registered(dev))
> +		device_unregister(dev);

Why is this call needed?

> +
> +	bus_unregister(&soc_bus_type);

What happens if you have more than one SOC device?  I think you just
oopsed.

> +
> +	kfree(soc_dev->attr);
> +	kfree(soc_dev);

Nope, you just failed again.  I can tell you never tried this code path,
otherwise you would have noticed the HUGE warnings that the kernel spit
back at you.  Please fix this.

greg k-h
