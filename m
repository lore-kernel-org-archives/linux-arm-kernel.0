From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Dec 2014 17:29:28 +0000
Subject: [PATCH 3/5] ASoC: dwc: Iterate over all channels
In-Reply-To: <547F3CA5.2010500@arm.com>
References: <547F3CA5.2010500@arm.com>
Message-ID: <20141203172928.GD7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 04:39:01PM +0000, Andrew Jackson wrote:

> +	/* Iterate over set of channels - independently controlled.
> +	 */
> +	do {
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			i2s_write_reg(dev->i2s_base, TCR(ch_reg),
> +				      xfer_resolution);
> +			i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
> +			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
> +			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
> +			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
> +		} else {
> +			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
> +				      xfer_resolution);
> +			i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
> +			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
> +			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
> +			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
> +		}
> +	} while (ch_reg-- > 0);

The normal way to write an iteration would be with a for loop - why are
we not doing that?

Also I see that you've not sent these as a single thread - please use
--thread.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/4c734ecb/attachment.sig>
