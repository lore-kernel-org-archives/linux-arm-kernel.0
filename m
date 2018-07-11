From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Wed, 11 Jul 2018 13:17:38 +0000
Subject: [PATCH -next] misc: vexpress: Fix potential NULL dereference in
 vexpress_syscfg_probe()
Message-ID: <1531315058-183762-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_resource() may fail and return NULL, so we should
better check it's return value to avoid a NULL pointer dereference
a bit later in the code.

This is detected by Coccinelle semantic patch.

@@
expression pdev, res, n, t, e, e1, e2;
@@

res = platform_get_resource(pdev, t, n);
+ if (!res)
+   return -EINVAL;
... when != res == NULL
e = devm_ioremap(e1, res->start, e2);

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/misc/vexpress-syscfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/vexpress-syscfg.c b/drivers/misc/vexpress-syscfg.c
index 9eea30f..2d72c93 100644
--- a/drivers/misc/vexpress-syscfg.c
+++ b/drivers/misc/vexpress-syscfg.c
@@ -259,6 +259,8 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&syscfg->funcs);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 	if (!devm_request_mem_region(&pdev->dev, res->start,
 			resource_size(res), pdev->name))
 		return -EBUSY;
