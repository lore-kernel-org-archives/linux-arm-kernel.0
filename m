From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Oct 2013 09:21:08 -0700
Subject: [PATCH v2 2/6] ASoC: sirf: add I2S CPU DAI driver
In-Reply-To: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
References: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20131028162108.GD13643@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 06:37:04AM +0800, Barry Song wrote:

> +static int sirf_i2s_startup(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	pm_runtime_get_sync(dai->dev);
> +	return 0;
> +}

This appears to be duplicating functionality in the core?  It already
holds a runtime PM reference on the device while it's active.

> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		i2s_ctrl |= I2S_SLAVE_MODE;
> +		i2s_tx_rx_ctrl &= ~I2S_MCLK_EN;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		i2s_ctrl &= ~I2S_SLAVE_MODE;
> +		i2s_tx_rx_ctrl |= I2S_MCLK_EN;
> +		break;

Why is I2S_MCLK_EN being controlled here?  This looks like a clock
outside the actual DAI and it's possible someone might wnat to use the
AP to generate MCLK but still have the CODEC drive the frame and bit
clocks on the bus.

> +	default:
> +		dev_err(dai->dev, " Only normal bit clock, normal frame clock supported\n");
> +		return -EINVAL;

Extra space at the start of the log message.

> +static int sirf_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
> +{
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +	u32 val;
> +	u32 bclk_div_coefficient;
> +
> +	if (div < 2 || div % 2) {
> +		dev_err(dai->dev, "BITCLK divider must greater than 1,"
> +			"And must is a multiple of 2\n");
> +		return -EINVAL;
> +	}

Why must the user manually configure the bitclock divider?  I would
expect the driver to be able to configure this automatically.

> +static struct snd_soc_dai_driver sirf_i2s_dai = {
> +	.probe = sirf_i2s_dai_probe,
> +	.name		= "sirf-i2s",
> +	.id			= 0,

The indentation here is pretty inconsistent.

> +static int sirf_i2s_runtime_resume(struct device *dev)
> +{
> +	struct sirf_i2s *si2s = dev_get_drvdata(dev);
> +	clk_prepare_enable(si2s->clk);
> +	device_reset(dev);
> +	return 0;

You should be checking the return value here.

> +	ret = snd_soc_register_component(&pdev->dev, &sirf_i2s_component,
> +			&sirf_i2s_dai, 1);

devm_snd_soc_register_component().

> +	if (ret) {
> +		dev_err(&pdev->dev, "Register Audio SoC dai failed.\n");
> +		goto err;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);

You need to enable runtime PM prior to registering otherwise something
may try to use the driver prior to it being enabled.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/66c112eb/attachment.sig>
