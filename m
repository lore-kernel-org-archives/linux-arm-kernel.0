From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 26 Jun 2015 13:52:35 -0500
Subject: [PATCH 2/3] hvc_dcc: don't ignore errors during initialization
In-Reply-To: <1435344756-20901-1-git-send-email-timur@codeaurora.org>
References: <1435344756-20901-1-git-send-email-timur@codeaurora.org>
Message-ID: <1435344756-20901-2-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hvc_instantiate() and hvc_alloc() return errors if they fail, so don't
ignore them.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/tty/hvc/hvc_dcc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 33657dc..f8b8cf2 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -225,20 +225,29 @@ static const struct hv_ops hvc_dcc_get_put_ops = {
 
 static int __init hvc_dcc_console_init(void)
 {
+	int ret;
+
+	/* This always runs on boot core */
 	if (!hvc_dcc_check())
 		return -ENODEV;
 
-	hvc_instantiate(0, 0, &hvc_dcc_get_put_ops);
-	return 0;
+	/* Returns -1 if error */
+	ret = hvc_instantiate(0, 0, &hvc_dcc_get_put_ops);
+
+	return ret < 0 ? -ENODEV : 0;
 }
 console_initcall(hvc_dcc_console_init);
 
 static int __init hvc_dcc_init(void)
 {
+	struct hvc_struct *p;
+
+	/* This can run on any core */
 	if (!hvc_dcc_check())
 		return -ENODEV;
 
-	hvc_alloc(0, 0, &hvc_dcc_get_put_ops, 128);
-	return 0;
+	p = hvc_alloc(0, 0, &hvc_dcc_get_put_ops, 128);
+
+	return IS_ERR(p) ? PTR_ERR(p) : 0;
 }
 device_initcall(hvc_dcc_init);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
