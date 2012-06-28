From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jun 2012 11:21:56 +0000
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <1340853214-5429-2-git-send-email-zhouqiao@marvell.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <1340853214-5429-2-git-send-email-zhouqiao@marvell.com>
Message-ID: <201206281121.56769.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 June 2012, Qiao Zhou wrote:
> 88PM800 and 88PM805 are two discrete chips used for power management.
> Hardware designer can use them together or only one of them according to
> requirement.
> 

This looks much better than the first version, great work!

However, there are a few things that you have not addressed from my review
and that you did not explain either. Most importantly, you said that you'd
add support for DT based booting, which is not in this version.

What platform is this driver for?
 - If it's for an existing platform that does not have DT support, please
   include the platform changes for that platform so we can see what gets
   done in there.
 - If it's for a new platform, you should not have any platform data in
   this patch, just device tree based probing because that platform will
   also have to use DT probing in order to get merged. The tree that
   carries such a platform out of the kernel can add back the platform
   data parsing, just don't submit it upstream with the main driver.

> due to hardware design, there are some registers used by pm805, but actually
> defined in pm800 chip. so pm805 needs to access pm800 register in some
> occasion. A workaround is used in driver to solve such issue and would be
> removed when it's fixed in latter new chip version.

I don't see from the code what this is referring to. Can you be a little
more specific? Ideally you would have one patch that adds the driver
without this workaround, followed by a patch that just adds that workaround
with an explanation why it's needed, and then you can later just revert
that patch once it's no longer required.

> All I2C operations are accessed by 80x-i2c driver, and register access is via
> regmap interface.
> 
> The benefit is that client drivers only need one kind of read/write API. I2C
> and MFD driver can be shared in both 800 and 805.

I'm not sure what the purpose of this split is. Usually you only separate out
the i2c parts if the same driver has multiple host-side interfaces, e.g. i2c
and spi. If your driver only has one of them, it's easier to just have one
file. Using regmap however seems to be a good idea nonetheless.

I would also suggest you consider splitting the driver into three separate
parts after moving the i2c file into the core file:

a) one "library" that contains the common code and exports symbols
b) one driver for 805 that contains just the 805 specific parts and
   registers the i2c driver for 805
c) one driver for 800 that contains just the 800 specific parts and
   registers the i2c driver for 800

Does that sound reasonable?

There is very little common that is actually part of the 88pm80x_common
file, everything else is specific to just one of the variants. The only common
parts I found are device_irq_init_80x and device_irq_exit_80x, and
even for those I'm not sure if it wouldn't be easier to just
have separate functions.

The common parts seem to be mostly in your current _i2c.c file, so that could
instead become the common file when you split 805 from 800. You basically
just export the pm_ops and the probe/remove functions and let that be called
from the individual drivers.

> +	if (pdata->pm80x_plat_config)
> +		pdata->pm80x_plat_config(chip, pdata);

You should definitely remove these callbacks, as I pointed out in the
initial review.

> +int __devinit pm80x_device_init(struct pm80x_chip *chip,
> +				struct pm80x_platform_data *pdata)
> +{
> +	int ret = 0;
> +
> +	switch (chip->id) {
> +	case CHIP_PM800:
> +		ret = device_800_init(chip, chip->client, pdata);
> +		break;
> +	case CHIP_PM805:
> +		ret = device_805_init(chip, chip->client, pdata);
> +		break;
> +	default:
> +		dev_err(chip->dev, "%s incorrect chip id!\n", __func__);
> +		return -EINVAL;
> +	}

It seems strange that you access the i2c_client in the common file,
rather than just working with the regmap.


> diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
> new file mode 100644
> index 0000000..9e2e11d
> --- /dev/null

A lot of the contents of this file should not really be globally visible.
Most of the register definitions are just used by the common mfd driver,
so I would put them in a header file in the mfd directory or (even better)
just into the .c file that uses them.


	Arnd
