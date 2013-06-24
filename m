From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 24 Jun 2013 08:58:16 -0700
Subject: [PATCH] clk/zynq/clkc: Add CLK_SET_RATE_PARENT flag to ethernet
 muxes
In-Reply-To: <1371509260-2340-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1371509260-2340-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <b79e12d1-dd4b-407c-b3c1-46d7d66292e8@CO1EHSMHS017.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping?

On Mon, Jun 17, 2013 at 03:47:40PM -0700, Soren Brinkmann wrote:
> Zynq's Ethernet clocks are created by the following hierarchy:
> 	mux0 ---> div0 ---> div1 ---> mux1 ---> gate
> Rate change requests on the gate have to propagate all the way up to
> div0 to properly leverage all dividers. Mux1 was missing the
> CLK_SET_RATE_PARENT flag, which is required to achieve this.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  drivers/clk/zynq/clkc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index 515a573..089d3e3 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -365,8 +365,9 @@ static void __init zynq_clk_setup(struct device_node *np)
>  			CLK_SET_RATE_PARENT, SLCR_GEM0_CLK_CTRL, 20, 6,
>  			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
>  			&gem0clk_lock);
> -	clk = clk_register_mux(NULL, "gem0_emio_mux", gem0_mux_parents, 2, 0,
> -			SLCR_GEM0_CLK_CTRL, 6, 1, 0, &gem0clk_lock);
> +	clk = clk_register_mux(NULL, "gem0_emio_mux", gem0_mux_parents, 2,
> +			CLK_SET_RATE_PARENT, SLCR_GEM0_CLK_CTRL, 6, 1, 0,
> +			&gem0clk_lock);
>  	clks[gem0] = clk_register_gate(NULL, clk_output_name[gem0],
>  			"gem0_emio_mux", CLK_SET_RATE_PARENT,
>  			SLCR_GEM0_CLK_CTRL, 0, 0, &gem0clk_lock);
> @@ -387,8 +388,9 @@ static void __init zynq_clk_setup(struct device_node *np)
>  			CLK_SET_RATE_PARENT, SLCR_GEM1_CLK_CTRL, 20, 6,
>  			CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
>  			&gem1clk_lock);
> -	clk = clk_register_mux(NULL, "gem1_emio_mux", gem1_mux_parents, 2, 0,
> -			SLCR_GEM1_CLK_CTRL, 6, 1, 0, &gem1clk_lock);
> +	clk = clk_register_mux(NULL, "gem1_emio_mux", gem1_mux_parents, 2,
> +			CLK_SET_RATE_PARENT, SLCR_GEM1_CLK_CTRL, 6, 1, 0,
> +			&gem1clk_lock);
>  	clks[gem1] = clk_register_gate(NULL, clk_output_name[gem1],
>  			"gem1_emio_mux", CLK_SET_RATE_PARENT,
>  			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
> -- 
> 1.8.3.1
> 
> 
