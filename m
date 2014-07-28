From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 28 Jul 2014 14:06:20 +0300
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <5237362.DJsH7MtqlU@wuerfel>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
 <5426556.OzZIXLrofJ@wuerfel> <1406285147.8530.13.camel@smile.fi.intel.com>
 <5237362.DJsH7MtqlU@wuerfel>
Message-ID: <1406545580.8530.28.camel@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-25 at 17:55 +0200, Arnd Bergmann wrote:
> On Friday 25 July 2014 13:45:47 Andy Shevchenko wrote:
> > On Fri, 2014-07-25 at 12:19 +0200, Arnd Bergmann wrote:
> > > On Friday 25 July 2014 12:55:59 Mika Westerberg wrote:
> > > > On Fri, Jul 25, 2014 at 12:07:14PM +0300, Mika Westerberg wrote:
> > > > > On Fri, Jul 25, 2014 at 10:38:36AM +0200, Arnd Bergmann wrote:
> > > > > > On Friday 25 July 2014 11:22:49 Mika Westerberg wrote:
> > 
> > []
> > 
> > > > Something like this?
> > 
> > Arnd, this dependency to certain DMA driver looks really bad.
> > 
> > If we go that way, can we split that part to [another] module and make
> > it dependent to DW_DMAC?
> 
> I don't see what you gain from that. The PCI ID will tell you which DMA
> engine is being used. The driver already hardcodes a slave_id based on
> the PCI ID today, and the 

"...and the..."?

> 
> > Or shall we introduce a dmaengine type field in the platform data and
> > dynamically choose proper filter-whatever-function to get the channel?
> 
> We already have an interface for this, in the form of
> dma_request_slave_channel(), which takes a string identifier that
> is used to look up all that information in either device tree or
> ACPI. It wouldn't be unreasonable to add a third path in there
> to handle hardcoded platform devices, but that's a lot of work.
> Note that you still need to encode a reference to the dma engine
> in some way to do this right. The current code (with or without Mika's
> patch) will break as soon as you have multiple DMA engine devices.

What about to keep PCI case still valid? We can pass struct pci_dev (or
actual struct device) of DMA controller to filter proper device.

> The current plan I think is to convert all platforms to use DT
> or ACPI so they get the right data from tables passed by the
> platform.

Good to know the road map.

[]

> > > What I think you got wrong here (by following my bad advice) is the master
> > > number. Looking at the code for dw_dma, I think src_master needs to be '1'
> > > for your driver.
> > 
> > On some SoCs we have up to 4 masters. It's blurry for me how the SPI
> > should choose those masters. Currently it works fine, but I suspect
> > there are [might be] performance issues.
> 
> I think it works because the dw-dma defaults to the values used by
> the specific implementation in your hardware.



> > What about AVR32 case? We have to fix drivers as well there.

> which ones?

arch/avr32/mach-at32ap/at32ap700x.c:1332:at32_add_device_mci

It seems opaque for me if it's used anywhere.


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
