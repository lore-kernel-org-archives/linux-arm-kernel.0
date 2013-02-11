From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Feb 2013 11:00:56 +0000
Subject: [PATCH 12/12] clocksource: samsung-time: Add Device Tree support
In-Reply-To: <1360502423-2246-13-git-send-email-tomasz.figa@gmail.com>
References: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
 <1360502423-2246-13-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130211110056.GC32455@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 01:20:23PM +0000, Tomasz Figa wrote:
> This patch adds support for parsing all platform-specific data from
> Device Tree and instantiation using clocksource_of_init to samsung-time
> clocksource driver.
> 
> Cc: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  .../devicetree/bindings/arm/samsung-timer.txt      |  32 +++++++
>  drivers/clocksource/samsung-time.c                 | 102 ++++++++++++++++++++-
>  2 files changed, 131 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung-timer.txt b/Documentation/devicetree/bindings/arm/samsung-timer.txt
> new file mode 100644
> index 0000000..8eb7030
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/samsung-timer.txt
> @@ -0,0 +1,32 @@
> +* Samsung PWM timer
> +
> +Samsung SoCs contain PWM timer blocks which can be used for system clock source
> +and clock event timers.
> +
> +Be aware that this configuration is supported only on uniprocessor platforms.
> +For SMP SoCs, SMP-aware timers should be used, like MCT.
> +
> +Required properties:
> +- compatible : should be one of following:
> +    samsung,s3c24xx-pwm-timer - for 16-bit timers present on S3C24xx
> +    samsung,s3c64xx-pwm-timer - for 32-bit timers present on S3C64xx and newer
> +- reg: base address and size of register area
> +- interrupts: interrupt list for all five PWM timers.

Is this a set of combined interrupts, or one per timer?

Which order are they in?

Assuming they're one per timer, in order, how about something like:

"- interrupts: one interrupt per timer, starting at timer 0".

> +- samsung,source-timer: index of timer to be used as clocksource
> +- samsung,event-timer: index of timer to be used as clock event

Is there any reason this needs to be specified in the dt?

Can the driver not just select two arbitrary timers from the hardware?

> +
> +Optional properties:
> +- samsung,prescale: PWM prescaler divisor (from 1 to 256)

It might be better to have this named "samsung,prescale-divisor" to make it
clear to the average reader that its a divisor value rather than a
multiplier value.

> +- samsung,divisor: PWM main divider divisor (1, 2, 4, 8 or 16)
> +
> +Example:
> +	timer at 7f006000 {
> +		compatible = "samsung,s3c64xx-pwm-timer";
> +		reg = <0x7f006000 0x1000>;
> +		interrupt-parent = <&vic0>;
> +		interrupts = <23>, <24>, <25>, <27>, <28>;
> +		samsung,source-timer = <4>;
> +		samsung,event-timer = <3>;
> +		samsung,prescale = <2>;
> +		samsung,divisor = <1>;
> +	};
> diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
> index 19a1c8a..63d2992 100644
> --- a/drivers/clocksource/samsung-time.c
> +++ b/drivers/clocksource/samsung-time.c
> @@ -14,6 +14,9 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/clockchips.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/samsung-time.h>
>  
> @@ -479,9 +482,11 @@ static void __init samsung_timer_resources(void)
>  	unsigned long source_id = timer_source.source_id;
>  	char devname[15];
>  
> -	timer_base = ioremap_nocache(timer_variant.reg_base, SZ_4K);
> -	if (!timer_base)
> -		panic("failed to map timer registers");
> +	if (!timer_base) {
> +		timer_base = ioremap_nocache(timer_variant.reg_base, SZ_4K);
> +		if (!timer_base)
> +			panic("failed to map timer registers");
> +	}

You map 4K here, but the binding didn't mention that 4K is always the expected
size of the reg.

>  
>  	timerclk = clk_get(NULL, "timers");
>  	if (IS_ERR(timerclk))
> @@ -514,8 +519,92 @@ static void __init samsung_timer_resources(void)
>  	clk_enable(tin_source);
>  }
>  
> +enum {
> +	TYPE_S3C24XX,
> +	TYPE_S3C64XX,
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id samsung_timer_ids[] = {
> +	{ .compatible = "samsung,s3c24xx-pwm-timer",
> +					.data = (void *)TYPE_S3C24XX, },
> +	{ .compatible = "samsung,s3c64xx-pwm-timer",
> +					.data = (void *)TYPE_S3C64XX, },
> +	{},
> +};
> +
> +static void samsung_timer_parse_dt(struct device_node *np,
> +					const struct of_device_id *match)
> +{
> +	int i;
> +	u32 val;
> +
> +	if (of_property_read_u32(np, "samsung,source-timer", &val))
> +		panic("no samsung,source-timer property provided");
> +	if (val > ARRAY_SIZE(timer_variant.irqs))
> +		panic("samsung,source-timer property out of range");

This check doesn't tell you if you actually had an irq in the dt for the timer
at that index.

Do you really need to panic here? Can you not just warn?

What if a future platform has another timer driver that can at least get the
board to boot?

> +	timer_source.source_id = val;
> +
> +	if (of_property_read_u32(np, "samsung,event-timer", &val))
> +		panic("no samsung,event-timer property provided");
> +	if (val > ARRAY_SIZE(timer_variant.irqs))
> +		panic("samsung,event-timer property out of range");
> +	timer_source.event_id = val;

I have the same problems here as with the source-timer block above.

> +
> +	timer_base = of_iomap(np, 0);
> +	if (!timer_base)
> +		panic("failed to map timer registers");

Similarly here and every other place that panics: I think warning might be a
better bet.

> +
> +	for (i = 0; i < ARRAY_SIZE(timer_variant.irqs); ++i)
> +		timer_variant.irqs[i] = irq_of_parse_and_map(np, i);
> +
> +	if (!timer_variant.irqs[timer_source.event_id])
> +		panic("no clock event irq provided");
> +
> +	switch ((unsigned int)match->data) {
> +	case TYPE_S3C24XX:
> +		timer_variant.bits = 16;
> +		timer_variant.prescale = 25;
> +		timer_variant.prescale = 50;
> +		timer_variant.has_tint_cstat = false;
> +		break;
> +	case TYPE_S3C64XX:
> +		timer_variant.bits = 32;
> +		timer_variant.prescale = 2;
> +		timer_variant.divisor = 2;
> +		timer_variant.has_tint_cstat = true;
> +		break;
> +	}
> +
> +	if (!of_property_read_u32(np, "samsung,prescale", &val)) {
> +		if (val < 1 || val > 256)
> +			panic("prescale must be from 1 to 256 range");
> +		timer_variant.prescale = val;
> +	}
> +
> +	if (!of_property_read_u32(np, "samsung,divisor", &val)) {
> +		if (val > 16 || (1 << (fls(val) - 1)) != val)
> +			panic("divsor must be 1, 2, 4, 8 or 16");
> +		timer_variant.divisor = timer_variant.prescale * val;

Maybe it's just me, but I find this somewhat difficult to read.

How about something like:

switch (val) {
case 1:
case 2:
case 4:
case 8:
case 16:
	timer_variant.divisor = timer_variant.prescale * val;
	break;
default:
	warn("no divisor specified");
};

Thanks,
Mark.
