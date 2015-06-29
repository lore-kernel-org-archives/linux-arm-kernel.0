From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Mon, 29 Jun 2015 15:24:58 +0200
Subject: dma_sync_single_for_cpu takes a really long time
In-Reply-To: <CAF6-1L7CY7HYr8RPeisW5rVGzftOcX8mRUev-Mqp1-EVB03pCQ@mail.gmail.com>
References: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>	<5590E6B1.90206@topic.nl>
 <CAF6-1L7CY7HYr8RPeisW5rVGzftOcX8mRUev-Mqp1-EVB03pCQ@mail.gmail.com>
Message-ID: <5591472A.4080707@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> You're on a Zynq, and that has an ACP port. Connect through that instead of
>> an HP port (interface is almost the same), add "dma-coherent" to the
>> devicetree and also add my patch that properly maps this into userspace.
>>
>> The penalty of the ACP port is that it will write a lot slower to the memory
>> (about half the speed of the 600MB/s you get from the HP port) because of
>> all the cache administration. The good news is that all memory will be
>> cacheable once more, and all the dma_sync_... calls will turn into no-ops.
>> You don't have to change your driver and the logic also remains the same.
>
> That's a pretty big downside. 600 M/s write speed is already pretty
> low (I mean, DDR raw bw should be close to 4G/s, sure it's DDR so you
> can never reach that but still for large purely sequential access I
> expected to get closer than that).

I just repeat what's in the Zynq documentation. I did measure 599 M/s 
(simultaneously reading and writing at that speed), so it lives up to that.
The 600MB/s appears to be a limitation of the HP port, not the DDR controller.

Xilinx also mentions 1200MB/s for the ACP port in the same document, but 
that's only the case when reading/writing the L2 cache data.

> Also, doesn't that impact the ARM access performance too much to have to share ?

That I haven't tested. I don't know if the snoop unit may become a bottleneck 
here. I'd expect not, since the CPU interface is a lot faster than when the 
ACP uses.

> I guess the best flags to use for this are coherent write request
> without L2 allocation.

That's the situation where you'll get about half the HP performance. Its the 
ACP-DDR path that is slow.

If you want to process the data fast, use smaller chunks (32k or 64k works 
well) so that all data fits in the L2 cache. Use a bit less than 512k (the L2 
cache size) of buffer memory (for example 6x64k) and have the CPU process it 
in those small chunks as it arrives. Let the CPU "touch" all buffers so that 
they are present in the L2 cache before the logic reads or writes them.
Simply put: Process scan lines, not whole frames. That would make the data 
never hit DDR at all, and raise the processing speed by a significant factor.


>> Another approach is to make your software uncached-memory friendly. If you
>> process the frames sequentially and use NEON instructions to fetch large
>> aligned chunks for further processing, the absense of caching won't matter
>> much.
>
> Yes, that was the next thing I was going to try.
>
> Does using pre-load make anysense for uncached ? I guess not.

You could do some "preloading" by interleaving fetch and process instructions, 
so the CPU has some work to do while waiting for the DDR data. I haven't 
experimented with that either.
