From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Dec 2013 13:16:43 +0000
Subject: [PATCH v3 5/9] ASoC: fsl-ssi: Add offline_config flag
In-Reply-To: <1387367865-26391-6-git-send-email-mpa@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20131219131643.GA31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 12:57:41PM +0100, Markus Pargmann wrote:

> +	/*
> +	 * imx51 and later SoCs have a slightly different IP that allows the
> +	 * SSI configuration while the SSI unit is running.
> +	 *
> +	 * More important, it is necessary on those SoCs to configure the
> +	 * sperate TX/RX DMA bits just before starting the stream
> +	 * (fsl_ssi_trigger). The SDMA unit has to be configured before fsl_ssi
> +	 * sends any DMA requests to the SDMA unit, otherwise it is not defined
> +	 * how the SDMA unit handles the DMA request.
> +	 *
> +	 * SDMA units are present on devices starting at imx35 but the imx35
> +	 * reference manual states that the DMA bits should not be changed
> +	 * while the SSI unit is running (SSIEN). So we support the necessary
> +	 * online configuration of fsl-ssi starting at imx51.
> +	 */
> +	if (hw_type != FSL_SSI_MX51)
> +		ssi_private->offline_config = true;
> +

This is really confusing.  I'd expect a switch statement here
enumerating the pre-i.MX51 hardware types otherwise if there's a new
variant added it'll do the wrong thing - the comment sounds like the
opposite of the test.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131219/93dff994/attachment.sig>
