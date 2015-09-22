From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Sep 2015 19:11:38 -0700
Subject: [PATCH 2/3] clk: bcm2835: Add a driver for the auxiliary
 peripheral clock gates.
In-Reply-To: <1441923750-19404-3-git-send-email-eric@anholt.net>
References: <1441923750-19404-1-git-send-email-eric@anholt.net>
 <1441923750-19404-3-git-send-email-eric@anholt.net>
Message-ID: <5600B8DA.4030406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2015 03:22 PM, Eric Anholt wrote:
> There are a pair of SPI masters and a mini UART that were last minute
> additions.  As a result, they didn't get integrated in the same way as
> the other gates off of the VPU clock in CPRMAN.

> diff --git a/drivers/clk/bcm/clk-bcm2835-aux.c b/drivers/clk/bcm/clk-bcm2835-aux.c

> +static int bcm2835_aux_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct clk_onecell_data *onecell;
> +	const char *parent;
> +	struct clk *parent_clk;
> +	void __iomem *reg;
> +
> +	parent_clk = of_clk_get(dev->of_node, 0);
> +	if (IS_ERR(parent_clk))
> +		return PTR_ERR(parent_clk);
> +	parent = __clk_get_name(parent_clk);

I think all the comments I made on probe() for the main bcm2835 clock
driver likely apply here too.

Also, is it "legal" for clock drivers to use __clk_get_name()? I thought
that was a clock core internal function, but may be wrong. I would have
expected to be able to pass a clock object when registering clocks
rather than a clock name, but oh well.

BTW, I like how this series shows how useful it is for someone with full
knowledge of the HW to come up with the DT bindings for a HW module;
once you know how the HW is actually designed, the correct binding ends
up being a lot easier to come up with, rather than guessing:-)
