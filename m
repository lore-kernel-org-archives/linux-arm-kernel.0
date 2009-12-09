From: julia@diku.dk (Julia Lawall)
Date: Wed, 9 Dec 2009 20:22:26 +0100 (CET)
Subject: [PATCH 1/12] arch/arm: Correct size given to memset
Message-ID: <Pine.LNX.4.64.0912092022040.1870@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <julia@diku.dk>

Memset should be given the size of the structure, not the size of the pointer.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
type T;
T *x;
expression E;
@@

memset(x, E, sizeof(
+ *
 x))
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/arm/plat-mxc/dma-mx1-mx2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/arch/arm/plat-mxc/dma-mx1-mx2.c b/arch/arm/plat-mxc/dma-mx1-mx2.c
--- a/arch/arm/plat-mxc/dma-mx1-mx2.c
+++ b/arch/arm/plat-mxc/dma-mx1-mx2.c
@@ -694,7 +694,7 @@ int imx_dma_request(int channel, const c
 		local_irq_restore(flags);
 		return -EBUSY;
 	}
-	memset(imxdma, 0, sizeof(imxdma));
+	memset(imxdma, 0, sizeof(*imxdma));
 	imxdma->name = name;
 	local_irq_restore(flags); /* request_irq() can block */
 
