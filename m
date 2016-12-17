From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 17 Dec 2016 16:59:36 +0530
Subject: [PATCH] drivers: remoteproc: constify rproc_ops structures
Message-ID: <1481974176-19912-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare rproc_ops structures as const as they are only passed as an
argument to the function rproc_alloc. This argument is of type const, so
rproc_ops structures having this property can be declared const too.
Done using Coccinelle:

@r1 disable optional_qualifier @
identifier i;
position p;
@@
static struct rproc_ops i at p = {...};

@ok1@
identifier r1.i;
position p;
@@
rproc_alloc(...,&i at p,...)

@bad@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i at p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct rproc_ops i;

File sizes before:
   text	   data	    bss	    dec	    hex	filename
   1258	    416	      0	   1674	    68a remoteproc/omap_remoteproc.o
   2402	    240	      0	   2642	    a52 remoteproc/st_remoteproc.o
   2064	    272	      0	   2336	    920 remoteproc/st_slim_rproc.o
   2160	    240	      0	   2400	    960 remoteproc/wkup_m3_rproc.o

File sizes after:
   text	   data	    bss	    dec	    hex	filename
   1297	    368	      0	   1665	    681 remoteproc/omap_remoteproc.o
   2434	    192	      0	   2626	    a42 remoteproc/st_remoteproc.o
   2112	    240	      0	   2352	    930 remoteproc/st_slim_rproc.o
   2200	    192	      0	   2392	    958 remoteproc/wkup_m3_rproc.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/remoteproc/omap_remoteproc.c | 2 +-
 drivers/remoteproc/st_remoteproc.c   | 2 +-
 drivers/remoteproc/st_slim_rproc.c   | 2 +-
 drivers/remoteproc/wkup_m3_rproc.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index fa63bf2..a96ce90 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -177,7 +177,7 @@ static int omap_rproc_stop(struct rproc *rproc)
 	return 0;
 }
 
-static struct rproc_ops omap_rproc_ops = {
+static const struct rproc_ops omap_rproc_ops = {
 	.start		= omap_rproc_start,
 	.stop		= omap_rproc_stop,
 	.kick		= omap_rproc_kick,
diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index da4e152..f21787b 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -107,7 +107,7 @@ static int st_rproc_stop(struct rproc *rproc)
 	return sw_err ?: pwr_err;
 }
 
-static struct rproc_ops st_rproc_ops = {
+static const struct rproc_ops st_rproc_ops = {
 	.start		= st_rproc_start,
 	.stop		= st_rproc_stop,
 };
diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
index 507716c..6cfd862 100644
--- a/drivers/remoteproc/st_slim_rproc.c
+++ b/drivers/remoteproc/st_slim_rproc.c
@@ -200,7 +200,7 @@ static void *slim_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 	return va;
 }
 
-static struct rproc_ops slim_rproc_ops = {
+static const struct rproc_ops slim_rproc_ops = {
 	.start		= slim_rproc_start,
 	.stop		= slim_rproc_stop,
 	.da_to_va       = slim_rproc_da_to_va,
diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
index 18175d0..1ada0e5 100644
--- a/drivers/remoteproc/wkup_m3_rproc.c
+++ b/drivers/remoteproc/wkup_m3_rproc.c
@@ -111,7 +111,7 @@ static void *wkup_m3_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 	return va;
 }
 
-static struct rproc_ops wkup_m3_rproc_ops = {
+static const struct rproc_ops wkup_m3_rproc_ops = {
 	.start		= wkup_m3_rproc_start,
 	.stop		= wkup_m3_rproc_stop,
 	.da_to_va	= wkup_m3_rproc_da_to_va,
-- 
1.9.1
