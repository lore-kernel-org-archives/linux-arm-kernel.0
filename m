From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 May 2015 13:25:44 +0100
Subject: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
In-Reply-To: <20150521234832.GA1827@deathray>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <20150512191758.GX3066@sirena.org.uk>
 <20150521020709.GA14258@deathray>
 <20150521101857.GR21577@sirena.org.uk>
 <20150521210411.GA5406@deathray>
 <20150521211638.GN21577@sirena.org.uk>
 <20150521234832.GA1827@deathray>
Message-ID: <20150522122544.GL21391@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 06:48:33PM -0500, Michael Welling wrote:

> So after reverting this patch I found there is a issue in that it is difficult
> to determine when a transfer is complete to properly drive the chipselect from
> within the transfer_one function.

Is unprepare_message() a suitable place here?  I've got a feeling the
answer is no...

> Then I figured that we could handle the case when GPIOs are being used with
> some conditional calls to omap2_mcspi_set_cs in the omap2_mcspi_work_one
> function.
> 
> Near the beginning of the function I added:
> 	if (gpio_is_valid(spi->cs_gpio))
> 		omap2_mcspi_set_cs(spi, 0);
> 
> Near the end of the function I added:
> 	if (gpio_is_valid(spi->cs_gpio))
> 		omap2_mcspi_set_cs(spi, 1);
> 
> This makes GPIO chip select support work while leaving the native working
> as previous.
> 
> Is this solution acceptible?

I think that's probably OK as well, it's not ideal though (and risky if
the chip select is routed somewhere...).  

> In the process of reviewing the changes I found a few other things that
> should be changed as well.

Please send fixes for these as separate patches (ideally without any
dependency on your new work so we can send them to Linus as fixes).

> Here you will see a delay that is already handled by the core spi driver:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/spi/spi-omap2-mcspi.c#n1166

I can't actually see that since I have no internet access right now!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/9b98b8f3/attachment.sig>
