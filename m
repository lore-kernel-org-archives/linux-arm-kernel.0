From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 8 Dec 2016 21:20:43 +0530
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1xshpyzk6p.fsf@unicorn.mansr.com>
References: <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com>
 <20161207164341.GX6408@localhost>
 <yw1xr35j1yd5.fsf@unicorn.mansr.com>
 <20161208103921.GC6408@localhost>
 <yw1x60mu1w7e.fsf@unicorn.mansr.com>
 <CAMuHMdUEXJtWF3S8yK5RY5e60nOnb-Wc9U2E_L553hZvsijvcw@mail.gmail.com>
 <yw1xshpyzk6p.fsf@unicorn.mansr.com>
Message-ID: <20161208155043.GE6408@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 12:20:30PM +0000, M?ns Rullg?rd wrote:
> >
> > I'm far from claiming that drivers/tty/serial/sh-sci.c is perfect, but
> > it does request DMA channels at open time, not at probe time.
> 
> In the part quoted above, I said most drivers request dma channels in
> their probe or open functions.  For the purposes of this discussion,
> that distinction is irrelevant.  In either case, the channel is held
> indefinitely.  

And the answer was it is wrong and not _all_ do that!!

> If this wasn't the correct way to use the dmaengine,
> there would be no need for the virt-dma helpers which are specifically
> designed for cases the one currently at hand.

That is incorrect.

virt-dma helps to have multiple request from various clients. For many
controllers which implement a SW mux, they can transfer data for one client
and then next transfer can be for some other one.

This allows better utilization of dma channels and helps in case where we
have fewer dma channels than users. This was _not_ developed to let people
grab channels in probe.

> The only problem we have is that nobody envisioned hardware where the
> dma engine indicates completion slightly too soon.  I suspect there's a
> fifo or such somewhere, and the interrupt is triggered when the last
> byte has been placed in the fifo rather than when it has been removed
> which would have been more correct.

That is pretty common hardware optimization but usually hardware shows up
with flush commands to let in flight transactions be completed.

One other example of this implementations has already been pointed in this
thread

-- 
~Vinod
