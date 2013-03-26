From: jhovold@gmail.com (Johan Hovold)
Date: Tue, 26 Mar 2013 20:27:13 +0100
Subject: [PATCH] rtc: rtc-at91rm9200: use a variable for storing IMR
In-Reply-To: <1363369032-12639-1-git-send-email-nicolas.ferre@atmel.com>
References: <1363369032-12639-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20130326192713.GA31628@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 06:37:12PM +0100, Nicolas Ferre wrote:
> On some revisions of AT91 SoCs, the RTC IMR register is not working.
> Instead of elaborating a workaround for that specific SoC or IP version,
> we simply use a software variable to store the Interrupt Mask Register and
> modify it for each enabling/disabling of an interrupt. The overhead of this
> is negligible anyway.

The patch does not add any memory barriers or register read-backs when
manipulating the interrupt-mask variable. This could possibly lead to
spurious interrupts both when enabling and disabling the various
RTC-interrupts due to write reordering and bus latencies.

Has this been considered? And is this reason enough for a more targeted
work-around so that the SOCs with functional RTC_IMR are not affected?

> Reported-by: Douglas Gilbert <dgilbert@interlog.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/rtc/rtc-at91rm9200.c | 50 +++++++++++++++++++++++++++-----------------
>  drivers/rtc/rtc-at91rm9200.h |  1 -
>  2 files changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index 79233d0..29b92e4 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -46,6 +46,7 @@ static DECLARE_COMPLETION(at91_rtc_updated);
>  static unsigned int at91_alarm_year = AT91_RTC_EPOCH;
>  static void __iomem *at91_rtc_regs;
>  static int irq;
> +static u32 at91_rtc_imr;
>  
>  /*
>
> * Decode time/date into rtc_time structure

[...]

> @@ -198,9 +203,12 @@ static int at91_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>  
>  	if (enabled) {
>  		at91_rtc_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
> +		at91_rtc_imr |= AT91_RTC_ALARM;

wmb() needed before enabling interrupt as at91_rtc_write() uses
__raw_writel() which does not add any barriers?

>  		at91_rtc_write(AT91_RTC_IER, AT91_RTC_ALARM);
> -	} else
> +	} else {
>  		at91_rtc_write(AT91_RTC_IDR, AT91_RTC_ALARM);

wmb() and register read-back needed before updating interrupt mask?

> +		at91_rtc_imr &= ~AT91_RTC_ALARM;
> +	}
>  
>  	return 0;
> }

[...]

> @@ -229,7 +235,7 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
>  	unsigned int rtsr;
>  	unsigned long events = 0;
>  
> -	rtsr = at91_rtc_read(AT91_RTC_SR) & at91_rtc_read(AT91_RTC_IMR);
> +	rtsr = at91_rtc_read(AT91_RTC_SR) & at91_rtc_imr;

Does at91_rtc_imr necessarily match the hardware state here?

>  	if (rtsr) {		/* this interrupt is shared!  Is it ours? */
>  		if (rtsr & AT91_RTC_ALARM)
>  			events |= (RTC_AF | RTC_IRQF);

Johan
