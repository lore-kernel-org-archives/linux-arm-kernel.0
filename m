From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 7 Oct 2013 14:15:22 +0200 (CEST)
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <20131007103936.GH2954@intel.com>
References: <Pine.LNX.4.64.1310051925170.8097@axis700.grange>
 <20131005190200.GZ12758@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1310052203060.8097@axis700.grange>
 <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
 <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
 <20131007111728.GM12758@n2100.arm.linux.org.uk>
 <20131007103936.GH2954@intel.com>
Message-ID: <Pine.LNX.4.64.1310071409080.20796@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013, Vinod Koul wrote:

> On Mon, Oct 07, 2013 at 12:17:28PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 07, 2013 at 12:45:33PM +0200, Guennadi Liakhovetski wrote:
> > > No, not something in the middle. I was thinking about
> > > 
> > > (1) cookie 1-3 are submitted
> > > (2) cookie 1 succeeds
> > > (3) a DMA error occurs, cookies 2-3 are discarded
> discarded using terminate_all right?

No, by the dmaengine driver as a part of the error processing.

> > > (4) cookie 4 is submitted and succeeds
> > > (5) the user requests status of cookie 2 and gets success back, AFAICS
> No you cant!, you can only request for 4..
> > 
> > This is a side effect of using a sequential cookie based system to indicate
> > whether a descriptor has succeeded or not.
> In the above case, since user calls terminate_all we can put a rule that
> terminate should reset the cookie counter.
> So after the terminate_all the cookies are sequentially valid!

Aren't all cookies "valid" at any time? I mean, even after such a reset, 
say, currently being at cookie #10, if the user asks for a status of 
cookie #1000, it will be returned as DMA_SUCCESS, won't it?

> Anyways as pointed above user shouldnt check for 2, he should have removed all
> refs till 3 before calling terminate.
> 
> > What may be better is to change the wording here: not DMA_SUCCESS but
> > DMA_COMPLETED.  That doesn't imply that it has been successful, merely
> > that the DMA engine has finished with the transaction.
> Agreed that its not indication of success but of DMA completetion. I have seen
> cases where slave perhiphral got stuck while sending last FIFO but since DMA
> finished transferiing to FIFO it says complete.
> 
> Dan do you agree?
> 
> > How a transaction gets to notify that it's been in error is a problem -
> > there is no mechanism to do that (part of that is because DMA engine slave
> > support grew out of the async_tx stuff which doesn't really have the
> > notion of failure.)
> > 
> > We can't fetch the descriptor after it has been completed, because it will
> > have been freed or recycled depending on the implementation.
> > 
> > If we want to have some way to report errors against descriptors, I think
> > we should augment the descriptor with another callback which gets called
> > (again from tasklet context) so that drivers which care about this can be
> > notified of errors.
> In case DMA engine gets an error interrupt we can do so, but same can be done
> with current callback by adding status bit. In more pratical scenarios its that
> DMA is stuck due to FIFO not moving, or wrong periphral mapping or some bug. In
> these cases dma driver cannot find it is stuck. So recommendation would be for
> client to put a timeout and after timeout assume the transfers are not completed

Yes, a timeout seems to be the only way so far for clients to identify a 
failure.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
