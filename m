From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Sep 2012 21:35:39 +0100
Subject: [PATCH V3 1/6] arm: cache-l2x0: make outer_cache_fns a field
 of l2x0_of_data
In-Reply-To: <1346852677-5381-2-git-send-email-gregory.clement@free-electrons.com>
References: <1346852677-5381-1-git-send-email-gregory.clement@free-electrons.com>
 <1346852677-5381-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120915203539.GK12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 03:44:32PM +0200, Gregory CLEMENT wrote:
> Instead of having multiple functions belonging to outer_cache and
> filling this structure on the fly, use a outer_cache_fns field inside
> l2x0_of_data and just memcopy it into outer_cache depending of the
> type of the l2x0 cache. For non DT case, the former code was kept.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Tested-and-reviewed-by: Yehuda Yitschak <yehuday@marvell.com>
> Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>

Just tried pulling this and got conflicts, so I looked a little deeper
at this.  This patch advertises itself as merely changing the way
outer_cache is initialized:

> +#ifndef CONFIG_OF
>  	outer_cache.inv_range = l2x0_inv_range;
>  	outer_cache.clean_range = l2x0_clean_range;
>  	outer_cache.flush_range = l2x0_flush_range;
> @@ -383,6 +384,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
>  	outer_cache.flush_all = l2x0_flush_all;
>  	outer_cache.inv_all = l2x0_inv_all;
>  	outer_cache.disable = l2x0_disable;
> +#endif

It disables this assignment...

>  static const struct l2x0_of_data pl310_data = {
...
> +	.outer_cache = {
> +		.resume      = pl310_resume,

moves the resume here...

> +		.inv_range   = l2x0_inv_range,
> +		.clean_range = l2x0_clean_range,
> +		.flush_range = l2x0_flush_range,
> +		.sync        = l2x0_cache_sync,
> +		.flush_all   = l2x0_flush_all,
> +		.inv_all     = l2x0_inv_all,
> +		.disable     = l2x0_disable,

initializes all these values that were previously set...

> +		.set_debug   = pl310_set_debug,

and adds one extra, which gets added because we blat over the assignment
of it in l2x0_init() after we read the ID from the device.

Plus, doesn't this patch break systems which may enable CONFIG_OF, but
don't supply a DT file, relying on the old way to initialize the L2 cache
operations functions?

This patch just looks buggy to me.
