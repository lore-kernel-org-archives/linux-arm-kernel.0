From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 16:37:22 +0100
Subject: [PATCH 1/2] clk: sunxi: delay protected clocks until arch initcall
In-Reply-To: <1453385439-10154-2-git-send-email-emilio.lopez@collabora.co.uk>
References: <1453385439-10154-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1453385439-10154-2-git-send-email-emilio.lopez@collabora.co.uk>
Message-ID: <20160127153722.GC4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Thu, Jan 21, 2016 at 11:10:38AM -0300, Emilio L?pez wrote:
> Clocks are registered early on, and unused clocks get disabled on
> late initcall, so we can delay protecting important clocks a bit.
> If we do this too early, it may happen that some clocks are orphans
> and therefore enabling them may not work as intended. If we do this
> too late, a driver may reparent some clock and cause another important
> clock to be disabled as a byproduct.
> 
> arch_initcall should be a good spot to do this, as clock drivers using
> the OF mechanisms will be all registered by then, and drivers won't
> have started probing yet.
> 
> Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
> ---
>  drivers/clk/sunxi/clk-sunxi.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 5ba2188..285e8ee 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -1153,10 +1153,12 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
>  	}
>  }
>  
> +/* By default, don't protect any clocks */
> +static const char **protected_clocks __initdata;
> +static int protected_clocks_nr __initdata;
> +
>  static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
>  {
> -	unsigned int i;
> -
>  	/* Register divided output clocks */
>  	of_sunxi_table_clock_setup(clk_divs_match, sunxi_divs_clk_setup);
>  
> @@ -1169,14 +1171,26 @@ static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
>  	/* Register mux clocks */
>  	of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
>  
> +	/* We shall protect these clocks when everything is ready */
> +	protected_clocks = clocks;
> +	protected_clocks_nr = nclocks;
> +}
> +
> +static int __init sunxi_init_clock_protection(void)
> +{
> +	unsigned int i;
> +
>  	/* Protect the clocks that needs to stay on */
> -	for (i = 0; i < nclocks; i++) {
> -		struct clk *clk = clk_get(NULL, clocks[i]);
> +	for (i = 0; i < protected_clocks_nr; i++) {
> +		struct clk *clk = clk_get(NULL, protected_clocks[i]);
>  
>  		if (!IS_ERR(clk))
>  			clk_prepare_enable(clk);
>  	}
> +
> +	return 0;
>  }
> +arch_initcall(sunxi_init_clock_protection);

You also need to filter that by the machine compatible in case you're
running it on a !sunxi SoC.

Overall, I'm a bit skeptical about the approach. It doesn't really fix
everything, just hides it behind a curtain, and I'm pretty sure the
clocks not registered by this code would still be broken (the mod0
clocks for example).

The real fix would be to make sure we don't have any orphan clock in
the first place, by using CLK_OF_DECLARE everywhere. I did submit a
patch doing just that when the clocks broke, but I never got any
answer to it. I thought the patches were simply dropped and the
rockchip people just took another approach.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/0c2c62cc/attachment-0001.sig>
