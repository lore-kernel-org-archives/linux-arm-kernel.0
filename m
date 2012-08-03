From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 03 Aug 2012 15:25:41 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <501994D6.6070508@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201207171924.33756.arnd@arndb.de> <1342756850.1726.74.camel@vkoul-udesk3>
 <201207200839.24259.arnd@arndb.de> <1342777047.1726.435.camel@vkoul-udesk3>
 <500EF27F.6050905@ti.com> <1343284960.1726.8978.camel@vkoul-udesk3>
 <501181C3.1020301@ti.com> <1343733132.1726.14418.camel@vkoul-udesk3>
 <501994D6.6070508@ti.com>
Message-ID: <1343987741.1726.14420.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-08-01 at 15:43 -0500, Jon Hunter wrote:
> Hi Vinod,
> 
> On 07/31/2012 06:12 AM, Vinod Koul wrote:
> > On Thu, 2012-07-26 at 12:43 -0500, Jon Hunter wrote:
> >>>> So yes I can see that a channel itself could be configured to
> >> support a
> >>>> given direction, but when we ask for a channel via
> >> dma_request_channel()
> >>>> we are going to get a channel that matches the criteria we pass
> >> using
> >>>> the filter parameter. So here the thinking was that "flags" is a
> >> filter
> >>>> parameter that the user could specify and one example being
> >> direction
> >>>> but it could be something else too.
> >>> Yes that can be done, but I am leaning towards clients not have to
> >> do
> >>> anything :) DMAEngine needs to know mapping and when
> >>> dma_request_channel() is called it _always_ gives you the right
> >> channel.
> >>
> >> Ok, so are you proposing to remove the filter function and parameter
> >> from the dma_request_channel()?
> > No. But add a new request call, dma_request_slave_channel() which is
> > exclusive for slave usages and takes into account the mapping to be done
> > for channels
> >>
> >>> Maybe for slave case we need to create dma_request_slave_channel()
> >> which
> >>> has additional arguments for dmaengine to do the filtering.
> > Yup
> >>
> >> Ok, so what is not clear to me is if you envision that
> >> dma_request_slave_channel() is using a mapping table based look-up or
> >> the DT scheme or both.
> > The API should not worry about it. It would be good to have DT/ other be
> > behind this API, so it is transparent to users. They just request a
> > slave channel.
> 
> So would you envision something like (copying from Guennadi's API but
> changing direction to flags) ...
> 
> struct dma_chan *dma_request_slave_channel(struct device *dev,
> 					char *name, unsigned int flags)
> {
> 	/* If device-tree is present get slave info from here */
> 	if (dev->of_node)
> 		return of_dma_request_slave_channel(dev, name, flags);
> 
> 	return NULL;
> }
> 
> Ok, so right now the above is nothing more than a simple wrapper around
> a DT dma function to extract the slave info. However, it would allow us
> to add another means for getting the slave info in the future if
> necessary by adding an else part to the above.
> 
Yup, something like above should work well. But without any dependency
from dmac's (unlike the RFC propsed)


-- 
~Vinod
