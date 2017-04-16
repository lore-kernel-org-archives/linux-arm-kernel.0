From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:57:13 +0200
Subject: [PATCH V2] clk: hi6220: Add the hi655x's pmic clock
In-Reply-To: <20170412150245.GK7065@codeaurora.org>
References: <1491683412-12237-1-git-send-email-daniel.lezcano@linaro.org>
 <20170412150245.GK7065@codeaurora.org>
Message-ID: <20170416205713.GW2078@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 08:02:45AM -0700, Stephen Boyd wrote:
> On 04/08, Daniel Lezcano wrote:
> >  
> >  Example:
> >  	pmic: pmic at f8000000 {
> > @@ -24,4 +29,5 @@ Example:
> >  		interrupt-controller;
> >  		#interrupt-cells = <2>;
> >  		pmic-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> > +		clock-cells = <0>;
> 
> Should be #clock-cells instead.

Ok.

> > +static int hi655x_clk_probe(struct platform_device *pdev)
> > +{
> > +	struct device *parent = pdev->dev.parent;
> > +	struct hi655x_pmic *hi655x = dev_get_drvdata(parent);
> > +	struct clk_init_data *hi655x_clk_init;
> 
> This can just go onto the stack? We don't need it around after
> probe.

Agree.
 
> > +	struct hi655x_clk *hi655x_clk;
> > +	const char *clk_name = "hi655x-clk";
> > +	int ret;
> > +
> > +	hi655x_clk = devm_kzalloc(&pdev->dev, sizeof(*hi655x_clk), GFP_KERNEL);
> > +	if (!hi655x_clk)
> > +		return -ENOMEM;
> > +
> > +	hi655x_clk_init = devm_kzalloc(&pdev->dev, sizeof(*hi655x_clk_init),
> > +				       GFP_KERNEL);
> > +	if (!hi655x_clk_init)
> > +		return -ENOMEM;
> > +
> > +	of_property_read_string_index(parent->of_node, "clock-output-names",
> > +				      0, &clk_name);
> > +
> > +	hi655x_clk_init->name	= clk_name;
> > +	hi655x_clk_init->ops	= &hi655x_clk_ops;
> > +
> > +	hi655x_clk->clk_hw.init	= hi655x_clk_init;
> > +	hi655x_clk->hi655x	= hi655x;
> > +
> > +	platform_set_drvdata(pdev, hi655x_clk);
> > +
> > +	ret = devm_clk_hw_register(&pdev->dev, &hi655x_clk->clk_hw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
> > +				     &hi655x_clk->clk_hw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = clk_hw_register_clkdev(&hi655x_clk->clk_hw, clk_name, NULL);
> 
> Missed this last time. Do you use this clkdev lookup? The name is
> usually supposed to be based on what the device is expecting,
> instead of clk_name, and we would want some device name for the
> third argument here.

I'm not sure to get your comment. Are you saying the clk_name should be the
third argument?


-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
