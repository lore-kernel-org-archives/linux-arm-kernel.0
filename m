From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sun, 23 Aug 2009 17:56:12 +0200
Subject: [RFC][PATCH 1/3 v2] ARM: OMAP: DMA: Add support for DMA channel self
	linking on OMAP1510
In-Reply-To: <200908101050.02530.jkrzyszt@tis.icnet.pl>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl>
Message-ID: <200908231756.13016.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement DMA channel self linking on OMAP1510 using AUTO_INIT and REPEAT
flags of the DMA CCR register.

Created against linux-2.6.31-rc5.

Tested on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
I'm sorry, but the original patch appears to have an issue. To be honest, I
started with the one I submit here as v2, got pretty good results, then
modified it in order to better fit into existing framework, and did not test
it well enough after the change.

The problem reveals itself when an application keeps a stream open while
cycling through playing sounds. I don't know if that particular application
may just behave wrong, however, I know that setting AUTO_INIT and REPEAT
flags once after opening a stream and unsetting them once before closing it
gives stable, correct results, while redoing it for every single piece of
sound without closing the stream in between, like the current patch does,
results in inaccurate transfer startups and random application hangups.

I know it's not very fair to change the patch after others that depend on it
have already been applied, but I hope there will be no problems with accepting
the way I have reimplemented it. In any case, I'll appreciate any comments or
suggestions.

--- linux-2.6.31-rc5/arch/arm/plat-omap/dma.c.orig	2009-08-23 02:24:46.000000000 +0200
+++ linux-2.6.31-rc5/arch/arm/plat-omap/dma.c	2009-08-23 14:53:48.000000000 +0200
@@ -1131,6 +1131,11 @@ int omap_dma_running(void)
 void omap_dma_link_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
+		if (lch_head == lch_queue) {
+			dma_write(dma_read(CCR(lch_head)) | (3 << 8),
+								CCR(lch_head));
+			return;
+		}
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
 		BUG();
 		return;
@@ -1153,6 +1158,11 @@ EXPORT_SYMBOL(omap_dma_link_lch);
 void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
+		if (lch_head == lch_queue) {
+			dma_write(dma_read(CCR(lch_head)) & ~(3 << 8),
+								CCR(lch_head));
+			return;
+		}
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
 		BUG();
 		return;
