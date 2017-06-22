From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Thu, 22 Jun 2017 17:12:47 +0200
Subject: [PATCH v1 1/5] [media] stm32-dcmi: catch dma submission error
In-Reply-To: <1498144371-13310-1-git-send-email-hugues.fruchet@st.com>
References: <1498144371-13310-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1498144371-13310-2-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Test cookie return by dmaengine_submit() and return error if any.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 83d32a5..0dd5d1c 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -295,6 +295,10 @@ static int dcmi_start_dma(struct stm32_dcmi *dcmi,
 
 	/* Push current DMA transaction in the pending queue */
 	dcmi->dma_cookie = dmaengine_submit(desc);
+	if (dma_submit_error(dcmi->dma_cookie)) {
+		dev_err(dcmi->dev, "%s: DMA submission failed\n", __func__);
+		return -ENXIO;
+	}
 
 	dma_async_issue_pending(dcmi->dma_chan);
 
-- 
1.9.1
