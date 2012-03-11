From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 11 Mar 2012 10:33:21 +0100
Subject: [PATCH v2 1/3] mfd: mc13xxx-core: Prepare for separate spi and
 i2c backends.
In-Reply-To: <1331429402-9639-2-git-send-email-marc@cpdesign.com.au>
References: <1331429402-9639-1-git-send-email-marc@cpdesign.com.au>
 <1331429402-9639-2-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120311093321.GK14173@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 12:30:00PM +1100, Marc Reilly wrote:
> This patch abstracts the bus specific operations from the driver core.
> Read and write handlers are introduced and generic initialization is
> consolidated into mc13xxx_comon_init. The irq member is removed because
s/_comon_/_common_/

one minor nitpick below.

> it is unused.
> 
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
>  drivers/mfd/mc13xxx-core.c |  162 ++++++++++++++++++++++++++------------------
>  1 files changed, 97 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 7122386..19d94a1 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -235,6 +234,34 @@ int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
>  
>  	return 0;
>  }
> +
> +int mc13xxx_reg_read(struct mc13xxx *mc13xxx, unsigned int offset, u32 *val)
> +{
> +	int ret;
> +
> +	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> +
> +	if (offset > MC13XXX_NUMREGS)
> +		return -EINVAL;
> +
> +	ret = mc13xxx->read_dev(mc13xxx, offset, val);
> +	dev_vdbg(mc13xxx->dev, "[0x%02x] -> 0x%06x\n", offset, *val);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mc13xxx_reg_read);
> +
> +int mc13xxx_reg_write(struct mc13xxx *mc13xxx, unsigned int offset, u32 val)
> +{
> +	BUG_ON(!mutex_is_locked(&mc13xxx->lock));
> +
> +	dev_vdbg(mc13xxx->dev, "[0x%02x] <- 0x%06x\n", offset, val);
> +
> +	if (offset > MC13XXX_NUMREGS || val > 0xffffff)
> +		return -EINVAL;
> +
> +	return mc13xxx->write_dev(mc13xxx, offset, val);
> +}
>  EXPORT_SYMBOL(mc13xxx_reg_write);
>  
>  int mc13xxx_reg_rmw(struct mc13xxx *mc13xxx, unsigned int offset,
> @@ -439,7 +466,7 @@ static int mc13xxx_irq_handle(struct mc13xxx *mc13xxx,
>  			if (handled == IRQ_HANDLED)
>  				num_handled++;
>  		} else {
> -			dev_err(&mc13xxx->spidev->dev,
> +			dev_err(mc13xxx->dev,
>  					"BUG: irq %u but no handler\n",
Without having counted I think you can join these two lines.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
