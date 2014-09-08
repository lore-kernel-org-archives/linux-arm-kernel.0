From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 8 Sep 2014 19:33:38 +0200
Subject: [PATCH 4/5] rtc: at91sam9: retain slow clock and check its rate
In-Reply-To: <1409733934-14465-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
 <1409733934-14465-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140908173338.GD14623@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2014 at 10:45:33 +0200, Boris Brezillon wrote :
> The RTT block is using the slow clock and expect it to run at 32KHz.
> Now that we moved to the CCF it's better to retain the clk reference so
> that the CCF can't disable the slow clock considering it is unused.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  drivers/rtc/rtc-at91sam9.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 57014b7..5c5093b 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -21,6 +21,7 @@
>  #include <linux/slab.h>
>  #include <linux/platform_data/atmel.h>
>  #include <linux/io.h>
> +#include <linux/clk.h>
>  
>  /*
>   * This driver uses two configurable hardware resources that live in the
> @@ -74,6 +75,7 @@ struct sam9_rtc {
>  	u32			imr;
>  	void __iomem		*gpbr;
>  	int 			irq;
> +	struct clk		*sclk;
>  };
>  
>  #define rtt_readl(rtc, field) \
> @@ -373,6 +375,25 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* Retain slow clk if it is specified in the DT.
> +	 * Do not complain if slow clk is missing, but check its rate
> +	 * if it is available.
> +	 */
> +	rtc->sclk = devm_clk_get(&pdev->dev, NULL);
> +	if (!IS_ERR(rtc->sclk)) {
> +		if (clk_get_rate(rtc->sclk) != AT91_SLOW_CLOCK) {

I would not bother doing that check but use the value for MR instead of
AT91_SLOW_CLOCK (see my previous mail).

> +			dev_err(&pdev->dev,
> +				"Invalid slow clock rate (expecting %lu got %lu)",
> +				(unsigned long)AT91_SLOW_CLOCK,
> +				clk_get_rate(rtc->sclk));
> +			return -EINVAL;
> +		}
> +
> +		ret = clk_prepare_enable(rtc->sclk);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* NOTE:  sam9260 rev A silicon has a ROM bug which resets the
>  	 * RTT on at least some reboots.  If you have that chip, you must
>  	 * initialize the time from some external source like a GPS, wall
> @@ -397,6 +418,9 @@ static int at91_rtc_remove(struct platform_device *pdev)
>  	/* disable all interrupts */
>  	rtt_writel(rtc, MR, mr & ~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN));
>  
> +	if (!IS_ERR(rtc->sclk))
> +		clk_disable_unprepare(rtc->sclk);
> +
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
