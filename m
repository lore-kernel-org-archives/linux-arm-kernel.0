From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 15:57:42 +0200
Subject: [PATCH v5] spi: orion.c: Add direct access mode
In-Reply-To: <5714DA84.2050505@denx.de>
References: <1460974417-32375-1-git-send-email-sr@denx.de>
 <4248364.c0REkIZjj0@wuerfel> <5714DA84.2050505@denx.de>
Message-ID: <4509446.OJU128rpNa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 15:00:52 Stefan Roese wrote:
> On 18.04.2016 13:32, Arnd Bergmann wrote:
> > On Monday 18 April 2016 12:04:15 Mark Brown wrote:
> >> On Mon, Apr 18, 2016 at 12:51:55PM +0200, Arnd Bergmann wrote:
> >>
> >>> This would be easier if have a conclusive proof that 1MB per CS always enough.
> >>> Is this something that is guaranteed in the SPI spec or the documentation for
> >>> this controller?
> >>
> >> There's no spec for SPI but if there were it'd be hard to see it
> >> imposing a limit, one can transfer data as long as the bus is clocked
> >> (which some things like ADCs and DACs make use of).
> >>
> >
> > I just reread Stefan's patch and realized that I had fundamentally
> > misunderstood how the transfer is done: I thought the offset inside of
> > the window was used to address a NOR flash directly, but it seems
> > it is just used to send arbitrarily long commands.
> 
> Yes. SPI NOR flash support definitely needs some additional patches.
> To support the address and commands being inserted in the SPI
> messages via the corresponding registers. Again, this patch is
> only intended and tested for very "simple" TX messages without any
> addresses being inserted at all.

Ok, so I looked up the datasheet again and understood now that it
actually does both ways: a) the direct read/write that I had always assumed
it did with automatic cmd/addr/data generation, and b) the mode where
you do each write transfer separately as implemented by your patch.

Those two modes seem to be wildly different in their needs for address
space:

- For a) we definitely need the mapping to be the same size as the
  addressable storage of the SPI-NOR (or other device that fits
  into the cmd/addr/data pattern supported by the hardware)

- For b) the address is ignored and at most 32 bytes are transfered,
  so whatever the smallest MBUS mapping window size is would certainly
  be enough.

As a side-note, I see that you use a regular devm_ioremap_resource(),
which I assume prevents the transfers from ever being more than
a single 4-byte word, while burst mode with up to 32 bytes likely
requires a write-combining mapping.

> > This means that the 1MB window is probably a reasonable size (provided
> > that the (most importantly) the SPI-NOR driver can guarantee that it
> > never exceeds this).
> 
> I have no problem switching from 1MiB to using 0xffffffff in the
> SPI controller 'reg' node to allow even bigger windows in v6.

How do you decide how much of the window to map though? Using 0xffffffff
is nice because it better represents what the hardware looks like
and doesn't limit you from having arbitrarily large mbus windows
based on your needs, but you'd probably have to try mapping various
sizes then to find the maximum supported one, or you'd have to do
some ugly parsing of the parent node ranges.

> > It also means that we are probably better off using the single-window mode
> > of the SPI controller, where all CS lines share a single mbus window.
> > The only real difference here is that we can map all endpoints using a
> > single contiguous window into the CPU address space if we want, or we
> > can still map them separately on a given board if that results in a nicer
> > layout.
> 
> Frankly, I've just read about this single-window mode for the first
> time. What I miss here in this mode though, is the configuration of
> the SPI device (chip-select 0...7) for this direct-mode in the SPI
> driver. With the currently implemented separate window method, your
> suggested method is easy: Either is window can be mapped (direct-mode)
> or not (indirect-mode). With this single-window mode I'm missing the
> per-device configuration for direct-mode. Or what is your idea on
> how to configure this access-mode in this case?

It would work the same way, the main difference is that for single-window
mode all the devices get the same amount of address MBUS address space,
e.g. 1MB per CS in a contiguous MBUS range, but you can still map
subsections of it into the CPU, e.g.


&mbus {
	ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000>,   /* internal regs */
		 <MBUS_ID(0x01, 0x1e) 0x300000 0 0xf1100000 0x200000>, /* CS3+CS4 */
		 <MBUS_ID(0x01, 0x1d) 0x600000 0 0xf1300000 0x80000>, /* bootrom */
		 <MBUS_ID(0x01, 0x1e) 0x600000 0 0xf1380000 0x10000>; /* CS6 */

	spi at f0,01,10600 {
                reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>,       /* control */
                      <MBUS_ID(0x01, 0x1e) 0x000000 0x100000>, /* CS0 */
                      <MBUS_ID(0x01, 0x1e) 0x100000 0x100000>, /* CS1 */
                      <MBUS_ID(0x01, 0x1e) 0x200000 0x100000>, /* CS2 */
                      <MBUS_ID(0x01, 0x1e) 0x300000 0x100000>, /* CS3 */
                      <MBUS_ID(0x01, 0x1e) 0x400000 0x100000>, /* CS4 */
                      <MBUS_ID(0x01, 0x1e) 0x500000 0x100000>, /* CS5 */
                      <MBUS_ID(0x01, 0x1e) 0x600000 0x100000>, /* CS6 */
                      <MBUS_ID(0x01, 0x1e) 0x700000 0x100000>; /* CS7 */
	};
};

In this example, you have to configure the SPI controller to have 1MB per CS
in single-window mode using the "SPI DecodeMode" and "SPI CS Adress Decode"
registers. The mbus then contains two mappings, one 2MB window spanning
CS3 and CS4 in a continuous CPU range, and one 64K window for a device at
CS6, making it as small as possible to conserve CPU address space.

	Arnd
