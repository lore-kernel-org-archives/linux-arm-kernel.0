From: labbott@redhat.com (Laura Abbott)
Date: Thu, 8 Mar 2018 18:01:10 -0800
Subject: [RFC] android: ion: How to properly clean caches for uncached
 allocations
In-Reply-To: <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
 <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
 <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
Message-ID: <7812c0ba-8ef3-2291-eef7-cdbf921f400d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2018 04:45 PM, Liam Mark wrote:
> On Wed, 7 Mar 2018, Laura Abbott wrote:
> 
>> On 02/28/2018 09:18 PM, Liam Mark wrote:
>>> The issue:
>>>
>>> Currently in ION if you allocate uncached memory it is possible that there
>>> are still dirty lines in the cache.  And often these dirty lines in the
>>> cache are the zeros which were meant to clear out any sensitive kernel
>>> data.
>>>
>>> What this means is that if you allocate uncached memory from ION, and then
>>> subsequently write to that buffer (using the uncached mapping you are
>>> provided by ION) then the data you have written could be corrupted at some
>>> point in the future if a dirty line is evicted from the cache.
>>>
>>> Also this means there is a potential security issue.  If an un-privileged
>>> userspace user allocated uncached memory (for example from the system heap)
>>> and then if they were to read from that buffer (through the un-cached
>>> mapping they are provided by ION), and if some of the zeros which were
>>> written to that memory are still in the cache then this un-privileged
>>> userspace user could read potentially sensitive kernel data.
>>
>> For the use case you are describing we don't actually need the
>> memory to be non-cached until it comes time to do the dma mapping.
>> Here's a proposal to shoot holes in:
>>
>> - Before any dma_buf attach happens, all mmap mappings are cached
>> - At the time attach happens, we shoot down any existing userspace
>> mappings, do the dma_map with appropriate flags to clean the pages
>> and then allow remapping to userspace as uncached. Really this
>> looks like a variation on the old Ion faulting code which I removed
>> except it's for uncached buffers instead of cached buffers.
>>
> 
> Thanks Laura, I will take a look to see if I can think of any concerns.
> 
> Initial thoughts.
> - What about any kernel mappings (kmap/vmap) the client has made?
> 

We could either synchronize with dma_buf_{begin,end}_cpu_access
or just disallow the mapping to happen if there's an outstanding
kmap or vmap. Is this an actual problem or only theoretical?

> - I guess it would be tempting to only do this behavior for memory that
> came from buddy (as opposed to the pool since it should be clean), but we
> would need to be careful that no pages sneak into the pool without being
> cleaned (example: client allocs then frees without ever call
> dma_buf_attach).
> 

You're welcome to try that optimization but I think we should
focus on the basics first. Honestly it might make sense just to
have a single pool at this point since the cost of syncing
is not happening on the allocation path.

>> Potential problems:
>> - I'm not 100% about the behavior here if the attaching device
>> is already dma_coherent. I also consider uncached mappings
>> enough of a device specific optimization that you shouldn't
>> do them unless you know it's needed.
> 
> I don't believe we want to allow uncached memory to be dma mapped by an
> io-coherent device and this is something I would like to eventually block.
> 
> Since there is always a kernel cached mapping for ION uncached memory then
> speculative access could still be putting lines in the cache, so when an
> io-coherent device tries to read this uncached memory its snoop into the
> cache could find one of these 'stale' clean cache lines and end up using
> stale data.
> Agree?
> 

Sounds right.

>> - The locking/sequencing with userspace could be tricky
>> since userspace may not like us ripping mappings out from
>> underneath if it's trying to access.
> 
> Perhaps delay this work to the dma_map_attachment call since when the data
> is dma mapped the CPU shouldn't be accessing it?
> 
> Or worst case perhaps fail all map attempts to uncached memory until the
> memory has been dma mapped (and cleaned) at least once?
> 

My concern was mostly concurrent userspace access on a buffer
that's being dma_mapped but that sounds racy to begin with.

I suggested disallowing mmap until dma_mapping before and I thought
that was not possible?

Thanks,
Laura

> Thanks,
> Liam
> 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
