From: josh.cartwright@ni.com (Josh Cartwright)
Date: Thu, 1 Nov 2012 20:56:47 -0600
Subject: [PATCH 8/8] clocksource: xilinx_ttc: add OF_CLK support
In-Reply-To: <0ea1ba71afb3f4551ac27a6dfa41bd97b63cef48.1351721190.git.josh.cartwright@ni.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <0ea1ba71afb3f4551ac27a6dfa41bd97b63cef48.1351721190.git.josh.cartwright@ni.com>
Message-ID: <20121102025647.GN5190@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 01:56:14PM -0600, Josh Cartwright wrote:
> Add support for retrieving TTC configuration from device tree.  This
> includes the ability to pull information about the driving clocks from
> the of_clk bindings.
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
> diff --git a/drivers/clocksource/xilinx_ttc.c b/drivers/clocksource/xilinx_ttc.c
> index ff38b3e..a4718f7 100644
> --- a/drivers/clocksource/xilinx_ttc.c
> +++ b/drivers/clocksource/xilinx_ttc.c
> @@ -209,7 +153,8 @@ static struct clocksource clocksource_xttcpss = {
>  static int xttcpss_set_next_event(unsigned long cycles,
>  					struct clock_event_device *evt)
>  {
> -	struct xttcpss_timer *timer = &timers[XTTCPSS_CLOCKEVENT];
> +	struct xttcpss_timer_clockevent *xttce = to_xttcpss_timer_clkevent(evt);
> +	struct xttcpss_timer *timer = &xttce->xttc;
>  
>  	xttcpss_set_interval(timer, cycles);
>  	return 0;
> @@ -224,12 +169,14 @@ static int xttcpss_set_next_event(unsigned long cycles,
>  static void xttcpss_set_mode(enum clock_event_mode mode,
>  					struct clock_event_device *evt)
>  {
> -	struct xttcpss_timer *timer = &timers[XTTCPSS_CLOCKEVENT];
> +	struct xttcpss_timer_clockevent *xttce = to_xttcpss_timer_clkevent(evt);
> +	struct xttcpss_timer *timer = &xttce->xttc;
>  	u32 ctrl_reg;
>  
>  	switch (mode) {
>  	case CLOCK_EVT_MODE_PERIODIC:
> -		xttcpss_set_interval(timer, TIMER_RATE / HZ);
> +		xttcpss_set_interval(timer,
> +				     clk_get_rate(xttce->clk) / PRESCALE);

I discovered with further testing that the above calculation is broken;
calculated interval also needs to be divided by HZ.

(I'll post a v2; just wanted to get this out there in the slim chance
anyone's testing this ;)

  Josh
