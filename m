From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Nov 2013 11:25:14 -0700
Subject: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131101182514.GE2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 03:04:48PM +0800, Xiubo Li wrote:

> +static int fsl_sai_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
> +		int div_id, int div)
> +{
> +	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> +	u32 tcr2, rcr2;
> +
> +	if (div_id == FSL_SAI_TX_DIV) {
> +		tcr2 = readl(sai->base + FSL_SAI_TCR2);
> +		tcr2 &= ~FSL_SAI_CR2_DIV_MASK;
> +		tcr2 |= FSL_SAI_CR2_DIV(div);
> +		writel(tcr2, sai->base + FSL_SAI_TCR2);

What is this divider and why does the user have to set it manually?

> +	} else
> +		return -EINVAL;
> +

Coding style?

> +static int fsl_sai_dai_probe(struct snd_soc_dai *dai)
> +{
> +	int ret;
> +	struct fsl_sai *sai = dev_get_drvdata(dai->dev);
> +
> +	ret = clk_prepare_enable(sai->clk);
> +	if (ret)
> +		return ret;

It'd be nicer to only enable the clock while the device is in active
use.

> +	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL,
> +			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> +	if (ret)
> +		return ret;

We should have a devm_ version of this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131101/6f21a6bb/attachment.sig>
