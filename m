From: mhocko@kernel.org (Michal Hocko)
Date: Mon, 29 Oct 2018 09:17:06 +0100
Subject: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
In-Reply-To: <20181029080708.GA32673@dhcp22.suse.cz>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
 <20181029080708.GA32673@dhcp22.suse.cz>
Message-ID: <20181029081706.GC32673@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 29-10-18 09:07:08, Michal Hocko wrote:
[...]
> Besides that, the following doesn't make much sense to me. It simply
> makes no sense to use vmalloc for sub page allocation regardless of
> HIGHMEM.

OK, it is still early morning here. Now I get the point of the patch.
You just want to (ab)use highmeme for smaller requests. I do not like
this, to be honest. It causes an internal fragmentation and more
importantly the VMALLOC space on 32b where HIGHMEM is enabled (do we
have any 64b with HIGHMEM btw?) is quite small to be wasted like that.

In any case such a changes should come with some numbers and as a
separate patch for sure.

> > diff --git a/mm/util.c b/mm/util.c
> > index 8bf08b5b5760..7b1c59b9bfbf 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -416,10 +416,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
> >  	ret = kmalloc_node(size, kmalloc_flags, node);
> >  
> >  	/*
> > -	 * It doesn't really make sense to fallback to vmalloc for sub page
> > -	 * requests
> > +	 * It only makes sense to fallback to vmalloc for sub page
> > +	 * requests if we might be able to allocate highmem pages.
> >  	 */
> > -	if (ret || size <= PAGE_SIZE)
> > +	if (ret || (!IS_ENABLED(CONFIG_HIGHMEM) && size <= PAGE_SIZE))
> >  		return ret;
> >  
> >  	return __vmalloc_node_flags_caller(size, node, flags,
> > -- 
> > 2.18.0
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
