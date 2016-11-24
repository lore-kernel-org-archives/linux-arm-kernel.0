From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 24 Nov 2016 14:17:18 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <5836C69A.3030309@free.fr> (Mason's message of "Thu, 24 Nov 2016
 11:53:14 +0100")
References: <58356EA8.2010806@free.fr> <yw1xpolmbdih.fsf@unicorn.mansr.com>
 <58358E79.5050404@free.fr> <yw1xh96yaz84.fsf@unicorn.mansr.com>
 <5836C69A.3030309@free.fr>
Message-ID: <yw1xr3619d3l.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

>>> I'm confused. Are you saying there is no solution to my problem
>>> within the existing DMA framework?
>>>
>>> In its current form, the tangox-dma.c driver will fail randomly
>>> for writes to a device (SATA, NFC).
>>>
>>> Maybe an extra hook can be added to the DMA framework?
>>>
>>> I'd like to hear from the framework's maintainers. Perhaps they
>>> can provide some guidance.
>> 
>> You could have the dma descriptor callback wait for the receiving device
>> to finish.  Bear in mind this runs from a tasklet, so it's not allowed
>> to sleep.
>
> Thanks for the suggestion, but I don't think it works :-(
>
> This is my DMA desc callback:
>
> static void tango_dma_callback(void *arg)
> {
> 	printk("%s from %pf\n", __func__, __builtin_return_address(0));
> 	mdelay(10000);
> 	printk("DONE FAKE SPINNING\n");
> 	complete(arg);
> }
>
> I also added
>     printk("%s from %pf\n", __func__, __builtin_return_address(0));
> after tangox_dma_pchan_detach(pchan);
>
> And I get this output:
>
> [   35.085854] SETUP DMA
> [   35.088272] START NAND TRANSFER
> [   35.091670] tangox_dma_pchan_start from tangox_dma_irq
> [   35.096882] tango_dma_callback from vchan_complete
> [   45.102513] DONE FAKE SPINNING
>
> So the IRQ rolls in, the ISR calls tangox_dma_pchan_start,
> which calls tangox_dma_pchan_detach to tear down the sbox
> setup; and only sometime later does the DMA framework call
> my callback function.

Yes, I realised this soon after I said it.  The dma driver could be
rearranged to make it work though.

> So far, the work-arounds I've tested are:
>
> 1) delay sbox tear-down by 10 ?s in tangox_dma_pchan_detach.
> 2) statically setup sbox in probe, and never touch it henceforth.
>
> WA1 is fragile, it might break for devices other than NFC.
> WA2 is what I used when I wrote the NFC driver.
>
> Can tangox_dma_irq() be changed to have the framework call
> the client's callback *before* tangox_dma_pchan_start?
>
> (Thinking out loud) The DMA_PREP_INTERRUPT requests that the
> DMA framework invoke the callback from tasklet context,
> maybe a different flag DMA_PREP_INTERRUPT_EX can request
> calling the call-back directly from within the ISR?
>
> (Looking at existing flags) Could I use DMA_CTRL_ACK?
> Description sounds like some kind hand-shake between
> client and dmaengine.
>
> Grepping for DMA_PREP_INTERRUPT, I don't see where the framework
> checks that flag to spawn the tasklet? Or is that up to each
> driver individually?

Those flags all have defined meanings and abusing them for other things
is a bad idea.  As far as possible, device drivers should work with any
dma driver.

-- 
M?ns Rullg?rd
