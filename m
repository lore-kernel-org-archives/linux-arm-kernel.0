From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Aug 2015 14:03:11 +0100
Subject: [PATCH v3 2/4] ASoC: rockchip: Add rockchip SPDIF transceiver
 driver
In-Reply-To: <1438947854-3743-3-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1438947854-3743-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438947854-3743-3-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <20150807130311.GW20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 01:44:12PM +0200, Sjoerd Simons wrote:

> Changes in v2:
> - Remove platform: module alias as it was unused

Ugh, I see Paul Bolle replied to one of your earlier patches :/  Please
just ignore him, he doesn't understand that we don't require machine
definitions to be in tree.  A platform: module alias is useful for any
platform device.

> +static inline struct rk_spdif_dev *to_info(struct snd_soc_dai *dai)
> +{
> +	return snd_soc_dai_get_drvdata(dai);
> +}

I'm not sure this is adding much to the two users but whatever.

> +static int rk_spdif_snd_txctrl(struct rk_spdif_dev *spdif, int on)
> +{
> +	int ret;
> +
> +	if (on) {
> +		ret = regmap_update_bits(spdif->regmap, SPDIF_DMACR,
> +				   SPDIF_DMACR_TDE_ENABLE,
> +				   SPDIF_DMACR_TDE_ENABLE);
> +
> +		if (ret != 0)
> +			goto bail;
> +
> +		ret = regmap_update_bits(spdif->regmap, SPDIF_XFER,
> +				   SPDIF_XFER_TXS_START,
> +				   SPDIF_XFER_TXS_START);

This function has no common code, just two branches in an if/else that
share nothing and is called from a single location.  Why not just inline
this into the trigger function?

> +	/* Set clock and calculate divider */
> +	clk_set_rate(spdif->mclk, mclk);

We should check the return value of clk_set_rate().

> +	spdif->hclk = devm_clk_get(&pdev->dev, "spdif_hclk");
> +	if (IS_ERR(spdif->hclk)) {
> +		dev_err(&pdev->dev, "Can't retrieve rk_spdif bus clock\n");
> +		return PTR_ERR(spdif->hclk);
> +	}
> +	ret = clk_prepare_enable(spdif->hclk);
> +	if (ret) {
> +		dev_err(spdif->dev, "hclock enable failed %d\n", ret);
> +		return ret;
> +	}

I notice that we don't manage the hclk over suspend/resume - should we
perhaps be using regmap_init_mmio_clk() together with runtime PM to
manage it?

> +	pm_runtime_enable(&pdev->dev);
> +	if (!pm_runtime_enabled(&pdev->dev)) {
> +		ret = rk_spdif_runtime_resume(&pdev->dev);
> +		if (ret)
> +			goto err_pm_disable;
> +	}

The normal pattern with this is to start the device powered up then idle
it - this does mean we need to bounce the power on but fitting in with
the common pattern is good and it's less conditional code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150807/644ccefb/attachment.sig>
