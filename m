From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu, 12 Jan 2012 22:49:28 +0100
Subject: [PATCH v2 2/5] drivers/media/video/s5p-fimc/fimc-capture.c: adjust
 double test
In-Reply-To: <1326404970-1084-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1326404970-1084-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1326404970-1084-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Rewrite a duplicated test to test the correct value

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression E;
@@

(
* E
  || ... || E
|
* E
  && ... && E
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
There is a height field, so it is my guess that that should be tested
instead of testing the width field again.

 drivers/media/video/s5p-fimc/fimc-capture.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/video/s5p-fimc/fimc-capture.c b/drivers/media/video/s5p-fimc/fimc-capture.c
index 2cc3b91..13dd598 100644
--- a/drivers/media/video/s5p-fimc/fimc-capture.c
+++ b/drivers/media/video/s5p-fimc/fimc-capture.c
@@ -689,7 +689,7 @@ static int fimc_pipeline_try_format(struct fimc_ctx *ctx,
 			mf->code = 0;
 			continue;
 		}
-		if (mf->width != tfmt->width || mf->width != tfmt->width) {
+		if (mf->width != tfmt->width || mf->height != tfmt->height) {
 			u32 fcc = ffmt->fourcc;
 			tfmt->width  = mf->width;
 			tfmt->height = mf->height;
@@ -698,7 +698,8 @@ static int fimc_pipeline_try_format(struct fimc_ctx *ctx,
 					       NULL, &fcc, FIMC_SD_PAD_SOURCE);
 			if (ffmt && ffmt->mbus_code)
 				mf->code = ffmt->mbus_code;
-			if (mf->width != tfmt->width || mf->width != tfmt->width)
+			if (mf->width != tfmt->width ||
+			    mf->height != tfmt->height)
 				continue;
 			tfmt->code = mf->code;
 		}
@@ -706,7 +707,7 @@ static int fimc_pipeline_try_format(struct fimc_ctx *ctx,
 			ret = v4l2_subdev_call(csis, pad, set_fmt, NULL, &sfmt);
 
 		if (mf->code == tfmt->code &&
-		    mf->width == tfmt->width && mf->width == tfmt->width)
+		    mf->width == tfmt->width && mf->height == tfmt->height)
 			break;
 	}
 
