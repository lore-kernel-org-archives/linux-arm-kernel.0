From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Jan 2014 13:23:34 +0000
Subject: [PATCH 1/2] spi: clps711x: Driver refactor
In-Reply-To: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140101132334.GP31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 01, 2014 at 10:09:28AM +0400, Alexander Shiyan wrote:
> This is a complex patch for refactoring CLPS711X SPI driver.
> Major changes:
> - Eliminate <mach/hardware.h> usage.
> - Devicetree support.

This really needs to be broken up into smaller changes so it can be
reviewed, your summary would be good as the cover mail for a patch
series but not for a single commit.  We need one change per commit with
a clear commit message saying what's going on.

There's a large set of changes here with no explanation of most of them
which means I can't really tell if the changes are doing what they're
supposed to and at least some of them seem to be doing things beyond
either description above.  I'd expect at least two changes, one for the
mach/hardware.h elimination and one for the bindings, but probably each
of those should be split into several changes.  For example the bindings
changes might have some patches doing refactorings before adding the
actual bindings.

> -	/* We are expect that SPI-device is not selected */
> -	gpio_direction_output(hw->chipselect[spi->chip_select],
> -			      !(spi->mode & SPI_CS_HIGH));
> +		ret = devm_gpio_request(&spi->master->dev, spi->cs_gpio, NULL);
> +		if (ret)
> +			return ret;

For example this is a refectoring to use devm and request the GPIO which
is good but definitely not something I'd expect to see happening in the
same commit as anything mentioned in the changelog.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140101/91591fc5/attachment.sig>
