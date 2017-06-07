From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed,  7 Jun 2017 11:34:12 -0700
Subject: [PATCH v8 33/34] media: imx: Drop warning upon multiple S_STREAM
 disable calls
In-Reply-To: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1496860453-6282-34-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marex@denx.de>

Calling S_STREAM OFF multiple times on a video device is valid, although
dubious, practice. Instead of warning about it and setting stream count
lower than zero, just ignore the subsequent S_STREAM calls and correct
the stream count to zero.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 drivers/staging/media/imx/imx-ic-prp.c      | 3 ++-
 drivers/staging/media/imx/imx-ic-prpencvf.c | 3 ++-
 drivers/staging/media/imx/imx-media-csi.c   | 3 ++-
 drivers/staging/media/imx/imx-media-vdic.c  | 3 ++-
 drivers/staging/media/imx/imx6-mipi-csi2.c  | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prp.c b/drivers/staging/media/imx/imx-ic-prp.c
index 783a515..c2bb5ef 100644
--- a/drivers/staging/media/imx/imx-ic-prp.c
+++ b/drivers/staging/media/imx/imx-ic-prp.c
@@ -391,7 +391,8 @@ static int prp_s_stream(struct v4l2_subdev *sd, int enable)
 
 update_count:
 	priv->stream_count += enable ? 1 : -1;
-	WARN_ON(priv->stream_count < 0);
+	if (priv->stream_count < 0)
+		priv->stream_count = 0;
 out:
 	mutex_unlock(&priv->lock);
 	return ret;
diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 5e9c817..ed363fe 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -1140,7 +1140,8 @@ static int prp_s_stream(struct v4l2_subdev *sd, int enable)
 
 update_count:
 	priv->stream_count += enable ? 1 : -1;
-	WARN_ON(priv->stream_count < 0);
+	if (priv->stream_count < 0)
+		priv->stream_count = 0;
 out:
 	mutex_unlock(&priv->lock);
 	return ret;
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index c6e8d2c..c306146 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -863,7 +863,8 @@ static int csi_s_stream(struct v4l2_subdev *sd, int enable)
 
 update_count:
 	priv->stream_count += enable ? 1 : -1;
-	WARN_ON(priv->stream_count < 0);
+	if (priv->stream_count < 0)
+		priv->stream_count = 0;
 out:
 	mutex_unlock(&priv->lock);
 	return ret;
diff --git a/drivers/staging/media/imx/imx-media-vdic.c b/drivers/staging/media/imx/imx-media-vdic.c
index c0b6d7f..7eabdc4 100644
--- a/drivers/staging/media/imx/imx-media-vdic.c
+++ b/drivers/staging/media/imx/imx-media-vdic.c
@@ -536,7 +536,8 @@ static int vdic_s_stream(struct v4l2_subdev *sd, int enable)
 
 update_count:
 	priv->stream_count += enable ? 1 : -1;
-	WARN_ON(priv->stream_count < 0);
+	if (priv->stream_count < 0)
+		priv->stream_count = 0;
 out:
 	mutex_unlock(&priv->lock);
 	return ret;
diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index cae1cb2..5061f3f 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -397,7 +397,8 @@ static int csi2_s_stream(struct v4l2_subdev *sd, int enable)
 
 update_count:
 	csi2->stream_count += enable ? 1 : -1;
-	WARN_ON(csi2->stream_count < 0);
+	if (csi2->stream_count < 0)
+		csi2->stream_count = 0;
 out:
 	mutex_unlock(&csi2->lock);
 	return ret;
-- 
2.7.4
