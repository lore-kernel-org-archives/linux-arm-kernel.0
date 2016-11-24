From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 24 Nov 2016 16:37:05 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <58370530.5080605@free.fr> (Mason's message of "Thu, 24 Nov 2016
 16:20:16 +0100")
References: <58356EA8.2010806@free.fr> <yw1xpolmbdih.fsf@unicorn.mansr.com>
 <58358E79.5050404@free.fr> <yw1xh96yaz84.fsf@unicorn.mansr.com>
 <5836C69A.3030309@free.fr> <yw1xr3619d3l.fsf@unicorn.mansr.com>
 <58370530.5080605@free.fr>
Message-ID: <yw1xinrcal72.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 24/11/2016 15:17, M?ns Rullg?rd wrote:
>
>> Mason wrote:
>> 
>>> [   35.085854] SETUP DMA
>>> [   35.088272] START NAND TRANSFER
>>> [   35.091670] tangox_dma_pchan_start from tangox_dma_irq
>>> [   35.096882] tango_dma_callback from vchan_complete
>>> [   45.102513] DONE FAKE SPINNING
>>>
>>> So the IRQ rolls in, the ISR calls tangox_dma_pchan_start,
>>> which calls tangox_dma_pchan_detach to tear down the sbox
>>> setup; and only sometime later does the DMA framework call
>>> my callback function.
>> 
>> Yes, I realised this soon after I said it.  The dma driver could be
>> rearranged to make it work though.
>
> There is a way to make the tasklet run and invoke the callback
> before the interrupt service routine proceeds?

No, but it would be possible to defer the teardown to the tasklet.
Having said that, I'm not sure it's such a great idea since the tasklet
could be held up for an arbitrary length of time waiting for the target
to finish.

>>> So far, the work-arounds I've tested are:
>>>
>>> 1) delay sbox tear-down by 10 ?s in tangox_dma_pchan_detach.
>>> 2) statically setup sbox in probe, and never touch it henceforth.
>>>
>>> WA1 is fragile, it might break for devices other than NFC.
>>> WA2 is what I used when I wrote the NFC driver.
>>>
>>> Can tangox_dma_irq() be changed to have the framework call
>>> the client's callback *before* tangox_dma_pchan_start?
>>>
>>> (Thinking out loud) The DMA_PREP_INTERRUPT requests that the
>>> DMA framework invoke the callback from tasklet context,
>>> maybe a different flag DMA_PREP_INTERRUPT_EX can request
>>> calling the call-back directly from within the ISR?
>>>
>>> (Looking at existing flags) Could I use DMA_CTRL_ACK?
>>> Description sounds like some kind hand-shake between
>>> client and dmaengine.
>>>
>>> Grepping for DMA_PREP_INTERRUPT, I don't see where the framework
>>> checks that flag to spawn the tasklet? Or is that up to each
>>> driver individually?
>> 
>> Those flags all have defined meanings and abusing them for other things
>> is a bad idea.  As far as possible, device drivers should work with any
>> dma driver.
>
> I was asking about introducing a new flag, not abusing existing
> flags. (I don't understand the semantics of DMA_CTRL_ACK.)

This needs more than a new flag anyhow.

> (FWIW, both the NFC and the MBUS agent are custom designs,
> not third-party IP blocks.)

Sure, but who knows what will be in the next chip?

-- 
M?ns Rullg?rd
