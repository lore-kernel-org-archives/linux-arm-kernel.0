From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Fri, 17 Jan 2014 00:23:26 -0300
Subject: clk: sunxi: add PLL5 and PLL6 support
In-Reply-To: <20140109052909.GC1265@elgon.mountain>
References: <20140109052909.GC1265@elgon.mountain>
Message-ID: <52D8A22E.4020605@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dan,

[cc'ing Mike so he is aware of this too]

2014/1/9 Dan Carpenter <dan.carpenter@oracle.com>:
> Hello Emilio L?pez,
>
> The patch d584c1331d64: "clk: sunxi: add PLL5 and PLL6 support" from
> Dec 23, 2013, leads to the Smatch following
> static checker warning:
>         drivers/clk/sunxi/clk-sunxi.c:952 sunxi_divs_clk_setup()
>         error: buffer overflow 'clks' 2 <= 2

Thanks for reporting this.

> drivers/clk/sunxi/clk-sunxi.c
>    878          clks = kzalloc(SUNXI_DIVS_MAX_QTY * sizeof(struct clk *), GFP_KERNEL);
>    879          if (!clks)
>    880                  goto free_clkdata;
>    881
>    882          clk_data->clks = clks;
>    883
>    884          /* It's not a good idea to have automatic reparenting changing
>    885           * our RAM clock! */
>    886          clkflags = !strcmp("pll5", parent) ? 0 : CLK_SET_RATE_PARENT;
>    887
>    888          for (i = 0; i < SUNXI_DIVS_MAX_QTY; i++) {
>    889                  if (of_property_read_string_index(node, "clock-output-names",
>    890                                                    i, &clk_name) != 0)
>    891                          break;
>
> Presumably we will always hit this condition on the last iteration of
> the loop, but I just wanted to confirm.
>    892
>
> [ snip ]
>
>    947                  WARN_ON(IS_ERR(clk_data->clks[i]));
>    948                  clk_register_clkdev(clks[i], clk_name, NULL);
>    949          }
>    950
>    951          /* The last clock available on the getter is the parent */
>    952          clks[i++] = pclk;
>                 ^^^^^^^^^^^^^^^^
> Otherwise we overflow.

Indeed, it is very possible that we are overflowing here. I will send a 
patch to fix this as soon as possible; hopefully later today.

Thanks!

Emilio
