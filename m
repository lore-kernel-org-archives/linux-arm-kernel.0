From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 19 Jul 2013 12:23:19 +0300
Subject: [PATCH v4 04/17] sched_clock: Add support for >32 bit sched_clock
In-Reply-To: <1374189690-10810-5-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130719092319.GA4681@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Jul 18, 2013 at 04:21:17PM -0700, Stephen Boyd wrote:
> The ARM architected system counter has at least 56 usable bits.
> Add support for counters with more than 32 bits to the generic
> sched_clock implementation so we can increase the time between
> wakeups due to dealing with wrap-around on these devices while
> benefiting from the irqtime accounting and suspend/resume
> handling that the generic sched_clock code already has. On my
> system using 56 bits over 32 bits changes the wraparound time
> from a few minutes to an hour. For faster running counters (GHz
> range) this is even more important because we may not be able to
> execute the timer in time to deal with the wraparound if only 32
> bits are used.
> 
> We choose a maxsec value of 3600 seconds because we assume no
> system will go idle for more than an hour. In the future we may
> need to increase this value.
> 
> Note: All users should switch over to the 64-bit read function so
> we can remove setup_sched_clock() in favor of sched_clock_register().
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

[..]

> @@ -110,14 +123,13 @@ void __init setup_sched_clock(u32 (*read)(void), int
>   bits, unsigned long rate)
>  	if (cd.rate > rate)
>  		return;
>  
> -	BUG_ON(bits > 32);
>  	WARN_ON(!irqs_disabled());
>  	read_sched_clock = read;
> -	sched_clock_mask = (1 << bits) - 1;
> +	sched_clock_mask = CLOCKSOURCE_MASK(bits);

Note that this conflicts with my integer overflow fix 
(http://article.gmane.org/gmane.linux.ports.arm.kernel/252498) that I hope 
will get merged before 3.11 is out.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
