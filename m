From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 11 Mar 2016 16:48:26 +0530
Subject: [PATCH] dma: sun4i: expose block size and wait cycle
 configuration to DMA users
In-Reply-To: <20160311105549.GZ8418@lukather>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost>
 <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather> <20160308025547.GI11154@localhost>
 <20160309120627.67612b1d@bbrezillon>
 <20160311062607.GP11154@localhost>
 <20160311104552.23e06a16@bbrezillon>
 <20160311100902.GY11154@localhost> <20160311105549.GZ8418@lukather>
Message-ID: <20160311111825.GC11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 11:55:49AM +0100, Maxime Ripard wrote:
> On Fri, Mar 11, 2016 at 03:39:02PM +0530, Vinod Koul wrote:
> > On Fri, Mar 11, 2016 at 10:45:52AM +0100, Boris Brezillon wrote:
> > > On Fri, 11 Mar 2016 11:56:07 +0530
> > > Vinod Koul <vinod.koul@intel.com> wrote:
> > > 
> > > > On Wed, Mar 09, 2016 at 12:06:27PM +0100, Boris Brezillon wrote:
> > > > > On Tue, 8 Mar 2016 08:25:47 +0530
> > > > > Vinod Koul <vinod.koul@intel.com> wrote:
> > > > > > 
> > > > > > Why does dmaengine need to wait? Can you explain that
> > > > > 
> > > > > I don't have an answer for that one, but when I set WAIT_CYCLES to 1
> > > > > for the NAND use case it does not work. So I guess it is somehow
> > > > > related to how the DRQ line is controlled on the device side...
> > > > 
> > > > Is the WAIT cycle different for different usages or same for all
> > > > usages/channels?
> > > > 
> > > 
> > > In Allwinner BSP they adapt it on a per slave device basis, but since
> > > DMA channels are dynamically allocated, you can't know in advance which
> > > physical channel will be attached to a specific device.
> > 
> > And we have the correct values availble in datasheet for all usages
> 
> No, we don't.
> 
> If you look at the datasheet in question, page 169.
> https://github.com/allwinner-zh/documents/blob/master/A20/A20_User_Manual_v1.4_20150510.pdf
> 
> This is the only documentation we have. And as you can see, it is very
> sparse (and that's an understament).
> 
> So we cannot make that assumption, so far the values have been found
> through trial and error for the devices in question.
> 
> > > Another option I considered was adding a new cell to the sun4i DT
> > > binding to encode these WAIT_CYCLES and BLOCK_SIZE information. But I'm
> > > not sure adding that to the DT is a good idea (not to mention that it
> > > would break DT ABI again, and given the last discussions on this topic,
> > > I'm not sure it's a good idea :-/).
> > 
> > Yes i was veering towards DT as well. This is a new property so ABI rules
> > wont break as long as driver still works with old properties.
> 
> Yeah, we can always default to our current hardcoded value if the
> property is missing. And since no-one is using the engine at the
> moment anyway, so it's not really a big deal.
> 
> > But this nees to be property for clients and not driver. Client can then
> > program these
> 
> Yes, totally. The question here is how the clients give that
> information to the driver.

For this part am not worried. If we can generalize this then we add to
dma_slave_config. Otherwise an exported symbol from driver should be fine.


-- 
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/c4b05f88/attachment-0001.sig>
