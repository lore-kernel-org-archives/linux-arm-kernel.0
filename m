From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Aug 2016 15:20:07 +0200
Subject: [PATCH 2/4 v2] soc: qcom: add EBI2 driver
In-Reply-To: <1472028758-29272-3-git-send-email-linus.walleij@linaro.org>
References: <1472028758-29272-1-git-send-email-linus.walleij@linaro.org>
 <1472028758-29272-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <201608291520.07798.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 August 2016, Linus Walleij wrote:

> +static void qcom_ebi2_setup_chipselect(struct device_node *np,
> +				       struct device *dev,
> +				       void __iomem *ebi2_base,
> +				       void __iomem *ebi2_xmem,
> +				       u32 csindex)
> +{
> +	const struct cs_data *csd;
> +	u32 slowcfg, fastcfg;
> +	u32 val;
> +	int ret;
> +	int i;
> +
> +	csd = &cs_info[csindex];
> +	val = readl_relaxed(ebi2_base);
> +	val |= csd->enable_mask;
> +	writel_relaxed(val, ebi2_base);
> +	dev_dbg(dev, "enabled CS%u\n", csindex);

better use readl/writel instead of *_relaxed() if it's not performance critical.
If you have a function that is worth optimizing with relaxed accessors, add a
comment about how your concluded that it's safe to do so.

> +static struct platform_driver qcom_ebi2_driver = {
> +	.probe = qcom_ebi2_probe,
> +	.driver = {
> +		.name = "qcom-ebi2",
> +		.of_match_table = qcom_ebi2_of_match,
> +	},
> +};
> +builtin_platform_driver(qcom_ebi2_driver);

Why not allow this to be a loadable module?

	Arnd
