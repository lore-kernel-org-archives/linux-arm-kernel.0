From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 9 Jan 2018 19:37:34 +0200
Subject: [PATCH] ARM: OMAP: clock: Fix debugfs_create_*() usage
In-Reply-To: <1514906735-8977-1-git-send-email-geert+renesas@glider.be>
References: <1514906735-8977-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20180109173734.tplddyd4d3akrzjr@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 02, 2018 at 04:25:35PM +0100, Geert Uytterhoeven wrote:
> When exposing data access through debugfs, the correct
> debugfs_create_*() functions must be used, depending on data type.
> 
> Remove all casts from data pointers passed to debugfs_create_*()
> functions, as such casts prevent the compiler from flagging bugs.
> 
> Correct all wrong usage:
>   - clk.rate is unsigned long, not u32,
>   - clk.flags is u8, not u32, which exposed the successive
>     clk.rate_offset and clk.src_offset fields.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
> Compile-tested only.
> ---
>  arch/arm/mach-omap1/clock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
> index 43e3e188f5213418..fa512413a4717221 100644
> --- a/arch/arm/mach-omap1/clock.c
> +++ b/arch/arm/mach-omap1/clock.c
> @@ -1011,17 +1011,17 @@ static int clk_debugfs_register_one(struct clk *c)
>  		return -ENOMEM;
>  	c->dent = d;
>  
> -	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, (u8 *)&c->usecount);
> +	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, &c->usecount);
>  	if (!d) {
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
> -	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
> +	d = debugfs_create_ulong("rate", S_IRUGO, c->dent, &c->rate);
>  	if (!d) {
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
> -	d = debugfs_create_x32("flags", S_IRUGO, c->dent, (u32 *)&c->flags);
> +	d = debugfs_create_x8("flags", S_IRUGO, c->dent, &c->flags);
>  	if (!d) {
>  		err = -ENOMEM;
>  		goto err_out;
> -- 
> 2.7.4
> 
