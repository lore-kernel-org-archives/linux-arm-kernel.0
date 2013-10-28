From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Oct 2013 14:31:05 -0700
Subject: [PATCH v2 3/6] ASoC: usp-pcm: add CPU DAI driver for PCM
 simulated from USP
In-Reply-To: <1382914576-4785-1-git-send-email-Baohua.Song@csr.com>
References: <1382914576-4785-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20131028213105.GB20960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 06:56:16AM +0800, Barry Song wrote:

> +static int sirf_usp_pcm_divider(struct snd_soc_dai *dai, int div_id, int rate)
> +{
> +	struct sirf_usp *susp = snd_soc_dai_get_drvdata(dai);
> +	u32 clk_rate, clk_div, clk_div_hi, clk_div_lo;
> +
> +	if (div_id != SIRF_USP_DIV_MCLK)
> +		return -EINVAL;

This is fine as far as it goes but why is this something that can't be
calculated automatically at runtime based on the sample rate the driver
is given?

> +	/* Congiure TX FIFO Level Check register */

Typo.

> +static int sirf_usp_pcm_runtime_resume(struct device *dev)
> +{
> +	struct sirf_usp *susp = dev_get_drvdata(dev);
> +	clk_prepare_enable(susp->clk);

Should check the return value here.

> +	clk_prepare_enable(susp->clk);

Should check the return value.

> +	ret = snd_soc_register_component(&pdev->dev, &sirf_usp_component,
> +		&sirf_usp_pcm_dai, 1);

devm_snd_soc_register_component() please.

> +	if (ret) {
> +		dev_err(&pdev->dev, "Register Audio SoC dai failed.\n");
> +		goto err;
> +	}
> +	pm_runtime_enable(&pdev->dev);

This needs to happen prior to registration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/e8ba8bdc/attachment.sig>
