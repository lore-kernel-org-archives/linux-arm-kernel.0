From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Nov 2014 15:05:26 +0000
Subject: [PATCH 2/4] input: touchscreen: ti_am335x_tsc: Remove udelay in
 interrupt handler
In-Reply-To: <1414408111-2631-3-git-send-email-vigneshr@ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <1414408111-2631-3-git-send-email-vigneshr@ti.com>
Message-ID: <20141103150526.GI4538@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Oct 2014, Vignesh R wrote:
> From: Brad Griffis <bgriffis@ti.com>
> 
> TSC interrupt handler had udelay to avoid reporting of false pen-up
> interrupt to user space. This patch implements workaround suggesting in
> Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay
> and touchscreen lag. This also improves performance of touchscreen and
> eliminates sudden jump of cursor at touch release.
> 
> IDLECONFIG and CHARGECONFIG registers are to be configured
> with same values in order to eliminate false pen-up events. This
> workaround may result in false pen-down to be detected, hence considerable
> charge step delay needs to be added. The charge delay is set to 0xB000
> (in terms of ADC clock cycles) by default.
> 
> TSC steps are disabled at the end of every sampling cycle and EOS bit is
> set. Once the EOS bit is set, the TSC steps need to be re-enabled to begin
> next sampling cycle.
> 
> In one shot mode, sequencer automatically disables all enabled steps at
> the end of each cycle. (both ADC steps and TSC steps) Hence these steps
> need not be saved in reg_se_cache for clearing these steps at a later
> stage.
> 
> Signed-off-by: Brad Griffis <bgriffis@ti.com>
> [vigneshr at ti.com: Ported patch from v3.12 to v3.18rc2]
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 56 ++++++++++++-------------------
>  drivers/mfd/ti_am335x_tscadc.c            |  7 ++--
>  include/linux/mfd/ti_am335x_tscadc.h      |  4 ++-
>  3 files changed, 30 insertions(+), 37 deletions(-)

[...]

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index d877e777cce6..94ef8992f46b 100644
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
> +		WARN_ON(reg & SEQ_STATUS & (!CHARGE_STEP));
>  		tsadc->adc_waiting = false;
>  	}
>  	tsadc->adc_in_use = true;
> @@ -96,7 +100,6 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tsadc)
>  void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
>  {
>  	spin_lock_irq(&tsadc->reg_lock);
> -	tsadc->reg_se_cache |= val;
>  	am335x_tscadc_need_adc(tsadc);
>  
>  	tscadc_writel(tsadc, REG_SE, val);

I believe all of these changes can, and therefor should live in a
separate patch.

> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index e2e70053470e..fcce182e4a35 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -52,6 +52,7 @@
>  
>  /* IRQ enable */
>  #define IRQENB_HW_PEN		BIT(0)
> +#define IRQENB_EOS		BIT(1)
>  #define IRQENB_FIFO0THRES	BIT(2)
>  #define IRQENB_FIFO0OVRRUN	BIT(3)
>  #define IRQENB_FIFO0UNDRFLW	BIT(4)
> @@ -107,7 +108,7 @@
>  /* Charge delay */
>  #define CHARGEDLY_OPEN_MASK	(0x3FFFF << 0)
>  #define CHARGEDLY_OPEN(val)	((val) << 0)
> -#define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(1)
> +#define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(0xB000)
>  
>  /* Control register */
>  #define CNTRLREG_TSCSSENB	BIT(0)
> @@ -127,6 +128,7 @@
>  
>  /* Sequencer Status */
>  #define SEQ_STATUS BIT(5)
> +#define CHARGE_STEP		0x11
>  
>  #define ADC_CLK			3000000
>  #define TOTAL_STEPS		16

The header changes should be split between the two Input and MFD
patches.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
