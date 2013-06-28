From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 28 Jun 2013 22:13:08 +0200 (CEST)
Subject: [PATCHv2 4/8] clocksource: sun4i: Fix the next event code
In-Reply-To: <1372449386-1334-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1372449386-1334-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372449386-1334-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <alpine.DEB.2.02.1306282204220.4013@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Jun 2013, Maxime Ripard wrote:

> The next_event logic was setting the next interval to fire in the
> current timer value instead of the interval value register, which is
> obviously wrong.

Ok.

> Plus the logic to set the actual value was wrong as well, so this
> code has always been broken.

This lacks an explanation why the logic is wrong and what the actual
fix is.
 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clocksource/sun4i_timer.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
> index 84ace76..695c8c8 100644
> --- a/drivers/clocksource/sun4i_timer.c
> +++ b/drivers/clocksource/sun4i_timer.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/clockchips.h>
> +#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqreturn.h>
> @@ -61,9 +62,14 @@ static void sun4i_clkevt_mode(enum clock_event_mode mode,
>  static int sun4i_clkevt_next_event(unsigned long evt,
>  				   struct clock_event_device *unused)
>  {
> -	u32 u = readl(timer_base + TIMER_CTL_REG(0));
> -	writel(evt, timer_base + TIMER_CNTVAL_REG(0));
> -	writel(u | TIMER_CTL_ENABLE | TIMER_CTL_AUTORELOAD,
> +	u32 val = readl(timer_base + TIMER_CTL_REG(0));
> +	writel(val & ~TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG(0));
> +	udelay(1);

That udelay() is more than suspicious. Is there really no other way to
deal with that hardware?

If no, you really need to put a proper explanation for that into the code.

Thanks,

	tglx
