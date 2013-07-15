From: julien.grall@linaro.org (Julien Grall)
Date: Mon, 15 Jul 2013 15:24:35 +0100
Subject: [PATCH] xen/control: protect functions with
 CONFIG_HIBERNATE_CALLBACKS to avoid warning
Message-ID: <1373898275-15765-1-git-send-email-julien.grall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_HIBERNATE_CALLBACKS is not set gcc will issue warnings:
drivers/xen/manage.c:46:13: warning: 'xen_hvm_post_suspend' defined but not used [-Wunused-function]
drivers/xen/manage.c:52:13: warning: 'xen_pre_suspend' defined but not used [-Wunused-function]
drivers/xen/manage.c:59:13: warning: 'xen_post_suspend' defined but not used [-Wunused-function]

Signed-off-by: Julien Grall <julien.grall@linaro.org>
---
 drivers/xen/manage.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 412b96c..7680276 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -36,6 +36,7 @@ enum shutdown_state {
 /* Ignore multiple shutdown requests. */
 static enum shutdown_state shutting_down = SHUTDOWN_INVALID;
 
+#ifdef CONFIG_HIBERNATE_CALLBACKS
 struct suspend_info {
 	int cancelled;
 	unsigned long arg; /* extra hypercall argument */
@@ -63,7 +64,6 @@ static void xen_post_suspend(int cancelled)
 	xen_mm_unpin_all();
 }
 
-#ifdef CONFIG_HIBERNATE_CALLBACKS
 static int xen_suspend(void *data)
 {
 	struct suspend_info *si = data;
-- 
1.7.10.4
