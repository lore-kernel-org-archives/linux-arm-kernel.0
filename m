From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Thu, 22 Jun 2017 17:12:48 +0200
Subject: [PATCH v1 2/5] [media] stm32-dcmi: revisit control register handling
In-Reply-To: <1498144371-13310-1-git-send-email-hugues.fruchet@st.com>
References: <1498144371-13310-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1498144371-13310-3-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify bits handling of DCMI_CR register.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 0dd5d1c..75d53aa 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -490,7 +490,7 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 {
 	struct stm32_dcmi *dcmi = vb2_get_drv_priv(vq);
 	struct dcmi_buf *buf, *node;
-	u32 val;
+	u32 val = 0;
 	int ret;
 
 	ret = clk_enable(dcmi->mclk);
@@ -510,22 +510,16 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	spin_lock_irq(&dcmi->irqlock);
 
-	val = reg_read(dcmi->regs, DCMI_CR);
-
-	val &= ~(CR_PCKPOL | CR_HSPOL | CR_VSPOL |
-		 CR_EDM_0 | CR_EDM_1 | CR_FCRC_0 |
-		 CR_FCRC_1 | CR_JPEG | CR_ESS);
-
 	/* Set bus width */
 	switch (dcmi->bus.bus_width) {
 	case 14:
-		val &= CR_EDM_0 + CR_EDM_1;
+		val |= CR_EDM_0 | CR_EDM_1;
 		break;
 	case 12:
-		val &= CR_EDM_1;
+		val |= CR_EDM_1;
 		break;
 	case 10:
-		val &= CR_EDM_0;
+		val |= CR_EDM_0;
 		break;
 	default:
 		/* Set bus width to 8 bits by default */
-- 
1.9.1
