From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Wed, 31 Oct 2018 19:33:34 +0300
Subject: [PATCH v9 01/20] kasan, mm: change hooks signatures
In-Reply-To: <37b1d7e7c372b60e2323b33bf2e57d4e3409df0b.1537542735.git.andreyknvl@google.com>
References: <cover.1537542735.git.andreyknvl@google.com>
 <37b1d7e7c372b60e2323b33bf2e57d4e3409df0b.1537542735.git.andreyknvl@google.com>
Message-ID: <64a7030a-d6bf-3b52-aa7d-dbb1b25a7bc8@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/21/2018 06:13 PM, Andrey Konovalov wrote:
> Tag-based KASAN changes the value of the top byte of pointers returned
> from the kernel allocation functions (such as kmalloc). This patch updates
> KASAN hooks signatures and their usage in SLAB and SLUB code to reflect
> that.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/kasan.h | 43 +++++++++++++++++++++++++++++--------------
>  mm/kasan/kasan.c      | 30 ++++++++++++++++++------------
>  mm/slab.c             | 12 ++++++------
>  mm/slab.h             |  2 +-
>  mm/slab_common.c      |  4 ++--
>  mm/slub.c             | 15 +++++++--------
>  6 files changed, 63 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 46aae129917c..52c86a568a4e 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -51,16 +51,16 @@ void kasan_cache_shutdown(struct kmem_cache *cache);
>  void kasan_poison_slab(struct page *page);
>  void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
>  void kasan_poison_object_data(struct kmem_cache *cache, void *object);
> -void kasan_init_slab_obj(struct kmem_cache *cache, const void *object);
> +void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object);
>  
> -void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
> +void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
>  void kasan_kfree_large(void *ptr, unsigned long ip);
>  void kasan_poison_kfree(void *ptr, unsigned long ip);
> -void kasan_kmalloc(struct kmem_cache *s, const void *object, size_t size,
> +void *kasan_kmalloc(struct kmem_cache *s, const void *object, size_t size,
>  		  gfp_t flags);

This patch missed couple call-sites, in kmem_cache_alloc_trace() and kmem_cache_alloc_node_trace() in include/linux/slab.h,
the return value of kasan_kmalloc() is ignored. Probably worth adding __must_check to functions like this.

Once that fixed you can add Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
here and to the rest of the patches. They look fine me.
