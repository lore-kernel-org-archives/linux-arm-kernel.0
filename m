From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 10 Jul 2014 11:43:14 +0400
Subject: [RFC/PATCH RESEND -next 12/21] mm: util: move krealloc/kzfree to
 slab_common.c
In-Reply-To: <alpine.DEB.2.11.1407090931350.1384@gentwo.org>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-13-git-send-email-a.ryabinin@samsung.com>
 <alpine.DEB.2.11.1407090931350.1384@gentwo.org>
Message-ID: <53BE4412.6030707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/14 18:32, Christoph Lameter wrote:
> On Wed, 9 Jul 2014, Andrey Ryabinin wrote:
> 
>> To avoid false positive reports in kernel address sanitizer krealloc/kzfree
>> functions shouldn't be instrumented. Since we want to instrument other
>> functions in mm/util.c, krealloc/kzfree moved to slab_common.c which is not
>> instrumented.
>>
>> Unfortunately we can't completely disable instrumentation for one function.
>> We could disable compiler's instrumentation for one function by using
>> __atribute__((no_sanitize_address)).
>> But the problem here is that memset call will be replaced by instumented
>> version kasan_memset since currently it's implemented as define:
> 
> Looks good to me and useful regardless of the sanitizer going in.
> 
> Acked-by: Christoph Lameter <cl@linux.com>
> 

I also noticed in mm/util.c:

	/* Tracepoints definitions. */
	EXPORT_TRACEPOINT_SYMBOL(kmalloc);
	EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
	EXPORT_TRACEPOINT_SYMBOL(kmalloc_node);
	EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc_node);
	EXPORT_TRACEPOINT_SYMBOL(kfree);
	EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);

Should I send another patch to move this to slab_common.c?
