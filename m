From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 May 2015 11:37:44 +0200
Subject: [PATCH 2/2] soc: mediatek: PMIC wrap: Fix register state machine
 handling
In-Reply-To: <1432633064-16839-1-git-send-email-s.hauer@pengutronix.de>
References: <1432633064-16839-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432633064-16839-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the PMIC wrapper state machine has read a register it goes into the
"wait for valid clear" (vldclr) state. The state machine stays in this
state until the VLDCLR bit is written to. We should write this bit after
reading a register because the SCPSYS won't let the system go into
suspend as long as the state machine waits for valid clear.

Since now we never leave the state machine in vldclr state we no longer
have to check for this state on pwrap_read/pwrap_write entry and can
remove the corresponding code.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 642d6a1..f432291 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -443,11 +443,6 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
 static int pwrap_write(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
 {
 	int ret;
-	u32 val;
-
-	val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
-	if (PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR)
-		pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
 
 	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
 	if (ret)
@@ -462,11 +457,6 @@ static int pwrap_write(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
 static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 {
 	int ret;
-	u32 val;
-
-	val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
-	if (PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR)
-		pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
 
 	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
 	if (ret)
@@ -480,6 +470,8 @@ static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
 
 	*rdata = PWRAP_GET_WACS_RDATA(pwrap_readl(wrp, PWRAP_WACS2_RDATA));
 
+	pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
+
 	return 0;
 }
 
-- 
2.1.4
