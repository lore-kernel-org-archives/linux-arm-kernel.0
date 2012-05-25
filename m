From: khilman@ti.com (Kevin Hilman)
Date: Fri, 25 May 2012 15:09:23 -0700
Subject: [PATCHv9 09/10] I2C: OMAP: Do not set the XUDF(Transmit
 underflow) if the underflow is not reached
In-Reply-To: <1335969135-20858-10-git-send-email-shubhrajyoti@ti.com>
 (Shubhrajyoti D.'s message of "Wed, 2 May 2012 20:02:14 +0530")
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
 <1335969135-20858-10-git-send-email-shubhrajyoti@ti.com>
Message-ID: <878vgfkj58.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Currently in the 1.153 errata handling while waiting for transmitter
> underflow if NACK is got the XUDF(Transmit underflow) flag is also set.

-EOVERFLOW

This sentence needs a rewrite and some punctuation.  It does not read well.

> The flag is set after wait for the condition is over.
>
> Cc: Alexander Shishkin <virtuoso@slind.org>
> Acked-by: Moiz Sonasath <m-sonasath@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 43b0efb..c0aa16b 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -730,7 +730,6 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
>  		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
>  			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
>  							OMAP_I2C_STAT_XDR));
> -			*err |= OMAP_I2C_STAT_XUDF;
>  			return -ETIMEDOUT;
>  		}
>  
> @@ -743,6 +742,7 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
>  		return 0;
>  	}
>  
> +	*err |= OMAP_I2C_STAT_XUDF;
>  	return 0;
>  }

Kevin
