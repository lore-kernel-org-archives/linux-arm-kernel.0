From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 30 Mar 2016 20:06:52 +0200
Subject: [PATCH] arm: at91: do not disable/enable clocks in a row
In-Reply-To: <1459258007-24968-1-git-send-email-bigeasy@linutronix.de>
References: <1459258007-24968-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <56FC15BC.9010708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2016 03:26 PM, Sebastian Andrzej Siewior wrote:
> Currently the driver will disable the clock and enable it one line later
> if it is switching from periodic mode into one shot.
> This can be avoided and causes a needless warning on -RT.

I don't see the connection between the description and the content of 
the patch.

It can be avoided by not disabling the clock when going to periodic / 
oneshot.

The function below suggest clk_enable() is called twice, is that the 
real issue ?

> Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   drivers/clocksource/tcb_clksrc.c | 33 +++++++++++++++++++++++++++++----
>   1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> index 4da2af9694a2..ed1ae4445e8d 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -74,6 +74,7 @@ static struct clocksource clksrc = {
>   struct tc_clkevt_device {
>   	struct clock_event_device	clkevt;
>   	struct clk			*clk;
> +	bool				clk_enabled;
>   	void __iomem			*regs;
>   };
>
> @@ -91,6 +92,24 @@ static struct tc_clkevt_device *to_tc_clkevt(struct clock_event_device *clkevt)
>    */
>   static u32 timer_clock;
>
> +static void tc_clk_disable(struct clock_event_device *d)
> +{
> +	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
> +
> +	clk_disable(tcd->clk);
> +	tcd->clk_enabled = false;
> +}
> +
> +static void tc_clk_enable(struct clock_event_device *d)
> +{
> +	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
> +
> +	if (tcd->clk_enabled)
> +		return;
> +	clk_enable(tcd->clk);
> +	tcd->clk_enabled = true;
> +}

This function.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
