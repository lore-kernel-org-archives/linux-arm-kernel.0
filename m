From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 25 Nov 2016 13:11:18 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr> (Mason's message
 of "Fri, 25 Nov 2016 13:46:26 +0100")
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
Message-ID: <yw1xpolj9021.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 25/11/2016 05:55, Vinod Koul wrote:
>
>> On Wed, Nov 23, 2016 at 11:25:44AM +0100, Mason wrote:
>>
>>> On my platform, setting up a DMA transfer is a two-step process:
>>>
>>> 1) configure the "switch box" to connect a device to a memory channel
>>> 2) configure the transfer details (address, size, command)
>>>
>>> When the transfer is done, the sbox setup can be torn down,
>>> and the DMA driver can start another transfer.
>>>
>>> The current software architecture for my NFC (NAND Flash controller)
>>> driver is as follows (for one DMA transfer).
>>>
>>>   sg_init_one
>>>   dma_map_sg
>>>   dmaengine_prep_slave_sg
>>>   dmaengine_submit
>>>   dma_async_issue_pending
>>>   configure_NFC_transfer
>>>   wait_for_IRQ_from_DMA_engine // via DMA_PREP_INTERRUPT
>>>   wait_for_NFC_idle
>>>   dma_unmap_sg
>> 
>> Looking at thread and discussion now, first thinking would be to ensure
>> the transaction is completed properly and then isr fired. You may need
>> to talk to your HW designers to find a way for that. It is quite common
>> that DMA controllers will fire and complete whereas the transaction is
>> still in flight.
>
> It seems there is a disconnect between what Linux expects - an IRQ
> when the transfer is complete - and the quirks of this HW :-(
>
> On this system, there are MBUS "agents" connected via a "switch box".
> An agent fires an IRQ when it has dealt with its *half* of the transfer.
>
> SOURCE_AGENT <---> SBOX <---> DESTINATION_AGENT
>
> Here are the steps for a transfer, in the general case:
>
> 1) setup the sbox to connect SOURCE TO DEST
> 2) configure source to send N bytes
> 3) configure dest to receive N bytes
>
> When SOURCE_AGENT has sent N bytes, it fires an IRQ
> When DEST_AGENT has received N bytes, it fires an IRQ
> The sbox connection can be torn down only when the destination
> agent has received all bytes.
> (And the twist is that some agents do not have an IRQ line.)
>
> The system provides 3 RAM-to-sbox agents (read channels)
> and 3 sbox-to-RAM agents (write channels).
>
> The NAND Flash controller read and write agents do not have
> IRQ lines.
>
> So for a NAND-to-memory transfer (read from device)
> - nothing happens when the NFC has finished sending N bytes to the sbox
> - the write channel fires an IRQ when it has received N bytes
>
> In that case, one IRQ fires when the transfer is complete,
> like Linux expects.
>
> For a memory-to-NAND transfer (write to device)
> - the read channel fires an IRQ when it has sent N bytes
> - the NFC driver is supposed to poll the NFC to determine
> when the controller has finished writing N bytes
>
> In that case, the IRQ does not indicate that the transfer
> is complete, merely that the sending half has finished
> its part.

When does your NAND controller signal completion?  When it has received
the DMA data, or only when it has finished the actual write operation?

> I think it is possible to have a generic solution:
> Right now, the callback is called from tasklet context.
> If we can have a new flag to have the callback invoked
> directly from the ISR, then the driver for the client
> device can do what is required.

No, that won't work.  The callback shouldn't run in interrupt context.

-- 
M?ns Rullg?rd
