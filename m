From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 25 Apr 2016 18:08:41 -0500
Subject: [Patch v2 4/8] firmware: qcom: scm: Add memory allocation API
In-Reply-To: <1461625725-32425-1-git-send-email-andy.gross@linaro.org>
References: <1461625725-32425-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1461625725-32425-5-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds APIs for the scm-32 and scm-64 to use for coherent memory
allocation.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 drivers/firmware/qcom_scm.c | 16 ++++++++++++++++
 drivers/firmware/qcom_scm.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index d4e9145..8f78938 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 
 #include "qcom_scm.h"
 
@@ -158,6 +159,21 @@ bool qcom_scm_is_available(void)
 }
 EXPORT_SYMBOL(qcom_scm_is_available);
 
+void *qcom_scm_alloc_buffer(size_t size, dma_addr_t *dma_addr,
+				      gfp_t gfp)
+{
+	if (__scm)
+		return dma_alloc_writecombine(__scm->dev, size, dma_addr, gfp);
+	else
+		return ERR_PTR(-ENODEV);
+}
+
+void qcom_scm_free_buffer(size_t size, void *cpu_addr,
+				 dma_addr_t dma_addr)
+{
+	dma_free_writecombine(__scm->dev, size, cpu_addr, dma_addr);
+}
+
 static int qcom_scm_probe(struct platform_device *pdev)
 {
 	struct qcom_scm *scm;
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 7dcc733..848c7de 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -36,6 +36,10 @@ extern int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id);
 extern int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
 		u32 *resp);
 
+extern void *qcom_scm_alloc_buffer(size_t size, dma_addr_t *dma_addr,
+				    gfp_t gfp);
+extern void qcom_scm_free_buffer(size_t size, void *virt_addr,
+				 dma_addr_t dma_addr);
 /* common error codes */
 #define QCOM_SCM_ENOMEM		-5
 #define QCOM_SCM_EOPNOTSUPP	-4
-- 
1.9.1
