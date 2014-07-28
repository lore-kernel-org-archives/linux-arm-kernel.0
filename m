From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 14:47:56 +0200
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <1406545580.8530.28.camel@smile.fi.intel.com>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
 <5237362.DJsH7MtqlU@wuerfel> <1406545580.8530.28.camel@smile.fi.intel.com>
Message-ID: <5712887.nI9VbeNx2r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 14:06:20 Andy Shevchenko wrote:
> On Fri, 2014-07-25 at 17:55 +0200, Arnd Bergmann wrote:
> > On Friday 25 July 2014 13:45:47 Andy Shevchenko wrote:
> > > On Fri, 2014-07-25 at 12:19 +0200, Arnd Bergmann wrote:
> > > > On Friday 25 July 2014 12:55:59 Mika Westerberg wrote:
> > > > > On Fri, Jul 25, 2014 at 12:07:14PM +0300, Mika Westerberg wrote:
> > > > > > On Fri, Jul 25, 2014 at 10:38:36AM +0200, Arnd Bergmann wrote:
> > > > > > > On Friday 25 July 2014 11:22:49 Mika Westerberg wrote:
> > > 
> > > []
> > > 
> > > > > Something like this?
> > > 
> > > Arnd, this dependency to certain DMA driver looks really bad.
> > > 
> > > If we go that way, can we split that part to [another] module and make
> > > it dependent to DW_DMAC?
> > 
> > I don't see what you gain from that. The PC ID will tell you which DMA
> > engine is being used. The driver already hardcodes a slave_id based on
> > the PCI ID today, and the 
> 
> "...and the..."?

Sorry for missing that.

the slave ID only makes sense in combination with the master device
it is used in, so the dependency exists already.

> > > Or shall we introduce a dmaengine type field in the platform data and
> > > dynamically choose proper filter-whatever-function to get the channel?
> > 
> > We already have an interface for this, in the form of
> > dma_request_slave_channel(), which takes a string identifier that
> > is used to look up all that information in either device tree or
> > ACPI. It wouldn't be unreasonable to add a third path in there
> > to handle hardcoded platform devices, but that's a lot of work.
> > Note that you still need to encode a reference to the dma engine
> > in some way to do this right. The current code (with or without Mika's
> > patch) will break as soon as you have multiple DMA engine devices.
> 
> What about to keep PCI case still valid? We can pass struct pci_dev (or
> actual struct device) of DMA controller to filter proper device.

Yes, that would be best. IIRC you have a single PCI device that instantiates
both the SPI and the DMA engine as subdevices (I haven't looked at the
code again), so that information would be readily available.
 
> > > > What I think you got wrong here (by following my bad advice) is the master
> > > > number. Looking at the code for dw_dma, I think src_master needs to be '1'
> > > > for your driver.
> > > 
> > > On some SoCs we have up to 4 masters. It's blurry for me how the SPI
> > > should choose those masters. Currently it works fine, but I suspect
> > > there are [might be] performance issues.
> > 
> > I think it works because the dw-dma defaults to the values used by
> > the specific implementation in your hardware.
> 
> 
> 
> > > What about AVR32 case? We have to fix drivers as well there.
> 
> > which ones?
> 
> arch/avr32/mach-at32ap/at32ap700x.c:1332:at32_add_device_mci
> 
> It seems opaque for me if it's used anywhere.

It seems correct to me. This is the filter function used by atmel_mci:

static bool atmci_filter(struct dma_chan *chan, void *pdata)
{
        struct mci_platform_data *sl_pdata = pdata;
        struct mci_dma_data *sl;

        if (!sl_pdata)
                return false;

        sl = sl_pdata->dma_slave;
        if (sl && find_slave_dev(sl) == chan->device->dev) {
                chan->private = slave_data_ptr(sl);
                return true;
        } else {
                return false;
        }
}

It sets the dw_dma_slave information from  slave_data_ptr(sl) here,
and does not attempt to set a slave_id at all, the slave_config
call only sets the required fields.

Do you still see a problem here?

> Actually the defaults came from original driver for AVR32 case.
> 
> Regarding to DW DMA databook the AHB masters could be used each by any
> channel, though it depends on what AHB layer is bound to (and
> corresponding peripheral device).
> 
> Thus, like I said we might have the [minor] performance issues if we
> use, for example, two out of four masters.

I don't see how: We have four cases that I am aware of, and all seem
to handle this right:

a) request line and masters are all configured from device-tree.
b) request line is configured from ACPI, masters are autoconfigured
c) request line and masters are all configured from avr32/arm32
   platform data.
d) request line and masters are all configured from Bay Trail
   PCI ID (Implemented by Mika's patch)

The ACPI case could be extended if we ever get an ACPI based system
that has more than two masters.
In the other cases, the same source of information that configures
the request line also configures the masters, so it's up to the
system integration to pick the best setting.

	Arnd
