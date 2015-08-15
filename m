From: agross@codeaurora.org (Andy Gross)
Date: Fri, 14 Aug 2015 23:56:59 -0500
Subject: [Patch v2] soc: qcom: smem: Fix errant private access
Message-ID: <1439614619-29808-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects private partition item access.  Instead of falling back to
global for instances where we have an actual host and remote partition existing,
return the results of the private lookup.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/soc/qcom/smem.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c809127..7fddf3b 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -264,10 +264,6 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 	size_t alloc_size;
 	void *p;
 
-	/* We're not going to find it if there's no matching partition */
-	if (host >= SMEM_HOST_COUNT || !smem->partitions[host])
-		return -ENOENT;
-
 	phdr = smem->partitions[host];
 
 	p = (void *)phdr + sizeof(*phdr);
@@ -377,8 +373,9 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 	if (ret)
 		return ret;
 
-	ret = qcom_smem_alloc_private(__smem, host, item, size);
-	if (ret == -ENOENT)
+	if (host < SMEM_HOST_COUNT && __smem->partitions[host])
+		ret = qcom_smem_alloc_private(__smem, host, item, size);
+	else
 		ret = qcom_smem_alloc_global(__smem, item, size);
 
 	hwspin_unlock_irqrestore(__smem->hwlock, &flags);
@@ -434,10 +431,6 @@ static int qcom_smem_get_private(struct qcom_smem *smem,
 	struct smem_private_entry *hdr;
 	void *p;
 
-	/* We're not going to find it if there's no matching partition */
-	if (host >= SMEM_HOST_COUNT || !smem->partitions[host])
-		return -ENOENT;
-
 	phdr = smem->partitions[host];
 
 	p = (void *)phdr + sizeof(*phdr);
@@ -490,8 +483,9 @@ int qcom_smem_get(unsigned host, unsigned item, void **ptr, size_t *size)
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
