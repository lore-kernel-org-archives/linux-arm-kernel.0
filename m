From: andy.gross@linaro.org (Andy Gross)
Date: Fri,  1 Jul 2016 23:20:14 -0500
Subject: [PATCH] firmware: qcom: scm: Change initcall to subsys
Message-ID: <1467433214-7667-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch changes the initcall for SCM to use subsys_initcall
instead of arch_initcall.  This corrects the order so that we don't
probe defer when trying to get clks which causes issues later when
the spm driver makes calls to qcom_set_warm_boot_addr().

The order became an issue due to the changes to use arch_initcall_sync
for of_platform_default_populate_init().

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 drivers/firmware/qcom_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 89c3775..e64a501 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -415,7 +415,7 @@ static int __init qcom_scm_init(void)
 	return platform_driver_register(&qcom_scm_driver);
 }
 
-arch_initcall(qcom_scm_init);
+subsys_initcall(qcom_scm_init);
 
 static void __exit qcom_scm_exit(void)
 {
-- 
1.9.1
