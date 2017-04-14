From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 14 Apr 2017 21:13:36 +0200
Subject: [PATCH] clockevents/tcb_clksrc: implement suspend/resume
In-Reply-To: <20170411154826.5883-1-alexandre.belloni@free-electrons.com>
References: <20170411154826.5883-1-alexandre.belloni@free-electrons.com>
Message-ID: <7100599f-529a-7d56-f43f-01513293d313@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2017 17:48, Alexandre Belloni wrote:
> On sama5d2, power to the core may be cut while entering suspend mode. It is
> necessary to save and restore the TCB registers.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/clocksource/tcb_clksrc.c | 46 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> index d4ca9962a759..57f5d72328f4 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -9,6 +9,7 @@
>  #include <linux/ioport.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/syscore_ops.h>
>  #include <linux/atmel_tc.h>
>  
>  
> @@ -40,6 +41,14 @@
>   */
>  
>  static void __iomem *tcaddr;
> +static struct
> +{
> +	u32 cmr;
> +	u32 imr;
> +	u32 rc;
> +	bool clken;
> +} tcb_cache[3];
> +static u32 bmr_cache;
>  
>  static u64 tc_get_cycles(struct clocksource *cs)
>  {
> @@ -61,12 +70,49 @@ static u64 tc_get_cycles32(struct clocksource *cs)
>  	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
>  }
>  
> +void tc_clksrc_suspend(struct clocksource *cs)
> +{
> +	int i;
> +
> +	for (i = 0; i < 3; i++) {

s/3/ARRAY_SIZE(tcb_cache)/

> +		tcb_cache[i].cmr = readl(tcaddr + ATMEL_TC_REG(i, CMR));
> +		tcb_cache[i].imr = readl(tcaddr + ATMEL_TC_REG(i, IMR));
> +		tcb_cache[i].rc = readl(tcaddr + ATMEL_TC_REG(i, RC));
> +		tcb_cache[i].clken = !!(readl(tcaddr + ATMEL_TC_REG(i, SR)) &
> +					ATMEL_TC_CLKSTA);
> +	}
> +
> +	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
> +}
> +
> +void tc_clksrc_resume(struct clocksource *cs)
> +{
> +	int i;
> +
> +	for (i = 0; i < 3; i++) {

s/3/ARRAY_SIZE(tcb_cache)/

> +		__raw_writel(tcb_cache[i].cmr, tcaddr + ATMEL_TC_REG(i, CMR));

Why __raw_writel?

> +		__raw_writel(0, tcaddr + ATMEL_TC_REG(i, RA));
> +		__raw_writel(0, tcaddr + ATMEL_TC_REG(i, RB));
> +		__raw_writel(tcb_cache[i].rc, tcaddr + ATMEL_TC_REG(i, RC));
> +		__raw_writel(0xff, tcaddr + ATMEL_TC_REG(i, IDR));
> +		__raw_writel(tcb_cache[i].imr, tcaddr + ATMEL_TC_REG(i, IER));
> +		if (tcb_cache[i].clken)
> +			__raw_writel(ATMEL_TC_CLKEN, tcaddr +
> +				     ATMEL_TC_REG(i, CCR));
> +	}
> +
> +	writel(bmr_cache, tcaddr + ATMEL_TC_BMR);
> +	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);

Do you mind to add a description of the restore sequence?

Thanks!

  -- Daniel

> +}
> +
>  static struct clocksource clksrc = {
>  	.name           = "tcb_clksrc",
>  	.rating         = 200,
>  	.read           = tc_get_cycles,
>  	.mask           = CLOCKSOURCE_MASK(32),
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.suspend	= tc_clksrc_suspend,
> +	.resume		= tc_clksrc_resume,
>  };
>  
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
