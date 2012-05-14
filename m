From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 14 May 2012 19:06:37 +0800
Subject: [PATCH 2/5] pinctrl: make pinmux disable function optional
In-Reply-To: <1336993600-30065-1-git-send-email-b29396@freescale.com>
References: <1336993600-30065-1-git-send-email-b29396@freescale.com>
Message-ID: <1336993600-30065-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Some SoCs may not have pinmux disable function in HW.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinmux.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 220fa49..3d5ac73 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -41,8 +41,7 @@ int pinmux_check_ops(struct pinctrl_dev *pctldev)
 	    !ops->get_functions_count ||
 	    !ops->get_function_name ||
 	    !ops->get_function_groups ||
-	    !ops->enable ||
-	    !ops->disable) {
+	    !ops->enable) {
 		dev_err(pctldev->dev, "pinmux ops lacks necessary functions\n");
 		return -EINVAL;
 	}
@@ -497,7 +496,8 @@ void pinmux_disable_setting(struct pinctrl_setting const *setting)
 		desc->mux_setting = NULL;
 	}
 
-	ops->disable(pctldev, setting->data.mux.func, setting->data.mux.group);
+	if (ops->disable)
+		ops->disable(pctldev, setting->data.mux.func, setting->data.mux.group);
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
1.7.0.4
