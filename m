From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 20 Aug 2016 00:51:14 -0500
Subject: [PATCH 2/2] firmware: qcom: scm: Fix interrupted SCM calls
In-Reply-To: <1471672274-19317-1-git-send-email-andy.gross@linaro.org>
References: <1471672274-19317-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1471672274-19317-3-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes an issue with the SCM64 calls.  Sometimes SCM calls can
be interrupted and return early.  When this happens, the contents of
register 6 will contain a session ID that is required when resuming the
SCM call.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 drivers/firmware/qcom_scm-64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 4a0f5ea..1851294 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -131,10 +131,12 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 					 qcom_smccc_convention,
 					 ARM_SMCCC_OWNER_SIP, fn_id);
 
+		res->a6 = 0;
+
 		do {
 			arm_smccc_smc(cmd, desc->arginfo, desc->args[0],
-				      desc->args[1], desc->args[2], x5, 0, 0,
-				      res);
+				      desc->args[1], desc->args[2], x5, res->a6,
+				      0, res);
 		} while (res->a0 == QCOM_SCM_INTERRUPTED);
 
 		mutex_unlock(&qcom_scm_lock);
-- 
1.9.1
