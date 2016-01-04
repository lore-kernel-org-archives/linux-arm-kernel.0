From: henryc.chen@mediatek.com (Henry Chen)
Date: Mon, 4 Jan 2016 19:59:35 +0800
Subject: [PATCH] soc: mediatek: PMIC wrap: Clear the vldclr if state machine
 stay on FSM_VLDCLR state.
Message-ID: <1451908775-21527-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes PMIC is too busy to send data in time to cause pmic wrap timeout,
because pmic wrap is waiting for FSM_VLDCLR after finishing WACS2_CMD. It
just return error when issue happened, so the state machine will stay on
FSM_VLDCLR state when data send back later by PMIC and timeout again in next
time because pmic wrap waiting for FSM_IDLE state at the beginning of the
read/write function.

Clear the vldclr when timeout if state machine stay on FSM_VLDCLR.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
Changes since v1:
Encapsulated the code in a inline function, and add a descriptive comment.
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 105597a..af919b1 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -412,6 +412,12 @@ static bool pwrap_is_fsm_vldclr(struct pmic_wrapper *wrp)
 	return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR;
 }
 
+static inline void pwrap_leave_fsm_vldclr(struct pmic_wrapper *wrp)
+{
+	if (pwrap_is_fsm_vldclr(wrp))
+		pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
+}
+
 static bool pwrap_is_sync_idle(struct pmic_wrapper *wrp)
 {
 	return pwrap_readl(wrp, PWRAP_WACS2_RDATA) & PWRAP_STATE_SYNC_IDLE0;
@@ -445,8 +451,18 @@ static int pwrap_write(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
 	int ret;
 
 	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
-	if (ret)
+	if (ret) {
+		/*
+		 * Timeout issue sometimes caused by the last read command
+		 * failed because pmic wrap could not got the FSM_VLDCLR
+		 * in time after finishing WACS2_CMD. It made state machine
+		 * still on FSM_VLDCLR and timeout next time.
+		 * Check the status of FSM and clear the vldclr to recovery the
+		 * error.
+		 */
+		pwrap_leave_fsm_vldclr(wrp);
 		return ret;
+	}
 
 	pwrap_writel(wrp, (1 << 31) | ((adr >> 1) << 16) | wdata,
 			PWRAP_WACS2_CMD);
@@ -459,8 +475,18 @@ static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 	int ret;
 
 	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
-	if (ret)
+	if (ret) {
+		/*
+		 * Timeout issue sometimes caused by the last read command
+		 * failed because pmic wrap could not got the FSM_VLDCLR
+		 * in time after finishing WACS2_CMD. It made state machine
+		 * still on FSM_VLDCLR and timeout next time.
+		 * Check the status of FSM and clear the vldclr to recovery the
+		 * error.
+		 */
+		pwrap_leave_fsm_vldclr(wrp);
 		return ret;
+	}
 
 	pwrap_writel(wrp, (adr >> 1) << 16, PWRAP_WACS2_CMD);
 
-- 
1.9.1
