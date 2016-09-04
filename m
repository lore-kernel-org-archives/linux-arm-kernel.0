From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 4 Sep 2016 20:20:15 +0200
Subject: [PATCH v3 4/5] net: stmmac: add a glue driver for the Amlogic
 Meson 8b / GXBB DWMAC
In-Reply-To: <20160830191906.GD12510@codeaurora.org>
References: <20160820093538.9707-1-martin.blumenstingl@googlemail.com>
 <20160828161637.9941-1-martin.blumenstingl@googlemail.com>
 <20160828161637.9941-5-martin.blumenstingl@googlemail.com>
 <20160830191906.GD12510@codeaurora.org>
Message-ID: <CAFBinCCVUhUVyceGc2capcCPOK8MTsn+RcC9gnrtMVvZUENXtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 9:19 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> +             return PTR_ERR(dwmac->m250_mux_clk);
>> +
>> +     /* create the m250_div */
>> +     snprintf(clk_name, sizeof(clk_name), "%s#m250_div", dev_name(dev));
>> +     init.name = devm_kstrdup(dev, clk_name, GFP_KERNEL);
>> +     init.ops = &clk_divider_ops;
>> +     init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
>> +     clk_div_parents[0] = __clk_get_name(dwmac->m250_mux_clk);
>> +     init.parent_names = clk_div_parents;
>> +     init.num_parents = ARRAY_SIZE(clk_div_parents);
>> +
>> +     dwmac->m250_div.reg = dwmac->regs + PRG_ETH0;
>> +     dwmac->m250_div.shift = PRG_ETH0_CLK_M250_DIV_SHIFT;
>> +     dwmac->m250_div.width = PRG_ETH0_CLK_M250_DIV_WIDTH;
>> +     dwmac->m250_div.hw.init = &init;
>> +     dwmac->m250_div.flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO;
>> +
>> +     dwmac->m250_div_clk = devm_clk_register(dev, &dwmac->m250_div.hw);
>
> We've been trying to move away from devm_clk_register() to
> devm_clk_hw_register() so that clk providers aren't also clk
> consumers. Obviously in this case this driver is a provider and a
> consumer, so this isn't as important. Kevin did something similar
> in the mmc driver, so I'll reiterate what I said on that patch.
> Perhaps we should make __clk_create_clk() into a real clk
> provider API so that we can use devm_clk_hw_register() here and
> then generate a clk for this device. That would allow us to have
> proper consumer tracking without relying on the clk that is
> returned from clk_register() (the intent is to make that clk
> instance internal to the framework).
please correct me if I'm wrong but I read this as "this code is OK for
now, but it should be changed once the clk framework has API for
that".
If still you want me to change the code then please send a NACK
(preferably on the updated series which I am preparing right now).

>> +     if (WARN_ON(PTR_ERR_OR_ZERO(dwmac->m250_div_clk)))
>> +             return PTR_ERR(dwmac->m250_div_clk);
>> +
>> +     /* create the m25_div */
>> +     snprintf(clk_name, sizeof(clk_name), "%s#m25_div", dev_name(dev));
>> +     init.name = devm_kstrdup(dev, clk_name, GFP_KERNEL);
>> +     init.ops = &clk_divider_ops;
>> +     init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
>> +     clk_div_parents[0] = __clk_get_name(dwmac->m250_div_clk);
>> +     init.parent_names = clk_div_parents;
>> +     init.num_parents = ARRAY_SIZE(clk_div_parents);
>> +
>> +     dwmac->m25_div.reg = dwmac->regs + PRG_ETH0;
>> +     dwmac->m25_div.shift = PRG_ETH0_CLK_M25_DIV_SHIFT;
>> +     dwmac->m25_div.width = PRG_ETH0_CLK_M25_DIV_WIDTH;
>> +     dwmac->m25_div.table = clk_25m_div_table;
>> +     dwmac->m25_div.hw.init = &init;
>> +     dwmac->m25_div.flags = CLK_DIVIDER_ALLOW_ZERO;
>> +
>> +     dwmac->m25_div_clk = devm_clk_register(dev, &dwmac->m25_div.hw);
>> +     if (WARN_ON(PTR_ERR_OR_ZERO(dwmac->m25_div_clk)))
>> +             return PTR_ERR(dwmac->m25_div_clk);
>> +
>> +     return 0;
>
> This could be return WARN_ON(PTR_ERR_OR_ZERO(...))
This would work as well but I prefer the way it is right now (as one
could easily extend the code without having to touch any existing code
apart from the last return).
However, as it's always the case with personal preference: if
coding-style requires me to change it then I'll do so, just let me
know.

I have addressed all other issues you found (thanks for that!) in v4
(which I am about to send in the next few minutes).


Thanks,
Martin
