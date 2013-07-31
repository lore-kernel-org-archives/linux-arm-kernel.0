From: joelf@ti.com (Joel Fernandes)
Date: Tue, 30 Jul 2013 23:49:39 -0500
Subject: [PATCH 4/9] dma: edma: Find missed events and issue them
In-Reply-To: <51F7659E.3040302@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
 <1375104595-16018-5-git-send-email-joelf@ti.com> <51F7659E.3040302@ti.com>
Message-ID: <51F89763.1010102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 07/30/2013 02:05 AM, Sekhar Nori wrote:
> On Monday 29 July 2013 06:59 PM, Joel Fernandes wrote:
>> In an effort to move to using Scatter gather lists of any size with
>> EDMA as discussed at [1] instead of placing limitations on the driver,
>> we work through the limitations of the EDMAC hardware to find missed
>> events and issue them.
>>
>> The sequence of events that require this are:
>>
>> For the scenario where MAX slots for an EDMA channel is 3:
>>
>> SG1 -> SG2 -> SG3 -> SG4 -> SG5 -> SG6 -> Null
>>
>> The above SG list will have to be DMA'd in 2 sets:
>>
>> (1) SG1 -> SG2 -> SG3 -> Null
>> (2) SG4 -> SG5 -> SG6 -> Null
>>
>> After (1) is succesfully transferred, the events from the MMC controller
>> donot stop coming and are missed by the time we have setup the transfer
>> for (2). So here, we catch the events missed as an error condition and
>> issue them manually.
> 
> Are you sure there wont be any effect of these missed events on the
> peripheral side. For example, wont McASP get into an underrun condition
> when it encounters a null PaRAM set? Even UART has to transmit to a

But it will not encounter null PaRAM set because McASP uses contiguous
buffers for transfer which are not scattered across physical memory.
This can be accomplished with an SG of size 1. For such SGs, this patch
series leaves it linked Dummy and does not link to Null set. Null set is
only used for SG lists that are > MAX_NR_SG in size such as those
created for example by MMC and Crypto.

> particular baud so I guess it cannot wait like the way MMC/SD can.

Existing driver have to wait anyway if they hit MAX SG limit today. If
they don't want to wait, they would have allocated a contiguous block of
memory and DMA that in one stretch so they don't lose any events, and in
such cases we are not linking to Null.

> Also, wont this lead to under-utilization of the peripheral bandwith?
> Meaning, MMC/SD is ready with data but cannot transfer because the DMA
> is waiting to be set-up.

But it is waiting anyway even today. Currently based on MAX segs, MMC
driver/subsystem will make SG list of size max_segs. Between these
sessions of creating such smaller SG-lists, if for some reason the MMC
controller is sending events, these will be lost anyway.

What will happen now with this patch series is we are simply accepting a
bigger list than this, and handling all the max_segs stuff within the
EDMA driver itself without outside world knowing. This is actually more
efficient as for long transfers, we are not going back and forth much
between the client and EDMA driver.

> Did you consider a ping-pong scheme with say three PaRAM sets per
> channel? That way you can keep a continuous transfer going on from the
> peripheral over the complete SG list.

Do you mean ping-pong scheme as used in the davinci-pcm driver today?
This can be used only for buffers that are contiguous in memory, not
those that are scattered across memory.

Thanks,

-Joel
