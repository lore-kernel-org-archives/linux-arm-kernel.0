From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Nov 2011 09:51:02 +0000
Subject: [PATCH] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <1320381143-28621-1-git-send-email-b39297@freescale.com>
References: <1320381143-28621-1-git-send-email-b39297@freescale.com>
Message-ID: <20111104095102.GX12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to Sascha's points...

On Fri, Nov 04, 2011 at 12:32:23PM +0800, wu guoxing wrote:
> +static int mc9s08dz60_remove(struct i2c_client *client)
> +{
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
