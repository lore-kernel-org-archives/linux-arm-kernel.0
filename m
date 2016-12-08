From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 8 Dec 2016 18:02:50 +0530
Subject: [PATCH v6 1/2] ARM: davinci: Export two clocks function
In-Reply-To: <1481130567-27829-1-git-send-email-abailon@baylibre.com>
References: <1481130567-27829-1-git-send-email-abailon@baylibre.com>
Message-ID: <4e313609-0acc-4e06-85e6-ba36b7916b33@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 December 2016 10:39 PM, Alexandre Bailon wrote:
> Rename and export __clk_enable() and __clk_disable() in order
> to use them from usb-da8xx.c. This file implements the usb20 phy clock
> that must be able to enable or disable usb20 clock.
> To prevent a recurssive call to clk_enable() that would cause a recursive
> locking issue, we must use __clk_enable() and __clk_disable().
> Rename these methods in davinci_clk_enable() and davinci_clk_disable(),
> and export them.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Suggested-by: David Lechner <david@lechnology.com>
> ---
>  arch/arm/mach-davinci/clock.c | 14 ++++++++------
>  arch/arm/mach-davinci/clock.h |  2 ++
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
> index df42c93..0f967c3 100644
> --- a/arch/arm/mach-davinci/clock.c
> +++ b/arch/arm/mach-davinci/clock.c
> @@ -31,10 +31,10 @@ static LIST_HEAD(clocks);
>  static DEFINE_MUTEX(clocks_mutex);
>  static DEFINE_SPINLOCK(clockfw_lock);
>  
> -static void __clk_enable(struct clk *clk)
> +void davinci_clk_enable(struct clk *clk)
>  {
>  	if (clk->parent)
> -		__clk_enable(clk->parent);
> +		davinci_clk_enable(clk->parent);
>  	if (clk->usecount++ == 0) {
>  		if (clk->flags & CLK_PSC)
>  			davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
> @@ -43,8 +43,9 @@ static void __clk_enable(struct clk *clk)
>  			clk->clk_enable(clk);
>  	}
>  }
> +EXPORT_SYMBOL(davinci_clk_enable);

We don't want to export these as we dont want drivers to use this API.
This is to be used within mach-davinci only.

Thanks,
Sekhar
