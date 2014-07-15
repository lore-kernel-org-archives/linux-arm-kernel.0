From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Tue, 15 Jul 2014 19:02:56 +0400
Subject: [RFC/PATCH RESEND -next 14/21] mm: slub: kasan: disable kasan when
 touching unaccessible memory
In-Reply-To: <alpine.DEB.2.11.1407150924320.10593@gentwo.org>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-15-git-send-email-a.ryabinin@samsung.com>
 <20140715060405.GI11317@js1304-P5Q-DELUXE> <53C4DA54.3010502@samsung.com>
 <20140715081852.GL11317@js1304-P5Q-DELUXE>
 <alpine.DEB.2.11.1407150924320.10593@gentwo.org>
Message-ID: <53C542A0.5050107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/14 18:26, Christoph Lameter wrote:
> On Tue, 15 Jul 2014, Joonsoo Kim wrote:
> 
>>> I think putting disable/enable only where we strictly need them might be a problem for future maintenance of slub.
>>> If someone is going to add a new function call somewhere, he must ensure that it this call won't be a problem
>>> for kasan.
>>
>> I don't agree with this.
>>
>> If someone is going to add a slab_pad_check() in other places in
>> slub.c, we should disable/enable kasan there, too. This looks same
>> maintenance problem to me. Putting disable/enable only where we
>> strictly need at least ensures that we don't need to care when using
>> slub internal functions.
>>
>> And, if memchr_inv() is problem, I think that you also need to add hook
>> into validate_slab_cache().
>>
>> validate_slab_cache() -> validate_slab_slab() -> validate_slab() ->
>> check_object() -> check_bytes_and_report() -> memchr_inv()
> 
> I think adding disable/enable is good because it separates the payload
> access from metadata accesses. This may be useful for future checkers.
> Maybe call it something different so that this is more generic.
> 
> metadata_access_enable()
> 
> metadata_access_disable()
> 
> ?
> 
It sounds like a good idea to me. However in this patch, besides from protecting metadata accesses,
this calls also used in setup_objects for wrapping ctor call. It used there because all pages in allocate_slab
are poisoned, so at the time when ctors are called all object's memory marked as poisoned.

I think this could be solved by removing kasan_alloc_slab_pages() hook form allocate_slab() and adding
kasan_slab_free() hook after ctor call.
But I guess in that case padding at the end of slab will be unpoisoined.

> Maybe someone else has a better idea?
> 
> 
> 
