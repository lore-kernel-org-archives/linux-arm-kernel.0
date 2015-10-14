From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Wed, 14 Oct 2015 10:30:10 +0200
Subject: [PATCH v2 1/4] dt-bindings: Document the STM32 DMA bindings
In-Reply-To: <20151013162157.GD24353@leverpostej>
References: <1444744848-720-1-git-send-email-cedric.madianga@gmail.com>
 <1444744848-720-2-git-send-email-cedric.madianga@gmail.com>
 <20151013142240.GC24353@leverpostej>
 <CAOAejn1m1shL-ajxBsiEwQABM1HuhuNgMbgn83LUzmvJXGx0_g@mail.gmail.com>
 <20151013162157.GD24353@leverpostej>
Message-ID: <CAOAejn0ixE6O3WAvDqkB=B6r_35U2UQgpawPshB3OmNye7DLVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

2015-10-13 18:21 GMT+02:00 Mark Rutland <mark.rutland@arm.com>:
>> >> +4. A 32bit mask specifying the DMA channel configuration
>> >> + -bit 1: Direct Mode Error Interrupt
>> >> +     0x0: disabled
>> >> +     0x1: enabled
>> >> + -bit 2: Transfer Error Interrupt
>> >> +     0x0: disabled
>> >> +     0x1: enabled
>> >> + -bit 3: Half Transfer Mode Error Interrupt
>> >> +     0x0: disabled
>> >> +     0x1: enabled
>> >> + -bit 4: Transfer Complete Interrupt
>> >> +     0x0: disabled
>> >> +     0x1: enabled
>> >
> The DT is separate from what the client driver might want, so if
> different clients want different things, that should be requested in a a
> generic and dnyamic fashion through the dmaengine API, with the physical
> details left to the DMA controller driver.
>
> I really don't see why the DTS author should be in charge of how the DMA
> controller driver chooses to use interrupts in this fashion.
>

Ok got it. As enabling all interrupts by default does not influence
DMA behavior I will remove these inputs from DT.
Thanks for this explanation.

>
>> >> + -bit 9: Peripheral Increment Address
>> >> +     0x0: no address increment between transfers
>> >> +     0x1: increment address between transfers
>> >> + -bit 10: Memory Increment Address
>> >> +     0x0: no address increment between transfers
>> >> +     0x1: increment address between transfers
>> >
> I'd have expected other DMA controllers to also need to handle this, but
> from a quick skim of bindings I couldn't spot anything similar, so I
> assume that this gets handled somehow dynamically.
>
> Do you know what other DMA controllers do for cases like this in Linux?

After quick search I don't find any other DMA controller that handles
this problematic.
For sure, there is no way to handle it thanks to dmaengine API.

Then, I know that previously many DMA clients could pass specific
information during channel request thanks to *fn_param as below:
struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
dma_filter_fn fn, void *fn_param)
But now, this API seems obsolete has new platform has to request
channel thanks to DT inputs via dma_request_slave_channel(struct
device *dev, const char *name) API.
In that way, all specific information has to be retrieved from DT.

>
>> But others clients could do it by incrementing an memory area after
>> each transfer and in this case PINC=1.
>> I don't have any example in mind for the second use case but as the
>> DMA supports it I would like to keep it.
>
> Similarly this seems odd. What do other DMA controllers do?

Same remark as above

>
>
>> >> +5. A 32bit mask specifying the DMA FIFO configuration
>> >> + -bit 0-1: Fifo threshold
>> >> +     0x0: 1/4 full FIFO
>> >> +     0x1: 1/2 full FIFO
>> >> +     0x2: 3/4 full FIFO
>> >> +     0x3:full FIFO
>> >
> Likewise there seems to be precedent for this. I don't know whether it
> really makes sense for this to be in the DT.

Same remark as above. We abolutely need to retrieve it from DT.
Moreover, this point really influence DMA controller behavior in term
of performance.

>
>> >> + -bit 7: FIFO Error Interrupt
>> >> +     0x0: disabled
>> >> +     0x1: enabled
>> >
>> > As with the other interrupt configuration, this does not look like it
>> > belongs in the DT.
>> Again the driver could set default configuration and don't let the DMA
>> client set it.
>> The goal here is to offer for each DMA client a way to choose his
>> level of information when an error occured on DMA bus.
>
> As with the other interrupts, I still don't believe this should be in
> the DT.

As other interrupt configuration, I will remove it from DT.

Thanks,
Cedric
