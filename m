From: cl@gentwo.org (Christoph Lameter)
Date: Wed, 9 Jul 2014 09:29:22 -0500 (CDT)
Subject: [RFC/PATCH RESEND -next 11/21] mm: slub: share slab_err and
 object_err functions
In-Reply-To: <1404905415-9046-12-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-12-git-send-email-a.ryabinin@samsung.com>
Message-ID: <alpine.DEB.2.11.1407090928530.1384@gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jul 2014, Andrey Ryabinin wrote:

> Remove static and add function declarations to mm/slab.h so they
> could be used by kernel address sanitizer.

Hmmm... This is allocator specific. At some future point it would be good
to move error reporting to slab_common.c and use those from all
allocators.

> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
> ---
>  mm/slab.h | 5 +++++
>  mm/slub.c | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 1257ade..912af7f 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -339,5 +339,10 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
>
>  void *slab_next(struct seq_file *m, void *p, loff_t *pos);
>  void slab_stop(struct seq_file *m, void *p);
> +void slab_err(struct kmem_cache *s, struct page *page,
> +		const char *fmt, ...);
> +void object_err(struct kmem_cache *s, struct page *page,
> +		u8 *object, char *reason);
> +
>
>  #endif /* MM_SLAB_H */
> diff --git a/mm/slub.c b/mm/slub.c
> index 6641a8f..3bdd9ac 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -635,14 +635,14 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
>  	dump_stack();
>  }
>
> -static void object_err(struct kmem_cache *s, struct page *page,
> +void object_err(struct kmem_cache *s, struct page *page,
>  			u8 *object, char *reason)
>  {
>  	slab_bug(s, "%s", reason);
>  	print_trailer(s, page, object);
>  }
>
> -static void slab_err(struct kmem_cache *s, struct page *page,
> +void slab_err(struct kmem_cache *s, struct page *page,
>  			const char *fmt, ...)
>  {
>  	va_list args;
>
