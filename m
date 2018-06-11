From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Mon, 11 Jun 2018 11:50:25 +0200
Subject: [PATCH 2/4] media: stm32-dcmi: return buffer in error state on dma
 error
In-Reply-To: <1528710627-8566-1-git-send-email-hugues.fruchet@st.com>
References: <1528710627-8566-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1528710627-8566-3-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return buffer to V4L2 in error state if DMA error occurs.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index a3fbfac..6ccf195 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -262,6 +262,9 @@ static void dcmi_dma_callback(void *param)
 		break;
 	case DMA_ERROR:
 		dev_err(dcmi->dev, "%s: Received DMA_ERROR\n", __func__);
+
+		/* Return buffer to V4L2 in error state */
+		dcmi_buffer_done(dcmi, buf, 0, -EIO);
 		break;
 	case DMA_COMPLETE:
 		dev_dbg(dcmi->dev, "%s: Received DMA_COMPLETE\n", __func__);
-- 
1.9.1
