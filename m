From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Mon, 11 Jun 2018 11:41:19 +0200
Subject: [PATCH] media: stm32-dcmi: increase max width/height to 2592
Message-ID: <1528710079-7944-1-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DCMI can capture 5Mp raw frames, increase limit accordingly.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 68da9ec..c55e6b5 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -90,14 +90,9 @@ enum state {
 };
 
 #define MIN_WIDTH	16U
-#define MAX_WIDTH	2048U
+#define MAX_WIDTH	2592U
 #define MIN_HEIGHT	16U
-#define MAX_HEIGHT	2048U
-
-#define MIN_JPEG_WIDTH	16U
-#define MAX_JPEG_WIDTH	2592U
-#define MIN_JPEG_HEIGHT	16U
-#define MAX_JPEG_HEIGHT	2592U
+#define MAX_HEIGHT	2592U
 
 #define TIMEOUT_MS	1000
 
@@ -844,14 +839,8 @@ static int dcmi_try_fmt(struct stm32_dcmi *dcmi, struct v4l2_format *f,
 	}
 
 	/* Limit to hardware capabilities */
-	if (pix->pixelformat == V4L2_PIX_FMT_JPEG) {
-		pix->width = clamp(pix->width, MIN_JPEG_WIDTH, MAX_JPEG_WIDTH);
-		pix->height =
-			clamp(pix->height, MIN_JPEG_HEIGHT, MAX_JPEG_HEIGHT);
-	} else {
-		pix->width = clamp(pix->width, MIN_WIDTH, MAX_WIDTH);
-		pix->height = clamp(pix->height, MIN_HEIGHT, MAX_HEIGHT);
-	}
+	pix->width = clamp(pix->width, MIN_WIDTH, MAX_WIDTH);
+	pix->height = clamp(pix->height, MIN_HEIGHT, MAX_HEIGHT);
 
 	/* No crop if JPEG is requested */
 	do_crop = dcmi->do_crop && (pix->pixelformat != V4L2_PIX_FMT_JPEG);
-- 
1.9.1
