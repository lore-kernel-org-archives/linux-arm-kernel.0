From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 1 Aug 2018 14:50:20 -0700
Subject: [RFC 0/2] harden alloc_pages against bogus nid
In-Reply-To: <20180801200418.1325826-1-jeremy.linton@arm.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
Message-ID: <20180801145020.8c76a490c1bf9bef5f87078a@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  1 Aug 2018 15:04:16 -0500 Jeremy Linton <jeremy.linton@arm.com> wrote:

> The thread "avoid alloc memory on offline node"
> 
> https://lkml.org/lkml/2018/6/7/251
> 
> Asked at one point why the kzalloc_node was crashing rather than
> returning memory from a valid node. The thread ended up fixing
> the immediate causes of the crash but left open the case of bad
> proximity values being in DSDT tables without corrisponding
> SRAT/SLIT entries as is happening on another machine.
> 
> Its also easy to fix that, but we should also harden the allocator
> sufficiently that it doesn't crash when passed an invalid node id.
> There are a couple possible ways to do this, and i've attached two
> separate patches which individually fix that problem.
> 
> The first detects the offline node before calling
> the new_slab code path when it becomes apparent that the allocation isn't
> going to succeed. The second actually hardens node_zonelist() and
> prepare_alloc_pages() in the face of NODE_DATA(nid) returning a NULL
> zonelist. This latter case happens if the node has never been initialized
> or is possibly out of range. There are other places (NODE_DATA &
> online_node) which should be checking if the node id's are > MAX_NUMNODES.
> 

What is it that leads to a caller requesting memory from an invalid
node?  A race against offlining?  If so then that's a lack of
appropriate locking, isn't it?

I don't see a problem with emitting a warning and then selecting a
different node so we can keep running.  But we do want that warning, so
we can understand the root cause and fix it?
