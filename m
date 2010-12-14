From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 14 Dec 2010 11:09:21 +0800
Subject: [PATCH 12/24] ARM: PXA: update clock source registration
In-Reply-To: <E1PSDvL-0008D4-Oi@rmk-PC.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
	<E1PSDvL-0008D4-Oi@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTi=tdaVXTk+0H1_w3kvsfVBi6P7H5STS9NhSU7cC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 3:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of the
> divisor shift/mult constants. ?Switch over to using this new interface.
>

Russell,

This has been already addressed in Haojian's previous patch posted and
merged in my tree:

http://git.kernel.org/?p=linux/kernel/git/ycmiao/pxa-linux-2.6.git;a=commitdiff;h=ee5ed917c3c412e0e13d1c198b5f09f82c03eea4

I'll send the pull request out early today to sort this out.

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/mach-pxa/time.c | ? ?6 +-----
> ?1 files changed, 1 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
> index 293e40a..caf92c0 100644
> --- a/arch/arm/mach-pxa/time.c
> +++ b/arch/arm/mach-pxa/time.c
> @@ -127,7 +127,6 @@ static struct clocksource cksrc_pxa_oscr0 = {
> ? ? ? ?.rating ? ? ? ? = 200,
> ? ? ? ?.read ? ? ? ? ? = pxa_read_oscr,
> ? ? ? ?.mask ? ? ? ? ? = CLOCKSOURCE_MASK(32),
> - ? ? ? .shift ? ? ? ? ?= 20,
> ? ? ? ?.flags ? ? ? ? ?= CLOCK_SOURCE_IS_CONTINUOUS,
> ?};
>
> @@ -155,12 +154,9 @@ static void __init pxa_timer_init(void)
> ? ? ? ? ? ? ? ?clockevent_delta2ns(MIN_OSCR_DELTA * 2, &ckevt_pxa_osmr0) + 1;
> ? ? ? ?ckevt_pxa_osmr0.cpumask = cpumask_of(0);
>
> - ? ? ? cksrc_pxa_oscr0.mult =
> - ? ? ? ? ? ? ? clocksource_hz2mult(clock_tick_rate, cksrc_pxa_oscr0.shift);
> -
> ? ? ? ?setup_irq(IRQ_OST0, &pxa_ost0_irq);
>
> - ? ? ? clocksource_register(&cksrc_pxa_oscr0);
> + ? ? ? clocksource_register_hz(&cksrc_pxa_oscr0, clock_tick_rate);
> ? ? ? ?clockevents_register_device(&ckevt_pxa_osmr0);
> ?}
>
> --
> 1.6.2.5
>
>
