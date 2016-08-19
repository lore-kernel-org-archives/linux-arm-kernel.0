From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 20 Aug 2016 02:46:29 +0900
Subject: [PATCH v6 1/2] clk: uniphier: add core support code for UniPhier
 clock driver
In-Reply-To: <20160819002507.GS361@codeaurora.org>
References: <1470112223-24835-1-git-send-email-yamada.masahiro@socionext.com>
 <1470112223-24835-2-git-send-email-yamada.masahiro@socionext.com>
 <20160819002507.GS361@codeaurora.org>
Message-ID: <CAK7LNAQg-LcK-vsWVU-b0WsF=Y_NBNR_cWqNDJKyMqp7Svdvqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,


2016-08-19 9:25 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
>> +int uniphier_clk_probe(struct platform_device *pdev)
>
> static?


Thanks.
Will fix in v7.


>> +{
>> +     struct device *dev = &pdev->dev;
>> +     const struct of_device_id *match;
>> +     struct clk_hw_onecell_data *hw_data;
>> +     struct device_node *parent;
>> +     struct regmap *regmap;
>> +     const struct uniphier_clk_data *p;
>> +     int clk_num = 0;
>> +
>> +     match = of_match_node(uniphier_clk_match, dev->of_node);
>> +     if (!match)
>> +             return -ENODEV;
>
> We can use of_driver_match_device() to make this simpler.


I want to use the returned "match".
The of_driver_match_device() just checks if it matches or not,
so I do not think it can be the replacement.

I can use of_match_device() instead, if you like.



>> +
>> +     parent = of_get_parent(dev->of_node); /* parent should be syscon node */
>> +     regmap = syscon_node_to_regmap(parent);
>> +     of_node_put(parent);
>
> devm_get_regmap(dev->parent) should work then? Why do we need to
> use OF APIs?

"git grep devm_get_regmap" did not hit anything.

Where is it defined?



>> +     init.name = name;
>> +     init.ops = &clk_fixed_factor_ops;
>> +     init.flags = data->parent_name ? CLK_SET_RATE_PARENT : 0;
>> +     init.flags |= CLK_IS_BASIC;
>
> Please don't use CLK_IS_BASIC unless you need it. So far we've
> kept it to OMAP and I'm hoping to delete it.


Will do in v7.



-- 
Best Regards
Masahiro Yamada
