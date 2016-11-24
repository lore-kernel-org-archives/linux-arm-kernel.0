From: slash.tmp@free.fr (Mason)
Date: Thu, 24 Nov 2016 11:53:14 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1xh96yaz84.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <yw1xpolmbdih.fsf@unicorn.mansr.com>
 <58358E79.5050404@free.fr> <yw1xh96yaz84.fsf@unicorn.mansr.com>
Message-ID: <5836C69A.3030309@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/2016 18:21, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> On 23/11/2016 13:13, M?ns Rullg?rd wrote:
>>
>>> Mason wrote:
>>>
>>>> On my platform, setting up a DMA transfer is a two-step process:
>>>>
>>>> 1) configure the "switch box" to connect a device to a memory channel
>>>> 2) configure the transfer details (address, size, command)
>>>>
>>>> When the transfer is done, the sbox setup can be torn down,
>>>> and the DMA driver can start another transfer.
>>>>
>>>> The current software architecture for my NFC (NAND Flash controller)
>>>> driver is as follows (for one DMA transfer).
>>>>
>>>>   sg_init_one
>>>>   dma_map_sg
>>>>   dmaengine_prep_slave_sg
>>>>   dmaengine_submit
>>>>   dma_async_issue_pending
>>>>   configure_NFC_transfer
>>>>   wait_for_IRQ_from_DMA_engine // via DMA_PREP_INTERRUPT
>>>>   wait_for_NFC_idle
>>>>   dma_unmap_sg
>>>>
>>>> The problem is that the DMA driver tears down the sbox setup
>>>> as soon as it receives the IRQ. However, when writing to the
>>>> device, the interrupt only means "I have pushed all data from
>>>> memory to the memory channel". These data have not reached
>>>> the device yet, and may still be "in flight". Thus the sbox
>>>> setup can only be torn down after the NFC is idle.
>>>>
>>>> How do I call back into the DMA driver after wait_for_NFC_idle,
>>>> to request sbox tear down?
>>>>
>>>> The new architecture would become:
>>>>
>>>>   sg_init_one
>>>>   dma_map_sg
>>>>   dmaengine_prep_slave_sg
>>>>   dmaengine_submit
>>>>   dma_async_issue_pending
>>>>   configure_NFC_transfer
>>>>   wait_for_IRQ_from_DMA_engine // via DMA_PREP_INTERRUPT
>>>>   wait_for_NFC_idle
>>>>   request_sbox_tear_down /*** HOW TO DO THAT ***/
>>>>   dma_unmap_sg
>>>>
>>>> As far as I can tell, my NFC driver should call dmaengine_synchronize ??
>>>> (In other words request_sbox_tear_down == dmaengine_synchronize)
>>>>
>>>> So the DMA driver should implement the device_synchronize hook,
>>>> and tear the sbox down in that function.
>>>>
>>>> Is that correct? Or am I on the wrong track?
>>>
>>> dmaengine_synchronize() is not meant for this.  See the documentation:
>>>
>>> /**
>>>  * dmaengine_synchronize() - Synchronize DMA channel termination
>>>  * @chan: The channel to synchronize
>>>  *
>>>  * Synchronizes to the DMA channel termination to the current context. When this
>>>  * function returns it is guaranteed that all transfers for previously issued
>>>  * descriptors have stopped and and it is safe to free the memory assoicated
>>>  * with them. Furthermore it is guaranteed that all complete callback functions
>>>  * for a previously submitted descriptor have finished running and it is safe to
>>>  * free resources accessed from within the complete callbacks.
>>>  *
>>>  * The behavior of this function is undefined if dma_async_issue_pending() has
>>>  * been called between dmaengine_terminate_async() and this function.
>>>  *
>>>  * This function must only be called from non-atomic context and must not be
>>>  * called from within a complete callback of a descriptor submitted on the same
>>>  * channel.
>>>  */
>>>
>>> This is for use after a dmaengine_terminate_async() call to wait for the
>>> dma engine to finish whatever it was doing.  This is not the problem
>>> here.  Your problem is that the dma engine interrupt fires before the
>>> transfer is actually complete.  Although you get an indication from the
>>> target device when it has received all the data, there is no way to make
>>> the dma driver wait for this.
>>
>> Hello Mans,
>>
>> I'm confused. Are you saying there is no solution to my problem
>> within the existing DMA framework?
>>
>> In its current form, the tangox-dma.c driver will fail randomly
>> for writes to a device (SATA, NFC).
>>
>> Maybe an extra hook can be added to the DMA framework?
>>
>> I'd like to hear from the framework's maintainers. Perhaps they
>> can provide some guidance.
> 
> You could have the dma descriptor callback wait for the receiving device
> to finish.  Bear in mind this runs from a tasklet, so it's not allowed
> to sleep.

Thanks for the suggestion, but I don't think it works :-(

This is my DMA desc callback:

static void tango_dma_callback(void *arg)
{
	printk("%s from %pf\n", __func__, __builtin_return_address(0));
	mdelay(10000);
	printk("DONE FAKE SPINNING\n");
	complete(arg);
}

I also added
    printk("%s from %pf\n", __func__, __builtin_return_address(0));
after tangox_dma_pchan_detach(pchan);

And I get this output:

[   35.085854] SETUP DMA
[   35.088272] START NAND TRANSFER
[   35.091670] tangox_dma_pchan_start from tangox_dma_irq
[   35.096882] tango_dma_callback from vchan_complete
[   45.102513] DONE FAKE SPINNING

So the IRQ rolls in, the ISR calls tangox_dma_pchan_start,
which calls tangox_dma_pchan_detach to tear down the sbox
setup; and only sometime later does the DMA framework call
my callback function.

So far, the work-arounds I've tested are:

1) delay sbox tear-down by 10 ?s in tangox_dma_pchan_detach.
2) statically setup sbox in probe, and never touch it henceforth.

WA1 is fragile, it might break for devices other than NFC.
WA2 is what I used when I wrote the NFC driver.

Can tangox_dma_irq() be changed to have the framework call
the client's callback *before* tangox_dma_pchan_start?

(Thinking out loud) The DMA_PREP_INTERRUPT requests that the
DMA framework invoke the callback from tasklet context,
maybe a different flag DMA_PREP_INTERRUPT_EX can request
calling the call-back directly from within the ISR?

(Looking at existing flags) Could I use DMA_CTRL_ACK?
Description sounds like some kind hand-shake between
client and dmaengine.

Grepping for DMA_PREP_INTERRUPT, I don't see where the framework
checks that flag to spawn the tasklet? Or is that up to each
driver individually?

Regards.
