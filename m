From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 20:51:01 +0200
Subject: [PATCH 04/22] clk: sunxi: move "ahb_sdram" to protected clock list
In-Reply-To: <1400831485-28576-5-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-5-git-send-email-wens@csie.org>
Message-ID: <20140525185101.GQ10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 03:51:07PM +0800, Chen-Yu Tsai wrote:
> With sunxi_gates clocks registered with clkdev, we can use the
> protected clocks list to enable the "ahb_sdram" clock, instead
> of looking for it and adding CLK_IGNORE_UNUSED inline in the
> clock setup code.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi/clk-sunxi.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 3e33bc1..b2c6d12 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -870,7 +870,6 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
>  	int qty;
>  	int i = 0;
>  	int j = 0;
> -	int ignore;
>  
>  	reg = of_iomap(node, 0);
>  
> @@ -891,15 +890,12 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
>  		of_property_read_string_index(node, "clock-output-names",
>  					      j, &clk_name);
>  
> -		/* No driver claims this clock, but it should remain gated */
> -		ignore = !strcmp("ahb_sdram", clk_name) ? CLK_IGNORE_UNUSED : 0;
> -
>  		clk_data->clks[i] = clk_register_gate(NULL, clk_name,
> -						      clk_parent, ignore,
> +						      clk_parent, 0,
>  						      reg + 4 * (i/32), i % 32,
>  						      0, &clk_lock);
>  		WARN_ON(IS_ERR(clk_data->clks[i]));
> -		clk_register_clkdev(clks[i], clk_name, NULL);
> +		clk_register_clkdev(clk_data->clks[i], clk_name, NULL);

I'm fine with the change itself, but shouldn't this part of it be in
the patch that actually add this line?

Looks broken to me otherwise.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/a70d23ed/attachment.sig>
