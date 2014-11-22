From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Nov 2014 15:39:19 +0100
Subject: [PATCH 6/6] dmaengine: ste_dma40: fix error return code
In-Reply-To: <1416667159-9808-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1416667159-9808-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1416667159-9808-7-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Return a negative error code on failure.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret; expression e1,e2;
@@
(
if (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/dma/ste_dma40.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 7de218c..c62d26b 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3432,6 +3432,7 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 
 			d40_err(base->dev, "Failed to allocate %d pages.\n",
 				base->lcla_pool.pages);
+			ret = -ENOMEM;
 
 			for (j = 0; j < i; j++)
 				free_pages(page_list[j], base->lcla_pool.pages);
