From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Jul 2013 13:43:05 +0200
Subject: [PATCH 5/5] iio: at91: introduce touch screen support in iio adc
 driver
In-Reply-To: <51E50DCC.4010107@atmel.com>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-6-git-send-email-josh.wu@atmel.com>
 <20130715131507.GE2962@lukather> <51E50DCC.4010107@atmel.com>
Message-ID: <20130716114305.GD3125@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Tue, Jul 16, 2013 at 05:09:32PM +0800, Josh Wu wrote:
> On 7/15/2013 9:15 PM, Maxime Ripard wrote:
> >Hi Josh,
> >
> >On Sun, Jul 14, 2013 at 04:04:29PM +0800, Josh Wu wrote:
> >>AT91 ADC hardware integrate touch screen support. So this patch add touch
> >>screen support for at91 adc iio driver.
> >>To enable touch screen support in adc, you need to add the dt parameters:
> >>   which type of touch are used? (4 or 5 wires), sample period time,
> >>   pen detect debounce time, average samples and pen detect resistor.
> >>
> >>In the meantime, since touch screen will use a interal period trigger of adc,
> >>so it is conflict to other hardware triggers. Driver will disable the hardware
> >>trigger support if touch screen is enabled.
> >>
> >>This driver has been tested in AT91SAM9X5-EK and SAMA5D3x-EK.
> >>
> >>Signed-off-by: Josh Wu <josh.wu@atmel.com>
> >>Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>---
> >>  .../devicetree/bindings/arm/atmel-adc.txt          |   13 +
> >>  arch/arm/mach-at91/include/mach/at91_adc.h         |   34 ++
> >>  drivers/iio/adc/at91_adc.c                         |  389 ++++++++++++++++++--
> >>  3 files changed, 412 insertions(+), 24 deletions(-)
> >>
> >>diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> >>index 0db2945..925d656 100644
> >>--- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> >>+++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> >>@@ -29,6 +29,19 @@ Optional properties:
> >>    - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
> >>    - atmel,adc-clock-rate: ADC clock rate. If not specified, use the default
> >>  			  adc_op_clk.
> >>+  - atmel,adc-touchscreen-wires: Number of touch screen wires. Only support
> >>+				 4 and 5 wires touch screen.
> >>+    NOTE: when adc touch screen enabled, the adc hardware trigger will be
> >>+          disabled. Since touch screen will occupied the trigger register.
> >>+  - atmel,adc-ts-pendet-debounce: Debounce time in microsecond for touch pen
> >>+				  detect.
> >>+  - atmel,adc-ts-sample-period-time: Sample Period Time in microsecond for
> >>+				     touch screen
> >>+  - atmel,adc-ts-filter-average: Numbers of sampling data will be averaged.
> >>+    0 means no average. 1 means average two samples. 2 means average four
> >>+    samples. 3 means average eight samples.
> >>+  - atmel,adc-ts-pendet-sensitivity: Pen Detection input pull-up resistor.
> >>+    It can be 0, 1, 2, 3.
> >Could you expand a bit on what are these properties for? Are they
> >board-specific? IP-specific?
> 
> +  - atmel,adc-touchscreen-wires: Number of touch screen wires. Only support
> +                 4 and 5 wires touch screen.
> +    NOTE: when adc touch screen enabled, the adc hardware trigger will be
> +          disabled. Since touch screen will occupied the trigger register.
> 
> It is board specific. Currently in AT91SAM9M10G45EK, AT91SAM9X5-EK,
> SAMA5D3x-EK all use 4 wire touch.
> Now the driver not support 5 wire yet.

I see, maybe you should add this in the documentation then

> +  - atmel,adc-ts-pendet-debounce: Debounce time in microsecond for
> touch pen
> +                  detect.
> 
> de-glitch time for pen detect. Board specific.
> 
> +  - atmel,adc-ts-sample-period-time: Sample Period Time in microsecond for
> +                     touch screen
> 
> The period to sample a touch data after pen is touched. Board specific.
> 
> +  - atmel,adc-ts-filter-average: Numbers of sampling data will be averaged.
> +    0 means no average. 1 means average two samples. 2 means average four
> +    samples. 3 means average eight samples.
> +  - atmel,adc-ts-pendet-sensitivity: Pen Detection input pull-up resistor.
> +    It can be 0, 1, 2, 3.
> 
> Above two properties only supported in SAM9X5, SAMA5D3 IP.

Ok, that should go to the documentation as well. What do the values of
atmel,adc-ts-pendet-sensitivity correspond to?

> >>@@ -104,14 +140,10 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
> >>  	return IRQ_HANDLED;
> >>  }
> >>-static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
> >>+/* Handler for classic adc channel eoc trigger */
> >>+void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
> >>  {
> >>-	struct iio_dev *idev = private;
> >>  	struct at91_adc_state *st = iio_priv(idev);
> >>-	u32 status = at91_adc_readl(st, st->registers->status_register);
> >>-
> >>-	if (!(status & st->registers->drdy_mask))
> >>-		return IRQ_HANDLED;
> >Why are you changing the prototype and remove most of the useful part
> >out of the handler?
> 
> I change the protype because I make it as a sub interrupt handler.
> Since I just add a new interrupt handler which will check the
> interrupt type, if DRDY interrupt is coming, it will call your
> original handler.
> Otherwise use touch screen interrupt handler code.
> 
> Following is the new interrupt handler code in this patch:
> 
> +static irqreturn_t at91_adc_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct at91_adc_state *st = iio_priv(idev);
> +	u32 status = at91_adc_readl(st, st->registers->status_register);
> +	const uint32_t ts_data_irq_mask =
> +		AT91_ADC_IER_XRDY |
> +		AT91_ADC_IER_YRDY |
> +		AT91_ADC_IER_PRDY;
> +
> +	if (status & st->registers->drdy_mask)
> +		handle_adc_eoc_trigger(irq, idev);
> 
>                              ^
>                              |
> here we call original trigger handler.
> 
> +
> +	if (status & AT91_ADC_IER_PEN) {
> +		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_PEN);
> +		at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_NOPEN |
> +			ts_data_irq_mask);
> +		/* Set up period trigger for sampling */
> +		at91_adc_writel(st, st->registers->trigger_register,
> +			AT91_ADC_TRGR_MOD_PERIOD_TRIG |
> +			AT91_ADC_TRGR_TRGPER_(st->ts_sample_period_val));
> +	} else if (status & AT91_ADC_IER_NOPEN) {
> +		at91_adc_writel(st, st->registers->trigger_register, 0);
> +		at91_adc_writel(st, AT91_ADC_IDR, AT91_ADC_IER_NOPEN |
> +			ts_data_irq_mask);
> +		at91_adc_writel(st, AT91_ADC_IER, AT91_ADC_IER_PEN);
> +
> +		input_report_key(st->ts_input, BTN_TOUCH, 0);
> +		input_sync(st->ts_input);
> +	} else if ((status & ts_data_irq_mask) == ts_data_irq_mask) {
> 
> Those code will handle for the Touch screen interrupt.

Ah, right.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/ccb648f8/attachment.sig>
