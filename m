From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Sat, 10 May 2014 14:07:07 -0300
Subject: [linux-sunxi] [PATCH 3/6] clk: sunxi: Move the GMAC clock to
 a file of its own
In-Reply-To: <1399692821-20988-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399692821-20988-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <536E5CBB.5070605@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

[let's hope this email goes through as non-empty]

El 10/05/14 00:33, Maxime Ripard escribi?:
> Since we have a folder of our own, we can actually make use of it by splitting
> the huge clock file into several sub drivers.
>
> The gmac clock is pretty easy to deal with, since it's pretty much isolated and
> doesn't have any dependency on the other clocks.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Looks good to me, but see below.

>   drivers/clk/sunxi/Makefile       |   3 +-
>   drivers/clk/sunxi/clk-a20-gmac.c | 119 +++++++++++++++++++++++++++++++++++++++
>   drivers/clk/sunxi/clk-sunxi.c    |  98 --------------------------------
>   3 files changed, 121 insertions(+), 99 deletions(-)
>   create mode 100644 drivers/clk/sunxi/clk-a20-gmac.c
>
(snip)
> +
> +	clk = clk_register_composite(NULL, clk_name,
> +			parents, SUN7I_A20_GMAC_PARENTS,
> +			&mux->hw, &clk_mux_ops,
> +			NULL, NULL,
> +			&gate->hw, &clk_gate_ops,
> +			0);
> +
> +	if (IS_ERR(clk))
> +		goto iounmap_reg;
> +
> +	of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +	clk_register_clkdev(clk, clk_name, NULL);

As I mentioned on the other email, I don't think we are using clkdev. 
Maybe we can drop it.

Thanks for working on this!

Emilio
