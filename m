From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 Jul 2013 19:13:13 +0100
Subject: [PATCH 3/6] ASoC: usp-pcm: add CPU DAI driver for PCM simulated
 from USP
In-Reply-To: <1374232042-26088-4-git-send-email-Baohua.Song@csr.com>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-4-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130719181313.GT9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 07:07:19PM +0800, Barry Song wrote:

> +static int sirf_usp_pcm_divider(struct snd_soc_dai *dai, int div_id, int rate)
> +{
> +	struct sirf_usp *susp = snd_soc_dai_get_drvdata(dai);
> +
> +	u32 clk_rate = clk_get_rate(susp->clk);
> +	u32 clk_div = (clk_rate/(2*rate)) - 1;
> +	u32 clk_div_hi = (clk_div & 0xC00)>>10;
> +	u32 clk_div_lo = (clk_div & 0x3FF);
> +
> +	writel((clk_div_lo<<21) | readl(susp->base + USP_MODE2),
> +		susp->base + USP_MODE2);
> +	writel((clk_div_hi<<30) | readl(susp->base + USP_TX_FRAME_CTRL),
> +		susp->base + USP_TX_FRAME_CTRL);
> +
> +	return 0;
> +}

I'd be happier if this did some validation on the supplied rate (for
example, checking that it's less than the master rate) and had arguments
specifying which clock was being affected (in case there's more in
future revisions).

Also what exactly is the rate being set - can the driver just figure
this out automatically from the sample rate?

> +#ifdef CONFIG_PM
> +static int sirf_usp_pcm_suspend(struct platform_device *pdev,
> +	pm_message_t state)
> +{
> +	struct sirf_usp *susp = platform_get_drvdata(pdev);
> +
> +	susp->mode1_reg = readl(susp->base + USP_MODE1);
> +	susp->mode2_reg = readl(susp->base + USP_MODE2);
> +	sirf_usp_controller_uninit(susp);
> +	clk_disable_unprepare(susp->clk);
> +
> +	return 0;
> +}

Can this be done as runtime PM as well?  Seems like it'd save power.

> +	susp->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(susp->clk)) {
> +		dev_err(&pdev->dev, "Get clock failed.\n");
> +		return PTR_ERR(susp->clk);
> +	}

devm_clk_get().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130719/e8735988/attachment.sig>
