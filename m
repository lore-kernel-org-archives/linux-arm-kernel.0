From: julia@diku.dk (Julia Lawall)
Date: Sun, 27 Dec 2009 23:25:52 +0100 (CET)
Subject: [PATCH 1/5] arch/arm: Correct NULL test
In-Reply-To: <20091227215106.GA18317@pengutronix.de>
References: <Pine.LNX.4.64.0912272226360.20548@ask.diku.dk>
	<20091227215106.GA18317@pengutronix.de>
Message-ID: <Pine.LNX.4.64.0912272325130.22240@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <julia@diku.dk>

Test the just-allocated value for NULL rather than some other value.
Adjust the size of the allocated array as well, according to the location
storing the result.

The semantic patch that makes the first change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,y;
statement S;
@@

x = \(kmalloc\|kcalloc\|kzalloc\)(...);
(
if ((x) == NULL) S
|
if (
-   y
+   x
       == NULL)
 S
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/arm/plat-pxa/dma.c             |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
index 2975798..fb28dc9 100644
--- a/arch/arm/plat-pxa/dma.c
+++ b/arch/arm/plat-pxa/dma.c
@@ -242,9 +242,9 @@ static void pxa_dma_init_debugfs(void)
 	if (!dbgfs_state)
 		goto err_state;
 
-	dbgfs_chan = kmalloc(sizeof(*dbgfs_state) * num_dma_channels,
+	dbgfs_chan = kmalloc(sizeof(*dbgfs_chan) * num_dma_channels,
 			     GFP_KERNEL);
-	if (!dbgfs_state)
+	if (!dbgfs_chan)
 		goto err_alloc;
 
 	chandir = debugfs_create_dir("channels", dbgfs_root);
