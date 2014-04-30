From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 30 Apr 2014 05:39:53 -0300
Subject: [PATCH] sunxi: make gate clock getable by name
In-Reply-To: <fa26ae07-b4ee-4730-b626-9724a51e7122@googlegroups.com>
References: <fa26ae07-b4ee-4730-b626-9724a51e7122@googlegroups.com>
Message-ID: <5360B6D9.7070409@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 30/04/14 05:25, ????????? ???????? escribi?:
> This patch enables to use devm_clk_get function to get gate clocks by name.
> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
>
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 31584ee..3617681 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -1048,6 +1048,8 @@ static void __init sunxi_gates_clk_setup(struct
> device_node *node,
>       reg + 4 * (i/32), i % 32,
>       0, &clk_lock);
> WARN_ON(IS_ERR(clk_data->clks[i]));
> +if (!IS_ERR(clk_data->clks[i]))
> +clk_register_clkdev(clk_data->clks[i], clk_name, NULL);
> j++;
> }

What are you trying to achieve here? Do you want to use devm_clk_get on 
your driver? If so, you just need to list the clock your device needs on 
its device tree node, like for example

device: blah at 0f0.... {
        ....
        clocks = <&gate 12>, <&clock>, <&whatever>;
        clock-names = "module", "ref", "sample";
}

And then you can pass "module", "ref" or "sample" to devm_clk_get to get 
the respective clock.

Cheers,

Emilio
