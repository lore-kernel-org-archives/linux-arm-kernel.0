From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Mon, 24 Sep 2018 14:54:59 +0200
Subject: [PATCH] media: stm32-dcmi: only enable IT frame on JPEG capture
Message-ID: <1537793699-2555-1-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only enable IT frame on JPEG capture, this saves some CPU
interruptions and processing on all the other cases.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index ba3e2ee..d6b00eda 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -659,7 +659,10 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	}
 
 	/* Enable interruptions */
-	reg_set(dcmi->regs, DCMI_IER, IT_FRAME | IT_OVR | IT_ERR);
+	if (dcmi->sd_format->fourcc == V4L2_PIX_FMT_JPEG)
+		reg_set(dcmi->regs, DCMI_IER, IT_FRAME | IT_OVR | IT_ERR);
+	else
+		reg_set(dcmi->regs, DCMI_IER, IT_OVR | IT_ERR);
 
 	return 0;
 
-- 
2.7.4
