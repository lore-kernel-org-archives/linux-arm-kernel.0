From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Oct 2015 17:21:58 +0100
Subject: [PATCH v2 1/4] dt-bindings: Document the STM32 DMA bindings
In-Reply-To: <CAOAejn1m1shL-ajxBsiEwQABM1HuhuNgMbgn83LUzmvJXGx0_g@mail.gmail.com>
References: <1444744848-720-1-git-send-email-cedric.madianga@gmail.com>
 <1444744848-720-2-git-send-email-cedric.madianga@gmail.com>
 <20151013142240.GC24353@leverpostej>
 <CAOAejn1m1shL-ajxBsiEwQABM1HuhuNgMbgn83LUzmvJXGx0_g@mail.gmail.com>
Message-ID: <20151013162157.GD24353@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +Each dmas request consists of 5 cells:
> >> +1. A phandle pointing to the STM32 DMA controller
> >> +2. The channel id
> >> +3. The request line number

Whoops, I meant to clip these lines out of my original reply. Sorry for
the confusion below resulting from this.

> >> +4. A 32bit mask specifying the DMA channel configuration
> >> + -bit 1: Direct Mode Error Interrupt
> >> +     0x0: disabled
> >> +     0x1: enabled
> >> + -bit 2: Transfer Error Interrupt
> >> +     0x0: disabled
> >> +     0x1: enabled
> >> + -bit 3: Half Transfer Mode Error Interrupt
> >> +     0x0: disabled
> >> +     0x1: enabled
> >> + -bit 4: Transfer Complete Interrupt
> >> +     0x0: disabled
> >> +     0x1: enabled
> >
> > Why should this be in the DT?
> >
> > Surely the driver should be in charge of deciding when to use these?
> For interrupt configuration the driver could set default configuration
> and don't let the DMA client set it.
> The goal here is to offer for each DMA client a way to choose his
> level of information when an error occured on DMA bus or when a DMA
> transfer is complete.

The DT is separate from what the client driver might want, so if
different clients want different things, that should be requested in a a
generic and dnyamic fashion through the dmaengine API, with the physical
details left to the DMA controller driver.

I really don't see why the DTS author should be in charge of how the DMA
controller driver chooses to use interrupts in this fashion.

> For channel and request ids, these inputs are really mandatory as DMA
> mapping (couple channel/request) is fixed.
> So each DMA peripheral has it own channel/request ids.

As above, I only meant to quote the interrupt bits here. The channel and
request line numbers should be in the DT as they are fixed HW details.

> >> + -bit 9: Peripheral Increment Address
> >> +     0x0: no address increment between transfers
> >> +     0x1: increment address between transfers
> >> + -bit 10: Memory Increment Address
> >> +     0x0: no address increment between transfers
> >> +     0x1: increment address between transfers
> >
> > These don't seem like they belong either. Surely this would depend on
> > the request made, rather than being a fixed property?
> It is really specific to the DMA client.
> Many clients transfer DMA from peripheral at fixed register address so
> in this use case PINC=0. (It is the most common case)

I'd have expected other DMA controllers to also need to handle this, but
from a quick skim of bindings I couldn't spot anything similar, so I
assume that this gets handled somehow dynamically.

Do you know what other DMA controllers do for cases like this in Linux?

> But others clients could do it by incrementing an memory area after
> each transfer and in this case PINC=1.
> I don't have any example in mind for the second use case but as the
> DMA supports it I would like to keep it.

Similarly this seems odd. What do other DMA controllers do?

> >> + -bit 16-17: Priority level
> >> +     0x0: low
> >> +     0x1: medium
> >> +     0x2: high
> >> +     0x3: very high
> >
> > What do we do elsewhere in terms of describing prioritisation? It feels
> > like it would be a dynamic property of the system.
> You're right it could be a dynamic property of the system but we don't
> have any way to set it via the dmaengine API.
> So, we decide to set it before requesting a DMA transfer and keep it
> during all peripheral life.

I see that there is precedent with existing bindings.

> >> +5. A 32bit mask specifying the DMA FIFO configuration
> >> + -bit 0-1: Fifo threshold
> >> +     0x0: 1/4 full FIFO
> >> +     0x1: 1/2 full FIFO
> >> +     0x2: 3/4 full FIFO
> >> +     0x3:full FIFO
> >
> > What does this mean?
> The STM32 DMA has a 4 words FIFO to temporarily stores data from source.
> The threshold level is used to know at each which FIFO filling rate
> the data stores in the FIFO will be really sent to the destination.
> For example, with FIFO threshold = 1/2 full FIFO, we wait at least 2
> words of data from source before storing it into to the destination.

Likewise there seems to be precedent for this. I don't know whether it
really makes sense for this to be in the DT.

> >> + -bit 2: Direct mode
> >> +     0x0: enabled
> >> +     0x1: disabled
> >
> > What does this mean?
> The Direct mode bit is used to choose if you want to use FIFO or not.
> In direct mode (Direct mode = 0), the data coming from source are not
> temporarily stored in the DMA FIFO and are directly stored into the
> destination.
> In FIFO mode ((Direct mode = 1), the data are temporarily stored in
> the DMA FIFO and then in the destination according to the FIFO
> threshold level as explained above.

I guess this is effectively an extension of the previous FIFO config
bits, so if those make sense I guess this does...

> >> + -bit 7: FIFO Error Interrupt
> >> +     0x0: disabled
> >> +     0x1: enabled
> >
> > As with the other interrupt configuration, this does not look like it
> > belongs in the DT.
> Again the driver could set default configuration and don't let the DMA
> client set it.
> The goal here is to offer for each DMA client a way to choose his
> level of information when an error occured on DMA bus.

As with the other interrupts, I still don't believe this should be in
the DT.

Thanks,
Mark.
