From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 5 Jun 2015 17:59:12 -0700
Subject: [PATCH 0/5] Add Mediatek MT8173 subsystem clocks support
In-Reply-To: <1433468737.14416.7.camel@mtksdaap41>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <20150528132452.GI26575@pengutronix.de>
 <1432867649.15597.46.camel@mtksdaap41>
 <20150529062345.GY6325@pengutronix.de>
 <20150604210212.GM676@codeaurora.org>
 <1433468737.14416.7.camel@mtksdaap41>
Message-ID: <20150606005912.GC29237@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05, James Liao wrote:
> Hi Stephen,
> 
> On Thu, 2015-06-04 at 14:02 -0700, Stephen Boyd wrote:
> > On 05/29, Sascha Hauer wrote:
> > > Yes. I previously got the impression that the subsystem clocks are not
> > > directly associated to the larbs, but needed to be handled by the larb
> > > code due to some side effect. Now that I saw that the larbs are directly
> > > in the subsystem register space it all makes sense.
> > > 
> > > Note that the way Mediatek SoCs are designed around sub modules is bit
> > > unusual and does not fit very well in the Linux directory structure.
> > > Normally SoCs have a single clocks controller which controls all clocks
> > > in the SoC. Then you often have a reset controller providing reset lines
> > > in the SoC. In this case it's clear that the clk driver goes to
> > > drivers/clk/, the reset controller driver to drivers/reset/. Mediatek
> > > SoCs instead have several blocks, each with its own clock and reset
> > > controller. Splitting each block up into parts in drivers/clk/ and
> > > drivers/reset/ leads to quite a code fragmentation.
> > > This is my opinion, it would be great to hear something from others.
> > > Matthias? I'd like to avoid running into a direction that is not
> > > acceptable in the end.
> > 
> > We already have drivers registering clocks and resets under
> > drivers/clk, so it's not unheard of. An alternative solution is
> > to make child devices for the clock part and the reset part at
> > runtime in the toplevel driver for the vencsys device (don't do
> > any sort of DT description for this) and use regmap to mediate
> > the register accesses and locking. That way we can put the clk
> > driver in drivers/clk/, the reset driver in drivers/reset, etc.
> > so that logically related code is grouped.
> 
> I have a question about the alternative way you mentioned. Currently
> clock providers and consumers describe what clocks they will provide /
> consume in device tree. If we don't describe vencsys clocks in device
> tree, how to get vencsys clocks for drivers that need to control them?
> 

Perhaps an example would be best. In DT we would have:

	vencsys: vencsys at 10000 {
		compatible = "mtk,vencsys";
		reg = <0x10000 0x1000>;
		#clock-cells = <1>;
		#reset-cells = <1>;
	};

	myconsumer at 12000 {
		compatible = "mtk,vencsys";
		reg = <0x12000 0x100>;
		clocks = <&vencsys 10>;
		clock-names = "core";
	};

	(Or are the consumers only children of the subsystem?
	It's not clear to me)

And then in the mtk,vencsys driver we would create a platform
device named something like "mtk-vencsys-clk" and assign the
of_node of the device to be the of_node that is assigned to the
mtk,vencsys device.

	static int vencsys_probe(struct platform_device *pdev)
	{
		int ret;
		struct device_node *np = pdev->dev.of_node;
		struct platform_device *clk_pdev;

		clk_pdev = platform_device_alloc("mtk-vencsys-clk", -1);
		clk_pdev->dev.of_node = of_node;
		ret = platform_device_add(clk_pdev);
		if (ret)
			return ret;
	}

Then we could put a mtk-vencsys-clk driver in drivers/clk/ that
does the clk driver part...

	static int clk_vencsys_probe(struct platform_device *pdev)
	{
		int ret;
		struct device_node *np = pdev->dev.of_node;
		struct regmap *regmap;

		ret = of_clk_add_provider(np, of_clk_src_onecell_get, ..);
		if (ret)
			return ret;

		regmap = dev_get_regmap(pdev->dev.parent, NULL);

	}

And similar things could be done for the reset driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
