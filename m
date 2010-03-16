From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Mar 2010 23:54:22 +0000
Subject: mapping uncached memory
In-Reply-To: <57314e841003161617l53dc3a50la969369f0161ccdd@mail.gmail.com>
References: <57314e841003161617l53dc3a50la969369f0161ccdd@mail.gmail.com>
Message-ID: <20100316235422.GC13948@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 01:17:45AM +0200, Budhee Jamaich wrote:
> these are the alternatives we currently see:
> 
> 
> 1. clean cache after every write to the memory (/invalidate the cache
> before every read)
> 
> this can be done using dmac_clean/inv_range and outer_clean/inv_range
> just like in dma_cache_maint.
> btw - what's the difference between the dmac_* and the outer_*
> functions ? why both are needed ?

You don't need to know; they're the wrong interface to use.

See the DMA API instead; that is the official interface.  What you're
looking at above is an implementation detail of that interface which is
not intended for direct use by anything other than the DMA API.  Use of
this implementation detail will lead to breakage.

> 2. use pgprot_noncached when assigning vma->vm_page_prot in our
> driver's mmap method
> 
> 
> will that really work ? all memory accesses will be uncached ?

Not on ARMv6 and above - it has become illegal to remap memory with
differing type attributes.

> 3. use dma_alloc_coherent in some way
> 
> cons: documentation says we still need to use cache clean/inv
> operations, so this might not really be of any advantage. but if that
> is so, what's the idea behind coherent pools of memory ? how does it
> work at all ?

Please provide a pointer to that documentation.

Note that the whole "DMA to user mapped pages" issue is a _big_ can of
worms and doesn't appear to have any sane and non-expensive solutions.
