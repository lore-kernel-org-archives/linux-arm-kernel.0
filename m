From: agross@codeaurora.org (Andy Gross)
Date: Fri, 14 Aug 2015 22:56:30 -0500
Subject: [PATCH] soc: qcom: smem: Fix errant private access
Message-ID: <1439610990-8427-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects private partition item access.  Instead of falling back to
global for instances where we have an actual host and remote partition existing,
return the results of the private lookup.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/soc/qcom/smem.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 7c2c324c..6603201d 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -484,8 +484,9 @@ int qcom_smem_get(unsigned host, unsigned item, void **ptr, size_t *size)
 	if (ret)
 		return ret;
 
-	ret = qcom_smem_get_private(__smem, host, item, ptr, size);
-	if (ret == -ENOENT)
+	if (host < SMEM_HOST_COUNT && __smem->partitions[host])
+		ret = qcom_smem_get_private(__smem, host, item, ptr, size);
+	else
 		ret = qcom_smem_get_global(__smem, item, ptr, size);
 
 	hwspin_unlock_irqrestore(__smem->hwlock, &flags);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
