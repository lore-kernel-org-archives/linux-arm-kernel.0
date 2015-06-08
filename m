From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 8 Jun 2015 15:27:51 +0800
Subject: [PATCH 0/5] Add Mediatek MT8173 subsystem clocks support
In-Reply-To: <20150606005912.GC29237@codeaurora.org>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <20150528132452.GI26575@pengutronix.de>
 <1432867649.15597.46.camel@mtksdaap41>
 <20150529062345.GY6325@pengutronix.de>
 <20150604210212.GM676@codeaurora.org> <1433468737.14416.7.camel@mtksdaap41>
 <20150606005912.GC29237@codeaurora.org>
Message-ID: <1433748471.15883.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, 2015-06-05 at 17:59 -0700, Stephen Boyd wrote:
> Perhaps an example would be best. In DT we would have:
> 
> 	vencsys: vencsys at 10000 {
> 		compatible = "mtk,vencsys";
> 		reg = <0x10000 0x1000>;
> 		#clock-cells = <1>;
> 		#reset-cells = <1>;
> 	};
> 
> 	myconsumer at 12000 {
> 		compatible = "mtk,vencsys";
> 		reg = <0x12000 0x100>;
> 		clocks = <&vencsys 10>;
> 		clock-names = "core";
> 	};
> 
> 	(Or are the consumers only children of the subsystem?
> 	It's not clear to me)

In our case the vencsys clocks may use used by its own driver and other
drivers (such as SMI driver).

> And then in the mtk,vencsys driver we would create a platform
> device named something like "mtk-vencsys-clk" and assign the
> of_node of the device to be the of_node that is assigned to the
> mtk,vencsys device.
> 
> 	static int vencsys_probe(struct platform_device *pdev)
> 	{
> 		int ret;
> 		struct device_node *np = pdev->dev.of_node;
> 		struct platform_device *clk_pdev;
> 
> 		clk_pdev = platform_device_alloc("mtk-vencsys-clk", -1);
> 		clk_pdev->dev.of_node = of_node;
> 		ret = platform_device_add(clk_pdev);
> 		if (ret)
> 			return ret;
> 	}
> 
> Then we could put a mtk-vencsys-clk driver in drivers/clk/ that
> does the clk driver part...
> 
> 	static int clk_vencsys_probe(struct platform_device *pdev)
> 	{
> 		int ret;
> 		struct device_node *np = pdev->dev.of_node;
> 		struct regmap *regmap;
> 
> 		ret = of_clk_add_provider(np, of_clk_src_onecell_get, ..);
> 		if (ret)
> 			return ret;
> 
> 		regmap = dev_get_regmap(pdev->dev.parent, NULL);
> 
> 	}
> 
> And similar things could be done for the reset driver.
> 

It looks like there is only one DT node (vencsys at 10000) but there are
several drivers refer to this DT node, and then we use a dummy driver
(or a "top driver") to aggregate drivers with different features (clk,
reset etc.).

It means we need to provide vencsys clk driver in drivers/clk and
vencsys reset driver in drivers/reset, and also to provide a vencsys top
driver in, for example, soc/mediatek, right?

Now we have 3 choice:

1. implement vencsys clock driver and reset driver in drivers/clk.
2. implement vencsys clock driver and reset driver in drivers/soc.
3. implement vencsys clock driver in drivers/clk, vencsys reset driver
in drivers/reset, and vencsys top driver in drivers/soc.

Sascha, do you have comments for these 3 solutions?


Best regards,

James
