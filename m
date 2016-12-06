From: slash.tmp@free.fr (Mason)
Date: Tue, 6 Dec 2016 16:24:04 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1xwpfd2o9f.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com>
Message-ID: <5846D814.9010106@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2016 14:14, M?ns Rullg?rd wrote:

> Mason wrote:
> 
>> On 06/12/2016 06:12, Vinod Koul wrote:
>>
>>> On Tue, Nov 29, 2016 at 07:25:02PM +0100, Mason wrote:
>>>
>>>> Is there a way to write a driver within the existing framework?
>>>
>>> I think so, looking back at comments from Russell, I do tend to agree with
>>> that. Is there a specific reason why sbox can't be tied to alloc and free
>>> channels?
>>
>> Here's a recap of the situation.
>>
>> The "SBOX+MBUS" HW is used in several iterations of the tango SoC:
>>
>> tango3
>>   2 memory channels available
>>   6 devices ("clients"?) may request an MBUS channel
>>
>> tango4 (one more channel)
>>   3 memory channels available
>>   7 devices may request an MBUS channel :
>>     NFC0, NFC1, SATA0, SATA1, memcpy, (IDE0, IDE1)
>>
>> Notes:
>> The current NFC driver supports only one controller.
> 
> I consider that a bug.

Meh. The two controller blocks share the I/O pins to the outside
world, so it's not possible to have two concurrent accesses.
Moreover, the current NAND framework does not currently support
such a setup. (I discussed this with the maintainer.)


>> IDE is mostly obsolete at this point.
>>
>> tango5 (SATA gets own dedicated MBUS channel pair)
>>   3 memory channels available
>>   5 devices may request an MBUS channel :
>>     NFC0, NFC1, memcpy, (IDE0, IDE1)
> 
> Some of the chip variants can also use this DMA engine for PCI devices.

Note: PCI support was dropped with tango4.


>> If I understand the current DMA driver (written by Mans), client
>> drivers are instructed to use a specific channel in the DT, and
>> the DMA driver muxes access to that channel.
> 
> Almost.  The DT indicates the sbox ID of each device.  The driver
> multiplexes requests from all devices across all channels.

Thanks for pointing that out. I misremembered the DT.
So a client's DT node specifies the client's SBOX port.
And the DMA node specifies all available MBUS channels.

So when an interrupt fires, the DMA driver (re)uses that
channel for the next transfer in line?


>> The DMA driver manages a per-channel queue of outstanding DMA transfer
>> requests, and a new transfer is started from within the DMA ISR
>> (modulo the fact that the interrupt does not signal completion of the
>> transfer, as explained else-thread).
> 
> We need to somehow let the device driver signal the dma driver when a
> transfer has been fully completed.  Currently the only post-transfer
> interaction between the dma engine and the device driver is through the
> descriptor callback, which is not suitable for this purpose.

The callback is called from vchan_complete() right?
Is that running from interrupt context?

What's the relationship between vchan_complete() and
tangox_dma_irq() -- does one call the other? Are they
asynchronous?


> This is starting to look like one of those situations where someone just
> needs to implement a solution, or we'll be forever bickering about
> hypotheticals.

I can give that a shot (if you're busy with real work).


>> What you're proposing, Vinod, is to make a channel exclusive
>> to a driver, as long as the driver has not explicitly released
>> the channel, via dma_release_channel(), right?
> 
> That's not going to work very well.  Device drivers typically request
> dma channels in their probe functions or when the device is opened.
> This means that reserving one of the few channels there will inevitably
> make some other device fail to operate.

This is true for tango3. Less so for tango4. And no longer
an issue for tango5.


> Doing a request/release per transfer really doesn't fit with the
> intended usage of the dmaengine api.  For starters, what should a driver
> do if all the channels are currently busy?

Why can't we queue channel requests the same way we queue
transfer requests?


> Since the hardware actually does support multiplexing the dma channels,
> I think it would be misguided to deliberately cripple the software
> support in order to shoehorn it into an incomplete model of how hardware
> ought to work.  While I agree it would be nicer if all hardware actually
> did work that way, this isn't the reality we're living in.

I agree with you that it would be nice to have a general solution,
since the HW supports it.

Regards.
