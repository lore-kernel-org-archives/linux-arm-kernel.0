From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 10 Jul 2014 13:24:17 +0400
Subject: [RFC/PATCH RESEND -next 15/21] mm: slub: add kernel address
 sanitizer hooks to slub allocator
In-Reply-To: <alpine.DEB.2.11.1407090947020.1384@gentwo.org>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-16-git-send-email-a.ryabinin@samsung.com>
 <alpine.DEB.2.11.1407090947020.1384@gentwo.org>
Message-ID: <53BE5BC1.6050802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/14 18:48, Christoph Lameter wrote:
> On Wed, 9 Jul 2014, Andrey Ryabinin wrote:
> 
>> With this patch kasan will be able to catch bugs in memory allocated
>> by slub.
>> Allocated slab page, this whole page marked as unaccessible
>> in corresponding shadow memory.
>> On allocation of slub object requested allocation size marked as
>> accessible, and the rest of the object (including slub's metadata)
>> marked as redzone (unaccessible).
>>
>> We also mark object as accessible if ksize was called for this object.
>> There is some places in kernel where ksize function is called to inquire
>> size of really allocated area. Such callers could validly access whole
>> allocated memory, so it should be marked as accessible by kasan_krealloc call.
> 
> Do you really need to go through all of this? Add the hooks to
> kmem_cache_alloc_trace() instead and use the existing instrumentation
> that is there for other purposes?
> 

I could move kasan_kmalloc hooks kmem_cache_alloc_trace(), and I think it will look better.
Hovewer I will require two hooks instead of one (for CONFIG_TRACING=y and CONFIG_TRACING=n).

Btw, seems I broke CONFIG_SL[AO]B configurations in this patch by  introducing __ksize function
which used in krealloc now.
