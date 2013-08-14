From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Aug 2013 15:30:10 +0530
Subject: [PATCH 00/20] ARM: pxa: move core and drivers to dmaengine
In-Reply-To: <52061C53.4050905@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <87zjsqzdg8.fsf@free.fr> <52061C53.4050905@gmail.com>
Message-ID: <20130814100010.GO32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 12:56:19PM +0200, Daniel Mack wrote:
> Hi Robert,
> 
> On 10.08.2013 00:50, Robert Jarzmik wrote:
> > Daniel Mack <zonque@gmail.com> writes:
> > 
> >>  * camera driver:
> >>      I started the transition, but I'm not sure how much sense that
> >>      makes without access to the hardware. I'd much appreciate if
> >>      anyone could volunteer for this piece; I'll happily share what
> >>      I got so far. Sascha, Sachin, Guennadi?
> > Hi Daniel,
> > 
> > Do you mean this driver ? :
> > drivers/media/platform/soc_camera/pxa_camera.c
> 
> Yes, exactly.
> 
> > In that case I might help. But before I can do that, I have to be convinced that
> > dmaengine can deal with this driver. I'm thinking in particular of :
> >  - "hot running DMA" queuing
> >  - multiple DMA channel synchronization (ie. 3 channel sync)
> > 
> > All that is described in there :
> >   Documentation/video4linux/pxa_camera.txt
> 
> Yes, I've seen that, and while the documentation about all that is
> excellent, I lack an explanation why things are so complicated for this
> application, and why a simple cyclic DMA approach does not suffice here.
> I'm sure there's a reason though.
> 
> There might be need to teach the dmaengine core more functionality, but
> in order to do that, we first need to understand the exact requirements.
> 
> > If someone with dmaengine knowledge could have a look at pxa_camera.txt (maybe
> > Vinod ?) and tell me that dma_engine framework fullfills the 2 requirements,
> > then I'll be happy to help.
> 
> Yes, Vinod and and Dan are certainly the best ones to comment on that I
> think.
I read the file esp the "DMA flow" and "DMA hot chaining timeslice issue". I can
say with "properly" implemented dmaengine driver this is very much doable.


Have you guys read: Documentation/dmaengine.txt?

So for "hot chaning" it would work as follows:

Client, allocates and channel and prepares the descriptors A B & C
Client (video), submits buffer A, Buffer B. Both are queued by dma driver
Client calls dma_async_issue_pending
DMA driver will start Buffer A. It gets the completetion for A and then Starts
B. It will invoke callbakc for A.

If you submit C, and invoke dma_async_issue_pending(), C is queued
On B completetion, the DMA driver will start C and invoke callback for B.

If B completes before C is submitted, after submit and invoking
dma_async_issue_pending(), the C buffer will be queued and started.

~Vinod
