From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 19 Aug 2015 18:02:48 -0500
Subject: [PATCH 1/3] [v3] hvc_dcc: don't ignore errors during initialization
Message-ID: <1440025370-9519-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hvc_instantiate() and hvc_alloc() return errors if they fail, so don't
ignore them.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/tty/hvc/hvc_dcc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 809920d..82f240f 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -70,20 +70,27 @@ static const struct hv_ops hvc_dcc_get_put_ops = {
 
 static int __init hvc_dcc_console_init(void)
 {
+	int ret;
+
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
 	if (!hvc_dcc_check())
 		return -ENODEV;
 
-	hvc_alloc(0, 0, &hvc_dcc_get_put_ops, 128);
-	return 0;
+	p = hvc_alloc(0, 0, &hvc_dcc_get_put_ops, 128);
+
+	return PTR_ERR_OR_ZERO(p);
 }
 device_initcall(hvc_dcc_init);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
