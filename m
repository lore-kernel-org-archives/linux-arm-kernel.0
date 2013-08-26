From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 26 Aug 2013 19:40:57 +0530
Subject: [PATCH] DMA: let filter functions of of_dma_simple_xlate
 possible check of_node
In-Reply-To: <2811939.DFy94j5OEx@avalon>
References: <1375408800-11789-1-git-send-email-rizhao@nvidia.com>
 <1441310.1kjKG7uebg@avalon> <20130826125547.GA2733@richard-laptop>
 <2811939.DFy94j5OEx@avalon>
Message-ID: <20130826141057.GQ2748@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 03:18:00PM +0200, Laurent Pinchart wrote:
> Hi Richard,
> 
> (Dropping Dan Williams from the CC list as his e-mail address doesn't seem to 
> be valid anymore)
> 
> > > > >> Hmm. Looking at the patch, I'm not sure it's right.
> > > > >> 
> > > > >> This patch simply passes all the specfier args to the filter
> > > > >> function, and the code to check the equality of the of_node to the
> > > > >> filter args is still duplicated in each DMA driver. Instead, the DMA
> > > > >> core should be implementing the equality check, and only even calling
> > > > >> the driver-specific filter function for devices where the client's
> > > > >> phandle matches the DMA providing device's of_node handle.
> > > > > 
> > > > > Filter function is called in dmaengine core code, independent of dt.
> > > > 
> > > > The core code can still check if a dmaengine's driver was instantiated
> > > > from DT and take additional actions in that case.
> > > > 
> > > > > And the reason why the driver has to write its own filter function is
> > > > > it has to store slave id there in its own way.
> > > > 
> > > > I'm not saying don't call the driver's filter function, but rather that
> > > > the dmaengine core should perform the common checks before doing so.
> > > 
> > > And it looks to me like the common case could even get rid of the driver's
> > > filter function:
> > > 
> > > https://lkml.org/lkml/2013/5/15/270
> > > https://lkml.org/lkml/2013/3/25/250
> > 
> > For general case, the slave id is not staticly bind to a specific channel.
> 
> Certainly not in all cases, but I think it's common enough to deserve a 
> specific helper function.
Why does DT need the fliter function in the first place. The DT enabled drivers
should not even have a filter function...

The dmaengine core calls the optional filter function. This needs to be
implemented in driver in order for driver to check if the channel is what it
needs or not.

And the selection should be done for the cases where you dont have programmable
mux in dmac. For programmable ones passing slave_id in dma_slave_config should
be fine.

~Vinod
