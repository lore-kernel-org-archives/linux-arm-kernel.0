From: miles.chen@mediatek.com (Miles Chen)
Date: Tue, 30 Oct 2018 09:29:10 +0800
Subject: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
In-Reply-To: <20181029081706.GC32673@dhcp22.suse.cz>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
 <20181029080708.GA32673@dhcp22.suse.cz>
 <20181029081706.GC32673@dhcp22.suse.cz>
Message-ID: <1540862950.12374.40.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-10-29 at 09:17 +0100, Michal Hocko wrote:
> On Mon 29-10-18 09:07:08, Michal Hocko wrote:
> [...]
> > Besides that, the following doesn't make much sense to me. It simply
> > makes no sense to use vmalloc for sub page allocation regardless of
> > HIGHMEM.
> 
> OK, it is still early morning here. Now I get the point of the patch.
> You just want to (ab)use highmeme for smaller requests. I do not like
> this, to be honest. It causes an internal fragmentation and more
> importantly the VMALLOC space on 32b where HIGHMEM is enabled (do we
> have any 64b with HIGHMEM btw?) is quite small to be wasted like that.
> 
thanks for your comment. It looks like that using vmalloc fallback for
sub page allocation is not good here.

Your comment gave another idea:

1. force kbuf to PAGE_SIZE
2. allocate a page by alloc_page(GFP_KERNEL | __GFP_HIGHMEM); so we can
get a highmem page if possible
3. use kmap/kunmap pair to create mapping for this page. No vmalloc
space is used.
4. do not change kvmalloc logic.


> In any case such a changes should come with some numbers and as a
> separate patch for sure.
> 
> > > diff --git a/mm/util.c b/mm/util.c
> > > index 8bf08b5b5760..7b1c59b9bfbf 100644
> > > --- a/mm/util.c
> > > +++ b/mm/util.c
> > > @@ -416,10 +416,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
> > >  	ret = kmalloc_node(size, kmalloc_flags, node);
> > >  
> > >  	/*
> > > -	 * It doesn't really make sense to fallback to vmalloc for sub page
> > > -	 * requests
> > > +	 * It only makes sense to fallback to vmalloc for sub page
> > > +	 * requests if we might be able to allocate highmem pages.
> > >  	 */
> > > -	if (ret || size <= PAGE_SIZE)
> > > +	if (ret || (!IS_ENABLED(CONFIG_HIGHMEM) && size <= PAGE_SIZE))
> > >  		return ret;
> > >  
> > >  	return __vmalloc_node_flags_caller(size, node, flags,
> > > -- 
> > > 2.18.0
> > > 
> > 
> > -- 
> > Michal Hocko
> > SUSE Labs
> 
