From: mhocko@kernel.org (Michal Hocko)
Date: Fri, 3 Aug 2018 08:20:08 +0200
Subject: [RFC 1/2] slub: Avoid trying to allocate memory on offline nodes
In-Reply-To: <c6caddbf-e275-219e-12b6-538a53ced17d@arm.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-2-jeremy.linton@arm.com>
 <20180802091554.GE10808@dhcp22.suse.cz>
 <c6caddbf-e275-219e-12b6-538a53ced17d@arm.com>
Message-ID: <20180803062008.GD27245@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 02-08-18 22:21:53, Jeremy Linton wrote:
> Hi,
> 
> On 08/02/2018 04:15 AM, Michal Hocko wrote:
> > On Wed 01-08-18 15:04:17, Jeremy Linton wrote:
> > [...]
> > > @@ -2519,6 +2519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > >   		if (unlikely(!node_match(page, searchnode))) {
> > >   			stat(s, ALLOC_NODE_MISMATCH);
> > >   			deactivate_slab(s, page, c->freelist, c);
> > > +			if (!node_online(searchnode))
> > > +				node = NUMA_NO_NODE;
> > >   			goto new_slab;
> > 
> > This is inherently racy. Numa node can get offline at any point after
> > you check it here. Making it race free would involve some sort of
> > locking and I am not really convinced this is a good idea.
> 
> I spent some time looking/thinking about this, and i'm pretty sure its not
> creating any new problems. But OTOH, I think the node_online() check is
> probably a bit misleading as what we really want to assure is that
> node<MAX_NUMNODES and that there is going to be a valid entry in NODE_DATA()
> so we don't deference null.

Exactly. And we do rely that the user of the allocator doesn't really
use bogus parameters. This is not a function to be used for untrusted or
unsanitized inputs.

-- 
Michal Hocko
SUSE Labs
