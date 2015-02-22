From: joe@perches.com (Joe Perches)
Date: Sat, 21 Feb 2015 18:53:40 -0800
Subject: [PATCH 13/27] ARM: plat-pxa: Remove use of seq_printf return value
In-Reply-To: <cover.1424573328.git.joe@perches.com>
References: <cover.1424573328.git.joe@perches.com>
Message-ID: <64ba440c9011e931b46faf8e119dd4f2be7abfe8.1424573328.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The seq_printf return value, because it's frequently misused,
(as it is here, it doesn't return # of chars emitted) will
eventually be converted to void.

See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
     seq_has_overflowed() and make public")

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/plat-pxa/dma.c | 111 +++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 58 deletions(-)

diff --git a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
index 054fc5a..d92f07f 100644
--- a/arch/arm/plat-pxa/dma.c
+++ b/arch/arm/plat-pxa/dma.c
@@ -51,19 +51,19 @@ static struct dentry *dbgfs_root, *dbgfs_state, **dbgfs_chan;
 
 static int dbg_show_requester_chan(struct seq_file *s, void *p)
 {
-	int pos = 0;
 	int chan = (int)s->private;
 	int i;
 	u32 drcmr;
 
-	pos += seq_printf(s, "DMA channel %d requesters list :\n", chan);
+	seq_printf(s, "DMA channel %d requesters list :\n", chan);
 	for (i = 0; i < DMA_MAX_REQUESTERS; i++) {
 		drcmr = DRCMR(i);
 		if ((drcmr & DRCMR_CHLNUM) == chan)
-			pos += seq_printf(s, "\tRequester %d (MAPVLD=%d)\n", i,
-					  !!(drcmr & DRCMR_MAPVLD));
+			seq_printf(s, "\tRequester %d (MAPVLD=%d)\n",
+				   i, !!(drcmr & DRCMR_MAPVLD));
 	}
-	return pos;
+
+	return 0;
 }
 
 static inline int dbg_burst_from_dcmd(u32 dcmd)
@@ -83,7 +83,6 @@ static int is_phys_valid(unsigned long addr)
 
 static int dbg_show_descriptors(struct seq_file *s, void *p)
 {
-	int pos = 0;
 	int chan = (int)s->private;
 	int i, max_show = 20, burst, width;
 	u32 dcmd;
@@ -94,44 +93,43 @@ static int dbg_show_descriptors(struct seq_file *s, void *p)
 	spin_lock_irqsave(&dma_channels[chan].lock, flags);
 	phys_desc = DDADR(chan);
 
-	pos += seq_printf(s, "DMA channel %d descriptors :\n", chan);
-	pos += seq_printf(s, "[%03d] First descriptor unknown\n", 0);
+	seq_printf(s, "DMA channel %d descriptors :\n", chan);
+	seq_printf(s, "[%03d] First descriptor unknown\n", 0);
 	for (i = 1; i < max_show && is_phys_valid(phys_desc); i++) {
 		desc = phys_to_virt(phys_desc);
 		dcmd = desc->dcmd;
 		burst = dbg_burst_from_dcmd(dcmd);
 		width = (1 << ((dcmd >> 14) & 0x3)) >> 1;
 
-		pos += seq_printf(s, "[%03d] Desc at %08lx(virt %p)\n",
-				  i, phys_desc, desc);
-		pos += seq_printf(s, "\tDDADR = %08x\n", desc->ddadr);
-		pos += seq_printf(s, "\tDSADR = %08x\n", desc->dsadr);
-		pos += seq_printf(s, "\tDTADR = %08x\n", desc->dtadr);
-		pos += seq_printf(s, "\tDCMD  = %08x (%s%s%s%s%s%s%sburst=%d"
-				  " width=%d len=%d)\n",
-				  dcmd,
-				  DCMD_STR(INCSRCADDR), DCMD_STR(INCTRGADDR),
-				  DCMD_STR(FLOWSRC), DCMD_STR(FLOWTRG),
-				  DCMD_STR(STARTIRQEN), DCMD_STR(ENDIRQEN),
-				  DCMD_STR(ENDIAN), burst, width,
-				  dcmd & DCMD_LENGTH);
+		seq_printf(s, "[%03d] Desc at %08lx(virt %p)\n",
+			   i, phys_desc, desc);
+		seq_printf(s, "\tDDADR = %08x\n", desc->ddadr);
+		seq_printf(s, "\tDSADR = %08x\n", desc->dsadr);
+		seq_printf(s, "\tDTADR = %08x\n", desc->dtadr);
+		seq_printf(s, "\tDCMD  = %08x (%s%s%s%s%s%s%sburst=%d width=%d len=%d)\n",
+			   dcmd,
+			   DCMD_STR(INCSRCADDR), DCMD_STR(INCTRGADDR),
+			   DCMD_STR(FLOWSRC), DCMD_STR(FLOWTRG),
+			   DCMD_STR(STARTIRQEN), DCMD_STR(ENDIRQEN),
+			   DCMD_STR(ENDIAN), burst, width,
+			   dcmd & DCMD_LENGTH);
 		phys_desc = desc->ddadr;
 	}
 	if (i == max_show)
-		pos += seq_printf(s, "[%03d] Desc at %08lx ... max display reached\n",
-				  i, phys_desc);
+		seq_printf(s, "[%03d] Desc at %08lx ... max display reached\n",
+			   i, phys_desc);
 	else
-		pos += seq_printf(s, "[%03d] Desc at %08lx is %s\n",
-				  i, phys_desc, phys_desc == DDADR_STOP ?
-				  "DDADR_STOP" : "invalid");
+		seq_printf(s, "[%03d] Desc at %08lx is %s\n",
+			   i, phys_desc, phys_desc == DDADR_STOP ?
+			   "DDADR_STOP" : "invalid");
 
 	spin_unlock_irqrestore(&dma_channels[chan].lock, flags);
-	return pos;
+
+	return 0;
 }
 
 static int dbg_show_chan_state(struct seq_file *s, void *p)
 {
-	int pos = 0;
 	int chan = (int)s->private;
 	u32 dcsr, dcmd;
 	int burst, width;
@@ -142,42 +140,39 @@ static int dbg_show_chan_state(struct seq_file *s, void *p)
 	burst = dbg_burst_from_dcmd(dcmd);
 	width = (1 << ((dcmd >> 14) & 0x3)) >> 1;
 
-	pos += seq_printf(s, "DMA channel %d\n", chan);
-	pos += seq_printf(s, "\tPriority : %s\n",
-			  str_prio[dma_channels[chan].prio]);
-	pos += seq_printf(s, "\tUnaligned transfer bit: %s\n",
-			  DALGN & (1 << chan) ? "yes" : "no");
-	pos += seq_printf(s, "\tDCSR  = %08x (%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s)\n",
-			  dcsr, DCSR_STR(RUN), DCSR_STR(NODESC),
-			  DCSR_STR(STOPIRQEN), DCSR_STR(EORIRQEN),
-			  DCSR_STR(EORJMPEN), DCSR_STR(EORSTOPEN),
-			  DCSR_STR(SETCMPST), DCSR_STR(CLRCMPST),
-			  DCSR_STR(CMPST), DCSR_STR(EORINTR), DCSR_STR(REQPEND),
-			  DCSR_STR(STOPSTATE), DCSR_STR(ENDINTR),
-			  DCSR_STR(STARTINTR), DCSR_STR(BUSERR));
-
-	pos += seq_printf(s, "\tDCMD  = %08x (%s%s%s%s%s%s%sburst=%d width=%d"
-			  " len=%d)\n",
-			  dcmd,
-			  DCMD_STR(INCSRCADDR), DCMD_STR(INCTRGADDR),
-			  DCMD_STR(FLOWSRC), DCMD_STR(FLOWTRG),
-			  DCMD_STR(STARTIRQEN), DCMD_STR(ENDIRQEN),
-			  DCMD_STR(ENDIAN), burst, width, dcmd & DCMD_LENGTH);
-	pos += seq_printf(s, "\tDSADR = %08x\n", DSADR(chan));
-	pos += seq_printf(s, "\tDTADR = %08x\n", DTADR(chan));
-	pos += seq_printf(s, "\tDDADR = %08x\n", DDADR(chan));
-	return pos;
+	seq_printf(s, "DMA channel %d\n", chan);
+	seq_printf(s, "\tPriority : %s\n", str_prio[dma_channels[chan].prio]);
+	seq_printf(s, "\tUnaligned transfer bit: %s\n",
+		   DALGN & (1 << chan) ? "yes" : "no");
+	seq_printf(s, "\tDCSR  = %08x (%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s)\n",
+		   dcsr, DCSR_STR(RUN), DCSR_STR(NODESC),
+		   DCSR_STR(STOPIRQEN), DCSR_STR(EORIRQEN),
+		   DCSR_STR(EORJMPEN), DCSR_STR(EORSTOPEN),
+		   DCSR_STR(SETCMPST), DCSR_STR(CLRCMPST),
+		   DCSR_STR(CMPST), DCSR_STR(EORINTR), DCSR_STR(REQPEND),
+		   DCSR_STR(STOPSTATE), DCSR_STR(ENDINTR),
+		   DCSR_STR(STARTINTR), DCSR_STR(BUSERR));
+
+	seq_printf(s, "\tDCMD  = %08x (%s%s%s%s%s%s%sburst=%d width=%d len=%d)\n",
+		   dcmd,
+		   DCMD_STR(INCSRCADDR), DCMD_STR(INCTRGADDR),
+		   DCMD_STR(FLOWSRC), DCMD_STR(FLOWTRG),
+		   DCMD_STR(STARTIRQEN), DCMD_STR(ENDIRQEN),
+		   DCMD_STR(ENDIAN), burst, width, dcmd & DCMD_LENGTH);
+	seq_printf(s, "\tDSADR = %08x\n", DSADR(chan));
+	seq_printf(s, "\tDTADR = %08x\n", DTADR(chan));
+	seq_printf(s, "\tDDADR = %08x\n", DDADR(chan));
+
+	return 0;
 }
 
 static int dbg_show_state(struct seq_file *s, void *p)
 {
-	int pos = 0;
-
 	/* basic device status */
-	pos += seq_printf(s, "DMA engine status\n");
-	pos += seq_printf(s, "\tChannel number: %d\n", num_dma_channels);
+	seq_puts(s, "DMA engine status\n");
+	seq_printf(s, "\tChannel number: %d\n", num_dma_channels);
 
-	return pos;
+	return 0;
 }
 
 #define DBGFS_FUNC_DECL(name) \
-- 
2.1.2
