From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 22 Apr 2016 17:17:10 -0500
Subject: [PATCH 6/8] firmware: qcom: scm: Add memory allocation API
In-Reply-To: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1461363432-5730-7-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds APIs for the scm-32 and scm-64 to use for coherent memory
allocation.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 drivers/firmware/qcom_scm.c | 17 +++++++++++++++++
 drivers/firmware/qcom_scm.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 7d7b12b..6e3defb 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -19,6 +19,7 @@
 #include <linux/qcom_scm.h>
 #include <linux/of.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 
 #include "qcom_scm.h"
 
@@ -171,6 +172,22 @@ static void qcom_scm_init(void)
 	__qcom_scm_init();
 }
 
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
+	if (__scm)
+		dma_free_writecombine(__scm->dev, size, cpu_addr, dma_addr);
+}
+
 static int qcom_scm_probe(struct platform_device *pdev)
 {
 	struct qcom_scm *scm;
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index d3f1f0a..33215b4 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -37,6 +37,10 @@ extern int __qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
 		u32 *resp);
 
 extern void __qcom_scm_init(void);
+extern void *qcom_scm_alloc_buffer(size_t size, dma_addr_t *dma_addr,
+				    gfp_t gfp);
+extern void qcom_scm_free_buffer(size_t size, void *virt_addr,
+				 dma_addr_t dma_addr);
 /* common error codes */
 #define QCOM_SCM_V2_EBUSY	-12
 #define QCOM_SCM_ENOMEM		-5
-- 
1.9.1
