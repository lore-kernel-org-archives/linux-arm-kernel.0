From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Apr 2016 20:27:36 +0100
Subject: [PATCH v3] spi: orion.c: Add direct access mode
In-Reply-To: <570CDF5F.9070106@denx.de>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
 <20160411105740.GB3351@sirena.org.uk> <570CDF5F.9070106@denx.de>
Message-ID: <20160412192736.GC14664@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 01:43:27PM +0200, Stefan Roese wrote:
> On 11.04.2016 12:57, Mark Brown wrote:
> > On Thu, Apr 07, 2016 at 02:06:51PM +0200, Stefan Roese wrote:

> >> +		if (count > da->size) {
> >> +			dev_err(&spi->dev,
> >> +				"max transfer size exceeded (%d > %d)\n",
> >> +				count, da->size);
> >> +			return 0;
> >> +		}

> > This seems obviously broken, we're neither returning an error nor
> > falling back to PIO here but instead silently ignoring the transfer.

> Its not silently ignored (dev_err above) but I agree, we should be
> able to fall back to PIO mode in this condition. I'll change this in
> v4.

Logging is not useful error handling, software doesn't see it and will
continue on potentially corrupting data.

> > Do bidirectional transfers work properly with this method (how much
> > incoming data can we queue up, is there memory backing the whole
> > region?), and are we guaranteed that the transfer finished by the time
> > we return?

> Frankly, I have no idea if bidirectional transfers work properly.
> I have no means to test it. As stated in the commit text, this 
> direct mode is only tested for TX as this is the mode that I'm using
> for the FPGA bitstream programming. So its perhaps best to remove the
> RX path completely from the direct mode for now. It can be added
> once someone has a board / platform that can make use of this direct
> RX mode.

That seems a lot safer since if recieve doesn't work that's likely to
upset things like flashes.

> >> +               spi->direct_access[cs].vaddr = devm_ioremap_resource(&pdev->dev,
> >> +                                                                    r);
> >> +               if (IS_ERR(spi->direct_access[cs].vaddr)) {

> > I seem to be missing where we configure the hardware to connect the
> > windows to the chip selects.  We just seem to map the windows but never
> > otherwise interact with the hardware.

> The connection between the CS and the window is done in the DT. All
> is now implemented as Arnd has suggested:

Writing something in the DT won't magically configure anything in the
hardware which is (as I said) the bit I'm missing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/2896a43e/attachment.sig>
