From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed,  1 Aug 2018 15:04:17 -0500
Subject: [RFC 1/2] slub: Avoid trying to allocate memory on offline nodes
In-Reply-To: <20180801200418.1325826-1-jeremy.linton@arm.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
Message-ID: <20180801200418.1325826-2-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a user calls the *alloc_node() functions with an invalid node
its possible to crash in alloc_pages_nodemask because NODE_DATA()
returns a bad node, which propogates into the node zonelist in
prepare_alloc_pages. This avoids that by not trying to allocate
new slabs against offline nodes.

(example backtrace)

  __alloc_pages_nodemask+0x128/0xf48
  allocate_slab+0x94/0x528
  new_slab+0x68/0xc8
  ___slab_alloc+0x44c/0x520
  __slab_alloc+0x50/0x68
  kmem_cache_alloc_node_trace+0xe0/0x230

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 51258eff4178..e03719bac1e2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2519,6 +2519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		if (unlikely(!node_match(page, searchnode))) {
 			stat(s, ALLOC_NODE_MISMATCH);
 			deactivate_slab(s, page, c->freelist, c);
+			if (!node_online(searchnode))
+				node = NUMA_NO_NODE;
 			goto new_slab;
 		}
 	}
-- 
2.14.3
