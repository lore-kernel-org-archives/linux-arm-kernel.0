From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 4 Jul 2013 23:42:36 +0200 (CEST)
Subject: [PATCH v5] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <1372940383-5957-1-git-send-email-jonas.jensen@gmail.com>
References: <1372687359-18235-1-git-send-email-jonas.jensen@gmail.com>
 <1372940383-5957-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <alpine.DEB.2.02.1307042211420.11637@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Jul 2013, Jonas Jensen wrote:

> This patch adds an clocksource driver for the main timer(s)
> found on MOXA ART SoCs.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> ---
> 
> Notes:
>     Applies to next-20130703
>     
>     Changes since v4:
>     
>     1. add general cache for TIMER_CR register

What you implemented is not a register cache. A register cache is
caching the current value and not some initial constant.
 
> +static void moxart_clkevt_mode(enum clock_event_mode mode,
> +			       struct clock_event_device *clk)
> +{
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_RESUME:
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		writel(timereg_cache & ~TIMEREG_CR_1_ENABLE, base + TIMER_CR);

You just modify bits on the "cache" variable. though you are not
caching it. As it seems to work it looks like this register simply can
be written with constants.

> +	timereg_cache = readl(base + TIMER_CR) | TIMEREG_CR_2_ENABLE;

Why are you reading that back? You know excactly which of the timers
you are using and none of those should be enabled before you reach
that code. If it one of them is enabled by the boot loader you better
disable it in this init function. 

Now if you disable all of those timers and just use a known set, then
you can do without a pseudo cache variable and just write constants
into the control register, right ?

Thanks,

	tglx
