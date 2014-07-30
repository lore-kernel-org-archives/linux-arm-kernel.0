From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Jul 2014 18:50:33 +0100
Subject: [PATCH 2/2] clk: initial clock driver for TWL6030
In-Reply-To: <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
Message-ID: <20140730175033.GA17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 04:02:29PM +0200, Stefan Assmann wrote:

> +static int twl6030_clk32kg_is_prepared(struct clk_hw *hw)
> +{
> +	struct twl6030_desc *desc = to_twl6030_desc(hw);
> +
> +	return desc->enabled;
> +}

Why not just check the register map - can't the register be cached?  If
that's not possible a comment would be good.

> +static int of_twl6030_clk32kg_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk *clk;
> +	int ret = 0;
> +
> +	if (!node)
> +		return -ENODEV;
> +
> +	clk = clk_get(&pdev->dev, "clk32kg");

devm_clk_get()?

> +	if (IS_ERR(clk))
> +		ret = -EPROBE_DEFER;

Shouldn't the provided return code be being used?

> +	else
> +		clk_prepare(clk);

Why is the clock driver defaulting to enabling the clock, and if it
needs to shouldn't it be doing a prepere_enable() even if the enable
happens not to do anything to the hardware?  Otherwise child clocks
might get confused.

The return value is also not being checked.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/ed6a6771/attachment.sig>
