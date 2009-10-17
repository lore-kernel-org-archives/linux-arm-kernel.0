From: julia@diku.dk (Julia Lawall)
Date: Sat, 17 Oct 2009 08:42:49 +0200 (CEST)
Subject: [PATCH 13/14] arch/arm/plat-s3c24xx: Move dereference after NULL test
Message-ID: <Pine.LNX.4.64.0910170842310.9213@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <julia@diku.dk>

If the NULL test on buf is needed, then the dereference should be after the
NULL test.

A simplified version of the semantic match that detects this problem is as
follows (http://coccinelle.lip6.fr/):

// <smpl>
@match exists@
expression x, E;
identifier fld;
@@

* x->fld
  ... when != \(x = E\|&x\)
* x == NULL
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/arm/plat-s3c24xx/dma.c         |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index 196b191..f046f8c 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -208,14 +208,14 @@ s3c2410_dma_loadbuffer(struct s3c2410_dma_chan *chan,
 {
 	unsigned long reload;
 
-	pr_debug("s3c2410_chan_loadbuffer: loading buff %p (0x%08lx,0x%06x)\n",
-		 buf, (unsigned long)buf->data, buf->size);
-
 	if (buf == NULL) {
 		dmawarn("buffer is NULL\n");
 		return -EINVAL;
 	}
 
+	pr_debug("s3c2410_chan_loadbuffer: loading buff %p (0x%08lx,0x%06x)\n",
+		 buf, (unsigned long)buf->data, buf->size);
+
 	/* check the state of the channel before we do anything */
 
 	if (chan->load_state == S3C2410_DMALOAD_1LOADED) {
