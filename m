From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Wed, 29 Apr 2015 10:47:05 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <2757951.K585xX1rYN@wuerfel>
References: <5538DD02.6050401@topic.nl> <2757951.K585xX1rYN@wuerfel>
Message-ID: <55409A89.5070008@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 23-04-15 14:32, Arnd Bergmann wrote:
> On Thursday 23 April 2015 13:52:34 Mike Looijmans wrote:
>> Can anyone here offer some advise on this?
>>
>
> The problem you are experiencing is a direct result of using hardware
> without cache-coherency from user space. There is no software workaround
> for this: If you want data to be cacheable *and* avoid doing manual cache
> flushes each time data is passed between user space and hardware, you have
> to use hardware that is cache-coherent.
>
> You mentioned that you are using 'Zynq', which supports cache-coherent
> DMA using the 'accelerator coherency port'. If you are able to connect
> your device to that port, it should work, otherwise you should consider
> using a different platform.

I tried as you suggested, and used the ACP instead of the HP to connect the 
logic to the CPU.

Without any further changes, this passes all tests with the exact same 
performance numbers. The reason for that is that the driver/DMA framework is 
unaware of the "coherency" hardware and still uses the manual cache 
flush/invalidate routines, so I figured out that adding a "dma-coherent" 
property to the devicetree node changes that.

However, with "dma-coherent" set for my driver, the system locks up at random 
points in the tests. Simple memory transfer tests fail with data mismatches 
(probably stale cache results). Running DMA tests usually results in the 
system completely locking up at some point.
Normal register read/write access is done through the AXI bus directly, not 
using the ACP at all.

Is the ACP hardware broken, is there some extra things my driver needs to be 
aware of, or is there something else I need to do here?


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
