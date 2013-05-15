From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 May 2013 16:07:54 +0200
Subject: [RFC PATCHv3 3/6] clk: Add TI-Nspire clock drivers
In-Reply-To: <1368332581-94691-4-git-send-email-dt.tangr@gmail.com>
References: <1368332581-94691-1-git-send-email-dt.tangr@gmail.com>
 <1368332581-94691-4-git-send-email-dt.tangr@gmail.com>
Message-ID: <201305151607.54442.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 May 2013, Daniel Tang wrote:
> 
> Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
> ---
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-nspire.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 142 insertions(+)
>  create mode 100644 drivers/clk/clk-nspire.c

You are missing a binding in Documentation/devicetree, same as for some of
the other drivers in this series.

> +static int nspire_clk_read(struct device_node *node,
> +		struct nspire_clk_info *clk)
> +{
> +	u32 val;
> +	int ret;
> +	void __iomem *io;
> +	const char *type = NULL;
> +
> +	ret = of_property_read_string(node, "io-type", &type);
> +	if (ret)
> +		return ret;

Using a string here feels clumsy. Why not use the "compatible" property
to distinguish the different models?

> +static void __init nspire_ahbdiv_setup(struct device_node *node)
> +{
> +	int ret;
> +	struct clk *clk;
> +	const char *clk_name = node->name;
> +	const char *parent_name;
> +	struct nspire_clk_info info;
> +
> +	ret = nspire_clk_read(node, &info);
> +	if (WARN_ON(ret))
> +		return;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);

It seems strange to assign the clk_name variable to node->name
first and then overriding it with the clock-output-names property.
Is that intentional? If so, please explain it in a comment.

> +
> +	pr_info("TI-NSPIRE Base: %uMHz CPU: %uMHz AHB: %uMHz\n",
> +		info.base_clock / MHZ,
> +		info.base_clock / info.base_cpu_ratio / MHZ,
> +		info.base_clock / info.base_ahb_ratio / MHZ);
> +}
> +
> +CLK_OF_DECLARE(nspire_clk, "nspire-clock", nspire_clk_setup);
> +CLK_OF_DECLARE(nspire_ahbdiv, "nspire-ahb-divider", nspire_ahbdiv_setup);

I would put each of these lines directly under the function it references.

	Arnd
