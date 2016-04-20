From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Apr 2016 10:11:50 +0200
Subject: [PATCH v5] spi: orion.c: Add direct access mode
In-Reply-To: <571731F5.2010809@denx.de>
References: <1460974417-32375-1-git-send-email-sr@denx.de>
 <3956609.3ttDzXh866@wuerfel> <571731F5.2010809@denx.de>
Message-ID: <4680158.9eGGVIb1s6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 April 2016 09:38:29 Stefan Roese wrote:
> > The single-window mode won't really work with SPI-NOR unless you make each
> > window large enough to hold the largest possible flash (128MB with
> > single-window, 256MB with double-window), but that size makes it harder
> > to gain much from saving mbus windows when you trade them for gigantic
> > CPU address space consumption.
> >
> > Therefore, we probably want the separate-window mode to allow the
> > combination of large SPI flashes with other SPI devices in direct-access
> > mode. We can also implement the single (and/or double) window mode
> > in addition to that, but realistically we probably don't need that
> > as all machines we support in the kernel today have at most one
> > non-flash device.
> 
> Yes, this is also my feeling. While implementing this 0xffffffff
> size in the SPI controller 'reg' DT node, I just stumbled over the
> following problem: The resulting size of the area to map
> (of_address_to_resource) is not the minimum of the 'soc' 'ranges'
> entry and this 0xffffffff as I would have expected. But its always
> 0xffffffff. Do you know if this is general problem with this
> approach or perhaps a problem / bug in the DT address probing /
> translation?

That is the problem I was trying to explain a few mails back. The
creation of the platform resources does not look at what size can
be translated. I had not considered the possibility that this could
be changed (which would make things work here), but there are also
reasons for not changing it: if we make the resource smaller (possibly
even changing the start rather than the end), that may be even
more unexpected to other driver writers when the parent ranges 
are smaller than the device addresses.

However, I think there is a simpler solution here: for normal
devices, just always map just a single page using ioremap,
independent of what size the mbus mapping is. If you change
from memcpy() to writesl(), all writes will go to address zero
anyway, and we are already guaranteed (by not using ioremap_wc)
that there won't be any transfers that span more than four bytes
at a time (8 bytes once we use the driver on 64-bit machines
with writesq()).

For the direct spi-nor or spi-nand modes, we need extra code
in the spi controller driver, and that code will then also have
to ioremap_wc() the entire device. That ioremap should fail
if the ranges property lists a smaller area than the entire
device and it can fall back to the mode of using the 4k page
map.

	Arnd
