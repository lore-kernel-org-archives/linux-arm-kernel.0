From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 30 Oct 2012 08:19:12 +0100
Subject: [PATCH 1/2] arm: mvebu: increase atomic coherent pool size for
 armada 370/XP
In-Reply-To: <201210251346.41596.arnd@arndb.de>
References: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
 <201210251127.36960.arnd@arndb.de> <20121025134352.16a8ef81@skate>
 <201210251346.41596.arnd@arndb.de>
Message-ID: <508F7F70.2060609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 10/25/2012 3:46 PM, Arnd Bergmann wrote:
> On Thursday 25 October 2012, Thomas Petazzoni wrote:
>> On Thu, 25 Oct 2012 11:27:36 +0000, Arnd Bergmann wrote:
>>> On Wednesday 24 October 2012, Gregory CLEMENT wrote:
>>>> For Armada 370/XP we have the same problem that for the commit
>>>> cb01b63, so we applied the same solution: "The default 256 KiB
>>>> coherent pool may be too small for some of the Kirkwood devices, so
>>>> increase it to make sure that devices will be able to allocate their
>>>> buffers with GFP_ATOMIC flag"
>>>>
>>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>
>>> Do you know why the ATA driver needs this? I find it surprising that
>>> it's necessary, so I'd like to make sure we're not just working around
>>> a device driver bug here.
>>
>> The sata_mv driver create dma_pool and allocate objects from them, and
>> all the memory allocated for dma_pools is allocated using
>> dma_alloc_coherent(), and I guess the driver is using too much of them.
>>
>> Seems like the driver is too lazy and allocates everything coherent to
>> avoid the hassle of doing dma_map/dma_unmap operations when needed, but
>> I haven't looked in details at the driver yet to see if it would be
>> possible to switch those DMA coherent allocations into non-coherent
>> allocations + appropriate calls to the DMA operations.
>
> Using coherent allocations is fine, I was wondering whether they need
> to be atomic or not.

I've checked the code and it turned out that ALL allocations from 
dma_pool are made with GFP_ATOMIC flag. GFP flags passed from caller are 
simply ignored, see mm/dmapool.c dma_pool_alloc() function.

This looks like an ugly hack or workaround from ancient times, because 
dma_pool_alloc() tries to implement __GFP_WAIT style approach on it's 
own. I've tried to find the reason for such approach, but it looks that 
this code comes from pre-git times. IMHO this strange code inside 
dma_pool_alloc() should be replaced with simple call to 
pool_alloc_page(pool, mem_flags) and let dma-mapping and core memory 
subsystems to handle gfp flags correctly.

Arnd: do you have any opinion on this? I'm aware that this change might 
have some side effects on drivers which don't pass correct gfp flags, 
but using the emergency memory pools all the time for all dma_pool 
allocations really doesn't make much sense.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
