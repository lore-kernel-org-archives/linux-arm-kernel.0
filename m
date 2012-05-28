From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 May 2012 15:59:05 +0100
Subject: [PATCH 3/4] ASOC: mmp: add sspa support
In-Reply-To: <1337929863-31885-4-git-send-email-zhangfei.gao@marvell.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-4-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <20120528145904.GK4032@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 03:11:02PM +0800, Zhangfei Gao wrote:
> The SSPA is a configurable multi-channel audio serial (TDM) interface.
> It's configurable at runtime to support up to 128 channels and the
> number of bits per sample: 8, 12, 16, 20, 24 and 32 bits. It also
> support stereo format: I2S, left-justified or right-justified.

Mostly looks good.  A few fairly minor things...

> +static int mmp_sspa_startup(struct snd_pcm_substream *substream,
> +	struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct sspa_priv *sspa_priv = snd_soc_dai_get_drvdata(dai);
> +	struct ssp_device *sspa = sspa_priv->sspa;
> +	int ret = 0;
> +
> +	if (!cpu_dai->active) {
> +		clk_enable(sysclk);
> +		clk_enable(sspa->clk);
> +	}

The clock API is refcounted so you shouldn't need to worry about
multiple enables, you should just be able to unconditionally enable and
disable.  If this is needed we probably have a problem we should fix.

> +	switch (pll_id) {
> +	case MMP_SYSCLK:
> +		clk_set_rate(sysclk, freq_out);
> +		break;
> +	case MMP_SSPA_CLK:
> +		clk_set_rate(sspa->clk, freq_out);
> +		break;

You're ignoring the return values here.

> +	priv->sspa->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->sspa->clk)) {
> +		ret = PTR_ERR(priv->sspa->clk);
> +		goto err_free_clk;
> +	}

devm_clk_get().

> +	res = request_mem_region(res->start, resource_size(res),
> +			pdev->name);
> +	if (res == NULL) {
> +		dev_err(&pdev->dev, "failed to request memory resource\n");
> +		ret = -EBUSY;
> +		goto err_get_res;
> +	}
> +
> +	priv->sspa->mmio_base = ioremap(res->start, resource_size(res));
> +	if (priv->sspa->mmio_base == NULL) {
> +		dev_err(&pdev->dev, "failed to ioremap() registers\n");
> +		ret = -ENODEV;
> +		goto err_free_mem;
> +	}

devm_request_and_ioremap().

> +err_free_clk:
> +	devm_kfree(&pdev->dev, priv->dma_params);
> +err_priv_dma_params:
> +	devm_kfree(&pdev->dev, priv->sspa);
> +err_priv_sspa:
> +	devm_kfree(&pdev->dev, priv);

The whole point of the devm_ stuff is that you don't need to do stuff
like this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120528/44c66208/attachment.sig>
