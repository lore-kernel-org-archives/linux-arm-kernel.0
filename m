From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 May 2011 16:01:20 +0900
Subject: [PATCH 02/13] ARM: s5p: consolidate selection of timer register
In-Reply-To: <E1QJhMK-0000yR-Q5@rmk-PC.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhMK-0000yR-Q5@rmk-PC.arm.linux.org.uk>
Message-ID: <03f501cc1072$6788da80$369a8f80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> s5p duplicates the runtime selection of the timer register three times.
> Move this out into a separate function.
> 
> FIXME: It is unclear whether this code needs to support true runtime
> selection of the timer register, or whether it can be selected once at
> init time.

Now, implementation is the latter :)

> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

It works fine on SMDKC110 and SMDK6440.
But there is small comment...

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/plat-s5p/s5p-time.c |   58
++++++++++++----------------------------
> -
>  1 files changed, 17 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
> index 8090403..9052f2a 100644
> --- a/arch/arm/plat-s5p/s5p-time.c
> +++ b/arch/arm/plat-s5p/s5p-time.c
> @@ -290,7 +290,7 @@ static void __init s5p_clockevent_init(void)
>  	setup_irq(irq_number, &s5p_clock_event_irq);
>  }
> 
> -static cycle_t s5p_timer_read(struct clocksource *cs)
> +static void __iomem *s5p_timer_reg(void)
>  {
>  	unsigned long offset = 0;
> 
> @@ -308,10 +308,17 @@ static cycle_t s5p_timer_read(struct clocksource
*cs)
> 
>  	default:
>  		printk(KERN_ERR "Invalid Timer %d\n",
timer_source.source_id);
> -		return 0;
> +		return NULL;
>  	}
> 
> -	return (cycle_t) ~__raw_readl(S3C_TIMERREG(offset));
> +	return S3C_TIMERREG(offset);
> +}
> +
> +static cycle_t s5p_timer_read(struct clocksource *cs)
> +{
> +	void __iomem *reg = s5p_timer_reg();
> +
> +	return (cycle_t) (reg ? ~__raw_readl(reg) : 0);
>  }
> 
>  /*
> @@ -325,53 +332,22 @@ static DEFINE_CLOCK_DATA(cd);
> 
>  unsigned long long notrace sched_clock(void)
>  {
> -	u32 cyc;
> -	unsigned long offset = 0;
> -
> -	switch (timer_source.source_id) {
> -	case S5P_PWM0:
> -	case S5P_PWM1:
> -	case S5P_PWM2:
> -	case S5P_PWM3:
> -		offset = (timer_source.source_id * 0x0c) + 0x14;
> -		break;
> -
> -	case S5P_PWM4:
> -		offset = 0x40;
> -		break;
> +	void __iomem *reg = s5p_timer_reg();
> 
> -	default:
> -		printk(KERN_ERR "Invalid Timer %d\n",
timer_source.source_id);
> +	if (!reg)
>  		return 0;
> -	}
> 
> -	cyc = ~__raw_readl(S3C_TIMERREG(offset));
> -	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
> +	return cyc_to_sched_clock(&cd, ~__raw_readl(reg), (u32)~0);
>  }
> 
>  static void notrace s5p_update_sched_clock(void)
>  {
> -	u32 cyc;
> -	unsigned long offset = 0;
> -
> -	switch (timer_source.source_id) {
> -	case S5P_PWM0:
> -	case S5P_PWM1:
> -	case S5P_PWM2:
> -	case S5P_PWM3:
> -		offset = (timer_source.source_id * 0x0c) + 0x14;
> -		break;
> -
> -	case S5P_PWM4:
> -		offset = 0x40;
> -		break;
> +	void __iomem *reg = s5p_timer_reg();
> 
> -	default:
> -		printk(KERN_ERR "Invalid Timer %d\n",
timer_source.source_id);
> -	}
> +	if (!reg)
> +		return 0;

Should be just 'return;' without a value?

> 
> -	cyc = ~__raw_readl(S3C_TIMERREG(offset));
> -	update_sched_clock(&cd, cyc, (u32)~0);
> +	update_sched_clock(&cd, ~__raw_readl(reg), (u32)~0);
>  }
> 
>  struct clocksource time_clocksource = {
> --
> 1.7.4.4

And will test with your 6th patch soon :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
