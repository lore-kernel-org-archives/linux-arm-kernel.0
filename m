From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Aug 2016 12:16:12 -0700
Subject: [PATCH v6 1/2] clk: uniphier: add core support code for UniPhier
 clock driver
In-Reply-To: <CAK7LNAQg-LcK-vsWVU-b0WsF=Y_NBNR_cWqNDJKyMqp7Svdvqg@mail.gmail.com>
References: <1470112223-24835-1-git-send-email-yamada.masahiro@socionext.com>
 <1470112223-24835-2-git-send-email-yamada.masahiro@socionext.com>
 <20160819002507.GS361@codeaurora.org>
 <CAK7LNAQg-LcK-vsWVU-b0WsF=Y_NBNR_cWqNDJKyMqp7Svdvqg@mail.gmail.com>
Message-ID: <20160819191612.GU361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20, Masahiro Yamada wrote:
> 2016-08-19 9:25 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> >> +{
> >> +     struct device *dev = &pdev->dev;
> >> +     const struct of_device_id *match;
> >> +     struct clk_hw_onecell_data *hw_data;
> >> +     struct device_node *parent;
> >> +     struct regmap *regmap;
> >> +     const struct uniphier_clk_data *p;
> >> +     int clk_num = 0;
> >> +
> >> +     match = of_match_node(uniphier_clk_match, dev->of_node);
> >> +     if (!match)
> >> +             return -ENODEV;
> >
> > We can use of_driver_match_device() to make this simpler.
> 
> 
> I want to use the returned "match".
> The of_driver_match_device() just checks if it matches or not,
> so I do not think it can be the replacement.
> 
> I can use of_match_device() instead, if you like.

Sorry I meant of_device_get_match_data().

> 
> 
> 
> >> +
> >> +     parent = of_get_parent(dev->of_node); /* parent should be syscon node */
> >> +     regmap = syscon_node_to_regmap(parent);
> >> +     of_node_put(parent);
> >
> > devm_get_regmap(dev->parent) should work then? Why do we need to
> > use OF APIs?
> 
> "git grep devm_get_regmap" did not hit anything.
> 
> Where is it defined?
> 

Sorry I meant dev_get_regmap().

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
