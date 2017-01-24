From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 25 Jan 2017 00:52:22 +0530
Subject: [PATCH] usb: musb: constify musb_hdrc_config structures
Message-ID: <1485285742-6949-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare musb_hdrc_config structures as const as they are only stored in
the config field of a musb_hdrc_platform_data structure. This field is of
type const, so musb_hdrc_config structures having this property can be
made const too.
Done using Coccinelle:

@r disable optional_qualifier@
identifier x;
position p;
@@
static struct musb_hdrc_config x at p={...};

@ok@
struct musb_hdrc_platform_data pdata;
identifier r.x;
position p;
@@
pdata.config=&x at p;

@bad@
position p != {r.p,ok.p};
identifier r.x;
@@
x at p

@depends on !bad disable optional_qualifier@
identifier r.x;
@@
+const
struct musb_hdrc_config x;

File size before:
   text	   data	    bss	    dec	    hex	filename
   1212	    338	      0	   1550	    60e	drivers/usb/musb/jz4740.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   1268	    290	      0	   1558	    616	drivers/usb/musb/jz4740.o

File size before:
   text	   data	    bss	    dec	    hex	filename
   6151	    333	     16	   6500	   1964	drivers/usb/musb/sunxi.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   6215	    269	     16	   6500	   1964	drivers/usb/musb/sunxi.o

File size before:
   text	   data	    bss	    dec	    hex	filename
   3668	    864	      0	   4532	   11b4	drivers/usb/musb/ux500.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   3724	    808	      0	   4532	   11b4	drivers/usb/musb/ux500.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/usb/musb/jz4740.c | 2 +-
 drivers/usb/musb/sunxi.c  | 2 +-
 drivers/usb/musb/ux500.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index bc88899..40c68c2 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -63,7 +63,7 @@ static struct musb_fifo_cfg jz4740_musb_fifo_cfg[] = {
 { .hw_ep_num = 2, .style = FIFO_TX, .maxpacket = 64, },
 };
 
-static struct musb_hdrc_config jz4740_musb_config = {
+static const struct musb_hdrc_config jz4740_musb_config = {
 	/* Silicon does not implement USB OTG. */
 	.multipoint = 0,
 	/* Max EPs scanned, driver will decide which EP can be used. */
diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index d0be0ea..64545de 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -645,7 +645,7 @@ static struct musb_fifo_cfg sunxi_musb_mode_cfg[] = {
 	MUSB_EP_FIFO_SINGLE(5, FIFO_RX, 512),
 };
 
-static struct musb_hdrc_config sunxi_musb_hdrc_config = {
+static const struct musb_hdrc_config sunxi_musb_hdrc_config = {
 	.fifo_cfg       = sunxi_musb_mode_cfg,
 	.fifo_cfg_size  = ARRAY_SIZE(sunxi_musb_mode_cfg),
 	.multipoint	= true,
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index 3eaa4ba..5a57250 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -30,7 +30,7 @@
 
 #include "musb_core.h"
 
-static struct musb_hdrc_config ux500_musb_hdrc_config = {
+static const struct musb_hdrc_config ux500_musb_hdrc_config = {
 	.multipoint	= true,
 	.dyn_fifo	= true,
 	.num_eps	= 16,
-- 
2.7.4
