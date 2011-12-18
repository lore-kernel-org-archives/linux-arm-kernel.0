From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 18 Dec 2011 16:42:08 +0100
Subject: [PATCH 1/3] i2c: tegra: Support DVC controller in device tree
In-Reply-To: <1324186101-23695-1-git-send-email-swarren@nvidia.com>
References: <1324186101-23695-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111218154208.GA5600@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
[...]
> @@ -636,7 +649,18 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  			i2c_dev->bus_clk_rate = be32_to_cpup(prop);
>  	}
>  
> -	if (pdev->id == 3)
> +#if defined(CONFIG_OF)
> +	if (pdev->dev.of_node) {
> +		const struct of_device_id *match;
> +
> +		match = of_match_device(tegra_i2c_of_match, &pdev->dev);
> +		if (!match)
> +			return -EINVAL;
> +
> +		i2c_dev->is_dvc = match->data;
> +	}
> +#endif
> +	else if (pdev->id == 3)

Shouldn't the "else" move into the CONFIG_OF branch?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111218/200453ba/attachment.sig>
