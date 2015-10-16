From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Oct 2015 10:40:43 -0500
Subject: [RFC PATCH 1/3] arm: plat-omap: dmtimer: Add clock source from DT
In-Reply-To: <5620ED30.2050507@baylibre.com>
References: <5620ED30.2050507@baylibre.com>
Message-ID: <87k2qmlt38.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Neil Armstrong <narmstrong@baylibre.com> writes:
> Add a function which sets the timer source from the clocks
> binding on dm_timer_prepare call.
>
> In case the clocks property is not valid, it falls back to
> the set_source() with 32_KHZ clock as default.
>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/plat-omap/dmtimer.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 8ca94d3..5e8aece 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -137,9 +137,33 @@ static int omap_dm_timer_reset(struct omap_dm_timer *timer)
>  	return 0;
>  }
>
> +static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
> +{
> +	int ret;
> +	struct clk *parent;
> +
> +	if (unlikely(!timer))
> +		return -EINVAL;

IMO, let this crash. If this happens we have bigger problems.

> +	if (IS_ERR(timer->fclk))
> +		return -EINVAL;

We bail out if we can't get fclk, this check is unnecessary.

> +	parent = clk_get(&timer->pdev->dev, NULL);

why NULL ? You could use something more descriptive, but no strong
feelings.

> +	if (IS_ERR(parent))
> +		return -ENODEV;
> +
> +	ret = clk_set_parent(timer->fclk, parent);
> +	if (ret < 0)
> +		pr_err("%s: failed to set parent\n", __func__);
> +
> +	clk_put(parent);
> +
> +	return ret;
> +}
> +
>  static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>  {
> -	int rc;
> +	int rc, ret;

doesn't seem like you need this extra 'ret' variable. Just use 'rc'.

> @@ -166,7 +190,11 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>  	__omap_dm_timer_enable_posted(timer);
>  	omap_dm_timer_disable(timer);
>
> -	return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> +	ret = omap_dm_timer_of_set_source(timer);
> +	if (ret < 0 && ret == -ENODEV)

this < 0 check is pointless if you're going to check for equality to -ENODEV

> +		return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> +
> +	return ret;
>  }
>
>  static inline u32 omap_dm_timer_reserved_systimer(int id)
> -- 
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151016/019159f9/attachment.sig>
