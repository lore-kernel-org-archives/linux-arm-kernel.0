From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Feb 2013 14:31:12 +0000
Subject: [PATCH V2] dma: imx-dma: Add oftree support
In-Reply-To: <20130224122748.GF10660@pengutronix.de>
References: <1361543838-12604-1-git-send-email-mpa@pengutronix.de>
 <201302232216.22113.arnd@arndb.de> <20130224122748.GF10660@pengutronix.de>
Message-ID: <201302251431.12829.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 24 February 2013, Markus Pargmann wrote:
> On Sat, Feb 23, 2013 at 10:16:21PM +0000, Arnd Bergmann wrote:
> > On Saturday 23 February 2013, Markus Pargmann wrote:

> > 
> > There are actually two more members in the imx_dma_data structure. Shouldn't those
> > be encoded in the dma specifier as well?
> 
> imx_dma_data is used by imx-dma and imx-sdma, but imx-dma does not use
> peripheral_type and priority. When not loaded from devicetree
> imx_dma_data is constructed by imx drivers without knowledge about the
> dma driver. This patch moves the initialization to the driver, so I
> think there is no need to fill all fields. I didn't want to use a new
> struct because the imx drivers could still use this old way.

Ok, got it.

> > >  static inline int imx_dma_is_ipu(struct dma_chan *chan)
> > > @@ -63,7 +66,8 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
> > >  	return strstr(dev_name(chan->device->dev), "sdma") ||
> > >  		!strcmp(dev_name(chan->device->dev), "imx1-dma") ||
> > >  		!strcmp(dev_name(chan->device->dev), "imx21-dma") ||
> > > -		!strcmp(dev_name(chan->device->dev), "imx27-dma");
> > > +		!strcmp(dev_name(chan->device->dev), "imx27-dma") ||
> > > +		!strcmp(chan->device->dev->driver->name, "imx-dma");
> > >  }
> > 
> > Also, your filter function does not actually check
> > imx_dma_is_general_purpose() as the old style filter functions
> > in the slave drivers do, which breaks when you have more than one dma engine
> > in the system.
> 
> Oh yes, in the filter function should be a device driver comparison. But
> I would prefer a direct check instead of imx_dma_is_general_purpose because
> I think the driver should not define a filter function that initializes data
> for another driver (sdma).

Yes, that is also how I did it in the dwdma patches. Basically  I have
the dma engine object passed into xlate and then from there into the
filter, where I can compare it against chan->device.

	Arnd
