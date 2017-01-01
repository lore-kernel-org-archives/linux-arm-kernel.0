From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sun,  1 Jan 2017 16:13:37 +0530
Subject: [PATCH v2] drivers: remoteproc: constify rproc_ops structures
Message-ID: <1483267417-7850-1-git-send-email-bhumirks@gmail.com>
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

File size details:

Size of the file remoteproc/da8xx_remoteproc.o remains the same before and
after applying the changes.

   text	   data	    bss	    dec	    hex	filename
   1312	    100	      4	   1416	    588 remoteproc/da8xx_remoteproc.o
   1312	    100	      4	   1416	    588 remoteproc/da8xx_remoteproc.o

    970	    240	      0	   1210	    4ba remoteproc/omap_remoteproc.o
   1002	    192	      0	   1194	    4aa remoteproc/omap_remoteproc.o

   1901	    240	      0	   2141	    85d remoteproc/st_remoteproc.o
   1933	    192	      0	   2125	    84d remoteproc/st_remoteproc.o

   1288	     96	      0	   1384	    568 remoteproc/st_slim_rproc.o
   1320	     64	      0	   1384	    568 remoteproc/st_slim_rproc.o

   2121	    240	      0	   2361	    939 remoteproc/wkup_m3_rproc.o
   2161	    192	      0	   2353	    931 remoteproc/wkup_m3_rproc.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
Changes in v2:
 * Apply the changes to the file da8xx_remoteproc.c as well.

 drivers/remoteproc/da8xx_remoteproc.c | 2 +-
 drivers/remoteproc/omap_remoteproc.c  | 2 +-
 drivers/remoteproc/st_remoteproc.c    | 2 +-
 drivers/remoteproc/st_slim_rproc.c    | 2 +-
 drivers/remoteproc/wkup_m3_rproc.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 1afac8f..3814de2 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -151,7 +151,7 @@ static void da8xx_rproc_kick(struct rproc *rproc, int vqid)
 	writel(SYSCFG_CHIPSIG2, drproc->chipsig);
 }
 
-static struct rproc_ops da8xx_rproc_ops = {
+static const struct rproc_ops da8xx_rproc_ops = {
 	.start = da8xx_rproc_start,
 	.stop = da8xx_rproc_stop,
 	.kick = da8xx_rproc_kick,
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
