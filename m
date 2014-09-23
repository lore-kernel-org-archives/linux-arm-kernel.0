From: johan@kernel.org (Johan Hovold)
Date: Tue, 23 Sep 2014 14:14:55 +0200
Subject: [PATCH v8 08/10] rtc: at91sam9: use clk API instead of relying
 on AT91_SLOW_CLOCK
In-Reply-To: <1411471444-2764-9-git-send-email-boris.brezillon@free-electrons.com>
References: <1411471444-2764-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411471444-2764-9-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140923121455.GC404@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 01:24:02PM +0200, Boris BREZILLON wrote:
> The RTT block is using the slow clock which is accessible through the clk
> API.
> Use the clk API to retrieve, enable and get the slow clk rate instead of
> the AT91_SLOW_CLOCK macro (which hardcodes the slow clk rate).
> Doing this allows us to reference the clk thus preventing the CCF from
> disabling it during the "disable unused" phase.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/rtc/rtc-at91sam9.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index be9c28b..2eca624 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -23,6 +23,7 @@
>  #include <linux/io.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/clk.h>
>  
>  /*
>   * This driver uses two configurable hardware resources that live in the
> @@ -61,8 +62,6 @@
>  #define AT91_RTT_ALMS		(1 << 0)		/* Real-time Alarm Status */
>  #define AT91_RTT_RTTINC		(1 << 1)		/* Real-time Timer Increment */
>  
> -#define AT91_SLOW_CLOCK		32768
> -
>  /*
>   * We store ALARM_DISABLED in ALMV to record that no alarm is set.
>   * It's also the reset value for that field.
> @@ -77,6 +76,7 @@ struct sam9_rtc {
>  	struct regmap		*gpbr;
>  	unsigned int		gpbr_offset;
>  	int 			irq;
> +	struct clk		*sclk;
>  };
>  
>  #define rtt_readl(rtc, field) \
> @@ -328,6 +328,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  	struct sam9_rtc	*rtc;
>  	int		ret, irq;
>  	u32		mr;
> +	unsigned int	sclk_rate;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> @@ -385,11 +386,27 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	rtc->sclk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rtc->sclk))
> +		return PTR_ERR(rtc->sclk);
> +
> +	sclk_rate = clk_get_rate(rtc->sclk);
> +	if (!sclk_rate || sclk_rate > AT91_RTT_RTPRES) {
> +		dev_err(&pdev->dev, "Invalid slow clock rate");

dev_err message needs a newline.

> +		return -EINVAL;
> +	}
> +
> +	ret = clk_prepare_enable(rtc->sclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not enable slow clock");

Here too.

Johan
