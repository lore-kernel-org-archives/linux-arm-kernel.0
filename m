From: songjun.wu@atmel.com (Wu, Songjun)
Date: Tue, 19 Apr 2016 18:02:46 +0800
Subject: [PATCH 1/2] [media] atmel-isc: add the Image Sensor Controller
 code
In-Reply-To: <81160604.beJHM8QlLS@avalon>
References: <1460533460-32336-1-git-send-email-songjun.wu@atmel.com>
 <1460533460-32336-2-git-send-email-songjun.wu@atmel.com>
 <81160604.beJHM8QlLS@avalon>
Message-ID: <57160246.2060804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/15/2016 00:21, Laurent Pinchart wrote:
>> >+		return -EINVAL;
>> >+
>> >+	parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
>> >+	if (!parent_names)
>> >+		return -ENOMEM;
>> >+
>> >+	of_clk_parent_fill(np, parent_names, num_parents);
>> >+
>> >+	init.parent_names	= parent_names;
>> >+	init.num_parents	= num_parents;
>> >+	init.name		= clk_name;
>> >+	init.ops		= &isc_clk_ops;
>> >+	init.flags		= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
>> >+
>> >+	isc_clk = &isc->isc_clks[id];
>> >+	isc_clk->hw.init	= &init;
>> >+	isc_clk->regmap		= regmap;
>> >+	isc_clk->lock		= lock;
>> >+	isc_clk->id		= id;
>> >+
>> >+	isc_clk->clk = clk_register(NULL, &isc_clk->hw);
>> >+	if (!IS_ERR(isc_clk->clk))
>> >+		of_clk_add_provider(np, of_clk_src_simple_get, isc_clk->clk);
>> >+	else {
>> >+		dev_err(isc->dev, "%s: clock register fail\n", clk_name);
>> >+		ret = PTR_ERR(isc_clk->clk);
>> >+		goto free_parent_names;
>> >+	}
>> >+
>> >+free_parent_names:
>> >+	kfree(parent_names);
>> >+	return ret;
>> >+}
>> >+
>> >+static int isc_clk_init(struct isc_device *isc)
>> >+{
>> >+	struct device_node *np = of_get_child_by_name(isc->dev->of_node,
>> >+						      "clk_in_isc");
> Do you really need the clk_in_isc DT node ? I would have assumed that the
> clock topology inside the ISC is fixed, and that it would be enough to just
> specify the three parent clocks in the ISC DT node and create the two internal
> clocks in the driver without needing a DT description.
>
Hi Laurent,

I think more, and the clk_in_isc DT node should be needed. The clock 
topology inside the ISC is fixed, but isc will provide the clock to 
sensor, we need create the corresponding clock node int DT file, then 
the sensor will get this clock and set the clock rate in DT file.
