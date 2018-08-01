From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed,  1 Aug 2018 15:04:16 -0500
Subject: [RFC 0/2] harden alloc_pages against bogus nid
Message-ID: <20180801200418.1325826-1-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thread "avoid alloc memory on offline node"

https://lkml.org/lkml/2018/6/7/251

Asked at one point why the kzalloc_node was crashing rather than
returning memory from a valid node. The thread ended up fixing
the immediate causes of the crash but left open the case of bad
proximity values being in DSDT tables without corrisponding
SRAT/SLIT entries as is happening on another machine.

Its also easy to fix that, but we should also harden the allocator
sufficiently that it doesn't crash when passed an invalid node id.
There are a couple possible ways to do this, and i've attached two
separate patches which individually fix that problem.

The first detects the offline node before calling
the new_slab code path when it becomes apparent that the allocation isn't
going to succeed. The second actually hardens node_zonelist() and
prepare_alloc_pages() in the face of NODE_DATA(nid) returning a NULL
zonelist. This latter case happens if the node has never been initialized
or is possibly out of range. There are other places (NODE_DATA &
online_node) which should be checking if the node id's are > MAX_NUMNODES.

Jeremy Linton (2):
  slub: Avoid trying to allocate memory on offline nodes
  mm: harden alloc_pages code paths against bogus nodes

 include/linux/gfp.h | 2 ++
 mm/page_alloc.c     | 2 ++
 mm/slub.c           | 2 ++
 3 files changed, 6 insertions(+)

-- 
2.14.3
