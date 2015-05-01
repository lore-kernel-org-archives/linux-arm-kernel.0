From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Fri, 1 May 2015 09:01:33 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <55431852.2000302@topic.nl>
References: <5538DD02.6050401@topic.nl> <9622793.RaVBbeJMCx@wuerfel>
 <55423317.7000401@topic.nl> <2309938.la6bU0Xy8o@wuerfel>
 <55431852.2000302@topic.nl>
Message-ID: <554324CD.3060807@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 01-05-15 08:08, Mike Looijmans wrote:
> On 30-04-15 15:54, Arnd Bergmann wrote:
>> On Thursday 30 April 2015 15:50:15 Mike Looijmans wrote:
>>>
>>> Just to give you a status update, I tried that too (by adding a
>>> dma_mmap_coherent variant that omits the "prot" change, and some printks to
>>> verify that it actually does as expected).
>>>
>>> Current status is that the ACP behaves exactly like the HP port, which it
>>> should not do. If I send data from logic via the ACP port through the L2
>>> cache, using a version of dma_sync that just invalidates the cache could
>>> (should?) result in data corruption. Instead, the data gets corrupted only if
>>> you do not invalidate the line. This is what the (non-coherent) HP port
>>> behaves like, as it writes directly to DDR.
>>>
>>> Currently I'm assuming that the tools did something wrong in the bitstream,
>>> for example, wiring the "AWCACHE" and similar signals on the ACP to logic "0"
>>> instead of "1" while claiming to have wired them to "1" in the UI. A bug like
>>> that would also explain the behaviour I'm seeing now.
>>>
>>> I'll let you know once I find out more.
>>
>> Ok, maybe you have to configure the SCU to include the ACP in the
>> cache coherency? That might not be done by default. I don't really
>> know anything about the SCU or the ACP, so I'm just taking wild
>> guesses here.
>
> The issue seems to be in these signals, the tool falsely claimed to have them
> set high, but it actually only sets half of them, which thus has no effect at
> all. I'll be able to test that in an hour or so once the bitstream is ready.

Indeed, controlling the signals manually instead of relying on the tools makes 
the ACP operate correctly.

> Interestingly, the coherency is not a property of the port or of the device
> itself, it is a property of the DMA transaction. One single master on this
> post can do both coherent and non-coherent transfers.
> Now there's an interesting challenge, since the kernel appears to assume that
> one device can only do one type. My 'hardware' actually has multiple masters,
> which could potentially be tied to different ports or busses.

Measurements show that this is going to be important. Writing larger blocks to 
DDR using coherency transfers data at about 240MB/s, while without coherency 
it's 600MB/s. Have yet to test small datasets, I expect opposite results 
there, since they'll remain in the L2 cache.




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
