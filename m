From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 05 Jun 2014 11:27:37 +0100
Subject: [PATCH 5/7] i2c: Make I2C ID tables non-mandatory for DT'ed
 and/or ACPI'ed devices
In-Reply-To: <1401883796-17841-6-git-send-email-lee.jones@linaro.org>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20140605102737.4ED08C40A4D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  4 Jun 2014 13:09:54 +0100, Lee Jones <lee.jones@linaro.org> wrote:
> Currently the I2C framework insists on devices supplying an I2C ID
> table.  Many of the devices which do so unnecessarily adding quite a
> few wasted lines to kernel code.  This patch allows drivers a means
> to 'not' supply the aforementioned table and match on either DT
> and/or ACPI match tables instead.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks okay to me. I've not applied or tested in any way though.

Acked-by: Grant Likely <grant.likely@linaro.org>

> ---
>  drivers/i2c/i2c-core.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index e8c2cba..71970da 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -100,7 +100,7 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
>  
>  
>  	/* Attempt an OF style match */
> -	if (of_driver_match_device(dev, drv))
> +	if (i2c_of_match_device(drv->of_match_table, dev))
>  		return 1;
>  
>  	/* Then ACPI style match */
> @@ -268,7 +268,18 @@ static int i2c_device_probe(struct device *dev)
>  		return 0;
>  
>  	driver = to_i2c_driver(dev->driver);
> -	if (!driver->probe || !driver->id_table)
> +	if (!driver->probe)
> +		return -EINVAL;
> +
> +	/*
> +	 * An I2C ID table is not mandatory, if and only if, a suitable Device
> +	 * Tree and/or ACPI match table entry is supplied for the probing
> +	 * device.
> +	 *
> +	 * TODO: Provide 'device type' to 'ACPI node' call and match here.
> +	 */
> +	if (!driver->id_table &&
> +	    !i2c_of_match_device(dev->driver->of_match_table, dev))
>  		return -ENODEV;
>  
>  	if (!device_can_wakeup(&client->dev))
> -- 
> 1.8.3.2
> 
