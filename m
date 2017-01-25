From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 25 Jan 2017 14:03:21 +0000
Subject: [PATCH -next] pinctrl: samsung: Fix return value check in
 samsung_pinctrl_get_soc_data()
Message-ID: <20170125140321.23911-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple
IORESOURCE_MEM for one pin-bank")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 3bc925f..9c03eab 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1009,7 +1009,7 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
 		virt_base[i] = devm_ioremap(&pdev->dev, res->start,
 						resource_size(res));
-		if (IS_ERR(virt_base[i]))
+		if (!virt_base[i])
 			return ERR_PTR(-EIO);
 	}
