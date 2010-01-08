From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 8 Jan 2010 22:07:51 +0100
Subject: [PATCH 14/18] ARM: PNX4008: move i2c_adapter structure inside
	the drivers private data
In-Reply-To: <4a57839e2a45ef8dc845d1c35560cc07e64141ac.1262431163.git.rmk+kernel@arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
	<4a57839e2a45ef8dc845d1c35560cc07e64141ac.1262431163.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F804F5ADDEBB@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All these changes in the patch series work on my hardware. A
few comments below, but these can be updated once these changes
are accepted.

>diff --git a/arch/arm/mach-pnx4008/i2c.c b/arch/arm/mach-pnx4008/i2c.c index 33146e8..8103f96 100644
>--- a/arch/arm/mach-pnx4008/i2c.c
>+++ b/arch/arm/mach-pnx4008/i2c.c
...
...
...
>  static struct i2c_pnx_data i2c0_data = {
> -	.adapter = &pnx_adapter0,
> +	.name = I2C_CHIP_NAME "0",
>  	.base = PNX4008_I2C1_BASE,
>  	.irq = I2C_1_INT,
>  };
> 
>  static struct i2c_pnx_data i2c1_data = {
> -	.adapter = &pnx_adapter1,
> +	.name = I2C_CHIP_NAME "1",
>  	.base = PNX4008_I2C2_BASE,
>  	.irq = I2C_2_INT,
>  };
> 
>  static struct i2c_pnx_data i2c2_data = {
> -	.adapter = &pnx_adapter2,
> +	.name = "USB-I2C",
>  	.base = (PNX4008_USB_CONFIG_BASE + 0x300),
>  	.irq = USB_I2C_INT,
>  };

This looks good. 'struct resource' can be used instead of the
specialized i2c_pnx_data structure. The name field can be removed
and the adapter name generically assigned in the driver based on
the .id field in the platform_device structure. (The i2c2 interface
won't have then "USB-I2C" name anymore, but thats really just another
I2C interface, not specific to USB). This would simplify the
platform code and driver a little more and bring it inline with how
all the other platform drivers handle platform data. The REGION_SIZE
macro in the i2c-pnx driver could be swapped out with the platform
data size field instead.

> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 1d66856..4fb6f72 100644
...
...
...
> -	i2c_pnx->adapter->algo_data = alg_data;
> +	strlcpy(alg_data->adapter.name, i2c_pnx->name,
> +		sizeof(alg_data->adapter.name));
> +	alg_data->adapter.dev.parent = &pdev->dev;
> +	alg_data->adapter.algo = &pnx_algorithm;
> +	alg_data->adapter.algo_data = alg_data;
> +	alg_data->adapter.nr = pdev->id;

See my comment below about alg_data->adapter.nr

>  	/* Register this adapter with the I2C subsystem */
> -	i2c_pnx->adapter->dev.parent = &pdev->dev;
> -	i2c_pnx->adapter->nr = pdev->id;
> -	ret = i2c_add_numbered_adapter(i2c_pnx->adapter);
> +	ret = i2c_add_adapter(&alg_data->adapter);
>  	if (ret < 0) {

If i2c_add_numbered_adapter isn't used, the alg_data->adapter.nr value
will be re-assigned in the i2c-core driver. The assigned pdev->id value
would get overwritten by something else, possibly not the same value.
The i2c_register_board_info() function in the platform code would have
to be tweaked for each platform, possibly based on the number of I2C
adapters registered in the system (up to 3 can be used, but 3 aren't
always used).
