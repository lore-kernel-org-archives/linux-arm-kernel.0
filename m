From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Nov 2012 14:38:42 +0000
Subject: [PATCH 4/6] ASoC: wm8974: add SPI as a possible bus master
In-Reply-To: <1352469625-32024-5-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-5-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20121109143841.GG23807@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 03:00:23PM +0100, Steffen Trumtrar wrote:

> The wm8974 can be controlled via i2c or spi. The current driver only supports
> i2c. Add SPI as possible bus.
> 
> As the driver has to distinguish the bus type, pass this info via the wm8974_priv.
> This reverts c2562a8e3b5f871ad0b73caf98bb7541e8724efc, because the driver now
> needs it back.

Don't just quote raw commit IDs, *especially* not full ones, as they're
completely illegible to humans.  Someone reading the changelog needs to
be able to understand what this commit is and why the driver needs it
back.

> -	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
> +	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8974->control_type);

We should be converting things to regmap if we're going to do this -
we're trying to phase out the ASoC-specific I/O and this makes the code
simpler anyway as the core will just be able to get the regmap from the
struct device without bouncing information around through the private
data and so on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/ebbcce41/attachment.sig>
