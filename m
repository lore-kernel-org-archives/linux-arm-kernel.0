From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Thu, 22 Jun 2017 17:05:39 +0200
Subject: [PATCH v1 3/6] [media] ov9650: select the nearest higher resolution
In-Reply-To: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1498143942-12682-4-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refine the resolution selection algorithm by selecting
only the nearest higher resolution (instead of lower and higher).

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/i2c/ov9650.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov9650.c b/drivers/media/i2c/ov9650.c
index 8340a45..4311da6 100644
--- a/drivers/media/i2c/ov9650.c
+++ b/drivers/media/i2c/ov9650.c
@@ -1196,9 +1196,11 @@ static void __ov965x_try_frame_size(struct v4l2_mbus_framefmt *mf,
 	unsigned int min_err = UINT_MAX;
 
 	while (i--) {
-		int err = abs(fsize->width - mf->width)
-				+ abs(fsize->height - mf->height);
-		if (err < min_err) {
+		int w_err = (fsize->width - mf->width);
+		int h_err = (fsize->height - mf->height);
+		int err = w_err + h_err;
+
+		if ((w_err >= 0) && (h_err >= 0) && (err < min_err)) {
 			min_err = err;
 			match = fsize;
 		}
-- 
1.9.1
