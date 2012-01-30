From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jan 2012 08:24:53 +0100
Subject: [PATCH 2/6] mfd: mc13xxx-core: ADC conv: wait_for_completion
 returns a long
In-Reply-To: <1327876408-22528-3-git-send-email-marc@cpdesign.com.au>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
 <1327876408-22528-3-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120130072453.GG6305@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 09:33:24AM +1100, Marc Reilly wrote:
> Use the correct return type for wait_for_completion, as long may be
> larger than int.
That's a theoretical problem only because the return value should be in
the range -ESOMETHING ... HZ which fits into an int.

> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
>  drivers/mfd/mc13xxx-core.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 8cb83ef..afff892 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -513,6 +513,7 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  {
>  	u32 adc0, adc1, old_adc0;
>  	int i, ret;
> +	long timeout;
>  	struct mc13xxx_adcdone_data adcdone_data = {
>  		.mc13xxx = mc13xxx,
>  	};
> @@ -566,20 +567,23 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  			mc13xxx_handler_adcdone, __func__, &adcdone_data);
>  
>  	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC0, adc0);
> -	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC1, adc1);
> +	ret = mc13xxx_reg_write(mc13xxx, MC13XXX_ADC1, adc1);
Is this change intended? I guess without it you get a warning that ret
is used uninitialized, but if mc13xxx_reg_write fails you should IMHO
return at once.
 
>  	mc13xxx_unlock(mc13xxx);
>  
> -	ret = wait_for_completion_interruptible_timeout(&adcdone_data.done, HZ);
> +	timeout = wait_for_completion_interruptible_timeout(&adcdone_data.done, HZ);
>  
> -	if (!ret)
> +	if (timeout <= 0) {
> +		dev_warn(mc13xxx->dev,
> +				"timed out waiting for ADC completion\n");
>  		ret = -ETIMEDOUT;
> +	}
I think this is wrong. wait_for_completion_interruptible_timeout returns
-ERESTARTSYS if it was interrupted. That's not a timeout and
-ERESTARTSYS should be propagated then. !ret is the correct test for
timeout.
>  
>  	mc13xxx_lock(mc13xxx);
>  
>  	mc13xxx_irq_free(mc13xxx, MC13XXX_IRQ_ADCDONE, &adcdone_data);
>  
> -	if (ret > 0)
> +	if (!ret)
This is wrong, too, isn't it?

>  		for (i = 0; i < 4; ++i) {
>  			ret = mc13xxx_reg_read(mc13xxx,
>  					MC13XXX_ADC2, &sample[i]);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
