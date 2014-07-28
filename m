From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 16:02:47 +0200
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <1406554444.8530.45.camel@smile.fi.intel.com>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
 <5712887.nI9VbeNx2r@wuerfel> <1406554444.8530.45.camel@smile.fi.intel.com>
Message-ID: <120751941.rzCjA94qJu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 16:34:04 Andy Shevchenko wrote:
> On Mon, 2014-07-28 at 14:47 +0200, Arnd Bergmann wrote:
> > On Monday 28 July 2014 14:06:20 Andy Shevchenko wrote:
> > static bool atmci_filter(struct dma_chan *chan, void *pdata)
> > {
> >         struct mci_platform_data *sl_pdata = pdata;
> >         struct mci_dma_data *sl;
> > 
> >         if (!sl_pdata)
> >                 return false;
> > 
> >         sl = sl_pdata->dma_slave;
> >         if (sl && find_slave_dev(sl) == chan->device->dev) {
> >                 chan->private = slave_data_ptr(sl);
> >                 return true;
> >         } else {
> >                 return false;
> >         }
> > }
> > 
> > It sets the dw_dma_slave information from  slave_data_ptr(sl) here,
> > and does not attempt to set a slave_id at all, the slave_config
> > call only sets the required fields.
> > 
> > Do you still see a problem here?
> 
> Sorry, I was talking about master defaults regarding to your patch that
> proposes to remove that part from dw_dmac. I mean it should be set in
> function mentioned early.

Ok. So atmci_filter is still correct because chan->private contains
a pointer to a structure with both request and master settings, right?

> > c) request line and masters are all configured from avr32/arm32
> >    platform data.
> > d) request line and masters are all configured from Bay Trail
> >    PCI ID (Implemented by Mika's patch)
> 
> Actually here I just recall the case when we might have different number
> of masters and use the same IP block [of SPI controller], how could you
> distinguish that case? How to provide proper masters?
> 
> It's luckily not a problem right now, but still potential one in some
> cases.

Do you mean case d? I think for each PCI ID, you will have to add the
correct settings to some table that is used in the filter function.

Are there any cases you know where we can't hardcode them?

	Arnd
