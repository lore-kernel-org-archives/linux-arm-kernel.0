From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 21 Apr 2016 11:45:20 +0800
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <1454107764-19876-1-git-send-email-stefan@agner.ch>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
Message-ID: <20160421034520.GA19965@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 02:49:23PM -0800, Stefan Agner wrote:
> If a clock gets enabled early during boot time, it can lead to a PLL
> startup. The wait_lock function makes sure that the PLL is really
> stareted up before it gets used. However, the function sleeps which
> leads to scheduling and an error:
> bad: scheduling from the idle thread!
> ...
> 
> Use udelay in case IRQ's are still disabled.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/clk/imx/clk-pllv3.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index c05c43d..b5ff561 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -63,7 +63,10 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
>  			break;
>  		if (time_after(jiffies, timeout))
>  			break;
> -		usleep_range(50, 500);
> +		if (unlikely(irqs_disabled()))

This causes a bit confusion that clk_pllv3_prepare is sleepable.
But this line indicates it's possible to be called in irq context.
Although it's only happened during kernel boot phase where irq is
still not enabled.
It seems schedule_debug() somehow did not catch it during early boot
phase. Maybe schedule guys can help explain.

My question is if it's really worthy to introduce this confusion
to fix the issue since the delay is minor?

Furthermore, shouldn't it be udelay(500)?

Shawn,
What's your idea?

Regards
Dong Aisheng

> +			udelay(50);
> +		else
> +			usleep_range(50, 500);
>  	} while (1);
>  
>  	return readl_relaxed(pll->base) & BM_PLL_LOCK ? 0 : -ETIMEDOUT;
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
