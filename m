From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 5 Nov 2015 13:31:55 +0900
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <20151104153910.GN7637@e104818-lin.cambridge.arm.com>
References: <20151103120504.GF7637@e104818-lin.cambridge.arm.com>
 <20151103143858.GI7637@e104818-lin.cambridge.arm.com>
 <CAMuHMdWk0fPzTSKhoCuS4wsOU1iddhKJb2SOpjo=a_9vCm_KXQ@mail.gmail.com>
 <20151103185050.GJ7637@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.20.1511031724010.8178@east.gentwo.org>
 <20151104123640.GK7637@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.20.1511040748590.17248@east.gentwo.org>
 <20151104145445.GL7637@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.20.1511040927510.18745@east.gentwo.org>
 <20151104153910.GN7637@e104818-lin.cambridge.arm.com>
Message-ID: <20151105043155.GA20374@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 03:39:10PM +0000, Catalin Marinas wrote:
> On Wed, Nov 04, 2015 at 09:28:34AM -0600, Christoph Lameter wrote:
> > On Wed, 4 Nov 2015, Catalin Marinas wrote:
> > 
> > > BTW, assuming L1_CACHE_BYTES is 512 (I don't ever see this happening but
> > > just in theory), we potentially have the same issue. What would save us
> > > is that INDEX_NODE would match the first "kmalloc-512" cache, so we have
> > > it pre-populated.
> > 
> > Ok maybe add some BUILD_BUG_ONs to ensure that builds fail until we have
> > addressed that.
> 
> A BUILD_BUG_ON should be fine.
> 
> Thinking some more, I think if KMALLOC_MIN_SIZE is 128, there is no gain
> with off-slab management since the freelist allocation would still be
> 128 bytes. An alternative to reverting while still having a little
> benefit of off-slab for 256 bytes objects (rather than 512 as we would
> get with the revert):
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 4fcc5dd8d5a6..ac32b4a0f2ec 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2212,8 +2212,8 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
>  	 * it too early on. Always use on-slab management when
>  	 * SLAB_NOLEAKTRACE to avoid recursive calls into kmemleak)
>  	 */
> -	if ((size >= (PAGE_SIZE >> 5)) && !slab_early_init &&
> -	    !(flags & SLAB_NOLEAKTRACE))
> +	if ((size >= (PAGE_SIZE >> 5)) && (size > KMALLOC_MIN_SIZE) &&
> +		!slab_early_init && !(flags & SLAB_NOLEAKTRACE))
>  		/*
>  		 * Size is large, assume best to place the slab management obj
>  		 * off-slab (should allow better packing of objs).
> 
> Whichever you prefer.

Hello,

I prefer this simple way. It looks like that it can solve the issue on
any arbitrary configuration.

Thanks.
