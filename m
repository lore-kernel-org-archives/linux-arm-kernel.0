From: B39297@freescale.com (Wu Guoxing-B39297)
Date: Fri, 4 Nov 2011 10:55:49 +0000
Subject: [PATCH] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <20111104095102.GX12913@n2100.arm.linux.org.uk>
References: <1320381143-28621-1-git-send-email-b39297@freescale.com>
	<20111104095102.GX12913@n2100.arm.linux.org.uk>
Message-ID: <3D55990BDF4852409EA769663F22E54AC049B7@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Russell and Sascha for the comments!

I have send out the changed patches for review.

Best Regards
Wu Guoxing

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Friday, November 04, 2011 5:51 PM
To: Wu Guoxing-B39297
Cc: linux-arm-kernel at lists.infradead.org; s.hauer at pengutronix.de; shawn.guo at linaro.org
Subject: Re: [PATCH] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function

In addition to Sascha's points...

On Fri, Nov 04, 2011 at 12:32:23PM +0800, wu guoxing wrote:
> +static int mc9s08dz60_remove(struct i2c_client *client) {
> +	struct gpio_chip *chip;
> +	int ret;
> +
> +	chip = i2c_get_clientdata(client);
> +	if (chip == NULL)
> +		return -ENODEV;
> +
> +	i2c_set_clientdata(client, NULL);
> +
> +	ret = gpiochip_remove(chip);
> +	if (!ret)
> +		kfree(chip);

Two points here:
1. remove functions can't actually fail (their return value is not checked)
   so there's no point returning errors.
2. the remove function for a particular device will only be called after
   a probe for the same device/driver pair has been successful.  As you've
   initialized the i2c client data in the probe function, it should never
   be NULL here.

> +int __init mc9s08dz60_init(void)
> +{
> +	int err;
> +
> +	err = i2c_add_driver(&mc9s08dz60_i2c_driver);
> +	return err;

There's no need for this 'err' variable - just use

	return i2c_add_driver(&mc9s08dz60_i2c_driver);
