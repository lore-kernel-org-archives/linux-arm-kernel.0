From: slash.tmp@free.fr (Mason)
Date: Fri, 25 Nov 2016 16:35:17 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1x8ts78w33.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <yw1xpolj9021.fsf@unicorn.mansr.com>
 <28bb9925-d0d7-9261-27fb-aa79345a19f1@free.fr>
 <yw1x8ts78w33.fsf@unicorn.mansr.com>
Message-ID: <baa01deb-f38a-8bb5-a5b1-ab7384d9113d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/2016 15:37, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> On 25/11/2016 14:11, M?ns Rullg?rd wrote:
>>
>>> Mason writes:
>>>
>>>> It seems there is a disconnect between what Linux expects - an IRQ
>>>> when the transfer is complete - and the quirks of this HW :-(
>>>>
>>>> On this system, there are MBUS "agents" connected via a "switch box".
>>>> An agent fires an IRQ when it has dealt with its *half* of the transfer.
>>>>
>>>> SOURCE_AGENT <---> SBOX <---> DESTINATION_AGENT
>>>>
>>>> Here are the steps for a transfer, in the general case:
>>>>
>>>> 1) setup the sbox to connect SOURCE TO DEST
>>>> 2) configure source to send N bytes
>>>> 3) configure dest to receive N bytes
>>>>
>>>> When SOURCE_AGENT has sent N bytes, it fires an IRQ
>>>> When DEST_AGENT has received N bytes, it fires an IRQ
>>>> The sbox connection can be torn down only when the destination
>>>> agent has received all bytes.
>>>> (And the twist is that some agents do not have an IRQ line.)
>>>>
>>>> The system provides 3 RAM-to-sbox agents (read channels)
>>>> and 3 sbox-to-RAM agents (write channels).
>>>>
>>>> The NAND Flash controller read and write agents do not have
>>>> IRQ lines.
>>>>
>>>> So for a NAND-to-memory transfer (read from device)
>>>> - nothing happens when the NFC has finished sending N bytes to the sbox
>>>> - the write channel fires an IRQ when it has received N bytes
>>>>
>>>> In that case, one IRQ fires when the transfer is complete,
>>>> like Linux expects.
>>>>
>>>> For a memory-to-NAND transfer (write to device)
>>>> - the read channel fires an IRQ when it has sent N bytes
>>>> - the NFC driver is supposed to poll the NFC to determine
>>>> when the controller has finished writing N bytes
>>>>
>>>> In that case, the IRQ does not indicate that the transfer
>>>> is complete, merely that the sending half has finished
>>>> its part.
>>>
>>> When does your NAND controller signal completion?  When it has received
>>> the DMA data, or only when it has finished the actual write operation?
>>
>> The NAND controller provides a STATUS register.
>> Bit 31 is the CMD_READY bit.
>> This bit goes to 0 when the controller is busy, and to 1
>> when the controller is ready to accept the next command.
>>
>> The NFC driver is doing:
>>
>> 	res = wait_for_completion_timeout(&tx_done, HZ);
>> 	if (res > 0)
>> 		err = readl_poll_timeout(addr, val, val & CMD_READY, 0, 1000);
>>
>> So basically, sleep until the memory agent IRQ falls,
>> then spin until the controller is idle.
> 
> This doesn't answer my question.  Waiting for the entire operation to
> finish isn't necessary.  The dma driver only needs to wait until all the
> data has been received by the nand controller, not until the controller
> is completely finished with the command.  Does the nand controller
> provide an indication for completion of the dma independently of the
> progress of the write command?  The dma glue Sigma added to the
> Designware sata controller does this.

I called the HW dev. He told me the NFC block does not have
buffers to store the incoming data; so they remain in the
MBUS FIFOs until the NFC consumes them, i.e. when it has
finished writing them to a NAND chip, which could take
a "long time" when writing to a slow chip.

So the answer to your question is: "the NAND controller
signals completion only when it has finished the actual
write operation."

>> Did you see that adding a 10 ?s delay at the start of
>> tangox_dma_pchan_detach() makes the system no longer
>> fail (passes an mtd_speedtest).
> 
> Yes, but maybe that's much longer than is actually necessary.

I could instrument my spin loop to record how long we had
to wait between the IRQ and CMD_READY.

Regards.
