From: vincenzo.frascino@arm.com (Vincenzo Frascino@Foss)
Date: Wed, 25 Jul 2018 14:44:10 +0100
Subject: [PATCH v4 13/17] khwasan: add hooks implementation
In-Reply-To: <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com>
Message-ID: <09cb5553-d84a-0e62-5174-315c14b88833@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2018 02:15 PM, Andrey Konovalov wrote:

> @@ -325,18 +341,41 @@ void kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
>   
>   void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
>   {
> -	return kasan_kmalloc(cache, object, cache->object_size, flags);
> +	object = kasan_kmalloc(cache, object, cache->object_size, flags);
> +	if (IS_ENABLED(CONFIG_KASAN_HW) && unlikely(cache->ctor)) {
> +		/*
> +		 * Cache constructor might use object's pointer value to
> +		 * initialize some of its fields.
> +		 */
> +		cache->ctor(object);
>
This seams breaking the kmem_cache_create() contract: "The @ctor is run 
when new pages are allocated by the cache." 
(https://elixir.bootlin.com/linux/v3.7/source/mm/slab_common.c#L83)

Since there might be preexisting code relying on it, this could lead to 
global side effects. Did you verify that this is not the case?

Another concern is performance related if we consider this solution 
suitable for "near-production", since with the current implementation 
you call the ctor (where present) on an object multiple times and this 
ends up memsetting and repopulating the memory every time (i.e. inode.c: 
inode_init_once). Do you know what is the performance impact?

-- 
Regards,
Vincenzo
