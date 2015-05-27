From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 27 May 2015 23:23:40 +0200
Subject: [PATCH] fixup! dmaengine: pxa_dma: add debug information
Message-ID: <1432761820-32072-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following error:
drivers/dma/pxa_dma.c: In function ?dbg_show_requester_chan?:
drivers/dma/pxa_dma.c:192:2: error: void value not ignored as it ought to be
  pos += seq_printf(s, "DMA channel %d requester :\n", phy->idx);
  ^
drivers/dma/pxa_dma.c:197:8: error: void value not ignored as it ought to be
        !!(drcmr & DRCMR_MAPVLD));
        ^
scripts/Makefile.build:258: recipe for target 'drivers/dma/pxa_dma.o' failed

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index ddcbbf5..be5b524 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -184,19 +184,18 @@ static unsigned int pxad_drcmr(unsigned int line)
 
 static int dbg_show_requester_chan(struct seq_file *s, void *p)
 {
-	int pos = 0;
 	struct pxad_phy *phy = s->private;
 	int i;
 	u32 drcmr;
 
-	pos += seq_printf(s, "DMA channel %d requester :\n", phy->idx);
+	seq_printf(s, "DMA channel %d requester :\n", phy->idx);
 	for (i = 0; i < 70; i++) {
 		drcmr = readl_relaxed(phy->base + pxad_drcmr(i));
 		if ((drcmr & DRCMR_CHLNUM) == phy->idx)
-			pos += seq_printf(s, "\tRequester %d (MAPVLD=%d)\n", i,
-					  !!(drcmr & DRCMR_MAPVLD));
+			seq_printf(s, "\tRequester %d (MAPVLD=%d)\n", i,
+				   !!(drcmr & DRCMR_MAPVLD));
 	}
-	return pos;
+	return 0;
 }
 
 static inline int dbg_burst_from_dcmd(u32 dcmd)
-- 
2.1.4
