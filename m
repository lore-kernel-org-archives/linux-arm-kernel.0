From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 21 Jul 2017 13:35:51 +0530
Subject: [PATCH 03/12] ARM: normalize clk API for older platforms
In-Reply-To: <20170720155132.3250812-1-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
 <20170720155132.3250812-1-arnd@arndb.de>
Message-ID: <b26930f6-3c57-7931-7f74-d0e07adb9cd7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thursday 20 July 2017 09:20 PM, Arnd Bergmann wrote:
> Six ARM platforms still provide their own variant of the clk API
> rather than using the generic COMMON_CLK API. This generally works,
> but it causes some link errors with drivers using the clk_set_rate,
> clk_get_parent, clk_set_parent or clk_round_rate functions when
> a platform lacks those interfaces.
> 
> OMAP1 implements the whole set already, but davinci, ep93xx, mmp,
> sa1100 and w90x900 all lack at least one of the functions.
> 
> This adds empty stub implementations for each of them, and I
> don't even try to do something useful here but instead just
> print a WARN() message to make it obvious what is going on
> if they ever end up being called.
> 
> The drivers that call these won't be used on these platforms
> (otherwise we'd get a link error today), so the added code is harmless
> bloat and will warn about accidental use.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-davinci/clock.c |  6 ++++++
>  arch/arm/mach-ep93xx/clock.c  | 21 +++++++++++++++++++++
>  arch/arm/mach-mmp/clock.c     | 22 ++++++++++++++++++++++
>  arch/arm/mach-sa1100/clock.c  | 29 +++++++++++++++++++++++++++++
>  arch/arm/mach-w90x900/clock.c | 29 +++++++++++++++++++++++++++++
>  5 files changed, 107 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
> index f5dce9b4e617..89586779526c 100644
> --- a/arch/arm/mach-davinci/clock.c
> +++ b/arch/arm/mach-davinci/clock.c
> @@ -218,6 +218,12 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>  }
>  EXPORT_SYMBOL(clk_set_parent);
>  
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	return clk->parent;
> +}
> +EXPORT_SYMBOL(clk_get_parent);

For mach-davinci change:

Acked-by: Sekhar Nori <nsekhar@ti.com>

> +
>  int clk_register(struct clk *clk)
>  {
>  	if (clk == NULL || IS_ERR(clk))
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 39ef3b613912..c1c91fc6e178 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -323,6 +323,27 @@ unsigned long clk_get_rate(struct clk *clk)
>  }
>  EXPORT_SYMBOL(clk_get_rate);
>  
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_round_rate);

Its probably better to WARN_ON_ONCE(). Also, since NULL clk is valid, it
should be probably be WARN_ON_ONCE(1).

Thanks,
Sekhar
