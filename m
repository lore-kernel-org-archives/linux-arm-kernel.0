From: labbott@redhat.com (Laura Abbott)
Date: Wed, 7 Mar 2018 15:15:01 -0800
Subject: [RFC] android: ion: How to properly clean caches for uncached
 allocations
In-Reply-To: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
Message-ID: <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2018 09:18 PM, Liam Mark wrote:
> The issue:
> 
> Currently in ION if you allocate uncached memory it is possible that there
> are still dirty lines in the cache.  And often these dirty lines in the
> cache are the zeros which were meant to clear out any sensitive kernel
> data.
> 
> What this means is that if you allocate uncached memory from ION, and then
> subsequently write to that buffer (using the uncached mapping you are
> provided by ION) then the data you have written could be corrupted at some
> point in the future if a dirty line is evicted from the cache.
> 
> Also this means there is a potential security issue.  If an un-privileged
> userspace user allocated uncached memory (for example from the system heap)
> and then if they were to read from that buffer (through the un-cached
> mapping they are provided by ION), and if some of the zeros which were
> written to that memory are still in the cache then this un-privileged
> userspace user could read potentially sensitive kernel data.

For the use case you are describing we don't actually need the
memory to be non-cached until it comes time to do the dma mapping.
Here's a proposal to shoot holes in:

- Before any dma_buf attach happens, all mmap mappings are cached
- At the time attach happens, we shoot down any existing userspace
mappings, do the dma_map with appropriate flags to clean the pages
and then allow remapping to userspace as uncached. Really this
looks like a variation on the old Ion faulting code which I removed
except it's for uncached buffers instead of cached buffers.

Potential problems:
- I'm not 100% about the behavior here if the attaching device
is already dma_coherent. I also consider uncached mappings
enough of a device specific optimization that you shouldn't
do them unless you know it's needed.
- The locking/sequencing with userspace could be tricky
since userspace may not like us ripping mappings out from
underneath if it's trying to access.

Thoughts?

Thanks,
Laura
