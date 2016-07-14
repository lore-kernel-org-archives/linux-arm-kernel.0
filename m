From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Jul 2016 17:20:59 +0100
Subject: [PATCH v3 2/2] ASoC: atmel-i2s: add driver for the new Atmel I2S
 controller
In-Reply-To: <ca944501da6c2bb6240f4a56e8d2ba5221373408.1468405019.git.cyrille.pitchen@atmel.com>
References: <cover.1468405019.git.cyrille.pitchen@atmel.com>
 <ca944501da6c2bb6240f4a56e8d2ba5221373408.1468405019.git.cyrille.pitchen@atmel.com>
Message-ID: <20160714162059.GB30372@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 12:25:39PM +0200, Cyrille Pitchen wrote:

A few small things but otherwise this looks good:

> +	switch (params_channels(params)) {
> +	case 1:
> +		mr |= is_playback ? ATMEL_I2SC_MR_TXMONO : ATMEL_I2SC_MR_RXMONO;

Please write normal if statements, it makes things easier to read.

> +		break;
> +	case 2:
> +		break;
> +	default:
> +		dev_err(dev->dev, "unsupported number of audio channels\n");
> +		break;
> +	}

Why don't we return an error if we don't support the requested number of
channels?

> +	dev->gclk = devm_clk_get(&pdev->dev, "gclk");
> +	if (IS_ERR(dev->aclk) && IS_ERR(dev->gclk)) {
> +		/* Master Mode not supported */
> +		dev->aclk = NULL;
> +		dev->gclk = NULL;

This won't handle probe deferral properly, it'll just ignore the clocks
if we get -EPROBE_DEFER.  The driver should special case that at least.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160714/35b5e76c/attachment.sig>
