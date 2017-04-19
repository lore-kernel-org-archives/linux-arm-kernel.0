From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Apr 2017 09:00:05 -0700
Subject: [PATCH V2] clk: hi6220: Add the hi655x's pmic clock
In-Reply-To: <20170416205713.GW2078@mai>
References: <1491683412-12237-1-git-send-email-daniel.lezcano@linaro.org>
 <20170412150245.GK7065@codeaurora.org> <20170416205713.GW2078@mai>
Message-ID: <20170419160005.GS7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16, Daniel Lezcano wrote:
> On Wed, Apr 12, 2017 at 08:02:45AM -0700, Stephen Boyd wrote:
> > On 04/08, Daniel Lezcano wrote:
>  
> > > +	struct hi655x_clk *hi655x_clk;
> > > +	const char *clk_name = "hi655x-clk";
> > > +	int ret;
> > > +
> > > +	hi655x_clk = devm_kzalloc(&pdev->dev, sizeof(*hi655x_clk), GFP_KERNEL);
> > > +	if (!hi655x_clk)
> > > +		return -ENOMEM;
> > > +
> > > +	hi655x_clk_init = devm_kzalloc(&pdev->dev, sizeof(*hi655x_clk_init),
> > > +				       GFP_KERNEL);
> > > +	if (!hi655x_clk_init)
> > > +		return -ENOMEM;
> > > +
> > > +	of_property_read_string_index(parent->of_node, "clock-output-names",
> > > +				      0, &clk_name);
> > > +
> > > +	hi655x_clk_init->name	= clk_name;
> > > +	hi655x_clk_init->ops	= &hi655x_clk_ops;
> > > +
> > > +	hi655x_clk->clk_hw.init	= hi655x_clk_init;
> > > +	hi655x_clk->hi655x	= hi655x;
> > > +
> > > +	platform_set_drvdata(pdev, hi655x_clk);
> > > +
> > > +	ret = devm_clk_hw_register(&pdev->dev, &hi655x_clk->clk_hw);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
> > > +				     &hi655x_clk->clk_hw);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = clk_hw_register_clkdev(&hi655x_clk->clk_hw, clk_name, NULL);
> > 
> > Missed this last time. Do you use this clkdev lookup? The name is
> > usually supposed to be based on what the device is expecting,
> > instead of clk_name, and we would want some device name for the
> > third argument here.
> 
> I'm not sure to get your comment. Are you saying the clk_name should be the
> third argument?
> 
> 

Sorry, no. I meant that con_id is typically something like "core"
or "ahb" or something like that, and dev_id is something like
"a456002.pmic_device" or whatever dev_name(pmic_dev) would return for
the consuming device. That way when we call clk_get(dev, "core")
it will find the lookup with "core" and "a456002.pmic_device" to
match up the clk lookup.

If anything, the clk_name should just go into the con_id for now,
and then it will need to be a globally unique identifier for the
clk. But that is going against how clkdev is supposed to be used.
Hence the question if you even need to use it. If not, just don't
add it. I can fix up v3 of this patch to put clk_name back at
con_id if you like. No need to resend.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
