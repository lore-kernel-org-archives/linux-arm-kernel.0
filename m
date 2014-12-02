From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Dec 2014 16:20:14 +0800
Subject: [PATCH 1/2] clk: Do not complain about correctly set read-only
 muxes when assigning clock parents from device tree
In-Reply-To: <1417452162-20046-1-git-send-email-p.zabel@pengutronix.de>
References: <1417452162-20046-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20141202082012.GC2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 05:42:42PM +0100, Philipp Zabel wrote:
> Assigning a clock parent to a mux with the CLK_MUX_READ_ONLY flag causes an
> error "clk: failed to reparent read_only_mux to already_set_parent: -38"
> even if the hardware is already set to the correct parent clock.
> 
> This patch avoids the error message by checking whether the correct parent
> is already set before calling clk_set_parent. This allows to use the
> assigned-clock-parents device tree binding for clock muxes that are not
> allowed to be changed anymore at the time of_clk_set_defaults is called.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Philipp,

The patch should be sent to Mike Turquette <mturquette@linaro.org>.  The
patch itself makes sense to me, so

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Shawn

> ---
>  drivers/clk/clk-conf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> index aad4796..ca8dc86 100644
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -62,7 +62,8 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
>  			goto err;
>  		}
>  
> -		rc = clk_set_parent(clk, pclk);
> +		if (pclk != __clk_get_parent(clk))
> +			rc = clk_set_parent(clk, pclk);
>  		if (rc < 0)
>  			pr_err("clk: failed to reparent %s to %s: %d\n",
>  			       __clk_get_name(clk), __clk_get_name(pclk), rc);
> -- 
> 2.1.3
> 
