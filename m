From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 18:25:24 +0100
Subject: [PATCH 1/3 v6] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
 <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140714172524.GH6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 11:11:44AM +0530, Naveen Krishna Chatradhi wrote:

> @@ -812,6 +800,10 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>  		spi->controller_data = cs;
>  	}
>  
> +	/* For the non-DT platforms derive chip selects from controller data */
> +	if (!spi->dev.of_node)
> +		spi->cs_gpio = cs->line;
> +
>  	if (IS_ERR_OR_NULL(cs)) {
>  		dev_err(&spi->dev, "No CS for SPI(%d)\n", spi->chip_select);
>  		return -ENODEV;
> @@ -819,17 +811,16 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>  
>  	if (!spi_get_ctldata(spi)) {
>  		/* Request gpio only if cs line is asserted by gpio pins */
> -		if (sdd->cs_gpio) {
> -			err = gpio_request_one(cs->line, GPIOF_OUT_INIT_HIGH,
> -					dev_name(&spi->dev));
> +		if (gpio_is_valid(spi->cs_gpio)) {

As previously mentioned gpio_is_valid() is *not* a direct substitute for
checking if the boolean flag cs_gpio has been set since 0 is a valid
GPIO on at least some of these platforms and as discussed several times
already some of the SoCs require the use of the built in chip select.

In general it's quite hard to tie the description in the patch to the
code changes, not helped by the decision to do separate refactorings
like this conversion to gpio_is_valid() as part of the one patch.  The
description of the patch now makes some statements about what the
problem that's intended to be fixed is but it still doesn't seem
entirely clear that everything has been thought through fully and tied
to the code.

The original code appears to be buggy which isn't helping anything but
it's hard to have confidence that this isn't going to break some other
use case that currently works given the lack of clarity and the number
of revisions that have been required so far.

I think some combination of smaller changes and a clearer working
through of the before and after states for both DT and non DT cases to
show that everything has been considered would help a lot.  I may have
another stare at this but it's worrying how hard I'm needing to think.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/3291e93c/attachment.sig>
