From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 17 Jan 2012 16:46:14 +0800
Subject: [PATCH 2/2] ARM: prima2: convert to common sched_clock()
 implementation
In-Reply-To: <1326715537-14968-3-git-send-email-marc.zyngier@arm.com>
References: <1326715537-14968-1-git-send-email-marc.zyngier@arm.com>
 <1326715537-14968-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAGsJ_4yg0zrA8B6qL91RFxE8LTyDaNZmTfAxEuK4eSFdMKtTcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/16 Marc Zyngier <marc.zyngier@arm.com>:
> Prima2 has its own sched_clock() implementation, which gets in the
> way of a single zImage. Moving to the common sched_clock framework
> makes the code slightly cleaner (the mapping hack in sched_clock()
> goes away...).
>
> Cc: Barry Song <baohua.song@csr.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Ack. Thanks, Marc.

-barry

> ---
> ?arch/arm/Kconfig ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-prima2/timer.c | ? 21 +++++++--------------
> ?2 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cb75734..a18550e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -388,6 +388,7 @@ config ARCH_PRIMA2
> ? ? ? ?select GENERIC_CLOCKEVENTS
> ? ? ? ?select CLKDEV_LOOKUP
> ? ? ? ?select GENERIC_IRQ_CHIP
> + ? ? ? select HAVE_SCHED_CLOCK
> ? ? ? ?select MIGHT_HAVE_CACHE_L2X0
> ? ? ? ?select USE_OF
> ? ? ? ?select ZONE_DMA
> diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer.c
> index b7a6091..0d024b1 100644
> --- a/arch/arm/mach-prima2/timer.c
> +++ b/arch/arm/mach-prima2/timer.c
> @@ -18,6 +18,7 @@
> ?#include <linux/of.h>
> ?#include <linux/of_address.h>
> ?#include <mach/map.h>
> +#include <asm/sched_clock.h>
> ?#include <asm/mach/time.h>
>
> ?#define SIRFSOC_TIMER_COUNTER_LO ? ? ? 0x0000
> @@ -165,21 +166,9 @@ static struct irqaction sirfsoc_timer_irq = {
> ?};
>
> ?/* Overwrite weak default sched_clock with more precise one */
> -unsigned long long notrace sched_clock(void)
> +static u32 notrace sirfsoc_read_sched_clock(void)
> ?{
> - ? ? ? static int is_mapped;
> -
> - ? ? ? /*
> - ? ? ? ?* sched_clock is called earlier than .init of sys_timer
> - ? ? ? ?* if we map timer memory in .init of sys_timer, system
> - ? ? ? ?* will panic due to illegal memory access
> - ? ? ? ?*/
> - ? ? ? if (!is_mapped) {
> - ? ? ? ? ? ? ? sirfsoc_of_timer_map();
> - ? ? ? ? ? ? ? is_mapped = 1;
> - ? ? ? }
> -
> - ? ? ? return sirfsoc_timer_read(NULL) * (NSEC_PER_SEC / CLOCK_TICK_RATE);
> + ? ? ? return (u32)(sirfsoc_timer_read(NULL) & 0xffffffff);
> ?}
>
> ?static void __init sirfsoc_clockevent_init(void)
> @@ -210,6 +199,8 @@ static void __init sirfsoc_timer_init(void)
> ? ? ? ?BUG_ON(rate < CLOCK_TICK_RATE);
> ? ? ? ?BUG_ON(rate % CLOCK_TICK_RATE);
>
> + ? ? ? sirfsoc_of_timer_map();
> +
> ? ? ? ?writel_relaxed(rate / CLOCK_TICK_RATE / 2 - 1, sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
> ? ? ? ?writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
> ? ? ? ?writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
> @@ -217,6 +208,8 @@ static void __init sirfsoc_timer_init(void)
>
> ? ? ? ?BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE));
>
> + ? ? ? setup_sched_clock(sirfsoc_read_sched_clock, 32, CLOCK_TICK_RATE);
> +
> ? ? ? ?BUG_ON(setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq));
>
> ? ? ? ?sirfsoc_clockevent_init();
> --
> 1.7.7.1
