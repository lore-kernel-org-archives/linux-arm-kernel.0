From: mwelling@ieee.org (Michael Welling)
Date: Thu, 21 May 2015 18:48:33 -0500
Subject: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
In-Reply-To: <20150521211638.GN21577@sirena.org.uk>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <20150512191758.GX3066@sirena.org.uk>
 <20150521020709.GA14258@deathray>
 <20150521101857.GR21577@sirena.org.uk>
 <20150521210411.GA5406@deathray>
 <20150521211638.GN21577@sirena.org.uk>
Message-ID: <20150521234832.GA1827@deathray>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 10:16:38PM +0100, Mark Brown wrote:
> On Thu, May 21, 2015 at 04:04:11PM -0500, Michael Welling wrote:
> 
> > Do you want to revert the patch and apply a new one or should I provide a
> > patch that reverts the changes and fixes it all in one?
> 
> Can you please send me separate revert and re-add patches, that's
> probably going to be easier to review.

So after reverting this patch I found there is a issue in that it is difficult
to determine when a transfer is complete to properly drive the chipselect from
within the transfer_one function.

Then I figured that we could handle the case when GPIOs are being used with
some conditional calls to omap2_mcspi_set_cs in the omap2_mcspi_work_one
function.

Near the beginning of the function I added:
	if (gpio_is_valid(spi->cs_gpio))
		omap2_mcspi_set_cs(spi, 0);

Near the end of the function I added:
	if (gpio_is_valid(spi->cs_gpio))
		omap2_mcspi_set_cs(spi, 1);

This makes GPIO chip select support work while leaving the native working
as previous.

Is this solution acceptible?

In the process of reviewing the changes I found a few other things that
should be changed as well.

Here you will see a delay that is already handled by the core spi driver:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/spi/spi-omap2-mcspi.c#n1166

In the set_cs function the inversion of the enable that occurs in the
core spi_set_cs function based on SPI_CS_HIGH needs to revert as the
controller handles the inversion with OMAP2_MCSPI_CHCONF_EPOL bit in the
CHCONF register.

If you approve of the fix for the GPIO support, I will provide a patch
series with all of these above mentioned fixes.
