From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Nov 2011 15:40:22 +0100
Subject: [PATCH] mfd: fixed mixed up ADC single channel readout
In-Reply-To: <1322132295-7511-1-git-send-email-robin@protonic.nl>
References: <1322132295-7511-1-git-send-email-robin@protonic.nl>
Message-ID: <20111124144022.GA19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 11:58:15AM +0100, Robin van der Gracht wrote:
> In single channel mode, when reading the ADC result, the index value
> is still set to the channel selected for this reading.
> This mixes up the order of the values returned. This causes problems when
> the converted results are made available in pairs (i.e. battery current reading)
> To straighten this up, the index value needs to be reset, so that the
> converted values are read at the assigned channel.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> ---
>  drivers/mfd/mc13xxx-core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index e6bb4b3..3582f15 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -650,6 +650,10 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  
>  	mc13xxx_lock(mc13xxx);
>  
> +	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC1, &adc1);
> +	adc1 &= ~(0x7 << MC13XXX_ADC1_CHAN0_SHIFT);
> +	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC1, adc1);
> +
I didn't completely understood what is exact the problem, but I wonder
if you don't also need 0x7 << MC13XXX_ADC1_CHAN1_SHIFT.

Best regards
Uwe

>  	mc13xxx_irq_free(mc13xxx, MC13XXX_IRQ_ADCDONE, &adcdone_data);
>  
>  	if (ret > 0)
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
