From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 8 Dec 2016 22:07:55 +0530
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <91b0d10c-1bc2-c3e1-4088-f4ad9adcd6c0@free.fr>
References: <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com>
 <20161207164341.GX6408@localhost>
 <yw1xr35j1yd5.fsf@unicorn.mansr.com>
 <20161208103921.GC6408@localhost>
 <91b0d10c-1bc2-c3e1-4088-f4ad9adcd6c0@free.fr>
Message-ID: <20161208163755.GH6408@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 11:54:51AM +0100, Mason wrote:
> On 08/12/2016 11:39, Vinod Koul wrote:
> 
> > On Wed, Dec 07, 2016 at 04:45:58PM +0000, M?ns Rullg?rd wrote:
> >
> >> Vinod Koul <vinod.koul@intel.com> writes:
> >>
> >>> On Tue, Dec 06, 2016 at 01:14:20PM +0000, M?ns Rullg?rd wrote:
> >>>>
> >>>> That's not going to work very well.  Device drivers typically request
> >>>> dma channels in their probe functions or when the device is opened.
> >>>> This means that reserving one of the few channels there will inevitably
> >>>> make some other device fail to operate.
> >>>
> >>> No that doesn't make sense at all, you should get a channel only when you
> >>> want to use it and not in probe!
> >>
> >> Tell that to just about every single driver ever written.
> > 
> > Not really, few do yes which is wrong but not _all_ do that.
> 
> Vinod,
> 
> Could you explain something to me in layman's terms?
> 
> I have a NAND Flash Controller driver that depends on the
> DMA driver under discussion.
> 
> Suppose I move the dma_request_chan() call from the driver's
> probe function, to the actual DMA transfer function.
> 
> I would want dma_request_chan() to put the calling thread
> to sleep until a channel becomes available (possibly with
> a timeout value).
> 
> But Maxime told me dma_request_chan() will just return
> -EBUSY if no channels are available.

That is correct

> Am I supposed to busy wait in my driver's DMA function
> until a channel becomes available?

If someone else is using the channels then the bust wait will not help, so
in this case you should fall back to PIO, few drivers do that

> I don't understand how the multiplexing of few memory
> channels to many clients is supposed to happen efficiently?

To make it efficient, disregarding your Sbox HW issue, the solution is
virtual channels. You can delink physical channels and virtual channels. If
one has SW controlled MUX then a channel can service any client. For few
controllers request lines are hard wired so they cant use any channel. But
if you dont have this restriction then driver can queue up many transactions
from different controllers.

-- 
~Vinod
