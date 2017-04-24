From: igall@marvell.com (Igal Liberman)
Date: Mon, 24 Apr 2017 08:50:32 +0000
Subject: [PATCH v3 2/3] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <20170424075407.19730-3-antoine.tenart@free-electrons.com>
References: <20170424075407.19730-1-antoine.tenart@free-electrons.com>
 <20170424075407.19730-3-antoine.tenart@free-electrons.com>
Message-ID: <8ff65d6a5e5e4d388d3c5a384e4f5fd6@IL-EXCH01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +	priv->clk = of_clk_get(dev->of_node, 0);
> +	if (!IS_ERR(priv->clk)) {
> +		ret = clk_prepare_enable(priv->clk);
> +		if (ret) {
> +			dev_err(dev, "unable to enable clk (%d)\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		/* The clock isn't mandatory */
> +		if (PTR_ERR(priv->clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));

The correct address width of the engine in Marvell SoCs is 40bit.

> +	if (ret)
> +		goto err_clk;
> +
> +	priv->context_pool = dmam_pool_create("safexcel-context", dev,
> +					      sizeof(struct
> safexcel_context_record),
> +					      1, 0);
> +	if (!priv->context_pool) {
> +		ret = -ENOMEM;
> +		goto err_clk;
> +	}
> +

Thanks,
Igal
