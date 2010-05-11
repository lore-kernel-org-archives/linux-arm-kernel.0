From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 May 2010 15:32:04 +0200
Subject: arm926_dma_flush_range undefined!
In-Reply-To: <20100511094448.GB18828@n2100.arm.linux.org.uk>
References: <4BE2C013.4040009@atmel.com>
	<1273154831.2094.11.camel@e102109-lin.cambridge.arm.com>
	<20100506175907.GA15797@n2100.arm.linux.org.uk>
	<4BE926B5.7090602@atmel.com>
	<20100511094448.GB18828@n2100.arm.linux.org.uk>
Message-ID: <4BE95C54.5070008@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/05/2010 11:44, Russell King - ARM Linux :
> On Tue, May 11, 2010 at 11:43:17AM +0200, Nicolas Ferre wrote:
>> Le 06/05/2010 19:59, Russell King - ARM Linux :
>>> On Thu, May 06, 2010 at 03:07:11PM +0100, Catalin Marinas wrote:
>>>> On Thu, 2010-05-06 at 15:11 +0200, Nicolas Ferre wrote:
>>>>> I am trying to compile a recent kernel 
>>>>> (v2.6.34-rc6-201-g722154e) and I am 
>>>>> having this kind of error:
>>>>>
>>>>> ERROR: "arm926_dma_flush_range" [drivers/mmc/host/at91_mci.ko] undefined!
>>>>
>>>> The driver seems to use dmac_flush_range() directly. That's not part of
>>>> the DMA API. Could you not use one of the supported DMA API functions?
>>
>> The difficult part for me is to choose the proper one ;-)
>>
>> And also, I am wondering if this call is needed as we do a
>> kunmap_atomic() on the same scatterlist pointer just before. Does not
>> kunmap_atomic() embed a cache flushing directive already?
> 
> No it doesn't.  What are you trying to do here?

After a read with DMA from sd/mmc interface, a DMA buffer allocated by
dma_alloc_coherent() is filled.
This buffer is then copied to the scatterlist provided by the mmc
request (from drivers/mmc/card/block.c it seems that sg buffers are
alocacted via kmalloc()).

For each buffer of the scatterlist, I do this dmac_flush_rage()...

As copy is done between a coherent and a kernel memory buffers, I guess
that the flushing routine is not needed?

Best regards,
-- 
Nicolas Ferre
