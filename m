From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Aug 2012 21:42:04 +0100
Subject: [PATCH v2] serial: pl011: honour serial aliases in device tree
In-Reply-To: <1345564094-16565-1-git-send-email-matthew.leach@arm.com>
References: <1345564094-16565-1-git-send-email-matthew.leach@arm.com>
Message-ID: <20120821204204.GA8316@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthew,

On Tue, Aug 21, 2012 at 04:48:14PM +0100, Matthew Leach wrote:
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index d3553b5..33c90f6 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -52,6 +52,8 @@
>  #include <linux/scatterlist.h>
>  #include <linux/delay.h>
>  #include <linux/types.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/sizes.h>
>  
> @@ -1869,6 +1871,38 @@ static struct uart_driver amba_reg = {
>  	.cons			= AMBA_CONSOLE,
>  };
>  
> +static int pl011_probe_dt_alias(int index, struct device *dev)
> +{
> +	struct device_node *np;
> +	static bool seen_dev_with_alias = false;
> +	static bool seen_dev_without_alias = false;
> +	int ret = index;
> +
> +	if (!IS_ENABLED(CONFIG_OF))
> +		return index;

May as well return ret here for consistency. With that:

Reviewed-by: Will Deacon <will.deacon@arm.com>

I guess this goes via Greg's tree rather than the ARM one?

Will
