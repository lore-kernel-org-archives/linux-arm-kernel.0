From: thomas@m3y3r.de (Thomas Meyer)
Date: Sat, 06 Aug 2011 13:26:13 +0200
Subject: [PATCH] arm: mach-davinci: use kzalloc()
Message-ID: <1312629976.5589.128.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Meyer <thomas@m3y3r.de>

 Use kzalloc rather than kmalloc followed by memset with 0

 This considers some simple cases that are common and easy to validate
 Note in particular that there are no ...s in the rule, so all of the
 matched code has to be contiguous

 The semantic patch that makes this output is available
 in scripts/coccinelle/api/alloc/kzalloc-simple.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
--- a/arch/arm/mach-davinci/dma.c 2010-10-26 18:50:12.713889353 +0200
+++ b/arch/arm/mach-davinci/dma.c 2011-08-01 20:40:38.326583216 +0200
@@ -1435,12 +1435,11 @@ static int __init edma_probe(struct plat
 			goto fail1;
 		}
 
-		edma_cc[j] = kmalloc(sizeof(struct edma), GFP_KERNEL);
+		edma_cc[j] = kzalloc(sizeof(struct edma), GFP_KERNEL);
 		if (!edma_cc[j]) {
 			status = -ENOMEM;
 			goto fail1;
 		}
-		memset(edma_cc[j], 0, sizeof(struct edma));
 
 		edma_cc[j]->num_channels = min_t(unsigned, info[j]->n_channel,
 							EDMA_MAX_DMACH);
