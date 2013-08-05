From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Aug 2013 02:22:43 +0900
Subject: [PATCH 17/18] ARM: SAMSUNG: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-18-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
 <1375309877-16617-18-git-send-email-sboyd@codeaurora.org>
Message-ID: <51FFDF63.1090505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/13 07:31, Stephen Boyd wrote:
> The 32 bit sched_clock interface now supports 64 bits. Upgrade to
> the 64 bit function to allow us to remove the 32 bit registration
> interface.
>
> Cc: Ben Dooks<ben-linux@fluff.org>
> Cc: Kukjin Kim<kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> Signed-off-by: Stephen Boyd<sboyd@codeaurora.org>
> ---
>   arch/arm/plat-samsung/samsung-time.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/samsung-time.c b/arch/arm/plat-samsung/samsung-time.c
> index 2957075..1e2119b 100644
> --- a/arch/arm/plat-samsung/samsung-time.c
> +++ b/arch/arm/plat-samsung/samsung-time.c
> @@ -312,7 +312,7 @@ static void __iomem *samsung_timer_reg(void)
>    * this wraps around for now, since it is just a relative time
>    * stamp. (Inspired by U300 implementation.)
>    */
> -static u32 notrace samsung_read_sched_clock(void)
> +static u64 notrace samsung_read_sched_clock(void)
>   {
>   	void __iomem *reg = samsung_timer_reg();
>
> @@ -337,7 +337,7 @@ static void __init samsung_clocksource_init(void)
>   	samsung_time_setup(timer_source.source_id, TCNT_MAX);
>   	samsung_time_start(timer_source.source_id, PERIODIC);
>
> -	setup_sched_clock(samsung_read_sched_clock, TSIZE, clock_rate);
> +	sched_clock_register(samsung_read_sched_clock, TSIZE, clock_rate);
>
>   	if (clocksource_mmio_init(samsung_timer_reg(), "samsung_clocksource_timer",
>   			clock_rate, 250, TSIZE, clocksource_mmio_readl_down))
