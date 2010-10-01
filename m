From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Oct 2010 19:40:12 +0100
Subject: [PATCH 2/3] ARM: timer-sp: support timer clock freq other than
	1MHz
In-Reply-To: <4CA5295C.60007@gmail.com>
References: <4CA5295C.60007@gmail.com>
Message-ID: <20101001184012.GC22533@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 07:20:44PM -0500, Rob Herring wrote:
> The timer-sp code is fixed to 1MHz timer clock. Add clock
> api calls to get the timer clock frequency.

This patch isn't threaded with the others (and as a result is separated by
at least 50 messages in my mailbox!)  Also the patch seems to be broken
by "inteligent" formatting.

> @@ -50,10 +52,19 @@ static struct clocksource clocksource_sp804 = {
>   void __init sp804_clocksource_init(void __iomem *base)
>  {
> +	struct clk *clk;
>  	struct clocksource *cs = &clocksource_sp804;
>   	clksrc_base = base;
>  +	if (sp804_rate == 0) {
> +		clk = clk_get_sys(NULL, "sp804_timer");

Why just a connection ID with a NULL device name?  This is wrong.  It
should at least be:

		clk = clk_get_sys("sp804", NULL);

Now, one issue here is that the ARM platforms have several of these -
normally 4, or maybe 8.  Some ARM platforms have them clocked differently
(they're even on two different boards.)  So we do need some kind of
connection ID there to identify which one.

I'd suggest passing in a const string to this function to set both the
clocksource name (to identify which sp804 is being used) and used as
a connection ID with clk_get_sys().

>  @@ -140,12 +151,21 @@ static struct irqaction sp804_timer_irq = {
>   void __init sp804_clockevents_init(void __iomem *base, unsigned int  
> timer_irq)
>  {
> +	struct clk *clk;
>  	struct clock_event_device *evt = &sp804_clockevent;
>   	clkevt_base = base;
>  +	if (sp804_rate == 0) {
> +		clk = clk_get_sys(NULL, "sp804_timer");

Same comments here.
