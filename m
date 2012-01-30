From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jan 2012 08:27:56 +0100
Subject: [PATCH 4/6] mfd: mc13xxx-core: ADC conv: clear ADC_WORKING flag
 for invalid mode
In-Reply-To: <1327876408-22528-5-git-send-email-marc@cpdesign.com.au>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
 <1327876408-22528-5-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120130072756.GH6305@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 09:33:26AM +1100, Marc Reilly wrote:
> Requesting a conversion for and invalid mode would mean that the
s/and/an/

> MC13XXX_ADC_WORKING flag never gets cleared.
> 
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
>  drivers/mfd/mc13xxx-core.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 56e09ea..61a767d 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -557,8 +557,9 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  		break;
>  
>  	default:
> -		mc13xxx_unlock(mc13xxx);
> -		return -EINVAL;
> +		dev_warn(mc13xxx->dev, "%s: bad ADC mode requested\n", __func__);
> +		ret = -EINVAL;
> +		goto out_flag;
I would prefer this to be named in a more descritive way. Maybe
"out_clear_working"?

Other than that, ack.

Uwe
>  	}
>  
>  	dev_dbg(mc13xxx->dev, "%s: request irq\n", __func__);
> @@ -608,6 +609,7 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  		/* restore TSMOD */
>  		mc13xxx_reg_write(mc13xxx, MC13XXX_ADC0, old_adc0);
>  
> +out_flag:
>  	mc13xxx->adcflags &= ~MC13XXX_ADC_WORKING;
>  out:
>  	mc13xxx_unlock(mc13xxx);
> -- 
> 1.7.3.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
