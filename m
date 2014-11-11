From: vigneshr@ti.com (R, Vignesh)
Date: Tue, 11 Nov 2014 15:26:19 +0000
Subject: [PATCH v3 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
In-Reply-To: <20141111122623.GA24004@x1>
References: <1415694844-11230-1-git-send-email-vigneshr@ti.com>
 <1415694844-11230-4-git-send-email-vigneshr@ti.com>
 <20141111122623.GA24004@x1>
Message-ID: <71C24A547111EA4E84AE759B748D9EAE4B976C@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 11 Nov 2014, Vignesh R wrote:

> In one shot mode, sequencer automatically disables all enabled steps 
> at the end of each cycle. (both ADC steps and TSC steps) Hence these 
> steps need not be saved in reg_se_cache for clearing these steps at a 
> later stage.
> Also, when ADC wakes up Sequencer should not be busy executing any of 
> the config steps except for the charge step. Previously charge step 
> was 1 ADC clock cycle and hence it was ignored.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---

You need to provide a changelog here when submitting new versions.

I have included changelog in the cover page. Will include them in 
individual patches next time.

>  drivers/mfd/ti_am335x_tscadc.c       | 7 +++++--
>  include/linux/mfd/ti_am335x_tscadc.h | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c 
> b/drivers/mfd/ti_am335x_tscadc.c index d877e777cce6..110038859a8d 
> 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -86,8 +86,12 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tsadc)
>  		spin_lock_irq(&tsadc->reg_lock);
>  		finish_wait(&tsadc->reg_se_wait, &wait);
>  
> +		/*
> +		 * Sequencer should either be idle or
> +		 * busy applying the charge step.
> +		 */
>  		reg = tscadc_readl(tsadc, REG_ADCFSM);
> -		WARN_ON(reg & SEQ_STATUS);
> +		WARN_ON((reg & SEQ_STATUS) && !(reg & CHARGE_STEP));
>  		tsadc->adc_waiting = false;
>  	}
>  	tsadc->adc_in_use = true;
> @@ -96,7 +100,6 @@ static void am335x_tscadc_need_adc(struct 
> ti_tscadc_dev *tsadc)  void am335x_tsc_se_set_once(struct 
> ti_tscadc_dev *tsadc, u32 val)  {
>  	spin_lock_irq(&tsadc->reg_lock);
> -	tsadc->reg_se_cache |= val;

You didn't answer my question about this?
I did reply to the question in the previous thread.  

Previously, TSC did not reliably re-enable its steps as the TSC irq handler received 
false pen up events. Hence, in order to use TSC after ADC operation, it was necessary to
 save and re-enable TSC steps (basically, to keep TSC steps enabled always).
The change was more of a workaround to overcome limitation of TSC irq handler. With 
this series of patches, TSC irq handler is very reliable and the workaround is no longer required.

>  	am335x_tscadc_need_adc(tsadc);
>  
>  	tscadc_writel(tsadc, REG_SE, val);
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h 
> b/include/linux/mfd/ti_am335x_tscadc.h
> index c99be5dc0f5c..fcce182e4a35 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -128,6 +128,7 @@
>  
>  /* Sequencer Status */
>  #define SEQ_STATUS BIT(5)
> +#define CHARGE_STEP		0x11
>  
>  #define ADC_CLK			3000000
>  #define TOTAL_STEPS		16

--
Lee Jones
Linaro STMicroelectronics Landing Team Lead Linaro.org ? Open source software for ARM SoCs Follow Linaro: Facebook | Twitter | Blog
