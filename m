From: cl@linux.com (Christoph Lameter)
Date: Tue, 3 Nov 2015 17:33:25 -0600 (CST)
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <20151103185050.GJ7637@e104818-lin.cambridge.arm.com>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151028190948.GJ8899@e104818-lin.cambridge.arm.com>
 <CAMuHMdWQygbxMXoOsbwek6DzZcr7J-C23VCK4ubbgUr+zj=giw@mail.gmail.com>
 <20151103120504.GF7637@e104818-lin.cambridge.arm.com>
 <20151103143858.GI7637@e104818-lin.cambridge.arm.com>
 <CAMuHMdWk0fPzTSKhoCuS4wsOU1iddhKJb2SOpjo=a_9vCm_KXQ@mail.gmail.com>
 <20151103185050.GJ7637@e104818-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.20.1511031724010.8178@east.gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Nov 2015, Catalin Marinas wrote:

> (cc'ing Jonsoo and Christoph; summary: slab failure with L1_CACHE_BYTES
> of 128 and sizeof(kmem_cache_node) of 152)

Hmmm... Yes that would mean use the 196 sized kmalloc array which is not a
power of two slab. But the code looks fine to me.

> If I revert commit 8fc9cf420b36 ("slab: make more slab management
> structure off the slab") it works but I still need to figure out how
> slab indices are calculated. The size_index[] array is overridden so
> that 0..15 are 7 and 16..23 are 8. But the kmalloc_caches[7] has never
> been populated, hence the BUG_ON. Another option may be to change
> kmalloc_size and kmalloc_index to cope with KMALLOC_MIN_SIZE of 128.
>
> I'll do some more investigation tomorrow.

The commit allows off slab management for PAGE_SIZE >> 5 that is 128.

After that commit kmem_cache_create would try to allocate an off slab
management structure which is not available during early boot.
But the slab_early_init is set which should prevent the use of an off slab
management infrastructure in kmem_cache_create().

However, the failure in line 2283 shows that the OFF SLAB flag was
mistakenly set anyways!!!! Something must havee cleared slab_early_init?
