From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 29 Nov 2010 15:23:18 +0800
Subject: [PATCH 6/8] ARM: pxa: auto compute shift and mult of timer
In-Reply-To: <1290570865-7577-6-git-send-email-haojian.zhuang@marvell.com>
References: <1290570865-7577-1-git-send-email-haojian.zhuang@marvell.com>
	<1290570865-7577-2-git-send-email-haojian.zhuang@marvell.com>
	<1290570865-7577-3-git-send-email-haojian.zhuang@marvell.com>
	<1290570865-7577-4-git-send-email-haojian.zhuang@marvell.com>
	<1290570865-7577-5-git-send-email-haojian.zhuang@marvell.com>
	<1290570865-7577-6-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTimskaNAZ5xOex2qormQMpAZ92EzxRwS4CbGFW-8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 11:54 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Use auto-computed shift and mult of timer with new API
> clocksource_calc_mult_shift()/clockevents_calc_mult_shift().
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>

Looks good. Applied.

> ---
> ?arch/arm/mach-pxa/time.c | ? ?9 ++-------
> ?1 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
> index 293e40a..dd96128 100644
> --- a/arch/arm/mach-pxa/time.c
> +++ b/arch/arm/mach-pxa/time.c
> @@ -111,7 +111,6 @@ pxa_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
> ?static struct clock_event_device ckevt_pxa_osmr0 = {
> ? ? ? ?.name ? ? ? ? ? = "osmr0",
> ? ? ? ?.features ? ? ? = CLOCK_EVT_FEAT_ONESHOT,
> - ? ? ? .shift ? ? ? ? ?= 32,
> ? ? ? ?.rating ? ? ? ? = 200,
> ? ? ? ?.set_next_event = pxa_osmr0_set_next_event,
> ? ? ? ?.set_mode ? ? ? = pxa_osmr0_set_mode,
> @@ -127,7 +126,6 @@ static struct clocksource cksrc_pxa_oscr0 = {
> ? ? ? ?.rating ? ? ? ? = 200,
> ? ? ? ?.read ? ? ? ? ? = pxa_read_oscr,
> ? ? ? ?.mask ? ? ? ? ? = CLOCKSOURCE_MASK(32),
> - ? ? ? .shift ? ? ? ? ?= 20,
> ? ? ? ?.flags ? ? ? ? ?= CLOCK_SOURCE_IS_CONTINUOUS,
> ?};
>
> @@ -147,17 +145,14 @@ static void __init pxa_timer_init(void)
>
> ? ? ? ?set_oscr2ns_scale(clock_tick_rate);
>
> - ? ? ? ckevt_pxa_osmr0.mult =
> - ? ? ? ? ? ? ? div_sc(clock_tick_rate, NSEC_PER_SEC, ckevt_pxa_osmr0.shift);
> + ? ? ? clocksource_calc_mult_shift(&cksrc_pxa_oscr0, clock_tick_rate, 4);
> + ? ? ? clockevents_calc_mult_shift(&ckevt_pxa_osmr0, clock_tick_rate, 4);
> ? ? ? ?ckevt_pxa_osmr0.max_delta_ns =
> ? ? ? ? ? ? ? ?clockevent_delta2ns(0x7fffffff, &ckevt_pxa_osmr0);
> ? ? ? ?ckevt_pxa_osmr0.min_delta_ns =
> ? ? ? ? ? ? ? ?clockevent_delta2ns(MIN_OSCR_DELTA * 2, &ckevt_pxa_osmr0) + 1;
> ? ? ? ?ckevt_pxa_osmr0.cpumask = cpumask_of(0);
>
> - ? ? ? cksrc_pxa_oscr0.mult =
> - ? ? ? ? ? ? ? clocksource_hz2mult(clock_tick_rate, cksrc_pxa_oscr0.shift);
> -
> ? ? ? ?setup_irq(IRQ_OST0, &pxa_ost0_irq);
>
> ? ? ? ?clocksource_register(&cksrc_pxa_oscr0);
> --
> 1.5.6.5
>
>
