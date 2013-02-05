From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 5 Feb 2013 14:45:25 -0500
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <CACRpkdbeoMO1rjPiWDAuVL0uYwMGF+9-vCxqoMiMd1uAgZm=RQ@mail.gmail.com>
References: <20130201213003.GW2637@n2100.arm.linux.org.uk>
 <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
 <20130204164712.GB4269@arwen.pp.htv.fi> <510FF5C9.3030600@mvista.com>
 <20130204170216.GC4269@arwen.pp.htv.fi> <51100A72.6030909@ti.com>
 <CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
 <5110369B.9060901@ti.com>
 <CACRpkda8xBB35CwuBH76xXcC341TeRs1ZuwzDD0LtuXc4ifQTw@mail.gmail.com>
 <20130205164705.GG4720@opensource.wolfsonmicro.com>
 <CACRpkdbeoMO1rjPiWDAuVL0uYwMGF+9-vCxqoMiMd1uAgZm=RQ@mail.gmail.com>
Message-ID: <51116155.3080609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 01:29 PM, Linus Walleij wrote:
> On Tue, Feb 5, 2013 at 5:47 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Tue, Feb 05, 2013 at 05:21:48PM +0100, Linus Walleij wrote:
>>
>>> For IRQ mode, use the completion callback to push each cookie
>>> to NAPI, and thus let the IRQ drive the traffic.
>>
>> The whole purpose of NAPI is to avoid taking interrupts for completion
>> of transfers.  Anything that generates interrupts when NAPI is in
>> polling mode is defeating the point.
>
> So what I was trying to get across is that when you're in polling
> mode you do not set DMA_PREP_INTERRUPT on your transfers,
> just throw the obtained struct dma_async_tx_descriptor on some
> list and then when polling use dma_async_is_tx_complete()
> on the channel and the cookie inside the descriptor.
>
> I was trying to describe that you can move from
> IRQ mode to polling mode and back again by selectively
> choosing to set/not set the DMA_PREP_INTERRUPT flag.
>

This does not work.  At prep/submit time, the network driver does not 
know if a particular packet buffer needs an interrupt or not.  It queues 
up a whole bunch of receive buffers upfront.  These buffers simply sit 
on the hardware queue/ring until the NIC receives traffic.  The driver 
throttles the receive processing rate by dynamically switching between 
interrupt and poll behaviors on the completion side, not on the 
submission side.

> If polling is all you want you never set it.
>

Another point here is that it is not simply a polling vs. interrupt 
problem.  The system needs to dynamically switch between the two 
behaviors depending on offered load conditions.  This dynamic switching 
is key to balancing latency (under low load) and throughput (at high 
rates).  It cannot be one or the other, it must be both.


Once again, I'm fairly sure that suitably reworking or extending the 
dma-engine interfaces will allow network DMAs to fit in nicely.

However, I'd also appreciate inputs on the alternative approach of using 
virtio devices as an interface to packet oriented DMA hardware.  From my 
perspective this offers the following advantages, some of which I've 
already mentioned in earlier postings:

1. The virtqueue interface is nice and clean, it fits very well with 
networking concepts such as NAPI.  In comparison, the dma-engine API 
will need extensions and/or rework to fit network DMAs.

2. Advantages from leveraging the virtio infrastructure.  For example, 
if a DMA pipe to a remote processor is exposed as a virtio device, 
something like rpmsg could very naturally fit on top of this without any 
other added glue.

3. Advantages from leveraging the driver model for binding dma clients 
to dma hardware, instead of resorting to name lookups and such.

Thanks
-- Cyril.
