From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 8 Feb 2018 14:43:05 +0100
Subject: [PATCH] regulator: stm32-vrefbuf: fix check on ready flag
Message-ID: <1518097385-7449-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32_vrefbuf_enable() wrongly checks VRR bit: 0 stands for not ready,
1 for ready. It currently checks the opposite.
This makes enable routine to exit immediately without waiting for ready
flag.

Fixes: 0cdbf481e927 ("regulator: Add support for stm32-vrefbuf")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/regulator/stm32-vrefbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index 72c8b3e..e0a9c44 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -51,7 +51,7 @@ static int stm32_vrefbuf_enable(struct regulator_dev *rdev)
 	 * arbitrary timeout.
 	 */
 	ret = readl_poll_timeout(priv->base + STM32_VREFBUF_CSR, val,
-				 !(val & STM32_VRR), 650, 10000);
+				 val & STM32_VRR, 650, 10000);
 	if (ret) {
 		dev_err(&rdev->dev, "stm32 vrefbuf timed out!\n");
 		val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
-- 
1.9.1
