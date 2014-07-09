From: cl@gentwo.org (Christoph Lameter)
Date: Wed, 9 Jul 2014 09:48:41 -0500 (CDT)
Subject: [RFC/PATCH RESEND -next 15/21] mm: slub: add kernel address
 sanitizer hooks to slub allocator
In-Reply-To: <1404905415-9046-16-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-16-git-send-email-a.ryabinin@samsung.com>
Message-ID: <alpine.DEB.2.11.1407090947020.1384@gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jul 2014, Andrey Ryabinin wrote:

> With this patch kasan will be able to catch bugs in memory allocated
> by slub.
> Allocated slab page, this whole page marked as unaccessible
> in corresponding shadow memory.
> On allocation of slub object requested allocation size marked as
> accessible, and the rest of the object (including slub's metadata)
> marked as redzone (unaccessible).
>
> We also mark object as accessible if ksize was called for this object.
> There is some places in kernel where ksize function is called to inquire
> size of really allocated area. Such callers could validly access whole
> allocated memory, so it should be marked as accessible by kasan_krealloc call.

Do you really need to go through all of this? Add the hooks to
kmem_cache_alloc_trace() instead and use the existing instrumentation
that is there for other purposes?
