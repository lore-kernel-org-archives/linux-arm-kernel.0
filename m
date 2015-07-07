From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  6 Jul 2015 18:09:30 -0700
Subject: [PATCH] pinctrl: qcom: Hook pm_power_down for shutdown support
Message-ID: <1436231370-18301-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign pm_power_off() if we have the PS_HOLD functionality so
that we can properly shutdown the SoC. Otherwise, shutdown won't
do anything besides put the CPU into a tight loop. Unfortunately,
we have to use a singleton here because pm_power_off() doesn't
take any arguments. Fortunately there's only one instance of the
pinctrl device on a running system so this isn't a problem.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index e457d52302a2..6242af8a42d5 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/reboot.h>
+#include <linux/pm.h>
 
 #include "../core.h"
 #include "../pinconf.h"
@@ -855,6 +856,13 @@ static int msm_ps_hold_restart(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_DONE;
 }
 
+static struct msm_pinctrl *poweroff_pctrl;
+
+static void msm_ps_hold_poweroff(void)
+{
+	msm_ps_hold_restart(&poweroff_pctrl->restart_nb, 0, NULL);
+}
+
 static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
 {
 	int i;
@@ -867,6 +875,8 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
 			if (register_restart_handler(&pctrl->restart_nb))
 				dev_err(pctrl->dev,
 					"failed to setup restart handler.\n");
+			poweroff_pctrl = pctrl;
+			pm_power_off = msm_ps_hold_poweroff;
 			break;
 		}
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
