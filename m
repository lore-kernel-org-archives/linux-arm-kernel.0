From: sasha.levin@oracle.com (Sasha Levin)
Date: Thu,  8 Nov 2012 15:23:10 -0500
Subject: [PATCH] ARM: dma: use BUG_ON where possible
In-Reply-To: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
References: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
Message-ID: <1352406191-14303-8-git-send-email-sasha.levin@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just use BUG_ON() instead of constructions such as:

	if (...)
		BUG()

A simplified version of the semantic patch that makes this transformation
is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@
- if (e) BUG();
+ BUG_ON(e);
// </smpl>

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/arm/mach-rpc/dma.c     |    3 +--
 arch/arm/mach-s3c64xx/dma.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
index 85883b2..92e22ba 100644
--- a/arch/arm/mach-rpc/dma.c
+++ b/arch/arm/mach-rpc/dma.c
@@ -265,8 +265,7 @@ static void floppy_enable_dma(unsigned int chan, dma_t *dma)
 	unsigned int fiqhandler_length;
 	struct pt_regs regs;
 
-	if (fdma->dma.sg)
-		BUG();
+	BUG_ON(fdma->dma.sg);
 
 	if (fdma->dma.dma_mode == DMA_MODE_READ) {
 		extern unsigned char floppy_fiqin_start, floppy_fiqin_end;
diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index f2a7a17..585c2ae 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -603,8 +603,7 @@ static irqreturn_t s3c64xx_dma_irq(int irq, void *pw)
 				&& buff->next != chan->next)
 			buff = buff->next;
 
-		if (!buff)
-			BUG();
+		BUG_ON(!buff);
 
 		if (buff == chan->next)
 			buff = chan->end;
-- 
1.7.10.4
