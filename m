From: riel@redhat.com (Rik van Riel)
Date: Mon, 25 Jul 2016 17:42:03 -0400
Subject: [PATCH v4 12/12] mm: SLUB hardened usercopy support
In-Reply-To: <0f980e84-b587-3d9e-3c26-ad57f947c08b@redhat.com>
References: <1469046427-12696-1-git-send-email-keescook@chromium.org>
 <1469046427-12696-13-git-send-email-keescook@chromium.org>
 <0f980e84-b587-3d9e-3c26-ad57f947c08b@redhat.com>
Message-ID: <1469482923.30053.122.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-07-25 at 12:16 -0700, Laura Abbott wrote:
> On 07/20/2016 01:27 PM, Kees Cook wrote:
> > Under CONFIG_HARDENED_USERCOPY, this adds object size checking to
> > the
> > SLUB allocator to catch any copies that may span objects. Includes
> > a
> > redzone handling fix discovered by Michael Ellerman.
> > 
> > Based on code from PaX and grsecurity.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Tested-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> > ?init/Kconfig |??1 +
> > ?mm/slub.c????| 36 ++++++++++++++++++++++++++++++++++++
> > ?2 files changed, 37 insertions(+)
> > 
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 798c2020ee7c..1c4711819dfd 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1765,6 +1765,7 @@ config SLAB
> > 
> > ?config SLUB
> > ?	bool "SLUB (Unqueued Allocator)"
> > +	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> > ?	help
> > ?	???SLUB is a slab allocator that minimizes cache line
> > usage
> > ?	???instead of managing queues of cached objects (SLAB
> > approach).
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 825ff4505336..7dee3d9a5843 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3614,6 +3614,42 @@ void *__kmalloc_node(size_t size, gfp_t
> > flags, int node)
> > ?EXPORT_SYMBOL(__kmalloc_node);
> > ?#endif
> > 
> > +#ifdef CONFIG_HARDENED_USERCOPY
> > +/*
> > + * Rejects objects that are incorrectly sized.
> > + *
> > + * Returns NULL if check passes, otherwise const char * to name of
> > cache
> > + * to indicate an error.
> > + */
> > +const char *__check_heap_object(const void *ptr, unsigned long n,
> > +				struct page *page)
> > +{
> > +	struct kmem_cache *s;
> > +	unsigned long offset;
> > +	size_t object_size;
> > +
> > +	/* Find object and usable object size. */
> > +	s = page->slab_cache;
> > +	object_size = slab_ksize(s);
> > +
> > +	/* Find offset within object. */
> > +	offset = (ptr - page_address(page)) % s->size;
> > +
> > +	/* Adjust for redzone and reject if within the redzone. */
> > +	if (kmem_cache_debug(s) && s->flags & SLAB_RED_ZONE) {
> > +		if (offset < s->red_left_pad)
> > +			return s->name;
> > +		offset -= s->red_left_pad;
> > +	}
> > +
> > +	/* Allow address range falling entirely within object
> > size. */
> > +	if (offset <= object_size && n <= object_size - offset)
> > +		return NULL;
> > +
> > +	return s->name;
> > +}
> > +#endif /* CONFIG_HARDENED_USERCOPY */
> > +
> 
> I compared this against what check_valid_pointer does for SLUB_DEBUG
> checking. I was hoping we could utilize that function to avoid
> duplication but a) __check_heap_object needs to allow accesses
> anywhere
> in the object, not just the beginning b) accessing page->objects
> is racy without the addition of locking in SLUB_DEBUG.
> 
> Still, the ptr < page_address(page) check from __check_heap_object
> would
> be good to add to avoid generating garbage large offsets and trying
> to
> infer C math.
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 7dee3d9..5370e4f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3632,6 +3632,9 @@ const char *__check_heap_object(const void
> *ptr, unsigned long n,
> ?????????s = page->slab_cache;
> ?????????object_size = slab_ksize(s);
> ??
> +???????if (ptr < page_address(page))
> +???????????????return s->name;
> +
> ?????????/* Find offset within object. */
> ?????????offset = (ptr - page_address(page)) % s->size;
>?

I don't get it, isn't that already guaranteed because we
look for the page that ptr is in, before __check_heap_object
is called?

Specifically, in patch 3/12:

+???????page = virt_to_head_page(ptr);
+
+???????/* Check slab allocator for flags and size. */
+???????if (PageSlab(page))
+???????????????return __check_heap_object(ptr, n, page);

How can that generate a ptr that is not inside the page?

What am I overlooking? ?And, should it be in the changelog or
a comment? :)

-- 

All Rights Reversed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/cdce2ed3/attachment-0001.sig>
