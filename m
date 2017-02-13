From: thibault.saunier@osg.samsung.com (Thibault Saunier)
Date: Mon, 13 Feb 2017 16:08:36 -0300
Subject: [PATCH v4 4/4] [media] s5p-mfc: Check and set 'v4l2_pix_format:field'
 field in try_fmt
In-Reply-To: <20170213190836.26972-1-thibault.saunier@osg.samsung.com>
References: <20170213190836.26972-1-thibault.saunier@osg.samsung.com>
Message-ID: <20170213190836.26972-5-thibault.saunier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is required by the standard that the field order is set by the
driver.

Signed-off-by: Thibault Saunier <thibault.saunier@osg.samsung.com>

---

Changes in v4: None
Changes in v3:
- Do not check values in the g_fmt functions as Andrzej explained in previous review

Changes in v2:
- Fix a silly build error that slipped in while rebasing the patches

 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index 0976c3e0a5ce..c954b34cb988 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -385,6 +385,20 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 	struct s5p_mfc_dev *dev = video_drvdata(file);
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct s5p_mfc_fmt *fmt;
+	enum v4l2_field field;
+
+	field = f->fmt.pix.field;
+	if (field == V4L2_FIELD_ANY) {
+		field = V4L2_FIELD_NONE;
+	} else if (field != V4L2_FIELD_NONE) {
+		mfc_debug(2, "Not supported field order(%d)\n", pix_mp->field);
+		return -EINVAL;
+	}
+
+	/* V4L2 specification suggests the driver corrects the format struct
+	 * if any of the dimensions is unsupported
+	 */
+	f->fmt.pix.field = field;
 
 	mfc_debug(2, "Type is %d\n", f->type);
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
-- 
2.11.1
