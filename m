From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Wed, 11 Jul 2018 12:34:21 +0000
Subject: [PATCH -next] pinctrl: nsp: fix potential NULL dereference in
 nsp_pinmux_probe()
Message-ID: <1531312461-134547-1-git-send-email-weiyongjun1@huawei.com>
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
e = devm_ioremap_nocache(e1, res->start, e2);

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-mux.c b/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
index 5cd8166..87618a4 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
@@ -577,6 +577,8 @@ static int nsp_pinmux_probe(struct platform_device *pdev)
 		return PTR_ERR(pinctrl->base0);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -EINVAL;
 	pinctrl->base1 = devm_ioremap_nocache(&pdev->dev, res->start,
 					      resource_size(res));
 	if (!pinctrl->base1) {
