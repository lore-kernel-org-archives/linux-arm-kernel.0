From: julia@diku.dk (Julia Lawall)
Date: Sat, 6 Feb 2010 09:42:00 +0100 (CET)
Subject: [PATCH 1/11] arch/arm/plat-pxa: Correct NULL test
Message-ID: <Pine.LNX.4.64.1002060941410.8092@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <julia@diku.dk>

Test the value that was just allocated rather than the previously tested one.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r@
expression *x;
expression e;
identifier l;
@@

if (x == NULL || ...) {
    ... when forall
    return ...; }
... when != goto l;
    when != x = e
    when != &x
*x == NULL
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/arm/plat-pxa/dma.c             |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
index 2975798..bcfda50 100644
--- a/arch/arm/plat-pxa/dma.c
+++ b/arch/arm/plat-pxa/dma.c
@@ -244,7 +244,7 @@ static void pxa_dma_init_debugfs(void)
 
 	dbgfs_chan = kmalloc(sizeof(*dbgfs_state) * num_dma_channels,
 			     GFP_KERNEL);
-	if (!dbgfs_state)
+	if (!dbgfs_chan)
 		goto err_alloc;
 
 	chandir = debugfs_create_dir("channels", dbgfs_root);
