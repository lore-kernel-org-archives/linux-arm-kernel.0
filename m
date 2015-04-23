From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu, 23 Apr 2015 15:05:41 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <2757951.K585xX1rYN@wuerfel>
References: <5538DD02.6050401@topic.nl> <2757951.K585xX1rYN@wuerfel>
Message-ID: <5538EE25.2030909@topic.nl>
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

I can live with manual flushes. I know exactly what and where to flush in the 
driver.

What bothers me so much is that just invalidating the data cache(s) takes 
longer than actually reading the data from uncached memory and writing it into 
cached memory elsewhere. That just does not sound right to me.

> You mentioned that you are using 'Zynq', which supports cache-coherent
> DMA using the 'accelerator coherency port'. If you are able to connect
> your device to that port, it should work, otherwise you should consider
> using a different platform.

I can probably hook up the DMA controller to the ACP port, however, I would 
expect this to have serious negative impact on system performance. The 
transfers are typically in the megabyte range (for example, video frames) so 
they will not fit into the L2 cache (which is 512k on the Zynq). I'd expect 
these transfers, when routed through the ACP, to "push" all data out of the L2 
cache, replacing it with data that isn't going to be read any time soon, and 
thus interfere with performance too much.

It might be worth a try though to see what will actually happen.

Mike.


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
