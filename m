From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Mon, 28 Jul 2014 12:28:08 +0300
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <5426556.OzZIXLrofJ@wuerfel>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
 <20140725090714.GY1857@lahna.fi.intel.com>
 <20140725095559.GA1857@lahna.fi.intel.com>
 <5426556.OzZIXLrofJ@wuerfel>
Message-ID: <20140728092808.GI1857@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 12:19:02PM +0200, Arnd Bergmann wrote:
> On Friday 25 July 2014 12:55:59 Mika Westerberg wrote:
> > On Fri, Jul 25, 2014 at 12:07:14PM +0300, Mika Westerberg wrote:
> > > On Fri, Jul 25, 2014 at 10:38:36AM +0200, Arnd Bergmann wrote:
> > > > On Friday 25 July 2014 11:22:49 Mika Westerberg wrote:
> > > > > > All you need to do is change your filter function to take the
> > > > > > slave id from pxa_spi_info and stick it in there, e.g.
> > > > > > 
> > > > > > static bool pxa2xx_spi_dw_dma_filter(struct dma_chan *chan, void *param)
> > > > > > {       
> > > > > >         const struct pxa2xx_spi_master *pdata = param;
> > > > > >         struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> > > > > >         
> > > > > >         dwc->request_line = fargs->req;
> > > > > >         dwc->src_master = 0;
> > > > > >         dwc->dst_master = 0;
> > > > > >         
> > > > > >         return 1;
> > > > > > }           
> > > > > 
> > > > > Oh man. That makes pxa2xx_spi dependent on a certain specific DMA engine
> > > > > driver.
> > > > 
> > > > I think you can improve this by putting the filter function (and a pointer
> > > > to it) into the pxa2xx_spi_master data provided by the PCI driver.
> > > 
> > > Indeed, that looks better. It still makes the PCI part of the driver
> > > dependent on a particular DMA engine driver but is certainly better than
> > > the core pxa2xx_spi driver.
> > 
> > Something like this?
> > 
> > Hock Leong / Chiaue Ee, are you able to check if this works on your BYT
> > machines?
> 
> I think I found a small bug, and one detail that could be improved.
> 
> > @@ -321,12 +310,14 @@ int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
> >  		return -ENOMEM;
> >  
> >  	drv_data->tx_chan = dma_request_slave_channel_compat(mask,
> > -				pxa2xx_spi_dma_filter, pdata, dev, "tx");
> > +				pdata->dma_filter, pdata->dma_filter_param,
> > +				dev, "tx");
> >  	if (!drv_data->tx_chan)
> >  		return -ENODEV;
> 
> If you change this part to pass '(void *)info->tx_slave_id' rather than
> pdata->dma_filter_param, you can simplify the next code:

OK

> > +static bool pxa2xx_spi_pci_dma_filter(struct dma_chan *chan, void *param)
> > +{
> > +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> > +	const struct pxa_spi_info *info = param;
> > +
> > +	if (chan->chan_id == info->tx_chan_id)
> > +		dwc->request_line = info->tx_slave_id;
> > +	else if (chan->chan_id == info->rx_chan_id)
> > +		dwc->request_line = info->rx_slave_id;
> > +	else
> > +		return false;
> > +
> > +	dwc->src_master = 0;
> > +	dwc->dst_master = 0;
> > +
> > +	return true;
> > +}
> 
> to disregard the tx_chan_id, which is really arbitrary as far as I can tell.
> 
> What I think you got wrong here (by following my bad advice) is the master
> number. Looking at the code for dw_dma, I think src_master needs to be '1'
> for your driver.

Right, I just copied your example. I'll change it to '1' in the next
revision.
