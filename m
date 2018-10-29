From: willy@infradead.org (Matthew Wilcox)
Date: Sun, 28 Oct 2018 19:30:26 -0700
Subject: [PATCHv2] mm/page_owner: use kvmalloc instead of kmalloc
In-Reply-To: <1540779403-27622-1-git-send-email-miles.chen@mediatek.com>
References: <1540779403-27622-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <20181029023026.GC28520@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 10:16:43AM +0800, miles.chen at mediatek.com wrote:
> The kbuf used by page owner is allocated by kmalloc(), which means it
> can use only normal memory and there might be a "out of memory"
> issue when we're out of normal memory.
> 
> Use kvmalloc() so we can also allocate kbuf from
> normal/hihghmem on 32bit kernel.

That's a misconception:

        ret = kmalloc_node(size, kmalloc_flags, node);

        /*
         * It doesn't really make sense to fallback to vmalloc for sub page
         * requests
         */
        if (ret || size <= PAGE_SIZE)
                return ret;

Now, maybe this is an opportunity for us to improve kvmalloc.  Maybe like
this ...

diff --git a/mm/util.c b/mm/util.c
index 8bf08b5b5760..fdf5b34d2c28 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -416,10 +416,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	ret = kmalloc_node(size, kmalloc_flags, node);
 
 	/*
-	 * It doesn't really make sense to fallback to vmalloc for sub page
-	 * requests
+	 * It only makes sense to fallback to vmalloc for sub page
+	 * requests if we might be able to allocate highmem pages.
 	 */
-	if (ret || size <= PAGE_SIZE)
+	if (ret || (!IS_ENABLED(CONFIG_HIGHMEM) && size <= PAGE_SIZE))
 		return ret;
 
 	return __vmalloc_node_flags_caller(size, node, flags,
