From: mhocko@kernel.org (Michal Hocko)
Date: Fri, 3 Aug 2018 08:24:19 +0200
Subject: [RFC 2/2] mm: harden alloc_pages code paths against bogus nodes
In-Reply-To: <5ed35dfa-5f02-55cb-9b84-b944394e1a5a@arm.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-3-jeremy.linton@arm.com>
 <20180802073147.GA10808@dhcp22.suse.cz>
 <5ed35dfa-5f02-55cb-9b84-b944394e1a5a@arm.com>
Message-ID: <20180803062419.GE27245@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 02-08-18 22:17:49, Jeremy Linton wrote:
> Hi,
> 
> On 08/02/2018 02:31 AM, Michal Hocko wrote:
> > On Wed 01-08-18 15:04:18, Jeremy Linton wrote:
> > > Its possible to crash __alloc_pages_nodemask by passing it
> > > bogus node ids. This is caused by NODE_DATA() returning null
> > > (hopefully) when the requested node is offline. We can
> > > harded against the basic case of a mostly valid node, that
> > > isn't online by checking for null and failing prepare_alloc_pages.
> > > 
> > > But this then suggests we should also harden NODE_DATA() like this
> > > 
> > > #define NODE_DATA(nid)         ( (nid) < MAX_NUMNODES ? node_data[(nid)] : NULL)
> > > 
> > > eventually this starts to add a bunch of generally uneeded checks
> > > in some code paths that are called quite frequently.
> > 
> > But the page allocator is really a hot path and people will not be happy
> > to have yet another branch there. No code should really use invalid numa
> > node ids in the first place.
> > 
> > If I remember those bugs correctly then it was the arch code which was
> > doing something wrong. I would prefer that code to be fixed instead.
> 
> Yes, I think the consensus is that 2/2 should be dropped.
> 
> The arch code is being fixed (both cases) this patch set is just an attempt
> to harden this code path against future failures like that so that we get
> some warnings/ugly messages rather than early boot failures.

Hmm, this is a completely different story. We do have VM_{BUG,WARN}_ON
which are noops for most configurations. It is primarily meant to be
enabled for developers or special debug kernels. If you have an example
when such an early splat in the log would safe a lot of head scratching
then this would sound like a reasonable justification to add
	VM_WARN_ON(!NODE_DATA(nid))
into the page allocator, me thinks. But considering that would should
get NULL ptr splat anyway then I am not really so sure. But maybe we are
in a context where warning would get into the log while a blow up would
just make the whole machine silent...
-- 
Michal Hocko
SUSE Labs
