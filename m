From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 29 Sep 2015 15:26:14 +0200
Subject: [PATCH 2/2] ASoC: atmel-i2s: add driver for the new Atmel I2S
 controller
In-Reply-To: <9b9890682c47fd2669aeed529225ebf44eca5cf6.1443452274.git.cyrille.pitchen@atmel.com>
References: <cover.1443452274.git.cyrille.pitchen@atmel.com>
 <9b9890682c47fd2669aeed529225ebf44eca5cf6.1443452274.git.cyrille.pitchen@atmel.com>
Message-ID: <560A9176.9070007@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/09/2015 17:05, Cyrille Pitchen a ?crit :
[...]
> +	/* Get audio clocks to generate the I2S Master Clock (I2S_MCK) */
> +	dev->aclk = devm_clk_get(&pdev->dev, "aclk");
> +	dev->gclk = devm_clk_get(&pdev->dev, "gclk");
> +	if (IS_ERR(dev->aclk) && IS_ERR(dev->gclk)) {
> +		/* Master Mode not supported */
> +		dev->aclk = NULL;
> +		dev->gclk = NULL;
> +	} else if (IS_ERR(dev->gclk)) {
> +		err = PTR_ERR(dev->gclk);
> +		dev_err(&pdev->dev,
> +			"failed to get the PMC generated clock: %d\n", err);
> +		return err;
> +	} else if (IS_ERR(dev->aclk)) {
> +		err = PTR_ERR(dev->aclk);
> +		dev_err(&pdev->dev,
> +			"failed to get the PLL audio clock: %d\n", err);
> +		return err;
> +	}
> +
> +	/* Do hardware specific settings to initialize I2S_MCK generator */
> +	if (dev->caps && dev->caps->mck_init) {
> +		err = dev->caps->mck_init(dev, np);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* Enable the peripheral clock. */
> +	err = clk_prepare_enable(dev->pclk);
> +	if (err)
> +		return err;
> +
> +	dev->dev = &pdev->dev;
> +	dev->regmap = regmap;
> +	platform_set_drvdata(pdev, dev);

those last 3 lines should be moved before calling dev->caps->mck_init(),
otherwise dev->dev would not be initialized yet if dev_err() is called by
atmel_i2s_sama5d2_mck_init().

Will be fixed in the next series.
[...]
