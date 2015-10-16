From: john.ogness@linutronix.de (John Ogness)
Date: Fri, 16 Oct 2015 14:28:50 +0200
Subject: [PATCH v2] ARM: edma: fix residue race for cyclic
In-Reply-To: <5620E392.8010100@ti.com> (Peter Ujfalusi's message of "Fri, 16
 Oct 2015 14:46:26 +0300")
References: <87io68s931.fsf@linutronix.de> <561F862A.7040106@ti.com>
 <87eggvt8hi.fsf_-_@linutronix.de> <5620E392.8010100@ti.com>
Message-ID: <876127t2t9.fsf@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-10-16, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 10/16/2015 01:26 PM, John Ogness wrote:
>> When retrieving the residue value for cyclic transfers, the
>> SRC/DST fields of the active PaRAM are read. However, the AM335x
>> Technical Reference Manual states:
>> 
>>   11.3.3.6 Parameter Set Updates
>> 
>>   After the TR is read from the PaRAM (and is in the process
>>   of being submitted to the EDMA3TC), the following fields are
>>   updated as needed: ... SRC DST
>> 
>> This means SRC/DST is incremented even though the DMA transfer
>> may not have started yet or is in progress. Thus if the reader
>> of the residue accesses the DMA buffer too quickly, the CPU is
>> misinformed about the data that has been successfully processed.
>> 
>> The CCSTAT.ACTV register is a boolean that is set if any TR is
>> being processed by either the EMDA3CC or EDMA3TC. By polling
>> this register it is possible to ensure that the residue value
>> returned is valid for immediate processing. However, since the
>> DMA engine may be active, polling may never hit a moment where
>> no TR is being processed. To handle this, the SRC/DST is also
>> polled to see if it changes. And as a last resort, a max loop
>> count for the busy waiting exists to avoid an infinite loop.
>
> I'm not sure what this actually going to solve, except that we are
> going to wait for the next PaRAM parameter update.

We are waiting until the active transfers are complete. The main wait
condition is when ACTV is 0. When this happens, all transfers are
definately complete. In the normal case, this is the condition that
causes the loop exit.

> As you have already described the issue is that when you first submit
> the transfer, the first PaRAM will be submitted to TC and at this
> point the parameters will be updated to be prepared for the next
> update.  This means that after we initiate the DMA the SRC/DST will be
> updated to point to the next batch of data. Reading SRC/DST before the
> second parameter update will always give you this. But this is also
> true further in the line.  We never know exactly where the DMA is, we
> only know that the DMA is somewhere in between 0x1234 - (0x1234 + data
> until next parameter update). At the next parameter update you again
> can not be sure where the DMA is, since it is now somewhere between
> (0x1234 + parameter update number of data) - till the next update, and
> so on.
>
> In the cyclic case we use AB-sync mode, in this case the parameter update is
> going to happen after each period if I'm not mistaken.
>
> To achieve the same thing (waiting for the next parameter update to happen)
> you could just poll the PaRAM's CCNT in AB-sync to see if it changing and when
> it did you return the SRC/DST address since those will be close enough at the
> time.

Is there really a difference between polling CCNT and polling SRC/DST?
Notice that the function does _not_ return the polled SRC/DST. The extra
polling is only used as an additional loop exit condition in case we
missed ACTV being 0. This condition does occur once in while (during my
3Mbit UART tests, about once every 100000 transfers).

> But what happens if the period size if big and the position is asked
> just right after the parameter update? We can not know this, so we
> spin a bit here and give up and return whatever we had in SRC/DST.

I would hope that we never enter the "give up" condition. If a transfer
request was started, that means one burst of data is supposed to be
ready, which means the burst transfer should execute quickly. If
something unexpected happens (certain clocks suddenly turn off, etc),
then we fallback to the "give up" condition and return bad data to the
caller.

I was considering if dmaengine_tx_status() should somehow notify that it
is not possible to identify the residue (i.e. we gave up waiting for the
transfer to complete). But that really adds new semantics to the DMA
API, which is something much bigger.

An alternative would be to always return a "last known residue". But
this can really only be tracked during DMA completion interrupts and
successful edma_residue() calls. Both of which cannot guarentee that we
didn't miss a completed transfer. That is particularly a problem for the
UART driver, where a call to dmaengine_tx_status() is then followed by
PIO. That means dmaengine_tx_status() needs to return as much DMA data
as is really available.

> Not sure how to deal with this, but for sure needs more thought...

This patch closes a very real and reproducable race window in the eDMA
driver. Aside from adding busy waiting cycles it does not produce worse
results than before. But I am open to ideas.

John Ogness
