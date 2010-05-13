From: julia@diku.dk (Julia Lawall)
Date: Thu, 13 May 2010 21:59:32 +0200 (CEST)
Subject: [PATCH 4/20] arch/arm/mach-davinci: Use kzalloc
Message-ID: <Pine.LNX.4.64.1005132159170.6282@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <julia@diku.dk>

Use kzalloc rather than the combination of kmalloc and memset.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,size,flags;
statement S;
@@

-x = kmalloc(size,flags);
+x = kzalloc(size,flags);
 if (x == NULL) S
-memset(x, 0, size);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/arm/mach-davinci/dma.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -u -p a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -1419,12 +1419,11 @@ static int __init edma_probe(struct plat
 			goto fail1;
 		}
 
-		edma_cc[j] = kmalloc(sizeof(struct edma), GFP_KERNEL);
+		edma_cc[j] = kzalloc(sizeof(struct edma), GFP_KERNEL);
 		if (!edma_cc[j]) {
 			status = -ENOMEM;
 			goto fail1;
 		}
-		memset(edma_cc[j], 0, sizeof(struct edma));
 
 		edma_cc[j]->num_channels = min_t(unsigned, info[j].n_channel,
 							EDMA_MAX_DMACH);
