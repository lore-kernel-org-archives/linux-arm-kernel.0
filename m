From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Apr 2016 15:41:22 +0200
Subject: [PATCH v5] spi: orion.c: Add direct access mode
In-Reply-To: <5715FD81.8090100@denx.de>
References: <1460974417-32375-1-git-send-email-sr@denx.de>
 <4509446.OJU128rpNa@wuerfel> <5715FD81.8090100@denx.de>
Message-ID: <3956609.3ttDzXh866@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 April 2016 11:42:25 Stefan Roese wrote:
> On 18.04.2016 15:57, Arnd Bergmann wrote:
> > On Monday 18 April 2016 15:00:52 Stefan Roese wrote:
> >> On 18.04.2016 13:32, Arnd Bergmann wrote:
> > Ok, so I looked up the datasheet again and understood now that it
> > actually does both ways: a) the direct read/write that I had always assumed
> > it did with automatic cmd/addr/data generation, and b) the mode where
> > you do each write transfer separately as implemented by your patch.
> > 
> > Those two modes seem to be wildly different in their needs for address
> > space:
> > 
> > - For a) we definitely need the mapping to be the same size as the
> >    addressable storage of the SPI-NOR (or other device that fits
> >    into the cmd/addr/data pattern supported by the hardware)
> > 
> > - For b) the address is ignored and at most 32 bytes are transfered,
> >    so whatever the smallest MBUS mapping window size is would certainly
> >    be enough.
> >
> > As a side-note, I see that you use a regular devm_ioremap_resource(),
> > which I assume prevents the transfers from ever being more than
> > a single 4-byte word, while burst mode with up to 32 bytes likely
> > requires a write-combining mapping.
> 
> Thanks for the hint. I've tested again with devm_ioremap_wc() and the
> resulting SPI TX time is identical to the one using the driver with
> the uncached (non write-combined) mapping. This is most likely a
> result of the already fully saturated SPI bus speed being the
> bottle-neck here.

Ok

> A bit more testing has shown, that using devm_ioremap_wc() leads
> to sporadic failures in the FPGA image downloading though. Now
> I'm unsure, if its really worth to add some cache flushing after
> the memcpy() call here (flush_cache_vmap ?) or better keep the
> uncached ioremap in place.

The cache is not involved here, as devm_ioremap_wc is still uncached.
However it's possible that memcpy has other issues here. If you
don't gain anything from sending more than 32 bits at a time,
writesl() might be a better alternative, but it requires the data
to be 32-bit aligned in RAM. If the buffer is not aligned, the
memcpy() might already cause problems in case the kernel
implementation does not send the data in the correct order.

memcpy_toio() could also be helpful here.

> >>> This means that the 1MB window is probably a reasonable size (provided
> >>> that the (most importantly) the SPI-NOR driver can guarantee that it
> >>> never exceeds this).
> >>
> >> I have no problem switching from 1MiB to using 0xffffffff in the
> >> SPI controller 'reg' node to allow even bigger windows in v6.
> > 
> > How do you decide how much of the window to map though? Using 0xffffffff
> > is nice because it better represents what the hardware looks like
> > and doesn't limit you from having arbitrarily large mbus windows
> > based on your needs, but you'd probably have to try mapping various
> > sizes then to find the maximum supported one, or you'd have to do
> > some ugly parsing of the parent node ranges.
> 
> This is for the single-window mode, right? My comment above was
> still referring to the original implementation. And yes, this
> gets a bit complicated and is most likely not really necessary.
> So I would prefer to keep the mapping fixed to a max. of 1MiB for
> now.

No, I also meant the separate windows here. Based on the discussion
above, I think the driver can ideally just ioremap 4KB for devices
other than SPI-NOR, and then you can list the 0xffffffff length.

> > In this example, you have to configure the SPI controller to have 1MB per CS
> > in single-window mode using the "SPI DecodeMode" and "SPI CS Adress Decode"
> > registers. The mbus then contains two mappings, one 2MB window spanning
> > CS3 and CS4 in a continuous CPU range, and one 64K window for a device at
> > CS6, making it as small as possible to conserve CPU address space.
> 
> Thanks. I've prepared a new version implementing this single-
> window mode. Please let me know how you prefer the cache issue
> above to be handled (uncached mapping, flush or ?) and I'll
> update the patch accordingly.

If a write-combining mapping doesn't help you here, just use the normal
ioremap as before.

The single-window mode won't really work with SPI-NOR unless you make each
window large enough to hold the largest possible flash (128MB with
single-window, 256MB with double-window), but that size makes it harder
to gain much from saving mbus windows when you trade them for gigantic
CPU address space consumption.

Therefore, we probably want the separate-window mode to allow the
combination of large SPI flashes with other SPI devices in direct-access
mode. We can also implement the single (and/or double) window mode
in addition to that, but realistically we probably don't need that
as all machines we support in the kernel today have at most one
non-flash device.

	Arnd
