From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 28 Jul 2014 16:34:04 +0300
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <5712887.nI9VbeNx2r@wuerfel>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
 <5237362.DJsH7MtqlU@wuerfel> <1406545580.8530.28.camel@smile.fi.intel.com>
 <5712887.nI9VbeNx2r@wuerfel>
Message-ID: <1406554444.8530.45.camel@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-07-28 at 14:47 +0200, Arnd Bergmann wrote:
> On Monday 28 July 2014 14:06:20 Andy Shevchenko wrote:
> > On Fri, 2014-07-25 at 17:55 +0200, Arnd Bergmann wrote:
> > > On Friday 25 July 2014 13:45:47 Andy Shevchenko wrote:
> > > > On Fri, 2014-07-25 at 12:19 +0200, Arnd Bergmann wrote:
> > > > > On Friday 25 July 2014 12:55:59 Mika Westerberg wrote:

> > > > Arnd, this dependency to certain DMA driver looks really bad.
> > > > 
> > > > If we go that way, can we split that part to [another] module and make
> > > > it dependent to DW_DMAC?
> > > 
> > > I don't see what you gain from that. The PC ID will tell you which DMA
> > > engine is being used. The driver already hardcodes a slave_id based on
> > > the PCI ID today, and the 
> > 
> > "...and the..."?
> 
> Sorry for missing that.
> 
> the slave ID only makes sense in combination with the master device
> it is used in, so the dependency exists already.

Yes, this is plain data that could be nicely fit in the pci driver.

> > > > > What I think you got wrong here (by following my bad advice) is the master
> > > > > number. Looking at the code for dw_dma, I think src_master needs to be '1'
> > > > > for your driver.
> > > > 
> > > > On some SoCs we have up to 4 masters. It's blurry for me how the SPI
> > > > should choose those masters. Currently it works fine, but I suspect
> > > > there are [might be] performance issues.
> > > 
> > > I think it works because the dw-dma defaults to the values used by
> > > the specific implementation in your hardware.
> > 
> > 
> > 
> > > > What about AVR32 case? We have to fix drivers as well there.
> > 
> > > which ones?
> > 
> > arch/avr32/mach-at32ap/at32ap700x.c:1332:at32_add_device_mci
> > 
> > It seems opaque for me if it's used anywhere.
> 
> It seems correct to me. This is the filter function used by atmel_mci:
> 
> static bool atmci_filter(struct dma_chan *chan, void *pdata)
> {
>         struct mci_platform_data *sl_pdata = pdata;
>         struct mci_dma_data *sl;
> 
>         if (!sl_pdata)
>                 return false;
> 
>         sl = sl_pdata->dma_slave;
>         if (sl && find_slave_dev(sl) == chan->device->dev) {
>                 chan->private = slave_data_ptr(sl);
>                 return true;
>         } else {
>                 return false;
>         }
> }
> 
> It sets the dw_dma_slave information from  slave_data_ptr(sl) here,
> and does not attempt to set a slave_id at all, the slave_config
> call only sets the required fields.
> 
> Do you still see a problem here?

Sorry, I was talking about master defaults regarding to your patch that
proposes to remove that part from dw_dmac. I mean it should be set in
function mentioned early.

> > Actually the defaults came from original driver for AVR32 case.
> > 
> > Regarding to DW DMA databook the AHB masters could be used each by any
> > channel, though it depends on what AHB layer is bound to (and
> > corresponding peripheral device).
> > 
> > Thus, like I said we might have the [minor] performance issues if we
> > use, for example, two out of four masters.
> 
> I don't see how: We have four cases that I am aware of, and all seem
> to handle this right:
> 
> a) request line and masters are all configured from device-tree.
> b) request line is configured from ACPI, masters are autoconfigured

They are just defaults. Say, hardcoded. We just get master bus width and
number of masters we have, but we don't use them.

> c) request line and masters are all configured from avr32/arm32
>    platform data.
> d) request line and masters are all configured from Bay Trail
>    PCI ID (Implemented by Mika's patch)

Actually here I just recall the case when we might have different number
of masters and use the same IP block [of SPI controller], how could you
distinguish that case? How to provide proper masters?

It's luckily not a problem right now, but still potential one in some
cases.

> The ACPI case could be extended if we ever get an ACPI based system
> that has more than two masters.
> In the other cases, the same source of information that configures
> the request line also configures the masters, so it's up to the
> system integration to pick the best setting.

Yeah, ACPI / DT cases work / will work fine, since we can get any
information we need from there.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
