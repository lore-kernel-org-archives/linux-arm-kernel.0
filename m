From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Thu, 20 Jul 2017 18:04:00 +0200
Subject: [PATCH 03/12] ARM: normalize clk API for older platforms
In-Reply-To: <20170720155132.3250812-1-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
 <20170720155132.3250812-1-arnd@arndb.de>
Message-ID: <89c62838-ce8c-cb83-fca9-73cbc41d590c@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd!

I'd like to insist on a functional implementation at least for EP93xx,
please see below:

On 20/07/17 17:50, Arnd Bergmann wrote:
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
> +
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_set_parent);
> +
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	WARN_ON(clk);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(clk_get_parent);
> +

I've sent the patch implementing this properly several times already
(the last one "[PATCH v5 1/5] clk: ep93xx: Implement clk_get_parent()"
on 04.06.2017) and this is really required for the ADC driver which
comes along with the series.

I don't mind if you take mine or implement it within your patch,
but I'd like to see the working function merged. 

>  static int set_keytchclk_rate(struct clk *clk, unsigned long rate)
>  {
>  	u32 val;
> diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
> index 28fe64c6e2f5..78513f74ae8d 100644
> --- a/arch/arm/mach-mmp/clock.c
> +++ b/arch/arm/mach-mmp/clock.c
> @@ -106,3 +106,25 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>  	return ret;
>  }
>  EXPORT_SYMBOL(clk_set_rate);
> +
> +/* Dummy clk routine to build generic kernel parts that may be using them */
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_round_rate);
> +
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_set_parent);
> +
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	WARN_ON(clk);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(clk_get_parent);
> diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
> index 0db46895c82a..a602d876c231 100644
> --- a/arch/arm/mach-sa1100/clock.c
> +++ b/arch/arm/mach-sa1100/clock.c
> @@ -35,6 +35,35 @@ struct clk clk_##_name = {				\
>  
>  static DEFINE_SPINLOCK(clocks_lock);
>  
> +/* Dummy clk routine to build generic kernel parts that may be using them */
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_round_rate);
> +
> +int clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_set_rate);
> +
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_set_parent);
> +
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	WARN_ON(clk);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(clk_get_parent);
> +
>  static void clk_gpio27_enable(struct clk *clk)
>  {
>  	/*
> diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
> index ac6fd1a2cb59..3f93fac98d97 100644
> --- a/arch/arm/mach-w90x900/clock.c
> +++ b/arch/arm/mach-w90x900/clock.c
> @@ -93,3 +93,32 @@ void nuc900_subclk_enable(struct clk *clk, int enable)
>  
>  	__raw_writel(clken, W90X900_VA_CLKPWR + SUBCLK);
>  }
> +
> +/* dummy functions, should not be called */
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_round_rate);
> +
> +int clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_set_rate);
> +
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	WARN_ON(clk);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_set_parent);
> +
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	WARN_ON(clk);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(clk_get_parent);
> 

-- 
Best regards,
Alexander Sverdlin.
