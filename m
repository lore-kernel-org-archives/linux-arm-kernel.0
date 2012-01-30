From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jan 2012 08:15:02 +0100
Subject: [PATCH 1/6] mfd: mc13xxx-core: ADC conv: ack existing pending
 irqs before requesting
In-Reply-To: <1327876408-22528-2-git-send-email-marc@cpdesign.com.au>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
 <1327876408-22528-2-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120130071502.GF6305@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 09:33:23AM +1100, Marc Reilly wrote:
> This acks any existing pending ADCDONE irqs before requesting one for the
> new conversion, rather than after.
> 
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
>  drivers/mfd/mc13xxx-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 1fd265d..8cb83ef 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -561,9 +561,9 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  	}
>  
>  	dev_dbg(mc13xxx->dev, "%s: request irq\n", __func__);
> +	mc13xxx_irq_ack(mc13xxx, MC13XXX_IRQ_ADCDONE);
>  	mc13xxx_irq_request(mc13xxx, MC13XXX_IRQ_ADCDONE,
>  			mc13xxx_handler_adcdone, __func__, &adcdone_data);
> -	mc13xxx_irq_ack(mc13xxx, MC13XXX_IRQ_ADCDONE);
>  
>  	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC0, adc0);
>  	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC1, adc1);
hmm, I wonder if the irq should be acked if it's not requested. The code
doesn't do error checking, but consider mc13xxx_irq_request fails
because the irq is already requested by someone else. Then acking before
requesting is wrong, isn't it? Maybe irq_request should ack the irq or
maybe better introduce a function mc13xxx_irq_request_and_ack that acks
only if the request part is OK?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
