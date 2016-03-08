From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 8 Mar 2016 09:42:31 +0100
Subject: [linux-sunxi] Re: [PATCH] dma: sun4i: expose block size and wait
 cycle configuration to DMA users
In-Reply-To: <20160308075131.GE8418@lukather>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost> <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather> <20160308025547.GI11154@localhost>
 <20160308075131.GE8418@lukather>
Message-ID: <56DE9077.3020905@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08-03-16 08:51, Maxime Ripard wrote:
> On Tue, Mar 08, 2016 at 08:25:47AM +0530, Vinod Koul wrote:
>> On Mon, Mar 07, 2016 at 09:30:24PM +0100, Maxime Ripard wrote:
>>> On Mon, Mar 07, 2016 at 04:08:57PM +0100, Boris Brezillon wrote:
>>>> Hi Vinod,
>>>>
>>>> On Mon, 7 Mar 2016 20:24:29 +0530
>>>> Vinod Koul <vinod.koul@intel.com> wrote:
>>>>
>>>>> On Mon, Mar 07, 2016 at 10:59:31AM +0100, Boris Brezillon wrote:
>>>>>> +/* Dedicated DMA parameter register layout */
>>>>>> +#define SUN4I_DDMA_PARA_DST_DATA_BLK_SIZE(n)	(((n) - 1) << 24)
>>>>>> +#define SUN4I_DDMA_PARA_DST_WAIT_CYCLES(n)	(((n) - 1) << 16)
>>>>>> +#define SUN4I_DDMA_PARA_SRC_DATA_BLK_SIZE(n)	(((n) - 1) << 8)
>>>>>> +#define SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(n)	(((n) - 1) << 0)
>>>>>> +
>>>>>> +/**
>>>>>> + * struct sun4i_dma_chan_config - DMA channel config
>>>>>> + *
>>>>>> + * @para: contains information about block size and time before checking
>>>>>> + *	  DRQ line. This is device specific and only applicable to dedicated
>>>>>> + *	  DMA channels
>>>>>
>>>>> What information, can you elobrate.. And why can't you use existing
>>>>> dma_slave_config for this?
>>>>
>>>> Block size is related to the device FIFO size. I guess it allows the
>>>> DMA channel to launch a transfer of X bytes without having to check the
>>>> DRQ line (the line telling the DMA engine it can transfer more data
>>>> to/from the device). The wait cycles information is apparently related
>>>> to the number of clks the engine should wait before polling/checking
>>>> the DRQ line status between each block transfer. I'm not sure what it
>>>> saves to put WAIT_CYCLES() to something != 1, but in their BSP,
>>>> Allwinner tweak that depending on the device.
>>
>> we already have block size aka src/dst_maxburst, why not use that one.
>
> I'm not sure it's really the same thing. The DMA controller also has a
> burst parameter, that is either 1 byte or 8 bytes, and ends up being
> different from this one.
>
>> Why does dmaengine need to wait? Can you explain that
>
> We have no idea, we thought you might have one :)
>
> It doesn't really makes sense to us, but it does have a significant
> impact on the throughput.

<wild speculation>

I see 2 possible reasons why waiting till checking for drq can help:

1) A lot of devices have an internal fifo hooked up to a single mmio data
register which gets read using the general purpose dma-engine, it allows
this fifo to fill, and thus do burst transfers
(We've seen similar issues with the scanout engine for the display which
  has its own dma engine, and doing larger transfers helps a lot).

2) Physical memory on the sunxi SoCs is (often) divided into banks
with a shared data / address bus doing bank-switches is expensive, so
this wait cycles may introduce latency which allows a user of another
bank to complete its RAM accesses before the dma engine forces a
bank switch, which ends up avoiding a lot of (interleaved) bank switches
while both try to access a different banj and thus waiting makes things
(much) faster in the end (again a known problem with the display
scanout engine).

</wild speculation>

Note the differences these kinda tweaks make can be quite dramatic,
when using a 1920x1080p60 hdmi output on the A10 SoC with a 16 bit
memory bus (real world worst case scenario), the memory bandwidth
left for userspace processes (measured through memset) almost doubles
from 48 MB/s to 85 MB/s, source:
http://ssvb.github.io/2014/11/11/revisiting-fullhd-x11-desktop-performance-of-the-allwinner-a10.html

TL;DR: Waiting before starting DMA allows for doing larger burst
transfers which ends up making things more efficient.

Given this, I really expect there to be other dma-engines which
have some option to wait a bit before starting/unpausing a transfer
instead of starting it as soon as (more) data is available, so I think
this would make a good addition to dma_slave_config.

Regards,

Hans
