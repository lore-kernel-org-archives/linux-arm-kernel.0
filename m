From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 1 Jun 2016 07:36:22 -0700
Subject: [PATCH 7/9] clocksource/drivers/cadence_ttc: Convert init
 function to return error
In-Reply-To: <1464770093-12667-8-git-send-email-daniel.lezcano@linaro.org>
References: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
 <1464770093-12667-8-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20160601143622.GA3766@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Wed, 2016-06-01 at 10:34:50 +0200, Daniel Lezcano wrote:
> The init functions do not return any error. They behave as the following:
> 
>  - panic, thus leading to a kernel crash while another timer may work and
>    make the system boot up correctly
> 
>  or
> 
>  - print an error and let the caller unaware if the state of the system
> 
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
> 
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/cadence_ttc_timer.c | 82 +++++++++++++++++++--------------
>  1 file changed, 48 insertions(+), 34 deletions(-)
> 
[...]
>  	ttcce->ttc.clk_rate_change_nb.notifier_call =
>  		ttc_rate_change_clockevent_cb;
>  	ttcce->ttc.clk_rate_change_nb.next = NULL;
> -	if (clk_notifier_register(ttcce->ttc.clk,
> -				&ttcce->ttc.clk_rate_change_nb))
> +
> +	err = clk_notifier_register(ttcce->ttc.clk,
> +				    &ttcce->ttc.clk_rate_change_nb);
> +	if (err) {
>  		pr_warn("Unable to register clock notifier.\n");
> +		return err;

So far we handle this as warning only and move on, as the notifier is
only needed when frequency scaling is enabled. And even then, the effect
is usually just that timing is off.

> +	}
> +
>  	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
>  
>  	ttcce->ttc.base_addr = base;
> @@ -451,13 +462,15 @@ static void __init ttc_setup_clockevent(struct clk *clk,
>  
>  	err = request_irq(irq, ttc_clock_event_interrupt,
>  			  IRQF_TIMER, ttcce->ce.name, ttcce);
> -	if (WARN_ON(err)) {
> +	if (err) {
>  		kfree(ttcce);
> -		return;
> +		return err;
>  	}
>  
>  	clockevents_config_and_register(&ttcce->ce,
>  			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
> +
> +	return 0;
>  }
>  
>  /**
> @@ -466,20 +479,14 @@ static void __init ttc_setup_clockevent(struct clk *clk,
>   * Initializes the timer hardware and register the clock source and clock event
>   * timers with Linux kernal timer framework
>   */
> -static void __init ttc_timer_init(struct device_node *timer)
> +static int __init ttc_timer_init(struct device_node *timer)
>  {
>  	unsigned int irq;
>  	void __iomem *timer_baseaddr;
>  	struct clk *clk_cs, *clk_ce;
> -	static int initialized;
> -	int clksel;
> +	int clksel, ret;
>  	u32 timer_width = 16;
>  
> -	if (initialized)
> -		return;
> -
> -	initialized = 1;
> -

This also changes behavior. We have multiple of these timer modules in
our HW and we don't want them all to be used for time keeping. This
construct made sure that we only use the first timer for which init is
called leaving the others for non-OS purposes.

	S?ren
