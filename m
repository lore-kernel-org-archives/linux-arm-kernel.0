From: mgr@pengutronix.de (Michael Grzeschik)
Date: Fri, 14 Mar 2014 11:19:07 +0100
Subject: [PATCH 3/3] spi: psdev: add passive serial driver
In-Reply-To: <20140312163427.GV28112@sirena.org.uk>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
 <20140312163427.GV28112@sirena.org.uk>
Message-ID: <20140314101907.GF4234@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 04:34:27PM +0000, Mark Brown wrote:
> On Wed, Mar 12, 2014 at 04:53:37PM +0100, Michael Grzeschik wrote:
> 
> > This patch introduces the psdev driver. It is used to communicate to an
> > Altera passive serial connected FPGA by writing into an character
> > device.
> > 
> > It simply initates the protocol on open and clocks the data into the
> > FPGA by using the underlying SPI bus on write. The used SPI bus can also
> > be an bitbang SPI bus. On close it will check for the response of the
> > FPGA and tells if the write process was successful.
> 
> Having read the above I'm still not entirely sure what this is supposed
> to do.  It sounds like it might be something to do with programming
> FPGAs but that doesn't seem like something for the SPI subsystem, it
> sounds like something for a FPGA handling subsystem.  People keep
> talking about that, there's a bunch of other stuff to integrate with
> there like loading DTs for the downloeaded bitstream.  I'm not sure what
> the status is there.

Ok, so first of all it needs better documentation, also for the
bindings. I will add some.

Second, the driver has "per se" nothing to do with SPI, beside it needs
a clock and data line to transfer an image to the FPGA. (One way,
therefor: passive). It needs to use some SPI controller to do that. Even
the SPI Bitbang driver. Because of this, it depends on the SPI
framework.

Beside the SCLK and MOSI, the protocol needs to toggle and check some
GPIOs for protocol start and end. For that I chose the posix open and
close, so that in userland it can be used as simple as $(cat
firmware.rbf > /dev/psdev0). This protocol also needs no SS line.

It is actually not more than that. I took the spidev character device
driver as reference implementation. Any Idea where to put this driver
instead.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
