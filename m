From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 5 Nov 2015 05:31:39 -0800
Subject: [PATCH] mm: slab: Only move management objects off-slab for
 sizes larger than KMALLOC_MIN_SIZE
In-Reply-To: <1446724235-31400-1-git-send-email-catalin.marinas@arm.com>
References: <20151105043155.GA20374@js1304-P5Q-DELUXE>
 <1446724235-31400-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20151105053139.e38214a9.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  5 Nov 2015 11:50:35 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Commit 8fc9cf420b36 ("slab: make more slab management structure off the
> slab") enables off-slab management objects for sizes starting with
> PAGE_SIZE >> 5. This means 128 bytes for a 4KB page configuration.
> However, on systems with a KMALLOC_MIN_SIZE of 128 (arm64 in 4.4), such
> optimisation does not make sense since the slab management allocation
> would take 128 bytes anyway (even though freelist_size is 32) with the
> additional overhead of another allocation.
> 
> This patch introduces an OFF_SLAB_MIN_SIZE macro which takes
> KMALLOC_MIN_SIZE into account. It also solves a slab bug on arm64 where
> the first kmalloc_cache to be initialised after slab_early_init = 0,
> "kmalloc-128", fails to allocate off-slab management objects from the
> same "kmalloc-128" cache.

That all seems to be quite minor stuff.

> Fixes: 8fc9cf420b36 ("slab: make more slab management structure off the slab")
> Cc: <stable@vger.kernel.org> # 3.15+

Yet you believe the fix should be backported.

So, the usual refrain: when fixing a bug, please describe the end-user
visible effects of that bug.
