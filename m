From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 15:21:49 +0000
Subject: [PATCH 1/2] ARM: sa11x0: Implement autoloading of codec and
 codec pdata for mcp bus.
In-Reply-To: <1322427655-914-1-git-send-email-jochen@scram.de>
References: <1322427655-914-1-git-send-email-jochen@scram.de>
Message-ID: <20120118152149.GI1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2011 at 10:00:54PM +0100, Jochen Friedrich wrote:

No commit log.

Do you actually have a platform which connects something other than a
UCB1x00 to the MCP, or are you just fiddling about in this code making
changes only to 'bring it up to latest standards' but without any real
purpose?

> diff --git a/arch/arm/mach-sa1100/include/mach/mcp.h b/arch/arm/mach-sa1100/include/mach/mcp.h
> index ed1a331..586cec8 100644
> --- a/arch/arm/mach-sa1100/include/mach/mcp.h
> +++ b/arch/arm/mach-sa1100/include/mach/mcp.h
> @@ -17,6 +17,8 @@ struct mcp_plat_data {
>  	u32 mccr1;
>  	unsigned int sclk_rate;
>  	int gpio_base;

This was added with the addition of GPIO, but now doesn't seem to be used
after your patch.

> diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
> index b281217..91c4f25 100644
> --- a/drivers/mfd/ucb1x00-core.c
> +++ b/drivers/mfd/ucb1x00-core.c
> @@ -36,6 +36,15 @@ static DEFINE_MUTEX(ucb1x00_mutex);
>  static LIST_HEAD(ucb1x00_drivers);
>  static LIST_HEAD(ucb1x00_devices);
>  
> +static struct mcp_device_id ucb1x00_id[] = {
> +	{ "ucb1x00", 0 },  /* auto-detection */
> +	{ "ucb1200", UCB_ID_1200 },
> +	{ "ucb1300", UCB_ID_1300 },
> +	{ "tc35143", UCB_ID_TC35143 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(mcp, ucb1x00_id);
> +
>  /**
>   *	ucb1x00_io_set_dir - set IO direction
>   *	@ucb: UCB1x00 structure describing chip
> @@ -527,17 +536,33 @@ static struct class ucb1x00_class = {
>  
>  static int ucb1x00_probe(struct mcp *mcp)
>  {
> +	const struct mcp_device_id *mid;
>  	struct ucb1x00 *ucb;
>  	struct ucb1x00_driver *drv;
> +	struct ucb1x00_plat_data *pdata;
>  	unsigned int id;
>  	int ret = -ENODEV;
>  	int temp;
>  
>  	mcp_enable(mcp);
>  	id = mcp_reg_read(mcp, UCB_ID);
> +	mid = mcp_get_device_id(mcp);
>  
> -	if (id != UCB_ID_1200 && id != UCB_ID_1300 && id != UCB_ID_TC35143) {
> -		printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
> +	if (mid && mid->driver_data) {
> +		if (id != mid->driver_data) {
> +			printk(KERN_WARNING "%s wrong ID %04x found: %04x\n",
> +				mid->name, (unsigned int) mid->driver_data, id);
> +			goto err_disable;
> +		}
> +	} else {
> +		mid = &ucb1x00_id[1];
> +		while (mid->driver_data) {
> +			if (id == mid->driver_data)
> +				break;
> +			mid++;
> +		}
> +		printk(KERN_WARNING "%s ID not found: %04x\n",
> +			ucb1x00_id[0].name, id);

Why do we need this complexity when we can detect the device from its
ID in hardware?  This, to me, is just code for the sake of code.

I'm far from impressed by this patch, and had it not already gone in,
I'd be NAKing it.
