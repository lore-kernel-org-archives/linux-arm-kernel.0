From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Nov 2015 10:08:32 -0800
Subject: [PATCH] clocksource/drivers/timer_sun5i: Replace code by
 clocksource_mmio_init
In-Reply-To: <1447348278-16277-1-git-send-email-daniel.lezcano@linaro.org>
References: <1447348278-16277-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20151112180832.GE32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, Nov 12, 2015 at 06:11:18PM +0100, Daniel Lezcano wrote:
> The current code to initialize, register and read the clocksource is
> already factored out in mmio.c via the clocksource_mmio_init function.
> 
> The only difference is the readl vs readl_relaxed.
> 
> Factor out the code with the clocksource_mmio_init function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/timer-sun5i.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
> index bca9573..dc3793c 100644
> --- a/drivers/clocksource/timer-sun5i.c
> +++ b/drivers/clocksource/timer-sun5i.c
> @@ -152,13 +152,6 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static cycle_t sun5i_clksrc_read(struct clocksource *clksrc)
> -{
> -	struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
> -
> -	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
> -}
> -
>  static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
>  				unsigned long event, void *data)
>  {
> @@ -217,13 +210,8 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
>  	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
>  	       base + TIMER_CTL_REG(1));
>  
> -	cs->clksrc.name = node->name;
> -	cs->clksrc.rating = 340;
> -	cs->clksrc.read = sun5i_clksrc_read;
> -	cs->clksrc.mask = CLOCKSOURCE_MASK(32);
> -	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
> -
> -	ret = clocksource_register_hz(&cs->clksrc, rate);
> +	ret = clocksource_mmio_init(base + TIMER_CNTVAL_LO_REG(1), node->name,
> +				    rate, 340, UINT_MAX, clocksource_mmio_readw_down);

Shouldn't it be clocksource_mmio_readl_down?

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151112/4de92519/attachment-0001.sig>
