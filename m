From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Jun 2013 09:33:08 +0100
Subject: [PATCH 3/3] ASoC: sgtl5000: Defer probe in case of I2C error
In-Reply-To: <1372168801-4221-3-git-send-email-fabio.estevam@freescale.com>
References: <1372168801-4221-1-git-send-email-fabio.estevam@freescale.com>
 <1372168801-4221-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130626083308.GL27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 11:00:01AM -0300, Fabio Estevam wrote:
> In case of I2C error, let's defer the probe.
> 
> On mx28, for example, the first read of the codec revision register fails 
> because there is no codec clock provided at this point. The codec clock will be 
> enabled later in the mxs-saif driver, so return -EPROBE_DEFER in case of I2C 
> read error, so that the codec driver can do another attempt at a later stage 
> when the codec clock is available.

This doesn't seem to match up with the code:

>  	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
> -	if (ret)
> +	if (ret) {
> +		ret = -EPROBE_DEFER; /* If I2C read failed, try again later */
>  		goto disable_clk;
>  
> +	}

Looking at the label we jump to here it seems like the clock really
should be enabled at the point where the register read is attempted...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/aa9024db/attachment.sig>
