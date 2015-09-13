From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun, 13 Sep 2015 17:15:53 -0300
Subject: [PATCH] dmaengine: sun4i: fix unsafe list iteration
Message-ID: <1442175353-4433-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, sun4i_dma_free_contract iterates over lists and frees memory
as it goes through them, causing reads to recently freed memory to
be performed. Fix this by using the safe version of the iterator, so
freed memory is not referenced at all.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
Hi,

This is a patch to fix an issue pointed out by Dan on

http://www.spinics.net/lists/dmaengine/msg05822.html

I didn't get a chance to test a system with this, but it looks trivial
enough and it builds. This should go in the -rc cycle, and there's no
need for stable as the driver just landed this merge window.

Cheers,
Emilio

 drivers/dma/sun4i-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index a1a500d..1661d518 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -599,13 +599,13 @@ get_next_cyclic_promise(struct sun4i_dma_contract *contract)
 static void sun4i_dma_free_contract(struct virt_dma_desc *vd)
 {
 	struct sun4i_dma_contract *contract = to_sun4i_dma_contract(vd);
-	struct sun4i_dma_promise *promise;
+	struct sun4i_dma_promise *promise, *tmp;
 
 	/* Free all the demands and completed demands */
-	list_for_each_entry(promise, &contract->demands, list)
+	list_for_each_entry_safe(promise, tmp, &contract->demands, list)
 		kfree(promise);
 
-	list_for_each_entry(promise, &contract->completed_demands, list)
+	list_for_each_entry_safe(promise, tmp, &contract->completed_demands, list)
 		kfree(promise);
 
 	kfree(contract);
-- 
2.5.1
