From: davidb@codeaurora.org (David Brown)
Date: Tue, 12 Mar 2013 11:41:48 -0700
Subject: [PATCH v2 03/11] ssbi: Fix exit mismatch in remove function
In-Reply-To: <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1363113716-25897-4-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

msm_ssbi_remove is referenced with __exit_p, but not declared with
__exit.  This causes a warning when the driver is not built as a
module:

drivers/ssbi/ssbi.c:341:23: warning: 'msm_ssbi_remove' defined but not used [-Wunused-function]

The remove is needed for unbinding to work, even if not compiled as a
module, so just remove it.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/ssbi/ssbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ssbi/ssbi.c b/drivers/ssbi/ssbi.c
index c08a7b8..da086d4 100644
--- a/drivers/ssbi/ssbi.c
+++ b/drivers/ssbi/ssbi.c
@@ -372,7 +372,7 @@ static int msm_ssbi_remove(struct platform_device *pdev)
 
 static struct platform_driver msm_ssbi_driver = {
 	.probe		= msm_ssbi_probe,
-	.remove		= __exit_p(msm_ssbi_remove),
+	.remove		= msm_ssbi_remove,
 	.driver		= {
 		.name	= "msm_ssbi",
 		.owner	= THIS_MODULE,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
